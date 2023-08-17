public class CMSLoginManagementController {
    public Sobject contact {get; set;}
    
    public String userName {get; set;}
    
    public void init()
    {
        Id contactId = LoginBlock.getLoggedInContact();
        
        /*s contact = (contactId != null)
                ? [SELECT Name,
                          SiteProfile__r.Default_Home_Page__r.Name__c,
                          SiteProfile__r.Name__c
                   FROM Contact 
                   WHERE id = :contactId]
                : new Contact(); */
              if  (contactId != null){
                contact =  LoginBlock.currentContact;
              } 
        userName = LoginBlock.id == null ? System.Label.Guest : LoginBlock.ConName;
    
    }
    public PageReference logout()
    {
        PageReference pg = new PageReference('/SiteView');
        pg.getParameters().put('jobSite', ApexPages.currentPage().getParameters().get('jobSite'));
        pg.getParameters().put('page', LoginBlock.sitepagename);
        pg.getParameters().put('p', LoginBlock.siteproName);
        pg.setRedirect(true);
        return pg;
    }
    
    public static testmethod void tstCMSLoginManagementController()
    {
        List<Account> accList = [select id from Account where Name = 'scs'];
        if(accList.size()>0){
            delete accList;
        }
        Account account = new Account();
        account.Name = 'scs';
        insert account;
        List<SiteProfile__c> profileList = [select id from SiteProfile__c];
        delete profileList;
        SiteProfile__c cmsProfile = new SiteProfile__c();
        cmsProfile.Name__c = 'CMSDefaultProfile';
        cmsProfile.Profile_Account__c = account.id;
        cmsProfile.CMSCss__c = 'CustomStyleSheet';
        cmsProfile.User_Registration__c = true;
        insert cmsProfile;
        
        Contact contact = new Contact();
        contact.FirstName = 'Ramesh';
        contact.LastName = 'Dhull';
        contact.UserName__c = 'dhull.ramesh@gmail.com';
        contact.Email = 'dhull.ramesh@gmail.com';
        contact.Password__c = 'avankia1';
        contact.SiteProfile__c = cmsProfile.id;
        insert contact;
        Map<String,String> headerMap = System.currentPageReference().getHeaders();
        String sessionString;
        sessionString = String.valueOf(Math.random());
        sessionString = sessionString.substring(2,12);
        Session__c session = new Session__c();
        session.Session_For__c = contact.Id;
        session.User_Agent__c=headerMap.get('User-Agent');
        session.IP_Address__c=headerMap.get('X-Salesforce-SIP');
        session.SessionId__c = sessionString;
        insert session;
        PageReference pg = new PageReference('/apex/SiteView');
        pg.getParameters().put('sessionId',session.SessionId__c);
        Test.setCurrentPageReference(pg);
        Test.startTest();
        CMSLoginManagementController loginManagement = new CMSLoginManagementController();
        loginManagement.init();
        loginManagement.logout();
        
        Test.stopTest();
    }
  
}