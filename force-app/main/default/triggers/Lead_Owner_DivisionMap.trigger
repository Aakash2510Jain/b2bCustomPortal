/*
When user try to change the owner of Lead record,
it will check for the division associated with new user,
it should be same as the division entered in lead record.
*/

trigger Lead_Owner_DivisionMap on Lead (after update) {
   
    for(Lead L:trigger.new){
            if(trigger.Isupdate && trigger.oldmap.get(L.Id).OwnerId != L.OwnerId){
            User u = null;
                system.debug('!!!!!entered in first if!!!!!');
             if(trigger.oldmap.get(L.Id).OwnerId != L.OwnerId && trigger.oldmap.get(L.Id).OwnerId != null && L.OwnerId != null){
                system.debug('@@@@@ Owner Id is @@@@@'+L.OwnerId);
             try{   
             u=[select Id,Name,Division from User where Id =: L.OwnerId];
             }catch(Exception e){
             System.debug(' This owner is assigned non user (like Queue), So no need to check condition');
             }
             if(u != null && u.Division == NULL){
             L.Ownerid.adderror('This user does not belongs to the division selected. Please Review');
             }
             else if(u != null && u.Division != NULL){
                system.debug('&&&&&&& UserId is &&&&&&'+u.id);
             if(L.Division_Name__c != u.Division.TRIM()){
                system.debug('&&&&&&& Division name-User &&&&&&'+u.Division);
                system.debug('&&&&&&& Division name-Lead &&&&&&'+L.Division_Name__c);
            /* L.Ownerid.adderror('Please select the appropriate Owner,who belongs to '+L.Division_Name__c+' of current Lead');*/
             
              }
             }
           }  
        }    
    }
  }