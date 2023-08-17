public without sharing class SiteUtility {

  
    public static List<User> getUserAssingToContact(String username) {
        return [
                SELECT Contact.Registration_Approved__c,
                       Contact.SiteProfile__c,
                       Contact.SiteProfile__r.Force_com_Authorization_and_Registration__c,
                       Contact.SiteProfile__r.Name__c,
                       Contact.SiteProfile__r.Default_Home_Page__r.Name__c,
                       Contact.Password__c
                FROM User
                WHERE Username = :username LIMIT 1];
    }
   
    public static Contact getLoggedInContact()
    {    
        SiteLog_controller.addMessage('SiteUtility', 'GetLoggedInContact', 'GetLoggedInContact');

        Id contactId = LoginBlock.getLoggedInContact();

        SiteLog_controller.addMessage('SiteUtility', 'GetLoggedInContact', 'contactId=' + contactId);

        return (contactId != null)
        ? Database.query(
                    ' SELECT ' + ContactFieldsUtil.getAllFieldsString() +
                    ' FROM Contact WHERE Id=\'' + contactId + '\'')
                : new Contact();
    }

    public static PageReference doLogin(SObject contact,String profileName, String profileHomePage)
    { 
        SiteLog_controller.addMessage('SiteUtility', 'doLogin', 'contact=' + contact);

        System.debug('!!!!!!!!!!!!!!!!!!!!params' + contact + profileName + profileHomePage);

        Session__c session = new Session__c();

        System.debug('contact id in session' + contact.id);
        
        List<CMSSettings__c> sesionfield = [SELECT Session_Field__c FROM CMSSettings__c LIMIT 1];
        string sessionstring = sesionfield[0].Session_Field__c;
                System.debug('sessionstring-' +sessionstring);

        session.put(sessionstring,contact.id);
        session.User_Agent__c = Login.getUserAgent();
        session.IP_Address__c = Login.getIP();
        SiteLog_controller.addMessage('SiteUtility','doLogin','Math.random() :'+Math.random());
        session.SessionId__c = String.valueOf(Math.random()).substring(2,16);
        insert session;

        SiteLog_controller.addMessage('SiteUtility', 'doLogin', 'session=' + session);

        PageReference pg;
        String startUrl = ApexPages.currentPage().getParameters().get('startUrl');

        SiteLog_controller.addMessage('SiteUtility', 'doLogin', 'startUrl=' + startUrl);

        if(startUrl != null && startUrl.length() > 0 && startUrl != 'null')
        {
            pg = new PageReference(startUrl.replace('~','&'));
        }
        else
        {
            pg = new PageReference('/apex/SiteView');
            pg.getParameters().put('jobSite', ApexPages.currentPage().getParameters().get('jobSite'));
            pg.getParameters().put('page', profileHomePage);
        }
        pg.getParameters().put('p', profileName);
        pg.getParameters().put('sessionId', session.SessionId__c);
        pg.setRedirect(true);

        SiteLog_controller.addMessage('SiteUtility', 'doLogin', 'pg=' + pg);
        system.debug('==========='+ApexPages.currentPage().getParameters().get('jobSite'));
        system.debug('==========='+pg);
        return pg;
    }
    
    public static Boolean isCurrentUserForceDotComLicensed() {
        SiteProfile__c profile = getProfile();
        System.debug('!!!!!!!!!!!!!profile=' + profile);
        return profile.Force_com_Authorization_and_Registration__c;
    }

    // Gets css styles for current profile
    public static String getCSSStyles()
    {
        SiteLog_controller.addMessage('SiteUtility', 'GetCSSStyles', '');

        SiteProfile__c profile = getProfile();

        SiteLog_controller.addMessage('SiteUtility', 'GetCSSStyles', 'profile=' + profile);
         
        List<ApexPage> pageList = [
                SELECT Markup
                FROM ApexPage
                WHERE Name = :profile.CMSCss__c
                LIMIT 1];
    system.debug('******Apexpage'+pageList);
     system.debug('******Apexpage'+profile);
      system.debug('******Apexpage'+profile.CMSCss__c);
        SiteLog_controller.addMessage('SiteUtility', 'GetCSSStyles', 'pageList=' + pageList);

        if(pageList.size() > 0)
        {
            String cmsCssCustom = pageList[0].Markup;
            if(cmsCssCustom != null)
            {
                Integer startIndex = cmsCssCustom.indexOf('>');
                cmsCssCustom=cmsCssCustom.substring(startIndex + 1);
                cmsCssCustom = cmsCssCustom.replace('</apex:page>', '');

                SiteLog_controller.addMessage('SiteUtility', 'GetCSSStyles', 'cmsCssCustom found');

                return cmsCssCustom.replace('background:#414141;', '');
            }
        }

        SiteLog_controller.addMessage('SiteUtility', 'GetCSSStyles', 'cmsCssCustom not found');

        return '';
    }

    public static SiteProfile__c getProfile()
    {
        SiteLog_controller.addMessage('SiteUtility', 'getProfile', '');

        String profileName = ApexPages.currentPage().getParameters().get('p');

        SiteLog_controller.addMessage('SiteUtility', 'getProfile', 'profileName=' + profileName);

        Id contactId = LoginBlock.getLoggedInContact();
                
        if (contactId != null)
        {	
        	
          /*s  Contact contact = [
                    SELECT SiteProfile__r.Name__c
                    FROM Contact
                    WHERE Id = :contactId];  */
                    
           // profileName =  String.valueOf(LoginBlock.currentContact.getSObject('SiteProfile__r').get('Name__c'));
            profileName = LoginBlock.siteproName;
           

            SiteLog_controller.addMessage('SiteUtility', 'getProfile', 'profileName2=' + profileName);
        }

        if(profileName == null || profileName == '')
            profileName = 'CMSDefaultProfile';

        SiteLog_controller.addMessage('SiteUtility', 'getProfile', 'profileName3=' + profileName);

        List<SiteProfile__c> profile = [
                SELECT P.Force_com_Authorization_and_Registration__c, P.CMSCss__c, P.Name__c
                FROM SiteProfile__c p
                WHERE Name__c = :profileName
                LIMIT 1];
        SiteProfile__c profileIs = new SiteProfile__c();

        if(profile.size() > 0){
            profileIs = profile[0];
        }
        SiteLog_controller.addMessage('SiteUtility', 'getProfile', 'profile=' + profileIs);
        return profileIs;
    }

    // Unused
    public static CMSSettings__c getCustomSettings(){return null;}

    static testmethod void testScenario1(){

        String sessionId = '66728278571221';//66728278571221 62486944141904
        ApexPages.currentPage().getParameters().put('sessionId', sessionId);

        Page__c testPage = new Page__c(Name = 'testPage',Name__c = 'testName');
        insert testPage;

        SiteProfile__c testProfile = new SiteProfile__c(Name__c = 'testName',Name = 'testProfile');
        insert testProfile;

        Account testAcc = new Account(Name = 'Test');
        insert testAcc;

        Contact testCon = new Contact(LastName = 'Test', AccountId = testAcc.Id,
                                Email = 'test@test.test', Password__c = 'TestPass');
        insert testCon;

        Session__c session = new Session__c(Is_Valid__c = true,
                                        Session_For__c = testCon.Id, SessionId__c = sessionId);
        insert session;
        
        
        CMSSettings__c  CMSSet= new CMSSettings__c(Name ='test', LoginObject__c = 'Contact', 
        						Session_Field__c = 'Session_For__c', SoqLogin__c ='test');
        insert CMSSet;
        
        SiteUtility controller = new SiteUtility();

        SiteUtility.doLogin(testCon,testProfile.Name,'testPage');

        SiteUtility.getUserAssingToContact(String.valueOf(UserInfo.getUserName()));

        SiteUtility.getLoggedInContact();

        SiteUtility.getCSSStyles();

        SiteUtility.getCustomSettings();
        SiteUtility.getProfile();
        SiteUtility.isCurrentUserForceDotComLicensed();
        
    }  
}