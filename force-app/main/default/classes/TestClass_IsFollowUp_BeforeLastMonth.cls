@IsTest
private class TestClass_IsFollowUp_BeforeLastMonth {
/*static testMethod void myUnitTest_SalesReport_BeforeMonth(){

date dt= date.today();  
       dt = dt-60;
       Date dt1 = dt.toStartOfMonth();
       integer noOfDays = date.daysInMonth(dt1.year(),dt1.month());
       Date dt2 = date.newInstance(dt1.year(),dt1.month(),noOfDays); 
             
User u1= [select id from User where alias='AUser' limit 1];
List<Lead> listLead = new List<Lead>();
Lead l1= new Lead();
l1.Company='1';
l1.Ownerid=u1.id;
l1.lastname='testclass';
l1.Status='Working';
l1.CreatedDate=dt2;
l1.Division_Name__c='Gladiators';
l1.isFollowUp__c = false;
l1.Team_Identification__c='Content';
l1.LeadSource='SEO Leads';
listLead.add(l1);

insert listLead;
/*
List<Opportunity> listOpty = new List<Opportunity>();

Opportunity opty= new Opportunity ();
opty.StageName = 'Deal';
opty.CloseDate=dt2;
opty.CreatedDate=dt2;
opty.Ownerid=u1.id;
opty.name='optytest';
opty.Opplead_id__c='testid';
opty.Division__c='Jaguars';
listOpty.add(opty);

insert listOpty;
    */
    /*..
List<Task> listTask = new List<Task>();
Task T=new Task();
T.Subject='Call';
T.Status='Completed';
T.OwnerId=u1.Id;
T.WhoId=l1.Id;
T.CREATEDDATE = dt2;
listTask.add(T);

Insert listTask;

List<Event> listEvent = new List<Event>();
Event E=new Event ();
E.Subject='Call';
E.OwnerId=u1.Id;
E.whoId=l1.Id;
E.EndDateTime=system.NOW();
E.StartDateTime=system.NOW();
E.CREATEDDATE =dt2;
listEvent.add(E);
insert listEvent;

for(Lead loopLead : listLead){
loopLead.isFollowUp__c = false;
}
    /*
for(Opportunity loopOpty : listOpty){
loopOpty.isFollowUp__c = false;
}
update listOpty;
    *//*..
update listLead;


SalesReport_Update_IsFollowUp followup=new SalesReport_Update_IsFollowUp();
followup.getBeforeLastMonthInfo();

    }*/
}