@isTest
private class Testclass_For_120dayslead {
static testMethod void myUnitTest_Leadfor120(){
Lead l1= new Lead();
l1.Company = '1';
l1.lastname='testclass';
l1.Status='Working';
l1.Team_Identification__c='LeadGen';
l1.Email='test1234@test.com';
insert l1;

delete l1;

try{
Lead l2= new Lead();
l2.Company='1';
l2.lastname='testclass';
l2.Email='test1234@test.com';
l2.Status='Qualified - Convert';
insert l2;
}catch(Exception e){}
}
}