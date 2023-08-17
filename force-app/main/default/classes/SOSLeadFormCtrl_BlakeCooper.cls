public class SOSLeadFormCtrl_BlakeCooper
{
      public Lead App{get;set;}
      public Attachment Att{get;set;}
      List<String> emaillist = new List<String>();
      List <Attachment> alist=new List <Attachment>();
      List<Lead> listLead=new List<Lead>();
      List<Spam_Email__c> spamemaillist =new List<Spam_Email__c>();
      List<Spam_Domain__c> spamdomainlist =new List<Spam_Domain__c>();
      List<String> parts= new List<String>();
      List<String> domainlist = new List<String>();
      Integer i=0;
      Integer j=0;
      Integer k=0;
      String s = '';
      List <Lead> lList=new List <Lead>();
      String curPage;
      
    public SOSLeadFormCtrl_BlakeCooper()
    {
        Att=new Attachment();
        App=new Lead ();    
    }
     public void checkemail(){
     
   /*  if(App.Email != null){
     s=App.Email;
     parts = s.split('@',2);
     }
     //date d=System.Today().daysbetween(listLead.Lead_Created_Date__c);
     spamemaillist = [select Name from Spam_Email__c where Name=:App.Email.TRIM()] ;
     listLead = [select id,Email,CreatedDate,Lead_Created_Date__c,OwnerId,User_Name_Manager_Joshua_Raj__c from Lead where Email=:App.Email.TRIM()];
     spamdomainlist = [select Name from Spam_Domain__c where Name=:parts ] ;
     List <Lead> li=new List <Lead>(); 
     for(lead l : listLead ) {
       Date d = Date.valueof(l.CreatedDate);
      integer i1=d.daysbetween(System.Today());
      
         if(i1 < 120) {
           li.add(l);                                
         }
     }
     i=li.size();
     j = spamemaillist.size(); 
     k = spamdomainlist.size();    
                  if(i>0){  
                 ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,'Leads with the same email are uploaded in last 120 Days')); 
                  }  
               else if(j>0) {
                  ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,'The lead entered is part of the spam list'));                              
               }
               else if(k>0) {
                  ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,'The lead entered is part of the spam domain'));                              
               }    */   
     }
     
       
     public pagereference save()
    {   
    
    /* checkemail();
         Attachment Att1=new Attachment();
         pagereference pr; 
         if ((i==0 && j==0 && k==0 )){
            
                System.debug('-------->'+App.Comments__c);
                     
             if (App.Lead_AssignedTo__c != NULL)
             {
                 User u = [Select Id, Mapped_UserID_Name__c from User where Mapped_UserID_Name__c =: App.Lead_AssignedTo__c  Limit 1];
                 App.OwnerId = U.Id;
             }
             else if (App.Lead_AssignedTo__c == NULL)
             {
             App.OwnerId = '00G9000000109WS';
             }
             App.Team_Identification__c='Blake Cooper';
             //App.Ignore_TriggerCheck__c='IgnoreTriggerCheck for teams 120days check';
             App.IgnoreTriggerCheck__c=TRUE;
              insert App;
            
             Att1.Body = Att.Body;
             Att1.Name = Att.Name;
             Att1.ParentId =App.Id;                    
             if(Att.Body!=NULL) {             
                 insert Att1;       
              }
                 
             pr=new pagereference('/apex/LeadSuccess1');
             pr.setredirect(true);
             return pr;       
        }
        else {
               if(i>0) {
                  ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,'Leads with the same email are uploaded in last 120 Days'));                              
               }
               else if(j>0) {
                  ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,'The lead entered is part of the spam list'));                              
               }
               else if(k>0) {
                  ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,'The lead entered is part of the spam domain'));                              
               }
             */
               return null;
      //  }                      
    }
    public pagereference leadSucess(){
     pagereference pr =new pagereference('http://strategicoutsourcingservices.force.com/BlakeCooper'); 
     pr.setredirect(true);
        return pr;
    }
           
  }