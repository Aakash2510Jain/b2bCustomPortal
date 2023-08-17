/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest 
private class TestClass_SendDocWithDocusign {

    static testMethod void myUnitTest_SendDocWithDocusign(){
        
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
	 	
		User u2 = new User(Alias = 'standt', Email='praveen.r@istrategicloudabdc.com', 
				EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
				IsActive=true,Division='Rainmakers',
				LocaleSidKey='en_US', ProfileId = p.Id,Mapped_UserID_Name__c='Test User (Rainmakers)', 
				TimeZoneSidKey='America/Los_Angeles', UserName='praveen.ravi@istrategicloud.com');
		insert u2;
		
		List<User> userList=[select id, name from User where id=:u2.id];
    	System.assertEquals(1, userList.size());
					
		
		System.debug('USER 2:'+u2);
					
		Account instantAccount= new Account(Name='TestCase');
		instantAccount.OwnerId=u2.id;
		instantAccount.Division__c = 'Winners';
		insert instantAccount;
		
		List<Account> accList=[select id, name from Account where id=:instantAccount.id];
    	System.assertEquals(1, accList.size());
    	
		list<Contact> contactList = new list<Contact>();
		Contact instantContact = new Contact(LastName='testUser');
		instantContact.OwnerId=u2.id;
		instantContact.AccountId=instantAccount.id;
		//instantContact.Country__c='India';
		instantContact.Email='praveen.r@istrategicloud.com';//'karthik147@hotmail.com';
		insert instantContact;
		system.debug('Contact inserted:'+instantContact);
		contactList.add(instantContact);
		
    	System.assertEquals(1, contactList.size());
		
		Docu_Sign__c docInstant = new Docu_Sign__c();
      	docInstant.UserName__c='varsha.sfdc@gmail.com';
      	docInstant.Password__c='cloud2013';
      	docInstant.Integrator_Key__c='PROC-e593cd98-14c0-435c-b324-7b1492f601d1';
        docInstant.AccountID__c='56345991-5ed2-4945-89af-69ca938cf527';
        insert docInstant;
        
        Folder fold = new Folder();
        fold = [select id,name from Folder limit 1];         
        
        List<Docu_Sign__c> docList=[select id, name from Docu_Sign__c where id=:docInstant.id];
    	System.assertEquals(1, docList.size());
        
		Opportunity oppInstant =new Opportunity(); 
		oppInstant.Name='sample';
      	oppInstant.AccountId= instantAccount.id;
      	oppInstant.Lead_Source__c='Approved Index';
      	oppInstant.Primary_Service_Name__c='Technology List';
      	oppInstant.Brand_Name__c='B2B Data Partners';
      	oppInstant.Division__c='Winners';
      	oppInstant.StageName='Warm';
      	oppInstant.Sample_To_Deal__c='other';
      	oppInstant.Uploaded_By__c='test';
      	oppInstant.ForecastCategoryName='pipeline';
      	oppInstant.Amount=5000;
      	oppInstant.CloseDate=date.today();
      	oppInstant.Docu_Sign_Setting__c=docInstant.id;
      	insert oppInstant;
      	
      	List<Opportunity> opportunities=[select id, name from Opportunity where id=:oppInstant.id];
    	System.assertEquals(1, opportunities.size());
        
        Attachment attach=new Attachment();   	
    	attach.Name='Unit Test Attachment';
    	Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
    	attach.body=bodyBlob;
        attach.parentId=oppInstant.id;
        insert attach;
        
        List<Attachment> attachments=[select id, name from Attachment where parent.id=:oppInstant.id];
    	System.assertEquals(1, attachments.size());
    	
    	Docusign_Status__c docStatus = new Docusign_Status__c();
    	docStatus.status__c = 'sent';
    	docStatus.Envelope_Id__c = 'test_id';
        docStatus.Opportunity__c = oppInstant.id;
        docStatus.Document_Name__c = attach.Name;
        docStatus.Username__c = oppInstant.Docu_Sign_Setting__r.UserName__c;
        docStatus.Password__c = oppInstant.Docu_Sign_Setting__r.Password__c;
        docStatus.Account_ID__c = oppInstant.Docu_Sign_Setting__r.AccountID__c;
        docStatus.Integrator_Key__c = oppInstant.Docu_Sign_Setting__r.Integrator_Key__c;
        insert docStatus;
        Docusign_Status__c docStatus1 = new Docusign_Status__c();
    	docStatus1.status__c = 'sent';
        docStatus1.Opportunity__c = null;
        docStatus1.Envelope_Id__c = 'test_id';
        docStatus1.Document_Name__c = attach.Name;
        docStatus1.Username__c = oppInstant.Docu_Sign_Setting__r.UserName__c;
        docStatus1.Password__c = oppInstant.Docu_Sign_Setting__r.Password__c;
        docStatus1.Account_ID__c = oppInstant.Docu_Sign_Setting__r.AccountID__c;
        docStatus1.Integrator_Key__c = oppInstant.Docu_Sign_Setting__r.Integrator_Key__c;
        insert docStatus1;
    	
        Apexpages.currentPage().getParameters().put('Id',oppInstant.id); 
        Apexpages.currentPage().getParameters().put('conid',instantContact.id);
        
        SendDocWithDocusignController docusign = new SendDocWithDocusignController();
        system.debug('@@@@@@@@@@@@@fold.id@@@@@@@@@@@'+fold.id);
        docusign.selcontactid = instantContact.id;
        docusign.folderId = fold.id;        
        docusign.attachmentId = attach.id;
        docusign.getAttachments();
        docusign.attachmentName = attach.Name;
        docusign.getDocuments();
        docusign.getAllContacts();
        docusign.selectcon();
        docusign.getselectedContact();
        docusign.getDocfolder();
        docusign.selectDocument();
        docusign.addDocuments();
        docusign.EmailBody='Sign ASAP!';
        docusign.EmailSubject='Docusign';
        docusign.sendDocsToDS();
        docusign.attachmentName = '';
        docusign.sendDocsToDS();
        docusign.EmailSubject='';
        docusign.sendDocsToDS();
        docusign.EmailSubject='Docusign';
        docusign.attachmentName = attach.Name;
        docusign.typeofService = 'workorder';
        docusign.sendDocsToDS();
        docusign.getTypeService();
        SendDocWithDocusignController.processDocument(oppInstant.id,attach.id,'Test_name','abc@xyz.com','xyz@abc.com','Test_Body','Test_Att_name','Test_service');
        SendDocWithDocusignController.authHeader();
        
        }
}