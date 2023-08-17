/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
 
@isTest

private class TestLeadDistributionReport {

    static testMethod void LeadDistributionReportTest(){
        
               
        Account acc=new Account();
        acc.Name='SOS';
        acc.Email__c='sample@in.com';
        acc.Phone='(954) 344-9254';
        acc.Type='Customer';
        insert acc; 
        
        List<Lead> leadsQueried = new List<Lead>();
        Lead newlead=new Lead();
        newlead.Email='kavn.m@istrtegicloud.com';
        newlead.Division_Name__c='Rainmakers';
        newlead.LeadSource='Approved Index';
        newlead.Status='Followup';
        newlead.Company = 'SOS';
        newlead.FirstName='TestN';
        newlead.LastName='TestJohn';
        newlead.Primary_Service_Name__c='CRM';
        newlead.LinkedIn_URL__c='karthik37/Linkedin.com';
        newlead.Lead_AssignedTo__c='William Perry (Rainmakers)';
        newlead.User_Name__c='test';
        newlead.Team_Identification__c='Raymond Phillips';
        leadsQueried.add(newlead);
        Lead newlea=new Lead();     
        newlea.Email='kevi.maxim@istrategicloud.com';
        newlea.Division_Name__c='Winners';
        newlea.LeadSource='Approved Index';
        newlea.Status='Followup';
        newlea.Company = 'SOS12';
        newlea.FirstName='TestK';
        newlea.LastName='TestSunny';
        newlea.Primary_Service_Name__c='CRM';
        newlea.LinkedIn_URL__c='karthik34/Linkedin.com';
        newlea.Lead_AssignedTo__c='Steve Sujith (Winners)';
        newlea.User_Name__c='Demo test';
        newlea.Team_Identification__c='Manager Steve Sujith';
        leadsQueried.add(newlea);
        insert leadsQueried; 
        
            
        List<Opportunity> opportunityQueried = new List<Opportunity>();
        Opportunity opp=new Opportunity();
        opp.Name='sample';
        opp.AccountId=acc.id;
        opp.Lead_Source__c='Approved Index';
        opp.Primary_Service_Name__c='Technology List';
        opp.Division__c='Gladiators';
        opp.StageName='Counts Provided (30%)';
        opp.Sample_To_Deal__c='other';
        opp.Uploaded_By__c='test';
        opp.ForecastCategoryName='pipeline';
        opp.Amount=5000;
        opp.CloseDate=date.today();
        opp.Team_Uploaded_By__c='Winners'; 
        opportunityQueried.add(opp);
        insert opportunityQueried; 
        
        List<Opportunity_Payment__c> oppPaymentQueried = new List<Opportunity_Payment__c>();
        Opportunity_Payment__c opppay=new Opportunity_Payment__c();
        opppay.Opportunity__c=opp.id;
        opppay.Pay_Status__c='paid';
        opppay.Payment_Amount__c=23442;
        opppay.Payment_Mode__c='Cash';
        oppPaymentQueried.add(opppay); 
        insert oppPaymentQueried; 
            
            
        //Map<String,LDR> leadGenDivisionReport = new Map<String,LDR>(); 
            
            
            
        LeadDistributionReport LDR = new LeadDistributionReport();  
            
        LDR.Divname='All';      
        LDR.getOptionMonth();
        LDR.getOptionYear();        
        LDR.i=1;
        LDR.ListMonth ='02';//string.valueof(Date.Today().Month());
        LDR.ListYear = '2014';//string.valueof(Date.Today().Year());
        LDR.fromDate= LDR.ListYear+'-'+LDR.ListMonth+'-01';
        LDR.toDate= LDR.ListYear+'-'+LDR.ListMonth+'-'+Date.daysInMonth(integer.ValueOf(LDR.ListYear), integer.ValueOf(LDR.ListMonth));
        LDR.Convertedfromdate='2014-11-02T07:00:00z';
        LDR.Convertedtodate='2014-13-02T07:00:00z';                   
        LDR.getDevList();
        LDR.doSearch();
        LDR.getLeadGenDivisionList();
        LDR.getTotalReport();
        
        
       
        
        LeadDistributionReport.LeadGenDivisionReport LGDR = new LeadDistributionReport.LeadGenDivisionReport();
        LGDR.divisionName='All';
        LGDR.getLeadGenReportMap();
        
       
        
        LeadDistributionReport.LeadGenReport LGR = new LeadDistributionReport.LeadGenReport();
        LGR.conversionRate = 75.0;
        LGR.dealCount=10;
        LGR.divisionName='All';
        LGR.leadCount=5;
        LGR.paidCount=10;
        LGR.userName='userone';
        LGR.BdNameMap.put('name1',1);
        LGR.BdNameMap.put('name2',2);
        LGR.BdNameMapForClosedDeal.put('name1',1);
        LGR.BdNameMapForClosedDeal.put('name2',2);
        LDR.totalReport = new LeadDistributionReport.LeadGenReport();
        LGDR.leadGenReportMap.put('one',LGR);
        
        LDR.exportReport(); 
        
        LDR.calculateLeadDistributionReport();        
        
       
    }
    
