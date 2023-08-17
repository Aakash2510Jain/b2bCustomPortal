global class CreateContract {
	WebService static String init(String opportunityId){
		
		List<Contract> contractRec = [Select Id from Contract where Opportunity__c =: opportunityId];
		if(contractRec.size() > 0){
			return 'Already Contract Exists for this Opportunity. You can update existing contract.';
		}else{
			Opportunity opporRecord = [Select Id,Name,OwnerId,AccountId,CloseDate,Client_Name__c,Client_Name__r.Title,Client_Name__r.MailingStreet,
				Client_Name__r.MailingState,Client_Name__r.MailingCity,Client_Name__r.MailingPostalCode,Client_Name__r.MailingCountry,
				Terms_And_Conditions__c, Project_Description__c, Template_Type__c 
						from Opportunity where Id =: opportunityId];
			try{
				List<Signature__c> signRecord = [Select Id from Signature__c where OwnerId =: opporRecord.OwnerId];
				
				Contract newContract = new Contract();
				newContract.AccountId = opporRecord.AccountId;
				newContract.Opportunity__c = opporRecord.Id;
				newContract.CustomerSignedId = opporRecord.Client_Name__c;
				newContract.CustomerSignedDate = opporRecord.CloseDate;
				newContract.CustomerSignedTitle = opporRecord.Client_Name__r.Title;
				newContract.CompanySignedId = opporRecord.OwnerId;
				newContract.CompanySignedDate = opporRecord.CloseDate;
				newContract.StartDate = opporRecord.CloseDate;
				newContract.BillingStreet = opporRecord.Client_Name__r.MailingStreet;
				newContract.BillingCity = opporRecord.Client_Name__r.MailingCity;
				newContract.BillingState = opporRecord.Client_Name__r.MailingState;
				newContract.BillingPostalCode = opporRecord.Client_Name__r.MailingPostalCode;
				newContract.BillingCountry = opporRecord.Client_Name__r.MailingCountry;
				newContract.SpecialTerms = opporRecord.Terms_And_Conditions__c;
				newContract.Description = opporRecord.Project_Description__c;
				if(signRecord.size() > 0){
					newContract.Signature__c = signRecord[0].Id;	
				}
				insert newContract;
				
				attachContract(opporRecord.Id,opporRecord.Name, newContract.Id);
			}catch(Exception er){
				return ''+er;
			}
			return 'success';
		}
	}
	
	WebService static String attachContract(String oppId, String oppName, String contId){
		try{
			System.debug('--------------'+oppId+'-------'+oppName+'---------'+contId);
			if(oppName==''){
				Opportunity oppRec = [Select Id,Name from Opportunity where Id =: oppId];
				oppName = oppRec.Name;
			}
			// inserting pdf work order to the contract
			PageReference newPage = new PageReference('/apex/Opp_Quote_Generation'+'?id='+oppId);
	        Blob blobFormPDF = null;
	        if (!Test.isRunningTest()){//unable to call .getContent() within tests
	            blobFormPDF = newPage.getContent();
	        }
	        List<Attachment> attachFiles = [Select Id from Attachment where parentId=:contId and Name=:oppName+'_WO.pdf'];
	        if(attachFiles.size() > 0){
	        	delete attachFiles;
	        }
	        Attachment formAttach = new Attachment();
	        formAttach.Name = oppName+'_WO.pdf';
	        formAttach.body = blobFormPDF;
	        formAttach.parentId = contId;
	 
	        if (!Test.isRunningTest()){//requires proper blob to insert an Attachment, unable to generate during testing
	            insert formAttach;
	        }
		}catch(Exception er){
		 	return ''+er;
		}
		return 'success';
	}
	public static testmethod void createContract() {
		Account testAccount = new Account();
		testAccount.Name = 'Test Account';
		insert testAccount;
		Opportunity opportunity = new Opportunity();
		opportunity.Name = 'Test Opportunity';
		opportunity.AccountId = testAccount.Id;
		opportunity.Client_Company__c = testAccount.Name;
		opportunity.LeadSource = 'Website';
		opportunity.Primary_Service_Name__c='CRM';
		opportunity.Division__c='Winners';
		opportunity.StageName='Demo Call';
		opportunity.ForecastCategoryName='PipeLine';
		opportunity.Amount=111.00;
		opportunity.CloseDate=System.today();
		insert opportunity;
		CreateContract.init(opportunity.Id);
		//List<Opportunity> oppRecord = [Select Id,Name from Opportunity limit 1];
		//System.debug('------------------'+oppRecord);
		//if(oppRecord.size() > 0){
			//CreateContract.init(oppRecord[0].Id);
		//}
		
	}
}