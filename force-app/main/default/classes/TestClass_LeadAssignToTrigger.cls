@isTest
private class TestClass_LeadAssignToTrigger {
static testMethod void myUnitTest_AssignTo(){
//User u1= [select id from User where alias='AUser' AND Rollup_should_hapen__c=false limit 1];
//update u1;
Profile p = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];

    User u1 = new User(
      Alias = 'AUser',
      Email = 'teste@unitingambition.com',
      EmailEncodingKey = 'UTF-8',
      LastName = 'Test',
      LanguageLocaleKey = 'en_US',
      LocaleSidKey = 'en_US',
      TimeZoneSidKey='America/Los_Angeles',
      ProfileId = p.Id,
      Rollup_should_hapen__c=false,
      UserName='testdev@unitingambition.com'
    );

    INSERT u1;
    System.runAs(u1){

LeadFormUsers__c LFU=new LeadFormUsers__c();
LFU.Name='Deepak';
LFU.EMail_ID__c='test@testmail.com';
insert LFU;
LeadFormUsers__c LFU1=new LeadFormUsers__c();
LFU1.Name='Zabi';
LFU1.EMail_ID__c='test1@testmail.com';
insert LFU1;

Lead l1= new Lead();
l1.Company='1';
l1.Ownerid=u1.id;
l1.lastname='testclass';
l1.Status='Working';
l1.User_Name_LeadGen__c='Deepak';
l1.Division_Name__c='Cuesent';
l1.Email = 'sample@sample.com';
insert l1;
l1.User_Name_LeadGen__c='Zabi';
update l1;


}
}

}