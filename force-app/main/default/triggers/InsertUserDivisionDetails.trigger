/*
This trigger is to create the record in WorkOrder_Download_Log__c who ever has downloaded the sample request.
*/
trigger InsertUserDivisionDetails on WorkOrder_Download_Log__c (before insert) {
        for(WorkOrder_Download_Log__c sampleRec : Trigger.new){
        String ownerId = sampleRec.ownerId;
        List<User> UserList = [select id, name, Division from User where id =:ownerid];
        sampleRec.Username__c=UserList[0].name;
        sampleRec.Division__c=UserList[0].Division;
        
    }  
}