/*
This trigger is written to restrict users from creating more number of samples for Lead/Opportunity
Except for profiles BDM-No sample restrictions,BDE-No sample restrictions,no other users can create more than one sample for Lead/Opportunity.
Exception:If the opportunity is created from the lead conversion,
sample also carry forward to that opportunity from lead.
In this case users can create one more Sample for opportunity.
*/

trigger Samples_Restriction on Sample_Request__c (before insert) {

    Profile userProfile = [select ID, name from profile where ID =: UserInfo.getProfileId()];
    if((userProfile.name == 'BDM- No sample restrictions') || (userProfile.name  == 'BDE- No sample restrictions') ||(userProfile.name  == 'Marketing Team With No IP Restriction')||(userProfile.name  == 'Marketing BDM') ||(userProfile.name  == 'Marketing BDSE') ){}
    else{
    set<ID> leadIDs = new set<ID>();
    set<ID> optyIDs = new set<ID>();
    set<ID> SRIDs = new set<ID>();
    Map<ID,integer> optyLeadMap = new Map<ID,integer>();
    // List<Sample_Request__c> SRList = new List<Sample_Request__c>();
    List<Sample_Request__c> leadSRList = new List<Sample_Request__c>();
    List<Sample_Request__c> optySRList = new List<Sample_Request__c>();
    List<integer> leadOptySRCountlist = new List<integer>();
    set<Integer> leadOptySRCountset = new set<Integer>();
    
    for (Sample_Request__c loopSR: Trigger.new ){
        leadIDs.add(loopSR.Lead__c);
        optyIDs.add(loopSR.Opportunity__c);
        SRIDs.add(loopSR.ID);        
    }
    
    //SRList = [select ID, Lead__c, Opportunity__c,LeadID__c, Lead_Divison__c from Sample_Request__c where ( Lead__c in :leadIDs and Lead__c != null ) or  ( Opportunity__c in :optyIDs and Opportunity__c != null )];
    leadSRList = [select ID, Lead__c, Opportunity__c,LeadID__c, Lead_Divison__c from Sample_Request__c where  Lead__c in :leadIDs and Lead__c != null and ID not in :SRIDs];
    optySRList = [select ID, Lead__c, Opportunity__c,LeadID__c, Lead_Divison__c from Sample_Request__c where Opportunity__c in :optyIDs and Opportunity__c != null and ID not in :SRIDs];
    if(leadSRList.size() > 0){
        Trigger.new[0].addError('Max of only 1 sample Request can be made from Lead');
    }
    else
    { 
        for(Sample_Request__c loopSR: optySRList){
        
            if(loopSR.LeadID__c == null){
                Trigger.new[0].addError('Max of only 1 sample request can be made from Opportunity');
                break;
            }              
            
            else
                optyLeadMap.put(loopSR.Opportunity__c,(optyLeadMap.get(loopSR.Opportunity__c)== null ? 0 : optyLeadMap.get(loopSR.Opportunity__c)+1));
            
        }
        leadOptySRCountlist = optyLeadMap.values();
        leadOptySRCountset.addAll(leadOptySRCountlist);
        leadOptySRCountset.remove(0);
        leadOptySRCountset.remove(1);
        if(leadOptySRCountset.size() > 0 )
            Trigger.new[0].addError('Max of only 1 sample request can be made from Opportunity');
        
    }   

}
}