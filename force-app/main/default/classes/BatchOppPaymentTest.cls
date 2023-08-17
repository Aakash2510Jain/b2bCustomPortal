@isTest
private class BatchOppPaymentTest {
   
    @isTest static void BatchOppPaymentMethod(){
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator' LIMIT 1];
        Account act = new Account(Name='Accenture');
        insert act;
        Contact con = new Contact(LastName='Meiyang Chang');
        insert con;
       
         User u = new User(Alias = 'standt', Email='sossfdc@cirrologix.com', 
        EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
        IsActive=true,Division='Rainmakers',Is_Account_Manager__c=true,
        LocaleSidKey='en_US', ProfileId = p.Id,Rating__c='A+',Mapped_UserID_Name__c='Test User(Rainmakers)', 
        TimeZoneSidKey='America/Los_Angeles', UserName='sossfdceeeee@cirrologix.com',Date_of_Joining__c=System.Today().addDays(1));
            
        
        insert u;
       
            Opportunity opp = new Opportunity(Client_Name__c = con.Id,Client_Company__c=act.id,Lead_Source__c='Lead Blog',Name=act.id,
                                            Amount=120000,Primary_Service_Name__c='CRM',Division__c='Rainmakers',StageName='Deal',Closedate=System.Today().addDays(1),EMT__c='IDH'
                                            );
         
        insert opp;
        
      
            Opportunity_Payment__c opPay = new Opportunity_Payment__c(Opportunity__c=opp.id);
           insert opPay;
      
                
        Test.startTest();
        System.runas(u){
        BatchOppPayment bu = new BatchOppPayment();
       Id batchId = Database.executeBatch(bu);
        }
        Test.stopTest();
        
       
        
    }

}