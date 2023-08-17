public class Leadoppcoloumpage {
    public string SessionID;
       public list<Opportunity> results{get;set;}
      List<Id> opids = new List<Id>();
       public string UploadedByName{get;set;}
       public String fromDate{get;set;}
       public String toDate{get;set;}
       public integer counter{get;set;}
       public integer dealCount{get;set;}
        Public integer docusigncountvalue{get;set;}
       
     
         List<Docusign_Status__c> docusigncount = new List<Docusign_Status__c>();
         
         
        
        
       
      
       List<LeadFormUsers__c> leadfrmusr = new List<LeadFormUsers__c>();
       
       public Leadoppcoloumpage(){
            UploadedByName=Apexpages.currentPage().getParameters().get('UploadedByName');
            sessionID = System.currentPageReference().getParameters().get('sessionId');
            System.debug('>>>>>>>>>>The value of session id is '+sessionID);
            if(sessionID!=null){
              
                Session__c ses =[Select s.Session_For__c,s.Session_For_LeadFormUsers__c, s.SessionId__c  From Session__c s where s.Sessionid__c=:sessionID limit 1];
              leadfrmusr=[SELECT Active__c,Approval_Message_Page__c,CreatedById,CreatedDate,Division__c,EMail_ID__c,Floor__c,Id,IsDeleted,
                         LastActivityDate,LastModifiedById,LastModifiedDate,Last_Login__c,Manager__c,Name,OwnerId,Password__c,
                              Registration_Approved__c,SiteProfile__c,SystemModstamp,UserName__c FROM LeadFormUsers__c 
                                            where ID = :ses.Session_For_LeadFormUsers__c limit 1];
                                            
                                        
        UploadedByName=leadfrmusr[0].Name; 
        system.debug('Uploadedby name'+UploadedByName);
      
        
      }
      doSearch(); 
       }
       
          
         public PageReference  doSearch() {
         
            system.debug('>>>>>>>>>>>the value of the name is'+ UploadedByName);
      counter=0;
      dealcount=0;
      system.debug('COunter Clear%%%%%%%%%%%%'+counter);
      system.debug('Deal Count Clear'+dealCount);
      if(fromDate==null  && toDate==null){
        date dt= date.today();  
        Date dt1 = dt.toStartOfMonth();
        fromdate=string.valueOf(dt1);
        todate=String.valueOf(System.today());
          }
       string queryOpportunity;
       string dealCountOpportunity;
        if(sessionID!=null){
        queryOpportunity='select  owner.name,Lead_ID__c,Lead_Generator__c, StageName,Amount,Primary_Service_Name__c,LeadSource,Uploaded_By__c,Opportunity_Number__c from Opportunity where CreatedDate >='+fromDate.split(' ')[0]+'T00:00:03Z and '+
                     ' CreatedDate <='+toDate.split(' ')[0]+'T23:59:59Z and Lead_Generator__c LIKE \''+UploadedByName+'\'';
                                     
  } else{
        queryOpportunity='select owner.name,Lead_ID__c,Lead_Generator__c, StageName,Amount,Opportunity_Number__c,Primary_Service_Name__c,LeadSource,Uploaded_By__c from Opportunity where CreatedDate >='+fromDate.split(' ')[0]+'T00:00:03Z and '+
                     ' CreatedDate <='+toDate.split(' ')[0]+'T23:59:59Z and Lead_Generator__c LIKE \''+UploadedByName+'\'';
                      
  }
   // Opportunitycount=queryOpportunity.size();
      //  system.debug('***************'+Opportunitycount);          
        System.debug('*************'+queryOpportunity);                 
        try{
          results= Database.query(queryOpportunity); 
          }catch(exception e){   
          system.debug(e);
        }
        
        for(opportunity op : results){
             opids.add(op.id);
        } 
    
        docusigncount=[Select status__c , Type__c from Docusign_Status__c where Type__c = 'proposal' and status__c = 'sent' and  Opportunity__c IN :opids];
        counter=results.size();
        docusigncountvalue=docusigncount.size();
      
  system.debug('COunter size%%%%%%%%%%%%'+counter+'DocusignCount#######'+docusigncount.size());
      
       
    return null;         
    }    
    }