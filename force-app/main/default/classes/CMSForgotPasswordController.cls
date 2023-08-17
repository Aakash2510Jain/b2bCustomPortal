public  class CMSForgotPasswordController {

    public String userName {get; set;}

    public CMSForgotPasswordController() {
    }

    public PageReference forgotPassword() {
    	List<User> customerPortalUser  = new List<User>();
    	customerPortalUser = SiteUtility.getUserAssingToContact(username.tolowercase());
 		if(customerPortalUser.size() > 0 && customerPortalUser[0].Contact.SiteProfile__r
 			.Force_com_Authorization_and_Registration__c){

 			System.debug('::::::if ');

	 		boolean success = Site.forgotPassword(username.tolowerCase());

	 		System.debug('::::::if success=' + success);
  
	        PageReference pr = new PageReference('/apex/SiteView');
            pr.getparameters().put('page','CMSForgotPasswordConfirm');
	        pr.setRedirect(true);

	        System.debug(success);

	        if (success) {
	            return pr;
	        }
	        else{

		        return null;
	        }
 		}
    	else{
      if (!isValid()) {
        return null;
      }
        List<Contact> contacts;
        if (userName != null && userName != '') {

        	System.debug(':::::::::::::;else');

            contacts = [select Name,Password__c ,PortalEmailAlert__c,Email,UserName__c from Contact
                        where UserName__c = :userName.tolowerCase()];
            if (contacts.size() == 0) {
                addErrorMessage('User not found');
                return null;
            }else{
                try{
                    contacts[0].PortalEmailAlert__c = 'Forgot Password';
                    update contacts;
                    PageReference pr = new PageReference('/apex/SiteView');
                    pr.getparameters().put('page','CMSForgotPasswordConfirm');
                    pr.getparameters().put('jobSite',ApexPages.currentPage().getParameters().get('jobSite'));
                    pr.getparameters().put('p',ApexPages.currentPage().getParameters().get('p'));
                    pr.setRedirect(true);
                    return pr;
                }
                catch(Exception e){
                    addErrorMessage(System.Label.Error_double_dot+e);
                    return null;
                }
            }
        }
    	}
        return null;
    }

    public boolean isValid() {
      boolean valid = true;

      if (userName == '') {
        addErrorMessage(System.Label.User_name_is_required);
        valid = false;
      }

      return valid;
    }
    public PageReference backToHome(){
        PageReference pg = new PageReference('/apex/SiteView');
        pg.getparameters().put('page','LoginPage_view');
        pg.getparameters().put('jobSite',ApexPages.currentPage().getParameters().get('jobSite'));
        pg.getparameters().put('p',ApexPages.currentPage().getParameters().get('p'));
        pg.setRedirect(true);
        return pg;
    }
    private void addErrorMessage(String message) {
        ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, message);
        ApexPages.addMessage(msg);
    }
    public static testmethod void tstCMSForgotPasswordController(){
        List<Account> accList = [select id from Account where Name = 'Candidate Pool2'];
        if(accList.size()>0){
            delete accList;
        }
        Account account = new Account();
        account.Name = 'Candidate Pool2';
        insert account;
        List<SiteProfile__c> profileList = [select id from SiteProfile__c];
        delete profileList;
        SiteProfile__c cmsProfile = new SiteProfile__c();
        cmsProfile.Name__c = 'CMSDefaultProfile';
        cmsProfile.Profile_Account__c = account.id;
        cmsProfile.CMSCss__c = 'CMSCssCustom';
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
        CMSForgotPasswordController forgotPasswordController = new CMSForgotPasswordController();
        forgotPasswordController.backToHome();
        forgotPasswordController.userName='';
        forgotPasswordController.forgotPassword();
        forgotPasswordController.userName=contact.UserName__c;
        forgotPasswordController.forgotPassword();
        forgotPasswordController.userName='kdfgjfsdak';
        forgotPasswordController.forgotPassword();
        forgotPasswordController.addErrorMessage('hello');
    }
}