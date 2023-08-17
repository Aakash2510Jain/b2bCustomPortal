/*Following Code is written to perform below task:
1. To fetch AccountName from contact where the entered email id in lead record match with the contact email id.
And update the Account name to Account_Name__c field in Lead record.
2. If no contact find with entered email id ,then it will search for Accounts and fetch the AccountName where the match finds.
*/

trigger Account_contact_namefetch on Lead (before insert, before update, after undelete) {

//lacc means List of Accounts
//lcon means List of Contacts
List<Account> lacc = new List<Account>();
List<Contact> lcon = new List<Contact>();
set <ID> slid = new set <ID> ();
set <string> semail = new Set<String>();
//Map<ID, Email>

//if( Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete )
for ( Lead  ltrigger : Trigger.new){
slid.add(ltrigger.id);
semail.add(ltrigger.Email);
}

lcon= [select id ,Name ,Account.Id, Email from Contact where Email IN :semail ]; 
lacc= [select id,Name, Email__c from Account where Email__c IN :semail limit 2000 ]; 
for ( Lead l : Trigger.new ){
for ( Contact c : lcon){
if(c.Email== l.Email)
l.Account_Name__c= c.Account.Id;
break;
}
}
for ( Lead l1 : Trigger.new ){
for ( Account acc : lacc){
if(acc.Email__c== l1.Email)
l1.Account_Name__c= acc.Id;
break;
}
}
}