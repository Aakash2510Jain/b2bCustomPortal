trigger IsTaskCreated_UpdateTrue on Task (before insert) {
     
        set<ID> leadIds = new set<ID>();
        
        for(Task loopTask : trigger.new){
            
            leadIds.add(loopTask.whoid);
            
           }                                        // Adding the task
           
        List<Lead> listLead = [select id,Is_Task_or_Event_Created__c from Lead where id IN :leadIds];  
        
        if(listLead.size() > 0 ){
            
            for(Lead loopLead : listLead){ 
                
                loopLead.Is_Task_or_Event_Created__c = true;
            }
            
            update listLead;
        }
            
        /*Lead Le = new Lead();
          String contact;
          
      For(Task FieldUpdateNewTask:Trigger.new){
      
         system.debug('###########'+FieldUpdateNewTask.whoId);
       
         If (FieldUpdateNewTask.whoId != null){
        
             String con = FieldUpdateNewTask.whoId;
       
             contact  = con.substring(0, 3);
        
             system.debug('@@@@@@@@@@'+contact); 
        }
              
       If (FieldUpdateNewTask.whoId != null && contact!='003' ){
                                     
            Le = [select id,Is_Task_or_Event_Created__c from Lead where id = : FieldUpdateNewTask.whoId ];
            
            Le.Is_Task_or_Event_Created__c = true;
            
            update Le;
            
            }
            
     }*/
}