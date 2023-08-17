public class SOSLeadFormCtrl_SamGreen
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
      
    public SOSLeadFormCtrl_SamGreen()
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
     listLead = [select id,CreatedDate,Email,Lead_Created_Date__c,OwnerId,UserName_SamGreen__c from Lead where Email=:App.Email.TRIM()];
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
               }      */ 
     }
     
       
     public pagereference save()
    {   
    
  /*   checkemail();
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
             App.OwnerId = '00G900000012qt2';
             }
             App.Team_Identification__c='Sam Green';
             //App.Ignore_TriggerCheck__c='IgnoreTriggerCheck for teams 120days check';
             App.IgnoreTriggerCheck__c=TRUE;
              insert App;
            
             Att1.Body = Att.Body;
             Att1.Name = Att.Name;
             Att1.ParentId =App.Id;                    
             if(Att.Body!=NULL) {             
                 insert Att1;       
              }
                 
             pr=new pagereference('/apex/LeadSuccess15');
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
       // }                      
    }
    public pagereference leadSucess(){
     pagereference pr =new pagereference('http://strategicoutsourcingservices.force.com/SamGreen'); 
     pr.setredirect(true);
        return pr;
    }
     static testMethod void myUnitTest_LeadGen(){
	 /*SOSLeadFormCtrl_LeadGen LeadGen=new SOSLeadFormCtrl_LeadGen();
	 
	    Lead lead4= new Lead();
        lead4.Company='test123'; 
        lead4.lastname='testclass';
        lead4.Status='Working';
        lead4.Division_Name__c='Gladiators';
        lead4.LeadSource='Other';         
        lead4.Email = 'test@istrategicloud.com';
        LeadGen.App = lead4;
        LeadGen.save();
        
        
        Lead l1= new Lead();
        l1.Company='test123';
        l1.lastname='testclass';
        l1.Status='Working';
        l1.Division_Name__c='Gladiators';
        l1.LeadSource='Other';        
        l1.Email='praveen.r@istrategicloud.com';
       
        LeadGen.App = l1;
        LeadGen.save();
        LeadGen.leadSucess();
        
        Lead l2= new Lead();
        l2.Company='test123';
        l2.lastname='testclass';
        l2.Status='Working';
        l2.Division_Name__c='Gladiators';
        l2.LeadSource='Other';         
        l2.Email = 'praveen.r@1020.net';
        LeadGen.App = l2;
        LeadGen.save();
        
        Lead lead3= new Lead();
        lead3.Company='test123'; 
        lead3.lastname='testclass';
        lead3.Status='Working';
        lead3.Division_Name__c='Gladiators';
        lead3.LeadSource='Other';         
        lead3.Email = 'annekimzey@cisco.com';
        LeadGen.App = lead3;
        LeadGen.save();
        
*/
    }                   
           
  }