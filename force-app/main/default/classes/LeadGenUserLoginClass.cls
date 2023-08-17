public without sharing class LeadGenUserLoginClass {
       
       public string userName{get;set;}
       public string password{get;set;}
       
       
       public string Session;
       public string UName;
       public LeadFormUsers__c leadFormUser;
       public string Userid{get;set;}
    
       public LeadGenUserloginClass(){
            Userid = ApexPages.currentPage().getParameters().get('emailAdd');
       }
    
       public PageReference checkLogin(){
        
        if((userName!=null && password!=null) || (userName!='' && password!='')){
        
            try{
            leadFormUser=[select EMail_ID__c,UserName__c,Name,Password__c,Division__c,Floor__c,
                                Last_Login__c from LeadFormUsers__c where 
                                        UserName__c=:Username and password__c=:password limit 1];
            }catch(Exception e){
                ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,'User not Found'));
                return null;
            }                           
        if(leadFormUser.id!=null){
                    
                                 Session = String.valueOf(Math.random()).substring(2,16);
                                 leadFormUser.Last_Login__c=Datetime.now();
                                 update leadFormUser;
                                 // PageReference successPage = new PageReference();
                                 PageReference successPage = new PageReference('/apex/B2BNewSiteLeadPage');
                                successPage.getParameters().put('id', leadFormUser.id);
                                //successPage.getParameters().put('sessionId', Session);
                                successPage.getParameters().put('div', leadFormUser.Division__c);

                                 successPage.setRedirect(true);
                             return successPage;
                    }else{
                        ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,'oops! Enter details are invalid'));
                        ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,'Please enter Valid details'));
                        return null;
                    }
        }else{
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,'oops! Enter details are invalid'));
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,'Please enter Valid details'));
            return null;
        }
          
        /*  try{
                if(Username != null){
                        Lfu=[select EMail_ID__c,Name,Password__c,Division__c,Floor__c,Last_Login__c from LeadFormUsers__c where EMail_ID__c=:Username limit 1];
                        string pass=Lfu.Password__c;
                        div=Lfu.Division__c;
                        //team=Lfu.Team__c;
                        UName = Lfu.Name;
                    } 
            }catch(Exception e){
                ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO,'User Name does not exists'));
                return null;
            }
            if(Password!=null){
                    if(lfu.Password__c==Password){
                             Userid =   Username;
                             Session = String.valueOf(Math.random()).substring(2,16);
                             PageReference pr = new PageReference('/apex/SOSLeadGenForm');
                             //?divisionUser='+div+'&UName='+UName+'&Emailid='+Userid
                             pr.getParameters().put('UName', UName);
                             pr.getParameters().put('div', div);
                             pr.getParameters().put('Emailid', Username);
                             pr.getParameters().put('sessionId', Session);
                             pr.setRedirect(true);
                         return pr;
                      }else{
                             ApexPages.Message Msg = new ApexPages.Message(ApexPages.Severity.WARNING,'Password Mismatch!');
                             ApexPages.addMessage(Msg);
                         return null;
                        }   
             }*/
            // return null;  
       }
    
}