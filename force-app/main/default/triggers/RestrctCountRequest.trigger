trigger RestrctCountRequest on Case (before insert) {
    set<ID> leadIDs = new set<ID>();
    set<ID> CRIDs = new set<ID>();
    List<Case> leadCRList = new List<Case>();
    for (Case loopCR: Trigger.new ){
        leadIDs.add(loopCR.Lead__c);
        CRIDs.add(loopCR.ID);        
    }
   
    leadCRList = [select ID,Lead__c,Lead_Id__c,Division__c from Case where  Lead__c in :leadIDs and Lead__c != null and ID not in :CRIDs];
    if(leadCRList.size() > 0){
        Trigger.new[0].addError('Max of only 1 Count Request can be made from Lead');
    }
}