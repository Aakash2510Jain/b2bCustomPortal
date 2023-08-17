@isTest
private class TestCountTask 
{
    static testMethod void CountTask()
    {
        Lead l1= new Lead();
        l1.Company = '1';
        l1.lastname='testclass';
        l1.Status='Followup';
        l1.Team_Identification__c='LeadGen';
        l1.Email='test1234@test.com';
        l1.division_name__c = 'winners';
        insert l1;
        Task T1 = New Task(whoid=l1.id,Status='Open');
        Insert t1;
        Event E1 = New Event(whoid=l1.id,DurationInMinutes=10,ActivityDateTime=System.Today());
        Insert E1;
        
       
        
account a = new account();
a.name = 'test';
a.email__c='a@a.com';
//insert a;        
Opportunity O1= new Opportunity();
o1.Name='test';
o1.accountid = a.id;
o1.division__c='Winners';
o1.StageName='Warm';
o1.Opplead_id__c='1234';
o1.CloseDate=date.today();
insert o1;
Task T2 = New Task(whatid=O1.id,Status='Open');
Insert t2;
Event E2 = New Event(whatid=O1.id,DurationInMinutes=10,ActivityDateTime=System.Today());
Insert E2;
    }
}