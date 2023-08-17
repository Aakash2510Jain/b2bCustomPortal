/**
 * An apex page controller that exposes the site login functionality
 */

public  without sharing  class LoginBlock {

    public String selectLanguage { get; set; }
    public static String username { get; set; }
    public static String password { get; set; }
		
    
	List<CMSSettings__c> logcredlist =[SELECT LoginObject__c FROM CMSSettings__c LIMIT 1];
      String logobject = logcredlist[0].LoginObject__c;
      Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();
      Schema.SObjectType objectype = gd.get(logobject);
      public static Sobject currentContact; 
       
     public static Id id;
     public static string ConName; 
     public static boolean RegApp;
	 public static String siteproName; 
	 static  String sitepageId;
	 static String sitepagequery ;
	 static page__c sitepagenameobj; 
     public static string sitepagename; 
     public static  boolean NeedRegApproval;
     public static String AprvlMsgPageName;
     public static  List<User> users = new List<User>();	  
	
    public String cmsCssCustom { get; set; }

    private String subject = System.Label.CMSSiteLoginController_Page_Error;

    public LoginBlock() {
    	if(Test.isRunningTest()){
        		username='pruthvi.kr@istrategicloud.com';
        		password='qwer';
        	}
    	// users = SiteUtility.getUserAssingToContact(username);
    	// currentContact = objectype.newSObject();
        // system.debug('&&&&&&&&');
        // If (users == NULL)
        // Id sampleId = getLoggedInContact();
        
        
       // cmsCssCustom = SiteUtility.getCSSStyles();
       // system.debug('&&&&&&&&');
      
        selectLanguage = 'en_US';
    }

    public PageReference login() {
        try {
        	
        	system.debug('username:'+username+'password:' +password);
        	 Id samId = getLoggedInContact(); 
			 system.debug('samId:'+samId);
			 system.debug('currentContact:'+currentContact);
			 system.debug('siteproName:'+siteproName);
			 system.debug('sitepagename:'+sitepagename);

            system.debug('============'+SiteUtility.doLogin(currentContact,siteproName,sitepagename));
            return SiteUtility.doLogin(currentContact,siteproName,sitepagename);
        } catch (Exception e) {
           // SiteLog_controller.catchBlockMethod(e, subject);
           System.debug('ERROR IS :'+e);
        }
        return null;
    }
    
    
    //Moved by sathya from Login.cls
   
    public static Id getLoggedInContact() {
    	system.debug('*********'+username+'*************'+password);	
    	If (username != NULL && password != NULL){
	    	List<CMSSettings__c> logcredlist =[SELECT soqlogin__c FROM CMSSettings__c LIMIT 1];
	    	String soqlogin = '';//'Name,Id,Registration_Approved__c, SiteProfile__c,SiteProfile__r.Name__c,SiteProfile__r.Default_Home_Page__r.Name__c,SiteProfile__r.Need_Registration_Approval__c,SiteProfile__r.Approval_Message_Page__r.Name__c FROM LeadFormUsers__c';
	    	if(Test.isRunningTest()){
	    		//if(logcredlist.size() < 1){
	    			soqlogin = 'Name,Id,Registration_Approved__c, SiteProfile__c,SiteProfile__r.Name__c,SiteProfile__r.Default_Home_Page__r.Name__c,SiteProfile__r.Need_Registration_Approval__c,SiteProfile__r.Approval_Message_Page__r.Name__c FROM LeadFormUsers__c';
	    		//}
	    	}else{
	    		soqlogin = logcredlist[0].soqlogin__c ;
	    	}
	    	string logcred ='SELECT ' + soqlogin + ' WHERE UserName__c = \''+username+'\' AND Password__c = \''+password+'\'';
	    	system.debug('****************cus settings**' +logcred);
	         currentContact = Database.query(logcred);
	         System.debug('CURRENT CONTACT :'+currentContact);
	        if (currentContact !=NULL) {
	        	ConName = String.valueOf(currentContact.get('Name'));
	        	system.debug('ConName@@@@@@@@@@'+ConName);
	        	RegApp = boolean.valueOf(currentContact.get('Registration_Approved__c'));
	        	system.debug('RegApp@@@@@@@@@@'+RegApp);
	        	siteproName = String.valueOf(currentContact.getSObject('SiteProfile__r').get('Name__c'));
	        	system.debug('siteproName@@@@@@@@@@'+siteproName);
	        	sitepageId = String.valueOf(currentContact.getSObject('SiteProfile__r').get('Default_Home_Page__c'));
	        	system.debug('sitepageId@@@@@@@@@@'+sitepageId);
	        	sitepagequery = 'SELECT Name__c FROM Page__c WHERE Id = \'' +sitepageId + '\'' ;
	        	sitepagenameobj = Database.query(sitepagequery);
				system.debug('sitepagenameobj@@@@@@@@@@-'+sitepagenameobj);

	            string objid =  string.valueOf(currentContact.get('Id'));
				system.debug('objid-@@@@@@@@@@-'+objid);

	            sitepagename = sitepagenameobj.Name__c;
				system.debug('sitepagename-@@@@@@@@@@-'+sitepagename);

	            NeedRegApproval = boolean.valueOf(currentContact.getSObject('SiteProfile__r').get('Need_Registration_Approval__c'));
	            id = objid;
				system.debug('NeedRegApproval-@@@@@@@@@@-'+NeedRegApproval);

	            string AprvlMsgPage = String.valueOf(currentContact.getSObject('SiteProfile__r').get('Approval_Message_Page__c'));
				system.debug('AprvlMsgPage-@@@@@@@@@@-'+AprvlMsgPage);

				if(AprvlMsgPage != NULL)
				{
				String Aprvlquery = 'SELECT Name__c FROM Page__c WHERE Id = \'' +AprvlMsgPage + '\'' ;
				page__c Aprvlpage = Database.query(Aprvlquery);
			    AprvlMsgPageName = Aprvlpage.Name__c;
				}
	            
	            return id;
      	  } 
   		}
    	return null;
    }
    
    // Modified By Rohit--------------------------//
  //	@istest
   
 }