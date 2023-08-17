@isTest
private class TestClass_FinanceReport {

//Test code for Finance Report Class

static testMethod void myUnitTest_FinanceReport(){
/*User u1= [select id from User where alias='AUser' limit 1];
u1.Division = 'Winners';
update u1;
Lead l1= new Lead();
l1.Company='1';
l1.Ownerid=u1.id;
l1.lastname='testclass';
l1.Status='Working';
l1.CreatedDate=System.today();
l1.User_Name__c='frankb';
l1.Team_Identification__c = 'test';
l1.LeadSource = 'test';
l1.Division_Name__c='Gladiators';

insert l1;

Lead l2= new Lead();
l2.Company='1';
l2.Ownerid=u1.id;
l2.lastname='testclass';
l2.Status='Working';
l2.CreatedDate=System.today();
l2.User_Name__c='frankb';
l2.Team_Identification__c = 'test';
l2.LeadSource = 'test';
l2.Division_Name__c='Gladiators';

insert l2;

Opportunity opty2= new Opportunity ();
opty2.StageName = 'Warm';
opty2.CloseDate=System.today();
opty2.Ownerid=u1.id;
opty2.name='optytest';
opty2.Opplead_id__c='testid';
opty2.Uploaded_By__c='frankb';
opty2.Team_Uploaded_By__c = 'test';
opty2.LeadSource = 'test';
opty2.Division__c='Gladiators';
insert opty2;

Opportunity opty= new Opportunity ();
opty.Sample_To_Deal__c='OTHER';
opty.StageName = 'Deal';
opty.CloseDate=System.today();
opty.Ownerid=u1.id;
opty.name='optytest';
opty.Opplead_id__c='testid';
opty.Uploaded_By__c='frankb';
opty.Team_Uploaded_By__c = 'test';
opty.LeadSource = 'test';
opty.Division__c='Gladiators';
insert opty;

Opportunity opty1= new Opportunity ();
opty1.Sample_To_Deal__c='OTHER';
opty1.StageName = 'Deal';
opty1.CloseDate=System.today();
opty1.Ownerid=u1.id;
opty1.name='optytest';
opty1.Opplead_id__c='testid';
opty1.Uploaded_By__c='robinm_it';
opty1.Team_Uploaded_By__c = 'test';
opty1.LeadSource = 'test';
opty1.Division__c='Gladiators';
insert opty1; */

lead newlead=new lead();
    	newlead.Email='kavin.m@istrategicloud.com';
    	newlead.Division_Name__c='Rainmakers';
    	newlead.LeadSource='Approved Index';
    	newlead.Status='Followup';
    	newlead.Company = 'SOS';
    	newlead.FirstName='TestN';
    	newlead.LastName='TestJohn';
    	newlead.Primary_Service_Name__c='CRM';
    	newlead.LinkedIn_URL__c='karthik37/Linkedin.com';
    	newlead.Lead_AssignedTo__c='Deepak Guduru';
    	newlead.User_Name__c='test';
    	newlead.Team_Identification__c='Deepak Guduru';
    	insert newlead;
    	
    	Account acc=new Account();
      acc.Name='SOS';
      acc.Email__c='sample@in.com';
      acc.Phone='(954) 344-9254';
      acc.Type='Customer';
      acc.Lead_Uploaded_By__c='test';
      insert acc;
      system.debug('*acc*****************'+acc.id);
      
      Contact contact=new Contact();
      contact.AccountId=acc.id;
      contact.Email='sample@in.com';
      contact.LastName='Testjo';
      contact.FirstName='test';
      insert contact;
      
      Opportunity opp=new Opportunity();
      opp.Name='sample';
      opp.AccountId=acc.id;
      opp.Lead_Source__c='Approved Index';
      opp.Primary_Service_Name__c='Technology List';
      opp.Division__c='Gladiators';
      opp.StageName='Deal';
      opp.Sample_To_Deal__c='other';
      opp.Uploaded_By__c='test';
      opp.ForecastCategoryName='pipeline';
      opp.Amount=5000;
      opp.CloseDate=date.parse('1/13/2013');
      opp.Team_Uploaded_By__c='Winners'; 
      opp.EMt__C='idh';
      opp.Primary_Service_Name__c='CRM';
      insert opp;
      
      Opportunity_Payment__c opppay=new Opportunity_Payment__c();
        opppay.Opportunity__c=opp.id;
        opppay.Pay_Status__c='paid';
        opppay.Payment_Amount__c=23442;
        opppay.Payment_Mode__c='Cash';	
    	opppay.Payment_Date__c=date.parse('1/13/2013');
        opppay.Service_Type__c='test';
        insert opppay;

Report_Lead_Deal RLD=new Report_Lead_Deal();
RLD.calculateLeadOpty();
RLD.calculateLeadOpty2();
RLD.fromDate='2012-08-01';
RLD.toDate='2012-10-18';
RLD.getPreviousMonthUserInfo();
RLD.bounsAmount(49, 2);
RLD.bounsAmount(55,5);
RLD.doSearch();
     
Report_Lead_Deal RLD1=new Report_Lead_Deal();
RLD1.calculateLeadOpty();
RLD1.calculateLeadOpty2();
//RLD.fromDate='2012-08-01';
//RLD.toDate='2012-10-18';
RLD1.getPreviousMonthUserInfo();
RLD1.bounsAmount(49, 2);
RLD1.bounsAmount(55,5);
RLD1.doSearch();

//wrpcls.getPreviousMonthUserInfo();

    }
}