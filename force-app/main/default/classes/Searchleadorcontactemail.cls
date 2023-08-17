Public without sharing class Searchleadorcontactemail {

    public Searchleadorcontactemail() {

    }

  public String text{get;set;}
    public PageReference AppSearch() {
       return null;
    }

    public Lead AppSearch {get;set;}
    public Searchleadorcontactemail (ApexPages.StandardController controller) {
           AppSearch=(Lead)controller.getRecord();
             }      
       
    public List<Lead> getAppSearchData(){
   system.debug('*******Size of list is**********'+text);                    
            List<Lead> listBd=[select Id,OwnerId,Owner.Name,Email,LastActivityDate,Sub_Division_Name__c,Comments__c  from Lead where Email=:text limit 50];   
            system.debug('*******Size of list is**********'+listBd.size());
            
            return listBd;
            }
                          
                                                                             
        
        public List<Contact> getAppSearchData1(){
   system.debug('*******Size of list is**********'+text);                      
            List<Contact> listBd1=[select Id,OwnerId,Owner.Name,Email,LastActivityDate from Contact where Email=:text limit 50];   
            system.debug('*******Size of list is**********'+listBd1.size());
            
            return listBd1; 
                                                                              
        }
}