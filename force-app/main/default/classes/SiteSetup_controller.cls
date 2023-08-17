public class SiteSetup_controller {
   public PageReference setSiteSetupForContact()
    {
        //Creating or editing to default setting for CMSDefaultProfile.
        List<SiteProfile__c> cmsProfileList = [
                SELECT Name, Profile_Manager__c, Profile_Account__c,
                       Name__c, Default_Home_Page__c
                FROM SiteProfile__c
                WHERE Name__c = 'CMSDefaultProfile'];

        if(cmsProfileList.size() == 0)
        {
            List<Account> accList = [
                    SELECT Name
                    FROM Account
                    LIMIT 1];
            if(accList.size() == 0)
            {
                accList.add(new Account(Name = 'CMSDefaultProfileAccount'));
                insert accList;
            }

            List<Page__c> pageList = [
                    SELECT Name,Name__c
                    FROM Page__c
                    WHERE Name__c = 'CMSDefaultProfilePage'];
            if(pageList.size() == 0)
            {
                pageList.add(new Page__c(
                        Name = 'CMSDefaultProfilePage',
                        Name__c = 'CMSDefaultProfilePage',
                        Active__c = true));
                insert pageList;
            }

            SiteProfile__c cmsProfile = new SiteProfile__c();
            cmsProfile.Name = 'CMSDefaultProfile';
            cmsProfile.Name__c = 'CMSDefaultProfile';
            cmsProfile.Profile_Account__c = accList[0].id;
            cmsProfile.Default_Home_Page__c = pageList[0].id;
            cmsProfile.Profile_Manager__c = UserInfo.getUserId();
            cmsProfile.Portal_Enabled__c = true;
            cmsProfile.User_Registration__c=true;
            cmsProfile = SiteProfile_extension.setupProfile(cmsProfile);
        }

        setupConfigSetting('ErrorsReceiver__c', System.Label.ErrorsReceiver);
        setupConfigSetting('ConfirmPasswordError__c', System.Label.ConfirmPasswordError);
        setupConfigSetting('PasswordError__c', System.Label.PasswordError);
        setupConfigSetting('ProfileUpdatedMsg__c', System.Label.ProfileUpdatedMsg);
       //TODO-SCS setupConfigSetting('SessionTimeout__c', System.Label.SessionTimeout);
        setupConfigSetting('Send_Logs__c', System.Label.Send_Logs);
        setupConfigSetting('Captcha_failed_message__c', System.Label.Captcha_failed_message);
        setupConfigSetting('Password_Email_Error__c', System.Label.Password_Email_Error);
        setupConfigSetting('Candidate_Duplicate_Record_Error_Messa__c', System.Label.Candidate_Duplicate_Record_Error_Messa);
		setupConfigSetting('Candidate_Duplicate_Record_Email__c', System.Label.Candidate_Duplicate_Record_Email);
        // Show message that setup was successfull.
        ApexPages.addMessage(new ApexPages.Message(
                ApexPages.Severity.INFO, System.Label.Configuration_setup_has_been_successfully_completed));

        return null;
    }

    private void setupConfigSetting(String configName, Object configDefaultValue)
    {
    	System.debug('ConfigHelper.getConfigSetting for ----'+configName);
       // Object obj = ConfigHelper.getConfigSetting(configName);
        Object obj = SiteConfig_controller.getConfigSetting(configName);
        if (obj == null)
            SiteConfig_controller.setConfigSetting(configName,configDefaultValue);
    }

    public static testmethod void tstSiteSetup_controller()
    {
        SiteSetup_controller siteSetup= new SiteSetup_controller();
        siteSetup.setSiteSetupForContact();
        SiteSetup_controller siteSetup1= new SiteSetup_controller();
        siteSetup1.setSiteSetupForContact();

        delete [SELECT Id FROM SiteProfile__c WHERE Name__c = 'CMSDefaultProfile'];
        delete [SELECT Id FROM Account WHERE Name = 'CMSDefaultProfileAccount1'];
        delete [SELECT Id FROM Page__c WHERE Name__c = 'CMSDefaultProfilePage'];

        SiteSetup_controller siteSetup2= new SiteSetup_controller();
        siteSetup2.setSiteSetupForContact();
    }

}