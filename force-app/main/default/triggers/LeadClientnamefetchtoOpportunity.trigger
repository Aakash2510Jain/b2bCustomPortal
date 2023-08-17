trigger LeadClientnamefetchtoOpportunity on Lead (before insert,after insert,after update) {
    if(trigger.isbefore && trigger.isInsert){
        system.debug('trigger.new==='+trigger.new);
         system.debug('trigger.newmap==='+trigger.newMap);
    }
    if(trigger.isAfter && trigger.isInsert){
        system.debug('trigger.new==='+trigger.new);
         system.debug('trigger.newmap==='+trigger.newMap);
    }
/**
 

  List<Opportunity> oprt = new List<Opportunity>();
  Map<ID,String> joining = new Map<ID,String>();

  for(Lead l : Trigger.new) {
    if(l.IsConverted && (l.ConvertedOpportunityId != null) ) {
      joining.put(l.ConvertedOpportunityId, l.ConvertedContactId);
    }
  }

  oprt = [SELECT Client_Name__c FROM Opportunity WHERE Id IN : joining.keySet()];

  for (Opportunity o: oprt) {
    o.Client_Name__c = joining.get(o.Id);
  }

  update oprt;*
  
  */
}