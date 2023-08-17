/*
This trigger is to create the record in Sample_Download_Logs__c who ever has downloaded the sample request.
*/
trigger sampleDownloadLogger on Sample_Download_Logs__c (before insert) {
       for(Sample_Download_Logs__c sampleRec : Trigger.new){
        String ownerId = sampleRec.ownerId;
        List<User> UserList = [select id, name, Division from User where id =:ownerid];
        sampleRec.Username__c=UserList[0].name;
        sampleRec.Division__c=UserList[0].Division;
        
    }  
}