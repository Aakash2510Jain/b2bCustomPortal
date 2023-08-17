public class LeadColumnPage{
      
       public string SessionID;
       public list<Lead> results{get;set;}
       public string UploadedByName{get;set;}
       public String fromDate{get;set;}
       public String toDate{get;set;}
       public integer counter{get;set;}
       
       List<LeadFormUsers__c> leadfrmusr = new List<LeadFormUsers__c>();
       
       public LeadColumnPage(){
            UploadedByName=Apexpages.currentPage().getParameters().get('UploadedByName');
            sessionID = System.currentPageReference().getParameters().get('sessionId');
            if(sessionID!=null){
                Session__c ses =[Select s.Session_For__c,s.Session_For_LeadFormUsers__c, s.SessionId__c  From Session__c s where s.Sessionid__c=:sessionID limit 1];
            	leadfrmusr=[SELECT Active__c,Approval_Message_Page__c,CreatedById,CreatedDate,Division__c,EMail_ID__c,Floor__c,Id,IsDeleted,
										     LastActivityDate,LastModifiedById,LastModifiedDate,Last_Login__c,Manager__c,Name,OwnerId,Password__c,
															Registration_Approved__c,SiteProfile__c,SystemModstamp,UserName__c FROM LeadFormUsers__c 
												                    where ID = :ses.Session_For_LeadFormUsers__c limit 1];
				UploadedByName=leadfrmusr[0].Name;	
			}
		doSearch();	
       }
       
      public  PageReference  doSearch() {
      counter=0;
      system.debug('COunter Clear%%%%%%%%%%%%'+counter);
			if(fromDate==null  && toDate==null){
				date dt= date.today();  
				Date dt1 = dt.toStartOfMonth();
				fromdate=string.valueOf(dt1);
				todate=String.valueOf(System.today());
					}
								
			string queryLead;
				 if(sessionID!=null){
				queryLead='select  Name,CreatedDate, Division_Name__c,LeadID__c,Company,Phone,Email,'+
				 					'Primary_Service_Name__c,LeadSource,Status,IsConverted,Leadgen_Owner__c,User_Name__c,'+
				 						'owner.name from Lead where CreatedDate >='+fromDate.split(' ')[0]+'T00:00:03Z and '+
				 						' CreatedDate <='+toDate.split(' ')[0]+'T23:59:59Z and User_Name__c LIKE \''+UploadedByName+'\'';
				 }else{
				 queryLead='select  Name,CreatedDate, Division_Name__c,Company,LeadID__c,Phone,Email,'+
				 					'Primary_Service_Name__c,LeadSource,Status,IsConverted,Leadgen_Owner__c,User_Name__c,'+
				 						'owner.name from Lead where CreatedDate >='+fromDate.split(' ')[0]+'T00:00:03Z and '+
				 						' CreatedDate <='+toDate.split(' ')[0]+'T23:59:59Z and User_Name__c LIKE '+UploadedByName;
				 
				 }	
				 
				// Leadcount=queryLead.size();
			//	system.debug('***************'+Leadcount);					
				System.debug('*************'+queryLead);		 						
				try{
					results= Database.query(queryLead);
					}catch(exception e){
					system.debug(e);
				}
				counter=results.size();
	system.debug('COunter size%%%%%%%%%%%%'+counter);
        	
        	return null;
          }
    }