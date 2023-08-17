@isTest
private class TestClass_For_SpamEmailTrigger {
static testMethod void unittest() {

Spam_Email__c se1 = new Spam_Email__c();
se1.Name='test@test.com';
insert se1;
Spam_Domain__c sd1 = new Spam_Domain__c();
sd1.Name='tst.co.in';
insert sd1;
try{
Lead l1= new Lead();
l1.Status ='Open - Not Contacted';
l1.lastname='test1';
l1.Company='testcom';
l1.Email = 'test@test.com';
insert l1;
}catch(Exception e){
}
try{
Lead l2= new Lead();
l2.Status ='Open - Not Contacted';
l2.lastname='test1';
l2.Company='testcom';
l2.Email = 'test@tst.co.in';
insert l2;
}catch(Exception e){
}
try{
Lead l3= new Lead();
l3.Status ='Open - Not Contacted';
l3.lastname='test1';
l3.Company='testcom';
l3.Email = 'test@test.in';
insert l3;
}catch(Exception e){
}
}
}