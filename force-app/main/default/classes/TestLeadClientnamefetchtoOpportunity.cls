@istest
public class TestLeadClientnamefetchtoOpportunity { 
    private static testMethod void trigTest() {

        // Create dummy lead
        Lead testLead = new Lead(Company='Test Lead',FirstName='John',LastName='Doe',Status='Open',Phone='555-123-4567',Email='amit.k@istrategicloud.com');
        insert testLead;
        System.debug(testLead + '&&&&&&&&&&&&&');
      
        Task tsk1 = new Task(WhoId = testLead.Id, Subject = 'Email: apex test', ActivityDate = date.today(), Status = 'Completed');
        insert tsk1;
        System.debug(tsk1 + 'AAAA&&&&&&&&&&&&&');
        update testLead;
        
    
        // Create dummy conversion
        Database.LeadConvert lc = new database.LeadConvert();
        lc.setLeadId(testlead.id);
        lc.setDoNotCreateOpportunity(false);
        lc.setConvertedStatus('Warm/Samples Sent');
                
                Database.LeadConvertResult lcr = Database.convertLead(lc);
                

        // Make sure conversion was successful
        System.assert(lcr.isSuccess());
        System.debug(lcr );

        // Test Contact "Status" field update
        //Opportunity testCon = new Opportunity(Name='mynan',StageName ='Open',CloseDate =System.today());
        //insert testCon;
       // testCon.Id =lcr.getOpportunityId();
      //  update testCon;
        Opportunity testCon = [SELECT Client_Name__c FROM Opportunity WHERE Opportunity.Id = :lcr.getOpportunityId()];
                System.debug(testCon );
       
    }
}