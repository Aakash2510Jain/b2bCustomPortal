public with sharing class LeadgenController{
  
   public string sessionID = '';
   public string LeadformUserID= '';
   public string UserId= '';
   public string Username{get;set;}
   public string Currentpassword{get;set;}
   public string Newpassword{get;set;}
   public string Confirmpassword{get;set;}
   public string name{get;set;}
   public string Division{get;set;} 
   public string Team{get;set;} 
   public string Email{get;set;}
   public string Manager{get;set;}
   public string Floor{get;set;}
   list<LeadFormUsers__c> LeadFormList= new list<LeadFormUsers__c>();
   
     
   public LeadgenController(){
    //Constructor
    	
        LeadformUserID= System.currentPageReference().getParameters().get('Id');
        system.debug('+++++6546546+++++'+LeadformUserID);
        sessionID = System.currentPageReference().getParameters().get('sessionId');
        system.debug('++++++++++'+sessionID);
            if(sessionID!=null){
                Session__c ses =[Select s.Session_For__c, s.Session_For_LeadFormUsers__c, s.SessionId__c  From Session__c s where s.Sessionid__c=:sessionID limit 1];
                LeadformUserID=ses.Session_For_LeadFormUsers__c;
            }
        LeadFormList= [SELECT Active__c,Approval_Message_Page__c,CreatedById,CreatedDate,Division__c,EMail_ID__c,Floor__c,Id,IsDeleted,
                    LastActivityDate,LastModifiedById,LastModifiedDate,Last_Login__c,Manager__r.Name,Name,OwnerId,Password__c,
                    Registration_Approved__c,SiteProfile__c,SystemModstamp,UserName__c FROM LeadFormUsers__c 
                    where ID = :LeadformUserID limit 1];
                 system.debug('_________LeadFormList__________'+LeadFormList.size());               
        if(LeadFormList.isEmpty() == false){
         // contactItem = contactList[0];
          Division= LeadFormList[0].Division__c;
          name = LeadFormList[0].Name;
          //Team= LeadFormList[0].Team__c;
          Email = LeadFormList[0].EMail_ID__c;
          Manager= LeadFormList[0].Manager__r.Name;
          Floor= LeadFormList[0].Floor__c;
          Username=LeadFormList[0].UserName__c;
          //Currentpassword = LeadFormList[0].Password__c;
        
        }
  }
 
 /* public pageReference cancelAction(){
    return null;
  }*/
  
 
  public pageReference saveItem(){
   
   	system.debug('$^$^$%$%^$$^'+LeadformUserID);
    LeadFormUsers__c Leadgen=  [SELECT Active__c,Approval_Message_Page__c,CreatedById,CreatedDate,Division__c,EMail_ID__c,Floor__c,Id,IsDeleted,
                    LastActivityDate,LastModifiedById,LastModifiedDate,Last_Login__c,Manager__c,Name,OwnerId,Password__c,
                    Registration_Approved__c,SiteProfile__c,SystemModstamp,UserName__c FROM LeadFormUsers__c 
                    where ID = :LeadformUserID limit 1];
                    Leadgen.Password__c=Currentpassword;
   
   if(Leadgen.id != null){
                    if(Currentpassword == null){
                    	ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please Enter the Current Password'));
                    	 }
					else if(Newpassword == Confirmpassword){
                    Leadgen.Password__c = Confirmpassword;
                    update Leadgen;
                    }                    
   
    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Profile Updated Successfully.'));
   }
   else{
    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Profile Updating Failed'));
   }
   return null;
  }
}