global class BatchOppPayment implements Database.Batchable<sObject> {
    global Integer recordsProcessed = 0;
        
        global Database.QueryLocator start(Database.BatchableContext bc){
            return Database.getQueryLocator('SELECT Id, opportunity__r.Owner.Id FROM Opportunity_Payment__c');
        }
       
    global void execute(Database.BatchableContext bc, List<Opportunity_Payment__c> opp){
         List<Opportunity_Payment__c> OppPaymentList = new List<Opportunity_Payment__c>();
        List<User> u = [SELECT Id, Date_of_Joining__c FROM User WHERE IsActive=True];
        for(Opportunity_Payment__c op : opp) {
            for(User us : u){
            if(op.opportunity__r.Owner.Id == us.id){
               op.DOJ__c = us.Date_of_Joining__c; 
                OppPaymentList.add(op);
                recordsProcessed = recordsProcessed + 1;
            }
        } 
        }
           update OppPaymentList;
    }
    
    global void finish(Database.BatchableContext bc){
        System.debug(recordsProcessed+' records processed. Vipul!');
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed,TotalJobItems, CreatedBy.Email FROM AsyncApexJob WHERE Id = :bc.getJobId()];
    }

}