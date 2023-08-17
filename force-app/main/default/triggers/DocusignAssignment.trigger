trigger DocusignAssignment on Opportunity (before insert, before update) {
    
    list<Docu_Sign__c> docList =  new list<Docu_Sign__c>();
    User userrecord;
    docList=[Select Name,Id,UserName__c From Docu_Sign__c]; 
    for(Opportunity oppObj: Trigger.new){
            userrecord=[select Name,Id,Email from User where id=:oppObj.OwnerId limit 1];
            for(Docu_Sign__c doc: docList){
                if(userrecord.Email==doc.UserName__c){
                    oppObj.Docu_Sign_Setting__c = doc.id;
                }
            }   
        }
    }