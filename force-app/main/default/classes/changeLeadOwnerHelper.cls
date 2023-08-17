public without sharing class changeLeadOwnerHelper {
    
    @AuraEnabled
    public static void updateOwner(String leadId, String objName){
        try{
            String sQuery = 'Select Id, OwnerId FROM ' + objName + ' WHERE Id =\'' + leadId + '\'';
            System.debug('sQuery --> ' + sQuery);
            if(leadId.startsWith('00Q')){
                Lead ldRecord = Database.query(sQuery);
                System.debug('ldRecord --> ' + ldRecord);
                String ldOwnerId = [SELECT Id FROM User WHERE UserName =: System.Label.Lead_New_Owner_UserName].Id;
                if(ldOwnerId != ldRecord.OwnerId){
                    ldRecord.OwnerId = ldOwnerId;
                    update ldRecord;
                }             
            }
            if(leadId.startsWith('a0F')){
                Duplicate_Leads__c dupLdRecord = Database.query(sQuery);
                System.debug('dupLdRecord --> ' + dupLdRecord);
                String ldOwnerId = [SELECT Id FROM User WHERE UserName =: System.Label.Lead_New_Owner_UserName].Id;
                if(ldOwnerId != dupLdRecord.OwnerId){
                    dupLdRecord.OwnerId = ldOwnerId;
                    update dupLdRecord;
                }                    
            }
        }
        catch(Exception e){
            system.debug('ERROR -- > ' + e.getMessage());
            system.debug('AT LINE NO -- > ' + e.getLineNumber());
            throw new AuraHandledException(e.getMessage());
        }
    }
}