    static testMethod void LeadDistributionReportTest1(){
        
               
        Account acc=new Account();
        acc.Name='SOS';
        acc.Email__c='sample@in.com';
        acc.Phone='(954) 344-9254';
        acc.Type='Customer';
        insert acc; 
        
        List<Lead> leadsQueried = new List<Lead>();
        Lead newlead=new Lead();
        newlead.Email='kavn.m@istrtegicloud.com';
        newlead.Division_Name__c='Rainmakers';
        newlead.LeadSource='Approved Index';
        newlead.Status='Followup';
        newlead.Company = 'SOS';
        newlead.FirstName='TestN';
        newlead.LastName='TestJohn';
        newlead.Primary_Service_Name__c='CRM';
        newlead.LinkedIn_URL__c='karthik37/Linkedin.com';
        newlead.Lead_AssignedTo__c='William Perry (Rainmakers)';
        newlead.User_Name__c='test';
        newlead.Team_Identification__c='Raymond Phillips';
        leadsQueried.add(newlead);
        Lead newlea=new Lead();     
        newlea.Email='kevi.maxim@istrategicloud.com';
        newlea.Division_Name__c='Winners';
        newlea.LeadSource='Approved Index';
        newlea.Status='Followup';
        newlea.Company = 'SOS12';
        newlea.FirstName='TestK';
        newlea.LastName='TestSunny';
        newlea.Primary_Service_Name__c='CRM';
        newlea.LinkedIn_URL__c='karthik34/Linkedin.com';
        newlea.Lead_AssignedTo__c='Steve Sujith (Winners)';
        newlea.User_Name__c='Demo test';
        newlea.Team_Identification__c='Manager Steve Sujith';
        leadsQueried.add(newlea);
        insert leadsQueried; 
        
            
        List<Opportunity> opportunityQueried = new List<Opportunity>();
        Opportunity opp=new Opportunity();
        opp.Name='sample';
        opp.AccountId=acc.id;
        opp.Lead_Source__c='Approved Index';
        opp.Primary_Service_Name__c='Technology List';
        opp.Division__c='Gladiators';
        opp.StageName='Counts Provided (30%)';
        opp.Sample_To_Deal__c='other';
        opp.Uploaded_By__c='test';
        opp.ForecastCategoryName='pipeline';
        opp.Amount=5000;
        opp.CloseDate=date.today();
        opp.Team_Uploaded_By__c='Winners'; 
        opportunityQueried.add(opp);
        insert opportunityQueried; 
        
        List<Opportunity_Payment__c> oppPaymentQueried = new List<Opportunity_Payment__c>();
        Opportunity_Payment__c opppay=new Opportunity_Payment__c();
        opppay.Opportunity__c=opp.id;
        opppay.Pay_Status__c='paid';
        opppay.Payment_Amount__c=23442;
        opppay.Payment_Mode__c='Cash';
        oppPaymentQueried.add(opppay); 
        insert oppPaymentQueried; 
            
            
        //Map<String,LDR> leadGenDivisionReport = new Map<String,LDR>(); 
            
            
            
        LeadDistributionReport LDR = new LeadDistributionReport();  
            
        LDR.Divname='';      
        LDR.getOptionMonth();
        LDR.getOptionYear();        
        LDR.i=1;
        LDR.ListMonth ='02';//string.valueof(Date.Today().Month());
        LDR.ListYear = '2014';//string.valueof(Date.Today().Year());
        LDR.fromDate= LDR.ListYear+'-'+LDR.ListMonth+'-01';
        LDR.toDate= LDR.ListYear+'-'+LDR.ListMonth+'-'+Date.daysInMonth(integer.ValueOf(LDR.ListYear), integer.ValueOf(LDR.ListMonth));
        LDR.Convertedfromdate='2014-11-02T07:00:00z';
        LDR.Convertedtodate='2014-13-02T07:00:00z';                   
        LDR.getDevList();
        LDR.doSearch();
        LDR.getLeadGenDivisionList();
        LDR.getTotalReport();
        
        
       
        
        LeadDistributionReport.LeadGenDivisionReport LGDR = new LeadDistributionReport.LeadGenDivisionReport();
        LGDR.divisionName='All';
        LGDR.getLeadGenReportMap();
        
       
        
        LeadDistributionReport.LeadGenReport LGR = new LeadDistributionReport.LeadGenReport();
        LGR.conversionRate = 75.0;
        LGR.dealCount=10;
        LGR.divisionName='All';
        LGR.leadCount=5;
        LGR.paidCount=10;
        LGR.userName='userone';
        LGR.BdNameMap.put('name1',1);
        LGR.BdNameMap.put('name2',2);
        LGR.BdNameMapForClosedDeal.put('name1',1);
        LGR.BdNameMapForClosedDeal.put('name2',2);
        LDR.totalReport = new LeadDistributionReport.LeadGenReport();
        LGDR.leadGenReportMap.put('one',LGR);
        
        LDR.exportReport(); 
        
        LDR.calculateLeadDistributionReport();        
        
       
    }
    
    
    
    
    
    
    
}