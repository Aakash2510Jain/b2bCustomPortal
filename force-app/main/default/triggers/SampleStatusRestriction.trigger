/*
This trigger is to restrict unauthorized users from changing Status of sample request.
1. Apart from helpdesk profile users,no other users should be able to change status to completed or working.
2. Helpdesk people should not be able to change status to New or Re-Open.
*/
trigger SampleStatusRestriction on Sample_Request__c (after update, after insert) {

Profile userProfile = [select ID, name from profile where ID =: UserInfo.getProfileId()];
system.debug('The user profile:'+userProfile.name);

for(Sample_Request__c sampleReqLoop : Trigger.new) {
    
    ID oldOptyValue = ((trigger.isUpdate) ? Trigger.oldMap.get(sampleReqLoop.ID).Opportunity__c : null);
    System.debug('SampleStatusRestriction : '+sampleReqLoop+'---------------------'+oldOptyValue);
    if( ! (sampleReqLoop.Opportunity__c != null && oldOptyValue == null )){   
     if( (userProfile.name == 'Technologylist_Helpdesk') || (userProfile.name  == 'Technologylist_Executives') || (userProfile.name  == 'Custom List_HelpDesk') || ( userProfile.name  == 'Custom List_HelpDesk_Manager')|| ( userProfile.name  == 'Web Team (DM)')|| ( userProfile.name  == 'Content Manager')|| ( userProfile.name  == 'Campaign Team (DM)') || ( userProfile.name  == 'Social Media Team (DM)')|| ( userProfile.name  == 'Append Sample Team')){
               if( ( sampleReqLoop.Status__c == 'New') || ( sampleReqLoop.Status__c == 'Re-Open')  ){
                sampleReqLoop.addError('You do not have sufficient privileges to change status to New/Re-Open');
            }
        }
        else {
            if( ( sampleReqLoop.Status__c == 'Working' ) || ( sampleReqLoop.Status__c == 'Completed') ){
                sampleReqLoop.addError('You do not have sufficient privileges to change status to Completed/Working');
            }
        }
      }
    }
}