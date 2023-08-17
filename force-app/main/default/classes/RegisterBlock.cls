/**
 * An apex class that creates a portal user
 */
    global class RegisterBlock {

    public String selectLanguage { get; set; }
    private Contact cont = new Contact();

    global String cmsCssCustom {get; set;}

    global RegisterBlock(){}

    global String getCmsCssCustom(){return null;}

    global String confirmPassword {get; set { confirmPassword = value == null ? value : value.trim(); } }

    global Boolean profileFlag;
    global Boolean getProfileFlag() { return cmsProfileList.size() > 1; }

    global Contact getContact(){return cont;}
    global void setContact(Contact cont){this.cont = cont;}
    private Boolean displayError = false;
    private String subject = System.Label.RegisterBlock_Page_Error;
    public Boolean captchaIsShow {get;set;}
  
    global PageReference init() {
        Cookie v_selectLanguage = ApexPages.currentPage().getCookies().get('selectLanguage');
        System.debug('------------- COOKIE ' + v_selectLanguage);

        if (v_selectLanguage != null && v_selectLanguage.getValue() != null) {
            selectLanguage = v_selectLanguage.getValue();
        } else {
            selectLanguage = 'en_US';
        }
        return null;
    }

    List<SiteProfile__c> cmsProfileList = [
            SELECT Profile_Manager__c,
                   Profile_Manager__r.Email,
                   Need_Registration_Approval__c,
                   Approval_Message_Page__c,
                   Approval_Message_Page__r.Name__c,
                   User_Record_Type__c,
                   Default_Home_Page__r.Name__c,
                   Default_Home_Page__r.Id,
                   Name__c,Profile_Account__c,
                   Force_com_Authorization_and_Registration__c
            FROM SiteProfile__c
            WHERE User_Registration__c = true];

    global List<SelectOption> getItems()
    {
        List<SelectOption> options = new List<SelectOption>();
        for(SiteProfile__c profile : cmsProfileList)
            options.add(new SelectOption(profile.id, profile.Name__c));
        return options;
    }

    global PageReference registerUser()
    {
         system.debug('cms1ProfileList '+cmsProfilelist);
        SiteLog_controller.addMessage('registered Page', 'registerUser()', 'before try');
        try
        {
            if(!Test.isRunningTest()) {
                /*if (captchaIsShow && !captchaVerified()) {
                    SiteLog_controller.addErrorMessage('Captcha is incorrect');
                    return null;
                }*/
            }

            SiteLog_controller.addMessage('registered Page', 'registerUser()', 'cont.UserName__c= ' + cont.UserName__c);

            Boolean validUserName = Pattern.matches('^([a-zA-Z0-9_\\.\\-])+\\@(([a-zA-Z0-9\\-])+\\.)+([a-zA-Z0-9]{2,4})+$',cont.UserName__c);

            Boolean validEmail = Pattern.matches('^([a-zA-Z0-9_\\.\\-])+\\@(([a-zA-Z0-9\\-])+\\.)+([a-zA-Z0-9]{2,4})+$',cont.Email);

          
            String lowerCaseUserName = cont.UserName__c.toLowerCase();
            String lowerCaseEmail = cont.Email.toLowerCase();
            SiteLog_controller.addMessage('registered Page', 'registerUser()', 'lowerCase= ' + lowerCaseUserName);


            List<Contact> oldContactsList = [
                    SELECT UserName__c,Email,Password__c
                    FROM Contact
                    WHERE (UserName__c = :lowerCaseUserName OR Email = :lowerCaseEmail) AND
                        Password__c != ''];


            List<User> oldUserList = [SELECT Name, Email FROM User WHERE Username = : lowerCaseUserName OR Email = : lowerCaseEmail];

            SiteLog_controller.addMessage('registered Page', 'registerUser()', 'oldContactsList= ' + oldContactsList);
            System.debug('!!!!!!!!!!!!!cont.Password__c=' + cont.FirstName);
            if (cmsProfileList.size() == 0)
                SiteLog_controller.addErrorMessage(System.Label.No_Profile_found_Please_contact_your_administrator);
            if (cont.FirstName == null || cont.FirstName == '')
                SiteLog_controller.addErrorMessage(System.Label.First_name_is_required);
            if (cont.lastName == null || cont.lastName == '')
                SiteLog_controller.addErrorMessage(System.Label.Last_name_is_required);
            if (cont.UserName__c == null || cont.UserName__c == '')
                SiteLog_controller.addErrorMessage(System.Label.User_Name_is_required);
            if (oldContactsList.size() > 0)
            {
           
                return null;
            }
            if (oldUserList.size() > 0) {
                System.debug('!!!!!!!!!!!!!!test=');
             
                return null;
            }
            if (cont.Password__c == null || cont.password__c == '')
                SiteLog_controller.addErrorMessage(System.Label.Password_is_required);
            if (confirmPassword == '')
                SiteLog_controller.addErrorMessage(System.Label.Password_confirmation_is_required);
            if (cont.Password__c != confirmPassword)
                SiteLog_controller.addErrorMessage(Label.site.passwords_dont_match);
            if (cont.Email == null || cont.Email == '')
                SiteLog_controller.addErrorMessage(System.Label.Email_is_required);

            //Modify by Kans 29.11.2011
            List<Contact> contList = [
                    SELECT  UserName__c, Password__c, Email
                    FROM Contact
                    WHERE Email  = :cont.Email
                        AND UserName__c = ''
                        AND Password__c = ''  LIMIT 1];

            if (contList != null && contList.size() > 0)
            {
                system.debug('!!!!!!!!!!!contlist=' + contList);
                contList[0].UserName__c = cont.UserName__c.toLowerCase();
                contList[0].Password__c = contList[0].id;

                update contList[0];
                if (!ApexPages.hasMessages(ApexPages.Severity.ERROR))
                    SiteLog_controller.addErrorMessage(CMSSettings__c.getInstance('Default').Password_Email_Error__c);
            }

            if (!ApexPages.hasMessages(ApexPages.Severity.ERROR))
            {
                SiteLog_controller.addMessage('registered Page', 'no error', '');

                SiteProfile__c profile;

                profile = cmsProfileList.size() == 1
                        ? cmsProfileList[0]
                        : new Map<Id, SiteProfile__c>(cmsProfileList).get(cont.SiteProfile__c);
                system.debug('$$profile.Force_com_Authorization_and_Registration__c '+profile.Name__c);
                if(profile.Force_com_Authorization_and_Registration__c){
                    User user = new User();
                    user.Username = cont.UserName__c;
                    user.Email = cont.Email;
                    user.FirstName = cont.FirstName;
                    user.LastName = cont.LastName;
                    user.CommunityNickname = cont.FirstName + ' '+ cont.LastName;
                    String accountId = profile.Profile_Account__c;
                    String firstNameContact = cont.FirstName;
                    String lastNameContact = cont.LastName;
                    String password = cont.Password__c;
                    String userName = cont.UserName__c;

                    System.debug('!!!!!!!!!!!!!user=' + user);
                    System.debug('!!!!!!!!!!!!!accountId=' + accountId);
                    System.debug('!!!!!!!!!!!!!cont.Password__c=' + cont.Password__c);
                    system.debug(':::::::::username contact' + cont.Username__c);
                    system.debug(':::::::::CommunityNicName '+user.CommunityNickname);

                    Savepoint sp = Database.setSavepoint();
                    String userId = Site.createPortalUser(user, accountId, cont.Password__c);
                    System.debug('!!!!!!!!!!!!!userId=' + userId);

                    System.debug('::::::::::contlist' + [SELECT id,LastName,PortalEmailAlert__c FROM Contact WHERE LastName ='test']);

                    if (userId == null)
                    {

                        Database.rollback(sp);
                        System.debug(':::::::::::contactviaUser2' + [SELECT id FROM Contact WHERE lastname = :cont.LastName]);
                        return null;
                    }
                    
                    
                    
                    List<User> customerPortalUser = [
                            SELECT Contact.Id, Contact.FirstName,Contact.LastName, Contact.Password__c,
                                Contact.UserName__c 
                            FROM User
                            WHERE UserName = :cont.UserName__c];

                    try{
                        if(customerPortalUser.size() > 0){
                            cont  = customerPortalUser[0].Contact;
                            cont.FirstName = firstNameContact;
                            cont.LastName = lastNameContact;
                            cont.Password__c = password;
                            cont.UserName__c = userName;
                        }
                    }catch(Exception e){

                        return null;
                    }
                }

 
                cont.AccountId = profile.Profile_Account__c;
                cont.Profile_Manager_Email__c = profile.Profile_Manager__r.Email;
                cont.Registration_Approved__c = !profile.Need_Registration_Approval__c;
                cont.PortalEmailAlert__c = System.Label.User_Created;
                cont.LeadSource = System.Label.Online;


            }
        }
       catch (Exception e)
        {
                if(e instanceOf System.DmlException && e.getDmlStatusCode(0) == 'FIELD_CUSTOM_VALIDATION_EXCEPTION')
                {
                    ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, e.getDmlMessage(0) );
                    ApexPages.addMessage(msg);
                }
                else
                    SiteLog_controller.catchBlockMethod(e, subject);
        }

        return null;
    }

    //From CMSController
    global PageReference getLoginPage() {
        Pagereference pg = new PageReference('/apex/SiteView');
        pg.getparameters().put('page','LoginPage_view');
        pg.getParameters().put('jobSite',ApexPages.currentPage().getParameters().get('jobSite'));
        pg.getParameters().put('p',ApexPages.currentPage().getParameters().get('p'));
        pg.getParameters().put('startUrl',ApexPages.currentPage().getParameters().get('startUrl'));
        return pg;
    }

    // *************reCaptcha********************************
    private static string secret = '6Lcuj8QSAAAAAOBuTKNOIbFUjXXav6X8tZVxb-ns';
    public string publicKey { get { return '6Lcuj8QSAAAAAAEYREXBgp9PKhYIDpA-hnsATOvV'; }}

    private static string baseUrl = 'http://www.google.com/recaptcha/api/verify';  //'http://api-verify.recaptcha.net/verify';

    public string challenge {get; set;}
    public string response {get; set; }

    public Boolean captchaVerified()
    {
        SiteLog_controller.addMessage('JobApplicationComponentController1', 'captchaVerified', '');
        System.debug('==== challenge > ' + challenge + ' ==== response > ' + response);
        if (challenge != null && response != null)
        {
            System.debug(logginglevel.ERROR, '::challenge != null && response != null' + challenge + ' '+ response);
            SiteLog_controller.addMessage('JobApplicationComponentController1', 'captchaVerified', 'challenge=' + challenge);
            SiteLog_controller.addMessage('JobApplicationComponentController1', 'captchaVerified', 'response=' + response);
            SiteLog_controller.addMessage('JobApplicationComponentController1', 'captchaVerified', 'baseUrl=' + baseUrl);
            System.debug('!!!!!!!!!!!!baseUrl=' + baseUrl);

            HttpResponse r = makeRequest(baseUrl,
                    'privatekey=' + secret +
                    '&remoteip=' + remoteHost +
                    '&challenge=' + challenge +
                    '&response=' + response +
                    '&error=incorrect-captcha-sol');

            SiteLog_controller.addMessage('JobApplicationComponentController1', 'captchaVerified', 'baseUrl=' + baseUrl);
            System.debug('!!!!!!!!!!1!baseUrl=' + baseUrl);

            SiteLog_controller.addMessage('JobApplicationComponentController1', 'captchaVerified', 'r=' + r);

            System.debug(logginglevel.ERROR, '::r != null' + r);



            // is null when test methods run
            if (r != null)
            {
                System.debug(logginglevel.ERROR, '::r != null' + r.getBody().contains('true'));

                SiteLog_controller.addMessage('JobApplicationComponentController1', 'captchaVerified', 'r.getBody()=' + r.getBody());
                return r.getBody().contains('true');
            }
        }

        System.debug(logginglevel.ERROR, '::return');

        return false;
    }

    public static HttpResponse makeRequest(string url, string body)
    {
        SiteLog_controller.addMessage('JobApplicationComponentController1', 'makeRequest', 'url='+ url);

        System.debug('!!!!!!!!!!!!url=' + url);

        SiteLog_controller.addMessage('JobApplicationComponentController1', 'makeRequest', '!!!!!!!!!!!!body='+ body);

        System.debug('!!!!!!!!!!1!body=' + body);


        HttpRequest req = new HttpRequest();
        HttpResponse response = null;
        req.setEndpoint(url);
        req.setMethod('POST');
        req.setBody(body);

        SiteLog_controller.addMessage('JobApplicationComponentController1', 'makeRequest', '!!!!!!!!!!!!req='+ req);

        System.debug('!!!!!!!!!!!!req=' + req);


        try
        {
            Http http = new Http();
            response = http.send(req);

            System.debug('!!!!!req=' + req);
            System.debug('::response: '+ response);
            System.debug('::body: '+ response.getBody());
        }
        catch(System.Exception e)
        {
            System.debug('::ERROR: '+ e);
        }

        return response;
    }

    public string remoteHost
    {
        get
        {
            string ret = '127.0.0.1';

            // also could use x-original-remote-host
            Map<String, String> hdrs = ApexPages.currentPage().getHeaders();
            if (hdrs.get('x-original-remote-addr') != null)
                ret = hdrs.get('x-original-remote-addr');
            else if(hdrs.get('X-Salesforce-SIP') != null)
                ret = hdrs.get('X-Salesforce-SIP');

                System.Debug('!!!!!!!!!!!ret='+ ret);
            return ret;
        }
    }

    // *************reCaptcha end********************************

    // global static testmethod void tstRegisterBlock() { }

   static testmethod void registerContactTestScenario(){
               
    
      Account testAcc = new Account(Name = 'TestAcc');
            insert testAcc;
      
      CMSSettings__c CMS = new CMSSettings__c();
              CMS.Candidate_Duplicate_Record_Email__c='support@cirrologix.com';
              CMS.Candidate_Duplicate_Record_Error_Messa__c='Duplicate email';
              CMS.Name='cirrologix';
              CMS.ConfirmPasswordError__c='Error';
              CMS.ErrorsReceiver__c='support@cirrologix.com';
      insert CMS;
            
             
       Page__c testPage = new Page__c(Name = 'TestPage', Name__c = 'TestPage');

                SiteProfile__c testCMSProfile = new SiteProfile__c( Name = 'TestProfile',   
                Need_Registration_Approval__c = true,
                Name__c = 'TestProfile',
                Profile_Account__c = testAcc.id,
                Force_com_Authorization_and_Registration__c = true,
                User_Registration__c = true, 
                Default_Home_Page__c = testPage.id);
        insert testCMSProfile;
        
        
        
         system.debug('SiteProfile Inserted'+ [select Name__c From SiteProfile__c]);
        
        
      /*  Contact cont = new Contact();
        cont.FirstName = 'test';
        cont.LastName = 'test';
        cont.UserName__c = 'asddsa@asddsa.com';
        cont.Email = 'gm@gm.com';
        cont.Password__c = 'testPassword12';
        cont.SiteProfile__c = testCMSProfile.Id;
        //cont.AccountId = profile.Profile_Account__c;
        //cont.Profile_Manager_Email__c = profile.Profile_Manager__r.Email;
        //cont.Registration_Approved__c = !profile.Need_Registration_Approval__c;
        //cont.PortalEmailAlert__c = System.Label.User_Created;
        //cont.LeadSource = System.Label.Online;
        
        insert cont; 
        
        Profile p =[ select Name , UserType  from Profile where Id ='00e90000000TjZrAAK'];
        system.debug(+p);
        User u =[select UserRoleId from User where UserType =:p.UserType];
        system.debug(+u);  */
        
         User usr = new User();
      usr.LastName='CEO1';
      usr.UserName='CEO123@gm.com';
      usr.Email='ceo123@gm.com';
      usr.Alias='CEO1';
      usr.CommunityNickname='ceo123' ;
      usr.TimeZoneSidKey='America/Los_Angeles';  
      usr.LanguageLocaleKey='en_US';
      usr.LocaleSidKey='en_US';
      usr.EmailEncodingKey='Iso-8859-1';
      //usr.UserRoleId = u.UserRoleId;
      usr.ProfileId='00e5i000001Aazs';
      //usr.PortalRole = 'Manager';
      //usr.UserType =p.UserType;
      //usr.UserRoleId = '00E90000000xOg0EAE';
      //usr.IsPortalEnabled = true;
      usr.IsActive = true;
      //usr.ContactId = cont.Id;
      //usr.AccountId = testAcc.Id;
           
      insert usr;
      system.debug('User Inserted');
      system.debug('User Inserted'+ [select Name From User]);
      
     
            
             

        RegisterBlock controller = new RegisterBlock();
        
            //controller.cont = [Select FirstName,LastName,UserName__c,Email,Password__c FROM Contact WHERE FirstName ='suresh'];
        
        //    System.Debug('!!!!!!!!!cont = '+cont);
        controller.init();

     //   Map<String,Schema.RecordTypeInfo> recordTypes =
     //                   Contact.sObjectType.getDescribe().getRecordTypeInfosByName();

        controller.setContact(new Contact(Password__c = 'testPassword12',
            FirstName = 'test', LastName = 'test', Email = 'asddsa@asddsa.com',
            UserName__c = 'gm15@gm.comm', SiteProfile__c = 'a009000000AP1X4AAL',
            
            Registration_Approved__c = true));
//RecordTypeId = recordTypes.values()[1].getRecordTypeId(),
        ApexPages.currentPage().getHeaders().put('X-Salesforce-SIP','X-Salesforce-SIP');

        controller.confirmPassword = controller.getContact().Password__c;

       // controller.getCmsCssCustom();
        controller.getProfileFlag();
        controller.getContact();
        controller.getItems();
        controller.registerUser();
       controller.getLoginPage();
    }

     static testmethod void incorrectRegisterTest() {
        Account testAcc = new Account(Name = 'TestAcc');
        insert testAcc;

     
        SiteProfile__c testCMSProfile = new SiteProfile__c( Name = 'TestProfile',
                Need_Registration_Approval__c = true,
                Name__c = 'TestProfile',
                Force_com_Authorization_and_Registration__c = true,
                User_Registration__c = false);
        insert testCMSProfile;
      
        

        ApexPages.currentPage().getHeaders().put('x-original-remote-addr','x-original-remote-addr');

        RegisterBlock controller = new RegisterBlock();
        
        controller.init();
        controller.captchaIsShow=true;
        controller.setContact(new Contact(Password__c = 'sammas',
            FirstName = 'sam', LastName = 'sam', Email = 'sam@sam.com',
            UserName__c = 'sam15@sam.com', SiteProfile__c = 'a009000000AP1X4AAL'));

        controller.confirmPassword = controller.getContact().Password__c;

        //controller.getCmsCssCustom();
        controller.getProfileFlag();
        controller.getContact();
        controller.getItems();
        controller.challenge = 'qqqq';
        controller.response = 'qqqq';
        controller.captchaVerified();
        String remoteHost = controller.remoteHost;
        controller.registerUser();
       controller.selectLanguage='en_US';
        
    } 
    
     static testmethod void incorrectRegisterTest1() {
        Account testAcc = new Account(Name = 'TestAcc');
        insert testAcc;

     
        SiteProfile__c testCMSProfile = new SiteProfile__c( Name = 'TestProfile',
                Need_Registration_Approval__c = true,
                Name__c = 'TestProfile',
                Force_com_Authorization_and_Registration__c = true,
                User_Registration__c = false);
        insert testCMSProfile;
        
      

        ApexPages.currentPage().getHeaders().put('x-original-remote-addr','x-original-remote-addr');

        RegisterBlock controller = new RegisterBlock();
        
        controller.init();
        controller.captchaIsShow=true;
        controller.setContact(new Contact(Password__c = 'sammas',
            FirstName = '', LastName = '', Email = 'sam@gmail.com',
            UserName__c = 'sam15@gmail.com', SiteProfile__c = 'a009000000AP1X4AAL'));

        controller.confirmPassword = controller.getContact().Password__c;

       // controller.getCmsCssCustom();
        controller.getProfileFlag();
        controller.getContact();
        controller.getItems();
        controller.challenge = 'qqqq';
        controller.response = 'qqqq';
        controller.captchaVerified();
        String remoteHost = controller.remoteHost;
        controller.registerUser();
       controller.selectLanguage='en_US';
        
    }
}