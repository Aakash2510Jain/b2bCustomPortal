Public with sharing class SearchSampleRequests_OPP {
    public String text{get;set;}
    public PageReference AppSearch() {
       return null;
    }


   // public SearchAppointments () {

    //}

    public Sample_Request__c AppSearch {get;set;}
    public SearchSampleRequests_OPP(ApexPages.StandardController controller) {
           AppSearch=(Sample_Request__c)controller.getRecord();
             }         
    public List<Sample_Request__c> getAppSearchData(){ 
   //String text= Appsearch.Opportunity_Number__c;                       
            List<Sample_Request__c> listBd=[select Id,Sample_ID__c,Name,Division__c,LeadID__c,OwnerId,Opportunity_Number__c,Sample_Type__c from Sample_Request__c where Opportunity_Number__c=:text AND Opportunity_Number__c!=NULL limit 50];   
            return listBd;                                           
        }
}