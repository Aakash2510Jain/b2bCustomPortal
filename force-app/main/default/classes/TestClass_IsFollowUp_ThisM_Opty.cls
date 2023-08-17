@IsTest
private class TestClass_IsFollowUp_ThisM_Opty {
/*static testMethod void myUnitTest_SalesReport_ThisM_Opty(){

User u1= [select id from User where alias='AUser' limit 1];
List<Lead> listLead = new List<Lead>();
Lead l1= new Lead();
l1.Company='1';
l1.Ownerid=u1.id;
l1.lastname='testclass';
l1.Status='Working';
l1.CreatedDate=system.Today();
l1.Division_Name__c='Gladiators';
l1.isFollowUp__c = false;
l1.Team_Identification__c='Content';
l1.LeadSource='SEO Leads';
listLead.add(l1);

insert listLead;

List<Opportunity> listOpty = new List<Opportunity>();

Opportunity opty= new Opportunity ();
opty.StageName = 'Deal';
opty.Sample_To_Deal__c='ADAMS';
opty.ADAMS_Reference_Key__c='123456';
opty.CloseDate=system.Today();
opty.CreatedDate=system.Today();
opty.Ownerid=u1.id;
opty.name='optytest';
opty.Opplead_id__c='testid';
opty.Division__c='Jaguars';
//opty.Reason_For_Unqualified_Lost__c='test ignore';

listOpty.add(opty);

insert listOpty;
List<Task> listTask = new List<Task>();
Task T=new Task();
T.Subject='Call';
T.Status='Completed';
T.OwnerId=u1.Id;
T.WhatId=opty.Id;
listTask.add(T);

Insert listTask;

List<Event> listEvent = new List<Event>();
Event E=new Event ();
E.Subject='Call';
E.OwnerId=u1.Id;
E.WhatId=opty.Id;
E.EndDateTime=system.NOW();
E.StartDateTime=system.NOW();
listEvent.add(E);
insert listEvent;

for(Lead loopLead : listLead){
loopLead.isFollowUp__c = false;
}
for(Opportunity loopOpty : listOpty){
loopOpty.isFollowUp__c = false;
}

update listLead;
update listOpty;

SalesReport_Update_IsFollowUp followup=new SalesReport_Update_IsFollowUp();
followup.getCurrentMonthInfo_Oppty();

    }*/
}