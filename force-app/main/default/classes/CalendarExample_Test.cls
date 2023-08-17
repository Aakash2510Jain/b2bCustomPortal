@istest
	public class CalendarExample_Test {
		
		public static testmethod void Calendar(){
		
		Bookings__c bookRecord = new Bookings__c();
		bookRecord.From_Date__c = datetime.newInstance(2013, 12, 1, 12, 30, 2);
		bookRecord.To_Date__c= datetime.newInstance(2013, 12, 11, 12, 30, 2);
		bookRecord.Subject__c='trip1';
		bookRecord.From_Source__c='Bangalore';
		bookRecord.To_Destination__c='Hyderabad';
		bookRecord.Guest_House__c='Villa';
		bookRecord.Incharge_Person__c='Prasanna';
		bookRecord.Status__c='Approved';
		
		insert bookrecord;
		
		
		
		Bookings__c bookRecords = new Bookings__c();
		bookRecords.From_Date__c = datetime.newInstance(2013, 12, 1, 12, 30, 2);
		bookRecords.To_Date__c= datetime.newInstance(2013, 12, 11, 12, 30, 2); 
		bookRecords.Subject__c='trip1';
		bookRecords.From_Source__c='Bangalore';
		bookRecords.To_Destination__c='Hyderabad';
		bookRecords.Guest_House__c='Villa';
		bookRecords.Incharge_Person__c='Prasanna';
		bookRecords.Status__c='Rejected';
		
		insert bookRecords;
		
		
		Bookings__c bookRec = new Bookings__c();
		bookRec.From_Date__c = datetime.newInstance(2013, 12, 1, 12, 30, 2);
		bookRec.To_Date__c= datetime.newInstance(2013, 12, 11, 12, 30, 2);
		bookRec.Subject__c='trip1';
		bookRec.From_Source__c='Bangalore';
		bookRec.To_Destination__c='Hyderabad';
		bookRec.Guest_House__c='Villa';
		bookRec.Incharge_Person__c='Prasanna';
		bookRec.Status__c='Pending';		
		insert bookRec;
	                
	    
		
			Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
	      	User u2 = new User(Alias = 'suser', Email='vinay.k@cirrologix.com', 
	        					EmailEncodingKey='UTF-8', LastName='sampleuser', LanguageLocaleKey='en_US', 
	        								LocaleSidKey='en_US', ProfileId = p.Id, 
											        TimeZoneSidKey='America/Los_Angeles', UserName='sampleuser@testsample.com');
	
	   System.runAs(u2) {
			
			ApexPages.StandardController sc = new ApexPages.StandardController(bookRecords);
			CalendarExample_Controller call = new CalendarExample_Controller(sc);
			call.pageLoad();
			call.toggleMyEvents();
			call.BookingUser();
		
		bookController book = new bookController();
		Bookings__c bookUpdate =[select Id, Driver__c, From_Date__c,Subject__c, To_Destination__c,Guest_House__c,Incharge_Person__c,From_Source__c, Team__c,To_Date__c,User_Name__c,Vehicles__c from Bookings__c where Status__c='pending'];
			bookUpdate.status__c='Approved';
			update bookupdate;		
			bookUpdate.status__c='Rejected';
			update bookupdate;
			Apexpages.currentPage().getParameters().put('id',bookRecords.id);
			book.getBook();
		    book.GoBack(); 
		               
	      }
		} 
	}