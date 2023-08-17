Public with sharing class SearchSampleRequests {
    public String text{get;set;}
    public PageReference AppSearch() {
       return null;
    }

    public Sample_Request__c AppSearch {get;set;}
    public SearchSampleRequests (ApexPages.StandardController controller) {
           AppSearch=(Sample_Request__c)controller.getRecord();
             }               
    public List<Sample_Request__c> getAppSearchData(){
   system.debug('*******Size of list is**********'+text);                      
            List<Sample_Request__c> listBd=[select Id,Sample_ID__c,Name,Division__c,LeadID__c,Opportunity_Number__c,OwnerId,Sample_Type__c from Sample_Request__c where LeadID__c=:text AND LeadID__c!=NULL limit 50];   
            system.debug('*******Size of list is**********'+listBd.size());
            
          /*  If(listBd.size()==0){
             ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,'No samples with the given LeadID')); 
            }
            else{*/
            return listBd; 
                                                                              
        }
}