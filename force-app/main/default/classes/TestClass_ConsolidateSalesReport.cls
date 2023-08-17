@isTest
public with sharing class TestClass_ConsolidateSalesReport {
	public static testMethod void mytest_ConsolidatesSalesReport(){
	
	User u1= [select id from User where alias='steam' limit 1];
	u1.Division = 'Winners';

		lead led=new lead();
    	led.Email='kavinmax.m@istrategicloud.com';
    	led.Division_Name__c='Rainmakers';
    	led.LeadSource='Approved Index';
    	led.Status='Followup';
    	led.Company = 'SOS1';    	
    	led.LastName='TestJohny';
    	led.Primary_Service_Name__c='CRM';
    	led.LinkedIn_URL__c='karthik37/Linkedin.com';
    	led.Lead_AssignedTo__c='Deepak Guduru';
    	led.Team_Identification__c='Deepak Guduru';
    	insert led;
    	
    	Account acc=new Account();
      acc.Name='SOS';
      acc.Email__c='sample@in.com';
      acc.Phone='(954) 344-9254';
      acc.Type='Customer';
      insert acc;
      
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
      insert opp;
      
      Opportunity_Payment__c opppay=new Opportunity_Payment__c();
        opppay.Opportunity__c=opp.id;
        opppay.Pay_Status__c='paid';
        opppay.Payment_Amount__c=23442;
        opppay.Payment_Mode__c='Cash';
        opppay.Requested_Count__c=2344;
        insert opppay;

ConsolidatedSalesReport CSR = new ConsolidatedSalesReport(); 
		Test.startTest();
		CSR.fromDate='2022-08-27';
		CSR.toDate='2022-10-12';
		CSR.getAllTeamReps('winners');
		CSR.search();
		CSR.getTotalLeadsAndDemos();
		CSR.getSalesTeamList();
		CSR.getICPTeam();
		CSR.getDivisionList();
		CSR.assignSalesToSalesTeamAndRep();
		List<Lead> li =new List<Lead>();
		CSR.assignLeadToSalesTeamAndRep(li);
		CSR.calculateSalesTeamAggregate();
		CSR.getTotalOpportunityAndDemos();
		CSR.calculateSalesTeamAggregate();
		CSR.getOverAllTeamList();
		//CSR.getTotalPayments();
		
		ConsolidatedSalesReport.SalesTeamReport str=new ConsolidatedSalesReport.SalesTeamReport();
		str.getSalesRepList();
		
		ConsolidatedSalesReport.SalesRepReport srr=new ConsolidatedSalesReport.SalesRepReport();
		
		Test.stopTest();
	
	}
	
}