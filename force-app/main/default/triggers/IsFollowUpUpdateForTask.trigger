/*
SalesReport Purpose: Counting number of Leads/Opportunities with no Task.
This trigger is written to make check box(isFollowUp__c) true in Lead/Opportunity when task is created.
*/
trigger IsFollowUpUpdateForTask on Task (after Insert, after delete, after update, after undelete){
    
    if(Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete) {
        set<ID> leadIds = new set<ID>();
        set<ID> optyIds = new set<ID>();
        for(Task loopTask : trigger.new){
            leadIds.add(loopTask.whoid);
            optyIds.add(loopTask.whatid);
        }

        List<Lead> listLead = [select id, isFollowUp__c from Lead where id IN :leadIds and isFollowUp__c = false];
        List<Opportunity> listOpty = [select id, isFollowUp__c from Opportunity where id IN :optyIds and isFollowUp__c = false];

        if(listLead.size() > 0 ){
            for(Lead loopLead : listLead){
                loopLead.isFollowUp__c = true;
            }
            update listLead;
        }
        if(listOpty.size() > 0 ){
            for(Opportunity loopOpty : listOpty){
                loopOpty.isFollowUp__c = true;
            }
            update listOpty;
        }
    }

    if(Trigger.isDelete){
        set<ID> leadIds = new set<ID>();
        set<ID> optyIds = new set<ID>();
        for(Task loopTask : trigger.old){
            leadIds.add(loopTask.whoid);
            optyIds.add(loopTask.whatid);
        }
        List<Lead> listLead = [select id, isFollowUp__c from Lead where id IN :leadIds and isFollowUp__c = true];
        List<Opportunity> listOpty = [select id, isFollowUp__c from Opportunity where id IN :optyIds and isFollowUp__c = true];

        if(listLead.size() > 0 ){
            for(Lead loopLead : listLead){
                loopLead.isFollowUp__c = false;
            }
            update listLead;
        }
        if(listOpty.size() > 0 ){
            for(Opportunity loopOpty : listOpty){
                loopOpty.isFollowUp__c = false;
             }
            update listOpty;
        }
    }

}