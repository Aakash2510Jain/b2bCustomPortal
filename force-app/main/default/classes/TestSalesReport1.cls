@isTest
private class TestSalesReport1 {
static testMethod void myUnitTest(){

account a = new account();
a.name = 'test';
a.email__c='a@a.com';
insert a;

    

Opportunity l1= new Opportunity();
l1.Name='test';
l1.accountid = a.id;
l1.division__c='Winners';
l1.StageName='Demo Call';
l1.Opplead_id__c='1234';
l1.CloseDate=date.today();
insert l1;


Opportunity l= new Opportunity();
l.Name='test';
l.accountid = a.id;
l.division__c='Winners';
l.StageName='Demo Call';
l.Opplead_id__c='1234';
l.CloseDate=date.today();
insert l;

l.StageName='Demo Call';
update l;
delete l1;

}}