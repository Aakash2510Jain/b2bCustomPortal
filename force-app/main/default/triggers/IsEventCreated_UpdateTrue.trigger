trigger IsEventCreated_UpdateTrue on Event (before insert) {
	
	set<ID> leadIds = new set<ID>();
	
		for(Event loopEvent : trigger.new){
     		
            leadIds.add(loopEvent.whoid);
            
     	   }   // Adding Event 
     	   
     	List<Lead> listLead = [select id,Is_Task_or_Event_Created__c from Lead where id IN :leadIds]; // checking whether Added Event is Related to Lead   
        
            if(listLead.size() > 0 ){
        	
            for(Lead loopLead : listLead){ 
            	
                loopLead.Is_Task_or_Event_Created__c = true;
            }
            
            update listLead;
        }
        
}

     /* Lead Le = new Lead();
      String contact;
  
    for(Event FieldUpdateNewEvent:Trigger.new){
       
        system.debug('%%%%%%%%%%%'+FieldUpdateNewEvent.whoId);
        
        if (FieldUpdateNewEvent.whoId !=null){
        	
        	 string con = FieldUpdateNewEvent.WhoId;
        
             contact = con.substring(0, 3);
             
             system.debug('@@@@@@@@@@@'+contact);
        	
        }
        
     if (FieldUpdateNewEvent.whoId !=null && contact !='033'){
        
            Le = [select id,Is_Task_or_Event_Created__c from Lead where id = : FieldUpdateNewEvent.whoId];
            
            Le.Is_Task_or_Event_Created__c = true;
            
            Update Le;
        }
     
        
    }*/