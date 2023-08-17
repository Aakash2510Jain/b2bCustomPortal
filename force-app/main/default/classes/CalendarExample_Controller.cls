public class CalendarExample_Controller {
    
    Id userId ;
    public Boolean includeMyEvents {get;set;}
    public list<calEvent> events {get;set;}
    //The calendar plugin is expecting dates is a certain format. We can use this string to get it formated correctly
    String dtFormat = 'EEE, d MMM yyyy HH:mm:ss z';
    
    public CalendarExample_Controller(ApexPages.StandardController controller) {
	     includeMyEvents = true;
	     userId = UserInfo.getUserId();         
    }
    
    public PageReference BookingUser() {
        	PageReference pg = new PageReference('/apex/bookcon?id='+userId);
        	pg.setRedirect(false);
        	return pg;
     }  
         
    public PageReference pageLoad() {
        events = new list<calEvent>();
         if(includeMyEvents){         
           for(Bookings__c booking: [select Id, Driver__c, From_Date__c,Subject__c, To_Destination__c,Guest_House__c,Incharge_Person__c,From_Source__c, Team__c,To_Date__c,User_Name__c,Vehicles__c from Bookings__c where Status__c='Approved']){//where OwnerID = :UserInfo.getUserId()*
                DateTime startDT = booking.From_Date__c;
                DateTime endDT = booking.To_Date__c;
                calEvent myEvent = new calEvent();
                myEvent.title = booking.Subject__c;
                myEvent.Source = booking.From_Source__c;
                myEvent.Destination = booking.To_Destination__c;
                myEvent.House = booking.Guest_House__c;
                myEvent.person = booking.Incharge_Person__c;
                myEvent.startString = startDT.format(dtFormat);
                myEvent.endString = endDT.format(dtFormat);
                myEvent.url = '/' + booking.Id;               
                myEvent.className = 'event-campaign';
                events.add(myEvent);
            }
        }
        
        
        if(includeMyEvents){         
           for(Bookings__c booking: [select Id, Driver__c, From_Date__c, From_Source__c,To_Destination__c, Team__c,Guest_House__c,Incharge_Person__c,Subject__c,To_Date__c,User_Name__c,Vehicles__c from Bookings__c where Status__c='Pending']){//where OwnerID = :UserInfo.getUserId()*
                DateTime startDT = booking.From_Date__c;
                DateTime endDT = booking.To_Date__c;
                calEvent myEvent = new calEvent();
                myEvent.title =  booking.Subject__c;
                myEvent.Source = booking.From_Source__c;
                myEvent.Destination = booking.To_Destination__c;
                myEvent.House = booking.Guest_House__c;
                myEvent.person = booking.Incharge_Person__c;
                myEvent.startString = startDT.format(dtFormat);
                myEvent.endString = endDT.format(dtFormat);
                myEvent.url = '/' + booking.Id;                
                myEvent.className = 'event-birthday';
                events.add(myEvent);
            }
        }
         if(includeMyEvents){         
           for(Bookings__c booking: [select Id, Driver__c, From_Date__c, From_Source__c,To_Destination__c, Team__c,Guest_House__c,Incharge_Person__c,Subject__c,To_Date__c,User_Name__c,Vehicles__c from Bookings__c where Status__c='Rejected']){//where OwnerID = :UserInfo.getUserId()*
                DateTime startDT = booking.From_Date__c;
                DateTime endDT = booking.To_Date__c;
                calEvent myEvent = new calEvent();
                myEvent.title =  booking.Subject__c;
                myEvent.Source = booking.From_Source__c;
                myEvent.Destination = booking.To_Destination__c;
                myEvent.House = booking.Guest_House__c;
                myEvent.person = booking.Incharge_Person__c;
                myEvent.startString = startDT.format(dtFormat);
                myEvent.endString = endDT.format(dtFormat);
                myEvent.url = '/' + booking.Id;                
                myEvent.className = 'event-personal';
                events.add(myEvent);
            }
        }
        return null;
    }
     
    public PageReference toggleMyEvents() {
        if(includeMyEvents){
            includeMyEvents = false;
        }
        else{
            includeMyEvents = true;
        }
        pageload();
        return null;
    }
 
     
    //Class to hold calendar event data
    public class calEvent{
        public String title {get;set;}
        public String Source {get;set;}
        public String Destination {get;set;}
        public String House {get;set;}
        public String person {get;set;}
        public Boolean allDay {get;set;}
        public String startString {get;set;}
        public String endString {get;set;}
        public String url {get;set;}
        public String className {get;set;}
    }
}