@isTest
public class TestUpdateCustomObject_Trigger {
    static testMethod void myUnitTest_CustomObject(){

/*Test code for FinanceReportLeadDealSample class */
User u1= [select id from User where alias='steam' limit 1];
List<Lead> listLead = new List<Lead>();
Lead l1= new Lead();
l1.Company='1';
l1.Ownerid=u1.id;
l1.lastname='testclass';
l1.Status='Working';
//l1.CreatedDate=System.today();
l1.Division_Name__c='Gladiators';
l1.isFollowUp__c = false;
l1.Team_Identification__c='Content';
l1.LeadSource='SEO Leads';
listLead.add(l1);

Lead l2= new Lead();
l2.Company='1';
l2.Ownerid=u1.id;
l2.lastname='testclass';
l2.Status='Working';
//l2.CreatedDate=System.today();
l2.Division_Name__c='Stallions';
l2.Team_Identification__c='Self Generated Lead';
l2.LeadSource='SEO Leads';
listLead.add(l2);


Lead l12= new Lead();
l12.Company='1';
l12.Ownerid=u1.id;
l12.lastname='testclass';
l12.Status='Working';
//l12.CreatedDate=System.today();
l12.Division_Name__c='Gladiators';
l12.isFollowUp__c = true;
l12.Team_Identification__c='Content';
l12.LeadSource='SEO Leads';
listLead.add(l12);

insert listLead;
List<Opportunity> listOpty = new List<Opportunity>();
Opportunity opty= new Opportunity ();
opty.StageName = 'Warm';
opty.CloseDate=System.today();
opty.Ownerid=u1.id;
opty.name='optytest';
opty.Opplead_id__c='testid';
opty.Division__c='Jaguars';
listOpty.add(opty);

Opportunity opty1= new Opportunity ();
opty1.StageName = 'Warm';
opty1.CloseDate=System.today();
opty1.Ownerid=u1.id;
opty1.name='optytest';
opty1.Opplead_id__c='testid';
opty1.Division__c='Spartans';
opty1.isFollowUp__c = false;
listOpty.add(opty1);

Opportunity opty2= new Opportunity ();
opty2.StageName = 'Warm';
opty2.CloseDate=System.today();
opty2.Ownerid=u1.id;
opty2.name='optytest';
opty2.Opplead_id__c='testid';
opty2.Division__c='Gladiators';
listOpty.add(opty2);
insert listOpty;

List<Sample_Request__c> listSR = new List<Sample_Request__c>();
Sample_Request__c SR1= new Sample_Request__c();
SR1.Name='TEST1';
SR1.Sample_Type__c='Custom Business List Sample';
SR1.Sample_Type_Description__c='TEST DESCRIPTION';
SR1.Opportunity__c=opty1.Id;
listSR.add(SR1);

Sample_Request__c SR= new Sample_Request__c();
SR.Name='TEST';
SR.Sample_Type__c='Custom Business List Sample';
SR.Sample_Type_Description__c='TEST DESCRIPTION';
SR.Lead__c=l1.Id;
listSR.add(SR);
insert listSR;


}

}