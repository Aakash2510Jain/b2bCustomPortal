trigger DuplicateEmailCheck_120Days on Lead (before insert) {

        /*Set<String> setEmail = new Set<String>();
        for ( Lead ltrigger : Trigger.new){
        setEmail.add(ltrigger.Email);
        }
        List <Lead> ListLead=[select Id,LastName,Lead_Created_Date__c,Email  from Lead where Email =: SetEmail];

        if(ListLead.size()>0){
        for(Lead ltrigger : Trigger.new){
        for(Lead li:ListLead){
        if(li.Email == ltrigger.Email){
            Date d = Date.valueof(li.Lead_Created_Date__c);
            integer i=System.Today().daysbetween(d);
               if(i< 120)
                  trigger.new[0].adderror('Duplicate Email Id');
            }
         }
        }
       }*/
      }