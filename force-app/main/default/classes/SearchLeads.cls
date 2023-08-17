Public class SearchLeads {

    public PageReference AppSearch() {
       return null;
    }


   // public SearchAppointments () {

    //}

    public Lead AppSearch {get;set;}
    public SearchLeads (ApexPages.StandardController controller) {
           AppSearch=(Lead)controller.getRecord();
             }         
    public List<Lead> getAppSearchData(){
    
   // DateTime dT = AppSearch.start_date_time__c;
   //Date myDate = date.newinstance(dT.year(), dT.month(), dT.day());  
   String text= Appsearch.company;                       
            List<Lead> listBd=[select Id,Name,Company,Division_Name__c,Sub_Division_Name__c,Email from Lead where Company=:text limit 100];  
            return listBd;                                           
        }
}