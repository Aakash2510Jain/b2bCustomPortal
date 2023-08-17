global  class SendEmailLeadUser{ 
	public static void sendEmail(List<String> leadIds, String additionalEmail)
    {
    	List<Messaging.SingleEmailMessage> sendMails = new List<Messaging.SingleEmailMessage>();
    	List<Lead> updateLeads = new List<Lead>();
    	try{
    		//List<Lead> recipient = [SELECT id,Owner.Email,User_EmailId__c,LeadID__c,Name,Lead_AssignedTo__c FROM Lead where id=:leadId];
			//System.debug('LEAD RECORDS IS : '+recipient);
			List<Lead> leadRecords = [SELECT id,OwnerId,Owner.Email,User_EmailId__c,LeadID__c,Name,
						Lead_AssignedTo__c FROM Lead where id=:leadIds and CreatedDate = TODAY for update];
			
    		for(Lead leadRecord : leadRecords){
    			System.debug('Lead Record is :'+leadRecord+'Owner Email'+leadRecord.Owner.Email);
		    	List<String> toAddresses = new List<String>();
		    	toAddresses.clear();
		    	Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
		    	if(leadRecord.Owner.Email != null){ 
					toAddresses.add(leadRecord.Owner.Email);
		    	}	
				toAddresses.add(leadRecord.User_EmailId__c);
				if(additionalEmail != null && additionalEmail != ''){
					toAddresses.add(additionalEmail);
				}
				mail.setToAddresses(toAddresses);
				mail.setSubject('Confirmation Email for Lead :'+leadRecord.LeadID__c);
				String emailBody ='Hi,\n\n This is to confirm that your lead is submitted successfully.'+
				'\n\nBelow are the submitted Lead details:'+
				'\nLead ID :'+leadRecord.LeadID__c+
				'\nLead Name :'+leadRecord.Name+
				'\nAssigned BD Name : '+leadRecord.Lead_AssignedTo__c+
				'\n\nRegards,\nSalesforce Administrator Team.';
				mail.setPlainTextBody(emailBody);
				System.debug('Email Object : '+mail);
				if(toAddresses.size() > 0){
					sendMails.add(mail);
					leadRecord.EmailConformanceToLeadGen__c = true;
					updateLeads.add(leadRecord);
				}
    		}
    		if(sendMails.size() > 0){
    			Messaging.sendEmail(sendMails);
    		}
    		if(updateLeads.size() > 0){
    			update updateLeads;
    		}
    	}catch(Exception e){
    		System.debug('ERROR ON SENDEMAILLEADUSER :');
    		Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    		String[] toAddresses = new String[] {'praveen.r@istrategicloud.com'};
    		mail.setToAddresses(toAddresses);
    		mail.setSubject('PRODUCTION LEAD EMAIL ERROR'); 
    		mail.setPlainTextBody('Your Error Is: \n\n' + e);
    		Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    		//throw e;
    	}		
    }
   public static testMethod void myUnitTest_SendEmailLeadUserController(){
	   	Profile p = [SELECT Id FROM Profile WHERE Name='Account Managers']; 
		User u = new User(Alias = 'standqt', Email='karthik.m@istrategicloud.com', 
				EmailEncodingKey='UTF-8', LastName='Testing u', LanguageLocaleKey='en_US',
				IsActive=true,Division='Rainmakers',Is_Account_Manager__c=true,
				LocaleSidKey='en_US', ProfileId = p.Id,Rating__c='A+',Mapped_UserID_Name__c='Test User (Rainmakers)', 
				TimeZoneSidKey='America/Los_Angeles', UserName='standardqtestuser@testorg.com');
		insert u;
	   	
	   	Lead leadRecCON = new Lead();
        leadRecCON.Company = 'Test';
        leadRecCON.OwnerId = u.id;
        leadRecCON.Country = 'India';
        leadRecCON.Title='title';
        leadRecCON.Email='karthikneo37@in.com';
        leadRecCON.FirstName='firstname';
        leadRecCON.LastName='testing';
        leadRecCON.Website='www.sign.com';
        leadRecCON.LeadSource='Other';
       // leadRecCON.Lead_AssignedTo__c=u2.Mapped_UserID_Name__c; 
        leadRecCON.Primary_Service_Name__c='InfocheckPoint';
        leadRecCON.Sub_Division_Name__c='Email Data Group'; 
        leadRecCON.Division_Name__c='Rainmakers';
        leadRecCON.Status='Yet to Initiate';
        leadRecCON.LinkedIn_URL__c='srivarsha379/linkedin.com';
        leadRecCON.Users__c='sraj';
        leadRecCON.IgnoreTriggerCheck__c=true;
       // leadRecCON.Account_Name__c=instantAccount.id;
        leadRecCON.Team_Identification__c='Web team';
   		leadRecCON.Users__c='Francis';
   		insert leadRecCON;
   	List<String> ids = new List<String>();
   	ids.add(leadRecCON.Id);
/*	List<Lead> leadRec = [select id from lead where EmailConformanceToLeadGen__c = false and User_EmailId__c != null];
	for(Lead leadRecd : leadRec){
		ids.add(leadRecd.Id);
	} */
	sendEmail(ids,'praveen.r@istrategicloud.com');
	}
}