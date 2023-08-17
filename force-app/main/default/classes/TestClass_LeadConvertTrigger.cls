@isTest
private class TestClass_LeadConvertTrigger {
static testMethod void myUnitLeadConvert(){

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
Lead l1= new Lead();
l1.Company='1';
// User u1= [select id from User where alias='AUser' limit 1];
l1.Ownerid=u1.id;
l1.lastname='testclass';
l1.Status='Working';
insert l1;
//l1.IsConverted =true;
update l1;
   } 
}