@isTest
private class TestSearchSampleRequests 
{
 static testMethod void TestSearchSampleRequests() 
 {
   Opportunity opp=new Opportunity();
              opp.Name='sample1';
              // opp.AccountId=acc.id;
              opp.Lead_Source__c='Approved Index';
              opp.Primary_Service_Name__c='Technology List';
              opp.Division__c='Winners';
              opp.StageName='new';
              opp.Sample_To_Deal__c='other';
              opp.Uploaded_By__c='test';
              opp.ForecastCategoryName='pipeline';
              opp.Amount=500;
              opp.CloseDate=date.parse('1/13/2013');
              opp.Team_Uploaded_By__c='Winners';
              opp.Emt__c='idh';
              insert opp;
              lead l = new Lead (LastName = 'Test data', Email = 'test@gmail.com', mobilephone = '+1234567890', Company = 'Test company');
              insert l;
              Sample_Request__c S=new Sample_Request__c();
              S.Name='Test';
              S.Opportunity__c=opp.Id;
              s.lead__c=l.id;
              s.Special_Instructions__c='testingdata';
              insert S;
              update s;
  
  
  ApexPages.StandardController sc1 = new ApexPages.StandardController(s); 
  ApexPages.StandardController Li = new ApexPages.StandardController(l);
  
   ApexPages.currentPage().getParameters().put('ID',s.id);
   SearchSampleRequests sr = new SearchSampleRequests (sc1); 
   SearchSampleRequests_OPP sr1 = new SearchSampleRequests_OPP (sc1); 
   SearchLeads SL=new SearchLeads(Li);     
    sr1.getAppSearchData(); 
     sr1.AppSearch(); 
     sr.getAppSearchData(); 
     sr.AppSearch();
     SL.getAppSearchData(); 
     SL.AppSearch();  

                   
 }
}