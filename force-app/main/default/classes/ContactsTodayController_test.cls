@IsTest(SeeAllData=false)
public class ContactsTodayController_test {

    
    public static testmethod void TestContactsTodayController() {
        
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator' LIMIT 1];
        
       
        User u = new User(Alias = 'rocks', Email='sossfdc@cirrologix.com', 
        EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
        IsActive=true,Division='Rainmakers',Is_Account_Manager__c=true,
        LocaleSidKey='en_US', ProfileId = p.Id,Rating__c='A+',Mapped_UserID_Name__c='Test User(Rainmakers)', 
        TimeZoneSidKey='America/Los_Angeles', UserName='sossfdceeeee@cirrologix.com',Date_of_Joining__c=System.Today().addDays(1));
            
        insert u;
        System.runAs(u) {
        
            Contact c = new Contact(FirstName = 'Joe', LastName = 'Test');
            insert c;
            
            Date td = Date.today();
            Task t = new Task(Subject = 'test', WhoId = c.Id, Status = 'Open');
            insert t;
            
            ContactsTodayController.getContactsForToday();
            //System.assertNotEquals(0,ContactsTodayController.getContactsForToday().size());
            
        }
        
    }
    
}