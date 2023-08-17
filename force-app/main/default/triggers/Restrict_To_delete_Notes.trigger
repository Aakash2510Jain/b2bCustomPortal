trigger Restrict_To_delete_Notes on Note (before delete) {
/*
This trigger restrict users to delete notes under SampleRequest object.
Exception for System Administrator,Helpdesk profiles(Technologylist_Helpdesk,Custom List_HelpDesk,CustomList_HelpDesk_Manager).
*/

Profile userProfile = [select ID, name from profile where ID =: UserInfo.getProfileId()];
    if((userProfile.name == 'System Administrator') || (userProfile.name  == 'Technologylist_Helpdesk') || (userProfile.name  == 'Custom List_HelpDesk') || (userProfile.name  == 'Custom List_HelpDesk_Manager') || (userProfile.name  == 'Technologylist_Executives')){}
else{

    set<ID> attParentIds = new set<ID>();
    for( Note loopAtt : Trigger.old){
    attParentIds.add(loopAtt.ParentId);
    }
    map<Id, List<Sample_Request__c>> srMap = new map<Id, List<Sample_Request__c>>(); 
    List <Sample_Request__c> SR1 = [select Id,Name from Sample_Request__c where id IN :attParentIds];
    for(Sample_Request__c s: SR1) {
        List<Sample_Request__c> sr = srMap.get(s.Id);
        if(sr == null) {
            sr = new List<Sample_Request__c>(); 
            srMap.put(s.Id,sr);
        }
        sr.add(s);
    }
    for( Note loopAtt : Trigger.old){
        List <Sample_Request__c> srList = new  List <Sample_Request__c>();
        srList = srMap.get(loopAtt.ParentId);
        if(srList.size() > 0) {
            loopAtt.adderror('You cannot delete Notes.Please contact System Administrator');
        }
    
    }
  }
}