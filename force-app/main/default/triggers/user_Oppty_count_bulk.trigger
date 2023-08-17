trigger user_Oppty_count_bulk on Opportunity(after insert, after update, after Undelete, before delete ) {
/*
//Map <Lead,User> leadUserMap = new Map <Lead, User> ();
List<User> ulist = new List<User>();
set <ID> luid = new set <ID> ();

if( Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete )
for ( Opportunity ltrigger : Trigger.new){
luid.add(ltrigger.Ownerid);}

if( Trigger.isDelete )
for (Opportunity ltrigger : Trigger.old){
luid.add(ltrigger.Ownerid);}

ulist = [select id,No_of_Open_Opportunities__c,Rollup_should_hapen__c,Open_Opportunities_Allowed__c from User where Rollup_should_hapen__c = true and ID IN :luid ]; 

if( Trigger.isInsert ){
for ( User uloop : ulist ){
for ( Opportunity ltrigger : Trigger.new){
if (ltrigger.StageName!= 'Closed Won' && ltrigger.Ownerid == uloop.id){
uloop.No_of_Open_Opportunities__c ++;
if (uloop.No_of_Open_Opportunities__c > uloop.Open_Opportunities_Allowed__c )
ltrigger.Ownerid.adderror('This user has more Opportunities('+uloop.No_of_Open_Opportunities__c+') than actual allowed('+uloop.Open_Opportunities_Allowed__c+'), Further Opportunities cannot be assigned');
}
}
}
update ulist;
}// End of the isInsert check

if( Trigger.isUpdate ){
for ( User uloop : ulist ){
for ( Opportunity ltrigger : Trigger.new){
if (ltrigger.Ownerid == uloop.id){
if (Trigger.oldMap.get(ltrigger.id).StageName!= 'Closed Won' && ltrigger.StageName== 'Closed Won')
uloop.No_of_Open_Opportunities__c --;
if (Trigger.oldMap.get(ltrigger.id).StageName== 'Closed Won' && ltrigger.StageName!= 'Closed Won')
uloop.No_of_Open_Opportunities__c ++;
if (uloop.No_of_Open_Opportunities__c > uloop.Open_Opportunities_Allowed__c )
ltrigger.Ownerid.adderror('This user has more Opportunities('+uloop.No_of_Open_Opportunities__c+') than actual allowed('+uloop.Open_Opportunities_Allowed__c+'), Further Opportunities cannot be assigned');
}
}
}
update ulist;
}// End of the isUpdate check

if( Trigger.isDelete) {
for ( User uloop : ulist ){
for ( integer i=0; i<Trigger.old.size(); i++ ){
if ( Trigger.old[i].StageName!= 'Closed Won' && Trigger.old[i].Ownerid == uloop.id){
uloop.No_of_Open_Opportunities__c --;
}
}
}
update ulist;
}
// End of the isDelete check

if( Trigger.isUndelete) {
for ( User uloop : ulist ){
for ( integer i=0; i<Trigger.new.size(); i++ ){
if ( Trigger.new[i].StageName!= 'Closed Won' && Trigger.new[i].Ownerid == uloop.id){
uloop.No_of_Open_Opportunities__c ++;
if (uloop.No_of_Open_Opportunities__c > uloop.Open_Opportunities_Allowed__c )
Trigger.new[i].Ownerid.adderror('This user has more Opportunities('+uloop.No_of_Open_Opportunities__c+') than actual allowed('+uloop.Open_Opportunities_Allowed__c+'), Further Opportunities cannot be assigned');
}
}
}
update ulist;
}
// End of the isUndelete check
*/
if(Trigger.isInsert || Trigger.isUpdate){
        for(Integer i = 0; i < Trigger.new.size();i++){
            Opportunity o = Trigger.new[i];
            boolean donotProcess=true;
            if(Trigger.isUpdate){
                Opportunity old = Trigger.old[i];
                if(old.StageName=='Deal'){
                    donotProcess = true;
                }else if(o.StageName == 'Deal' && old.StageName != 'Deal'){
                    donotProcess = false;
                }
            }
        if(!donotProcess){
          System.debug('***Deal****'+o.StageName+'----------Sample To Deal :'+o.Sample_To_Deal__c);
          System.debug('***SmapleREques****'+o.Sample_Request__c+'----------ADAMS_Reference_Key__c :'+o.ADAMS_Reference_Key__c);
          List<Sample_Request__c> samReq = new List<Sample_Request__c>([select Id,Sample_Type__c from Sample_Request__c where Opportunity__c =:o.Id]);
                System.debug('****samplesize*****'+samReq.size());
                
                String test = o.Sample_To_Deal__c;
                if(test!=null){
                String[] split1 = test.split(';');
                system.debug('*****splitsize******'+split1.size());
                    if(o.StageName == 'Deal'  && split1.size() > 2){
                    o.addError('Please check Sample to Deal, max limit of selecting value is two.');
                    }
                }
                
           if(o.StageName == 'Deal'  && o.Sample_To_Deal__c=='HELP DESK SAMPLES' && o.Sample_Request__c == null  ){
              if(samReq.size() > 0 ){
               o.addError('You are attempting to update the Stage as Deal,if type is HELP DESK SAMPLES.Please select Sample Request Under Sample Request ID Field.');
                }else{
                o.addError('You are attempting to update the Stage,there is no Sample Request. Please select the Sample to Deal "OTHER" or "HELPDESK COUNTS ONLY".');
                }
             }
            if(o.StageName == 'Deal'  && o.Sample_To_Deal__c=='HELP DESK SAMPLES' && o.Sample_Request__c != null &&  o.ADAMS_Reference_Key__c != null ){
               o.addError('You are attempting to update the Stage,if type is HELPDESK SAMPLES. Please add only Sample Request ID.');
            }    
            if(o.StageName == 'Deal'  && o.Sample_To_Deal__c=='ADAMS' && o.ADAMS_Reference_Key__c == null && o.Sample_Request__c != null ){
               o.addError('You are attempting to update the Stage as Deal,if type is ADAMS Please Provide ADAMS reference key Under ADAMS reference key Field.');
            } 
            if(o.StageName == 'Deal'  && o.Sample_To_Deal__c=='ADAMS' && o.ADAMS_Reference_Key__c != null && o.Sample_Request__c != null  ){
               o.addError('You are attempting to update the Stage as Deal,if type is ADAMS.Please Provide only ADAMS reference key Under ADAMS reference key Field.');
            }
            if(o.StageName == 'Deal'  && o.Sample_To_Deal__c=='OTHER' && o.ADAMS_Reference_Key__c != null && o.Sample_Request__c != null  ){
               o.addError('You are attempting to update the Stage,if type is OTHER Please remove ADAMS Reference Key and Sample Request ID.');
            }
            if(o.StageName == 'Deal'  && o.Sample_To_Deal__c=='OTHER' && o.ADAMS_Reference_Key__c != null  ){
               o.addError('You are attempting to update the Stage,if type is OTHER Please remove ADAMS Reference Key ');
            }
            if(o.StageName == 'Deal'  && o.Sample_To_Deal__c=='OTHER' && o.Sample_Request__c != null  ){
               o.addError('You are attempting to update the Stage,if type is OTHER Please remove Sample Request ID.');
            }
            
            if(o.StageName == 'Deal'  && o.Sample_To_Deal__c=='OTHER;HELPDESK COUNTS ONLY' && o.ADAMS_Reference_Key__c != null && o.Sample_Request__c != null  ){
               o.addError('You are attempting to update the Stage,if type is OTHER and HELPDESK COUNTS ONLY Please remove ADAMS Reference Key  and Sample Request ID');
            }
            if(o.StageName == 'Deal'  && o.Sample_To_Deal__c=='OTHER;HELPDESK COUNTS ONLY' && o.Sample_Request__c != null  ){
               o.addError('You are attempting to update the Stage,if type is OTHER and HELPDESK COUNTS ONLY Please remove Sample Request ID');
            }
            if(o.StageName == 'Deal'  && o.Sample_To_Deal__c=='OTHER;HELPDESK COUNTS ONLY' && o.ADAMS_Reference_Key__c != null ){
               o.addError('You are attempting to update the Stage,if type is OTHER and HELPDESK COUNTS ONLY Please remove ADAMS Reference Key  ');
            }
            
            if(o.StageName == 'Deal'  && o.Sample_To_Deal__c=='HELPDESK COUNTS ONLY' && o.ADAMS_Reference_Key__c != null  ){
               o.addError('You are attempting to update the Stage,if type is HELPDESK COUNTS ONLY Please remove ADAMS Reference Key ');
            }
            if(o.StageName == 'Deal'  && o.Sample_To_Deal__c=='HELPDESK COUNTS ONLY' && o.Sample_Request__c != null  ){
               o.addError('You are attempting to update the Stage,if type is HELPDESK COUNTS ONLY Please do not select either ADAMS Reference Key and Sample Request ID');
            }
             if(o.StageName == 'Deal'  && o.Sample_To_Deal__c=='ADAMS' && o.ADAMS_Reference_Key__c == null ){
               o.addError('You are attempting to update the Stage as Deal,if type is ADAMS Please Provide ADAMS reference key Under ADAMS reference key Field.');
            } 
            if(o.StageName == 'Deal' && o.Sample_To_Deal__c == 'ADAMS;HELP DESK SAMPLES' && o.Sample_Request__c==null &&  o.ADAMS_Reference_Key__c == null   ){
                o.addError('You are attempting to update the Stage as Deal.if type is ADAMS & HELP DESK SAMPLES, Please Provide details of ADAMS Reference Key and Sample Request ID.');
            }
            if(o.StageName == 'Deal' && o.Sample_To_Deal__c == 'ADAMS;HELP DESK SAMPLES' && o.Sample_Request__c==null &&  o.ADAMS_Reference_Key__c != null   ){
                o.addError('Sample to Deal is ADAMS&HELP DESK SAMPLES,Please Enter the ADAMS Reference Key and Sample Request ID.');
            }
            if(o.StageName == 'Deal' && o.Sample_To_Deal__c == 'ADAMS;HELP DESK SAMPLES' && o.Sample_Request__c!=null &&  o.ADAMS_Reference_Key__c == null   ){
                o.addError('Sample to Deal is ADAMS&HELP DESK SAMPLES,Please enter the ADAMS Reference Key and Sample Request ID.');
            }
            if(o.StageName == 'Deal' && o.Sample_To_Deal__c == 'HELP DESK SAMPLES;ADAMS' && o.Sample_Request__c==null &&  o.ADAMS_Reference_Key__c == null   ){
                    o.addError('Sample to Deal is ADAMS&HELP DESK SAMPLES,Please enter the ADAMS Reference Key and Sample Request ID.');
            }
            if(o.StageName == 'Deal' && o.Sample_To_Deal__c == 'HELP DESK SAMPLES;ADAMS' && o.Sample_Request__c!=null &&  o.ADAMS_Reference_Key__c == null   ){
                    o.addError('Sample to Deal is ADAMS&HELP DESK SAMPLES,Please enter the ADAMS Reference Key and Sample Request ID.');
            }
            if(o.StageName == 'Deal' && o.Sample_To_Deal__c == 'HELP DESK SAMPLES;ADAMS' && o.Sample_Request__c==null &&  o.ADAMS_Reference_Key__c != null   ){
                    o.addError('Sample to Deal is ADAMS&HELP DESK SAMPLES,Please enter the ADAMS Reference Key and Sample Request ID.');
            }
            if(o.StageName == 'Deal' && o.Sample_To_Deal__c == 'HELP DESK SAMPLES;OTHER' && o.Sample_Request__c==null &&  o.ADAMS_Reference_Key__c != null   ){
                    o.addError('Sample to Deal is HELP DESK SAMPLES,Please enter the Sample Request ID.');
            }
            if(o.StageName == 'Deal' && o.Sample_To_Deal__c == 'OTHER;HELP DESK SAMPLES' && o.Sample_Request__c==null  ){
                    o.addError('Sample to Deal is HELP DESK SAMPLE ,Please enter the Sample Request ID.');
            }
            if(o.StageName == 'Deal' && o.Sample_To_Deal__c == 'OTHER;ADAMS' && o.ADAMS_Reference_Key__c == null   ){
                    o.addError('Sample to Deal is ADAMS,Please enter the ADAMS Reference Key.');
            }               
            if(o.StageName == 'Deal' && o.Sample_To_Deal__c == 'HELPDESK COUNTS ONLY;HELP DESK SAMPLES' && o.Sample_Request__c==null  ){
                    o.addError('Sample to Deal is HELP DESK SAMPLE ,Please enter the Sample Request ID.');
            }
             if(o.StageName == 'Deal' && o.Sample_To_Deal__c == 'HELP DESK SAMPLES;HELPDESK COUNTS ONLY' && o.Sample_Request__c==null  ){
                    o.addError('Sample to Deal is HELP DESK SAMPLE ,Please enter the Sample Request ID.');
            }
            if(o.StageName == 'Deal' && o.Sample_To_Deal__c == 'HELPDESK COUNTS ONLY;HELP DESK SAMPLES' && o.Sample_Request__c==null  && o.ADAMS_Reference_Key__c != null    ){
                    o.addError('Sample to Deal is HELP DESK SAMPLE ,Please enter the Sample Request ID.');
            }
            if(o.StageName == 'Deal' && o.Sample_To_Deal__c == 'HELPDESK COUNTS ONLY;ADAMS' && o.ADAMS_Reference_Key__c == null   ){
                    o.addError('Sample to Deal is ADAMS,Please enter the ADAMS Reference Key.');
            }   
            if(o.StageName == 'Deal' && o.Sample_To_Deal__c == 'ADAMS;OTHER' &&  o.ADAMS_Reference_Key__c == null   ){
                    o.addError('Sample to Deal is ADAMS&OTHER,Please enter the ADAMS Reference Key');
            }
            if(o.StageName == 'Deal' && o.Sample_To_Deal__c == 'ADAMS;HELPDESK COUNTS ONLY' && o.ADAMS_Reference_Key__c == null   ){
                    o.addError('Sample to Deal is ADAMS,Please enter the ADAMS Reference Key.');
            }
            if(o.StageName == 'Deal' && o.Sample_To_Deal__c == 'ADAMS;HELPDESK COUNTS ONLY;HELP DESK SAMPLES' && o.Sample_Request__c==null &&  o.ADAMS_Reference_Key__c == null   ){
                    o.addError('Sample to Deal is ADAMS & HELP DESK SAMPLES,Please enter the ADAMS Reference Key and Sample Request ID.');
            }       
            if(o.StageName == 'Deal' && o.Sample_To_Deal__c == null ){
                 o.addError('Deal cannot be closed without ADAMS / HELP DESK SAMPLES,Please enter the Sample to Deal.');
            }
            if(o.StageName == 'Deal' && o.Sample_To_Deal__c == null && o.ADAMS_Reference_Key__c != null && o.Sample_Request__c==null  ){
                 o.addError('Deal cannot be closed without ADAMS / HELP DESK SAMPLES,Please Enter the Sample to Deal.');
            }
            if(o.StageName == 'Deal' && o.ADAMS_Reference_Key__c == null && o.Sample_To_Deal__c == 'ADAMS' && o.Sample_Request__c==null ){
                 o.addError('You are attempting to update the Stage,if Type is ADAMS Please Enter the ADAMS Reference Key.');
            }
            if(o.StageName == 'Deal' && samReq.size()>0 && o.Sample_Request__c == null && o.Sample_To_Deal__c == 'HELP DESK SAMPLES'){
                 o.addError('You are attempting to update the Stage as Deal.If type is HELP DESK SAMPLES Please enter the  Sample Request ID field.');
            }
            
            //TECHNOLOGY COUNTS ONLY enhancement 
                        if(o.StageName == 'Deal'  && o.Sample_To_Deal__c=='OTHER;TECHNOLOGY COUNTS ONLY' && o.ADAMS_Reference_Key__c != null && o.Sample_Request__c != null  ){
               o.addError('You are attempting to update the Stage,if type is OTHER and TECHNOLOGY COUNTS ONLY. Please remove ADAMS Reference Key  and Sample Request ID');
            }

            if(o.StageName == 'Deal' && o.Sample_To_Deal__c == 'ADAMS;TECHNOLOGY COUNTS ONLY' && o.ADAMS_Reference_Key__c == null   ){
                    o.addError('Sample to Deal is ADAMS,Please enter the ADAMS Reference Key.');
            }
            if(o.StageName == 'Deal' && o.Sample_To_Deal__c == 'TECHNOLOGY COUNTS ONLY;ADAMS' && o.ADAMS_Reference_Key__c == null   ){
                    o.addError('Sample to Deal is ADAMS,Please enter the ADAMS Reference Key.');
            }   

            if(o.StageName == 'Deal' && o.Sample_To_Deal__c == 'TECHNOLOGY COUNTS ONLY;HELP DESK SAMPLES' && o.Sample_Request__c==null  && o.ADAMS_Reference_Key__c != null    ){
                    o.addError('Sample to Deal is HELP DESK SAMPLE ,Please enter the Sample Request ID.');
            }

             if(o.StageName == 'Deal' && o.Sample_To_Deal__c == 'HELP DESK SAMPLES;TECHNOLOGY COUNTS ONLY' && o.Sample_Request__c==null  ){
                    o.addError('Sample to Deal is HELP DESK SAMPLE ,Please enter the Sample Request ID.');
            }

                        if(o.StageName == 'Deal' && o.Sample_To_Deal__c == 'TECHNOLOGY COUNTS ONLY;HELP DESK SAMPLES' && o.Sample_Request__c==null  ){
                    o.addError('Sample to Deal is HELP DESK SAMPLE ,Please enter the Sample Request ID.');
            }

             if(o.StageName == 'Deal'  && o.Sample_To_Deal__c=='TECHNOLOGY COUNTS ONLY' && o.Sample_Request__c != null  ){
               o.addError('You are attempting to update the Stage,if type is TECHNOLOGY COUNTS ONLY ONLY Please do not select either ADAMS Reference Key and Sample Request ID');
            }

             if(o.StageName == 'Deal'  && o.Sample_To_Deal__c=='TECHNOLOGY COUNTS ONLY' && o.ADAMS_Reference_Key__c != null  ){
               o.addError('You are attempting to update the Stage,if type is TECHNOLOGY COUNTS ONLY Please remove ADAMS Reference Key ');
            }

             if(o.StageName == 'Deal'  && o.Sample_To_Deal__c=='OTHER;TECHNOLOGY COUNTS ONLY' && o.ADAMS_Reference_Key__c != null ){
               o.addError('You are attempting to update the Stage,if type is OTHER and TECHNOLOGY COUNTS ONLY Please remove ADAMS Reference Key  ');
            }
             if(o.StageName == 'Deal'  && o.Sample_To_Deal__c=='OTHER;TECHNOLOGY COUNTS ONLY' && o.Sample_Request__c != null  ){
               o.addError('You are attempting to update the Stage,if type is OTHER and TECHNOLOGY COUNTS ONLY Please remove Sample Request ID');
            }
            if(o.StageName == 'Deal'  && o.Sample_To_Deal__c=='OTHER;TECHNOLOGY COUNTS ONLY' && o.ADAMS_Reference_Key__c != null && o.Sample_Request__c != null  ){
               o.addError('You are attempting to update the Stage,if type is OTHER and TECHNOLOGY COUNTS ONLY Please remove ADAMS Reference Key  and Sample Request ID');
            }
            // Code to update the Opportunity Accounts to AM as Owners
            OpportunityUtility.assignAccountToAM(o.Id); 
        }
      }
    }
}