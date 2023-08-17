trigger GeneratePasswordForUser on User_Portal__c (after insert, before insert) {
    if(trigger.isafter && trigger.isInsert){
        GeneratePasswordForUser.afterSignupGeneratePassword(trigger.new);
    }
    if(trigger.isbefore && trigger.isInsert){
        GeneratePasswordForUser.beforeSignupGeneratePassword(trigger.new);
    }
}