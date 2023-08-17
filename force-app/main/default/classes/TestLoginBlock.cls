@isTest
public class TestLoginBlock {
static testMethod void testLoginBlock() {
      Account CL = new Account();
      CL.AccountNumber='1234567';
      CL.BillingCountry='India';
      CL.Name='cirrologix';
      insert CL;
      CMSSettings__c CMS = new CMSSettings__c();
      CMS.Candidate_Duplicate_Record_Email__c='support@cirrologix.com';
      CMS.Candidate_Duplicate_Record_Error_Messa__c='Duplicate Email';
      CMS.LoginObject__c='LeadFormUsers__c';
      CMS.ConfirmPasswordError__c='Entered Password and Confirm password doesnt match';
      CMS.ErrorsReceiver__c='Sample@cirrologix.com';
      CMS.Name='Cirrologix';
      insert CMS; 
      System.debug('CMS RECORD INSERTED :'+CMS);
      Page__c amp = new Page__c();
    amp.Name ='Test Page';
    amp.Active__c = TRUE;
    amp.Name__c  = 'TEst';
    insert amp;          
      SiteProfile__c sp = new SiteProfile__c();
    sp.Default_Home_Page__c = amp.id;
    sp.Approval_Message_Page__c = amp.id;
    insert sp;    
      LeadFormUsers__c lef = new LeadFormUsers__c();      
    lef.UserName__c = 'rajeev.r@championsmail.com.com';
    lef.Password__c = 'cloud17';
    lef.Name = 'demo4';
    lef.Employee_Real_Name__c = 'Rajeev';
    lef.Employee_Number__c = 'CIPL9999' ;     
    lef.Division__c = 'Rainmakers';
    lef.EMail_ID__c = 'demo1@scs.com';
    lef.SiteProfile__c  = sp.id;
    insert lef;    
    system.debug('_______________'+lef.id);
      LoginBlock log =new LoginBlock();      
      Apexpages.currentPage().getParameters().put('username','rajeev.r@championsmail.com.com');
      Apexpages.currentPage().getParameters().put('password','cloud17');        
      log.login();
      Apexpages.currentPage().getParameters().put('username','pruthvi.kr@istrategicloud.com');
      Apexpages.currentPage().getParameters().put('password','qwer');
      log.login();      
      log.cmsCssCustom='testing';        
      
    }
}