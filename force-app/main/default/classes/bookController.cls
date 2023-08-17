public class bookController
 {
	public list<Bookings__c> bookingList{get;set;}
    id Id = apexpages.currentpage().getparameters().get('id');
    public bookController() {
    }
        
    public list<Bookings__c> getBook(){
         bookingList = [select id,From_Date__c,Status__c,Subject__c,User_Name__c,User_Name__r.name,Driver__c,Vehicles__c,To_Date__c from Bookings__c where User_Name__c=:id];
         return bookingList;
      }
      
    public PageReference GoBack() {
        	PageReference pg = new PageReference('/apex/bookings');
        	pg.setRedirect(false);
        	return pg;
      }
      
}