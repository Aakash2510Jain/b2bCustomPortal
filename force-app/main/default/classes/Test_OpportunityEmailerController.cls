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
private class Test_OpportunityEmailerController {

    static testMethod void myUnitTest() {
        // TO DO: implement unit test
       
        Profile pf= [Select Id from profile where Name='System Administrator']; 
        
        String orgId=UserInfo.getOrganizationId(); 
        String dateString=String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','') ;
        Integer RandomId=Integer.valueOf(Math.rint(Math.random()*1000000)); 
        String uniqueName=orgId+dateString+RandomId; 
        User uu1=new User(firstname = 'ABC', 
                         lastName = 'XYZ', 
                         email = uniqueName +'1'+ '@test' + orgId + '.org', 
                         Username = uniqueName +'1'+ '@test' + orgId + '.org', 
                         EmailEncodingKey = 'ISO-8859-1', 
                         Alias = uniqueName.substring(18, 23), 
                         TimeZoneSidKey = 'America/Los_Angeles', 
                         LocaleSidKey = 'en_US', 
                         LanguageLocaleKey = 'en_US',
                         Division='Winners',
                         ProfileId = pf.Id,
                          Is_Account_Manager__c=false
                        );         
        insert uu1;
        
        User uu2=new User(firstname = 'ABC', 
                         lastName = 'XYZ', 
                         email = uniqueName +'2'+ '@test' + orgId + '.org', 
                         Username = uniqueName +'2'+ '@test' + orgId + '.org', 
                         EmailEncodingKey = 'ISO-8859-1', 
                         Alias = uniqueName.substring(18, 23), 
                         TimeZoneSidKey = 'America/Los_Angeles', 
                         LocaleSidKey = 'en_US', 
                         LanguageLocaleKey = 'en_US',
                         Division='Winners',
                         ProfileId = pf.Id,
                          Is_Account_Manager__c=true
                        );         
        insert uu2;
        
        /* 
         User u2 = [select Id,Mapped_UserID_Name__c,LastLoginDate,Division,Email,Is_Account_Manager__c from User 
					where  Division='Winners' and LastLoginDate != null 
					and isActive=true and Is_Account_Manager__c=false 
					order by LastLoginDate desc limit 1];
        
		 User u3 = [select Id,Mapped_UserID_Name__c,LastLoginDate,Division,Email,Is_Account_Manager__c from User 
					where  Division='Winners' and LastLoginDate != null 
					and isActive=true and Is_Account_Manager__c=true 
					order by LastLoginDate desc limit 1];			
			*/		
					
		User u2 = [select Id,Mapped_UserID_Name__c,LastLoginDate,Division,Email,Is_Account_Manager__c from User 
					where  Division='Winners' and isActive=true and Is_Account_Manager__c=false 
					order by Name desc limit 1];
        
		 User u3 = [select Id,Mapped_UserID_Name__c,LastLoginDate,Division,Email,Is_Account_Manager__c from User 
					where  Division='Winners' and isActive=true and Is_Account_Manager__c=true 
					order by Name desc limit 1];
		System.debug('USER 2:'+u2);
					
		Account instantAccount= new Account(Name='TestCase');
		instantAccount.OwnerId=u2.id;
		instantAccount.Division__c = 'Winners';
		instantAccount.Name = 'Cirrologix';
		insert instantAccount;
		instantAccount.Name='TestLEADIN';
		update instantAccount;  
		
		Date accountDays = System.today() - 10;
		Account dupAccount = [Select Id, Name from Account where LastModifiedDate >= :accountDays limit 1];
		
		Contact instantContact = new Contact(LastName='testUser');
		instantContact.OwnerId=u2.id;
		instantContact.AccountId=instantAccount.id;
		
		instantContact.Email='praveen.r@istrategicloud.com';//'karthik147@hotmail.com';
		insert instantContact;
		
		Brand_Details__c brand = new Brand_Details__c();
		brand.Active__c=true;
		brand.Address__c='test';
		brand.Brand_Name__c='B2B Data Partners';
		brand.Brand_Template_VF_Page__c='/apex/B2BDataPartners';
		brand.Cheque__c='test';
		brand.Email__c='test@gmail.com';
		brand.Floor__c='First';
		//brand.Name='B2B Data Partners';
		brand.Name__c='B2B Data Partners';
		brand.paypal__c='test';
		brand.Phone__c='223234';
		//brand.ServiceOffer__c
	//	brand.Signature__c
		//brand.Template__c
		//brand.TemplateCode__c
		//brand.Type__c
		//brand.Website__c
		//brand.Wire__c
		//brand.WireDetails_Type2__c
		insert brand;
		Contact instantCont = new Contact(LastName='testUser');
		instantCont.OwnerId=u2.id;
		instantCont.AccountId=instantAccount.id;
		instantContact.Email='karthikneo37@gmail.com';//'karthik147@hotmail.com';
		insert instantCont;
		
		Contact dupContact = [Select Id, Name from Contact where LastModifiedDate >= :accountDays limit 1];
		 List<Opportunity> opptyln = new List<Opportunity>();
		Opportunity opp =new Opportunity(); 
		opp.Name='sample';
		
      	opp.AccountId=instantAccount.id;
      	opp.Lead_Source__c='Approved Index';
      	opp.Primary_Service_Name__c='Technology List';
      	opp.Brand_Name__c='B2B Data Partners';
      	opp.Division__c='Winners';
      	//opp.Check_payment__c=true;
      	//opp.Wire_Payment__c=true;
      	opp.StageName='Warm';
      	opp.Sample_To_Deal__c='other';
      	opp.Uploaded_By__c='test';
      	opp.Check_payment__c=true;
      	opp.Wire_Payment__c=true;
      	opp.ForecastCategoryName='pipeline';
      	opp.Amount=5000;
      	opp.OwnerId=u2.id;
      	opp.CloseDate=date.parse('12/13/2013');
      //	opp.Team_Uploaded_By__c='Winners'; 
      	insert opp;
      	System.debug('OPP INSERTED : '+opp);
        opptyln.add(opp);
        Opportunity opp1 =new Opportunity(); 
		opp1.Name='sample';
      	opp1.AccountId=instantAccount.id;
      	opp1.Lead_Source__c='Approved Index';
      	opp1.Primary_Service_Name__c='Technology List';
      	opp1.Brand_Name__c='B2B Data Partners';
      	opp1.Division__c='Winners';
      	//opp.Check_payment__c=true;
      	//opp.Wire_Payment__c=true;
      	opp1.StageName='Warm';
      	opp1.Sample_To_Deal__c='other';
      	opp1.Uploaded_By__c='test';
      	opp1.Check_payment__c=true;
      	opp1.Wire_Payment__c=true;
      	opp1.ForecastCategoryName='pipeline';
      	opp1.Amount=5000;
      	opp1.CloseDate=date.parse('12/13/2013');
      //	opp.Team_Uploaded_By__c='Winners'; 
      	insert opp1;
      	System.debug('OPP INSERTED : '+opp1); 
        opptyln.add(opp1);
        
         Document	document = new Document();
		document.Body = Blob.valueOf('Some Text');
		document.ContentType = 'application/pdf';
		document.DeveloperName = 'my_document';
		document.IsPublic = true;
		document.Name = 'My Document';
		document.FolderId = [select id from folder where name = 'Shared Documents'].id;
		insert document;
		
		Attachment attach=new Attachment();   	
    	attach.Name='Unit Test Attachment';
    	Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
    	attach.body=bodyBlob;
        attach.parentId=opp1.id;
        insert attach;
		
		Folder fd =[Select f.Type, f.Name, f.Id, f.DeveloperName, f.CreatedDate, f.CreatedById, f.AccessType From Folder f where name='CMS'];
		string fd_id= fd.id;
        //EmailTemplate e = new EmailTemplate ();
        //e.developerName = 'test';
        //e.FolderId = fd_id;
        //e.TemplateType= 'Text';
        //e.Name = 'test'; // plus any other fields that you want to set
		//insert e;
        
        ApexPages.currentPage().getParameters().put('id',opp.id);
        ApexPages.StandardSetController sc = new ApexPages.StandardSetController(opptyln);
        OpportunityEmailerController oec = new OpportunityEmailerController(sc);
        ApexPages.currentPage().getParameters().put('id',opp1.id);
        OpportunityEmailerController oec1 = new OpportunityEmailerController();
        oec1.email = 'karthik@neo.com';
        oec1.emailCc = 'karthik147@badshaw.com';
        oec1.emailBcc ='karthikneo37@dot.com';
        oec1.Subject = 'opportunity closed';
        oec1.emailBody ='This is to inform you that the opportuntiy is closed won';
        oec1.fromEmail = 'sendermail.com';
        oec1.fromName = 'SenderName';
        oec1.documentId = attach.id;
        //oec1.templateId = e.id;
        oec1.cancel();         
        oec1.result = true;
        oec1.sendDoc();       
        oec1.Subject = '';
        oec1.fromName = '';
        oec1.sendDoc();
        oec1.email = '';       
        oec1.fromName = 'SenderName';
        oec1.sendDoc();
        oec1.email = 'karthik@neo.com';
        oec1.fromEmail = '';
        oec1.sendDoc();
        oec1.fromEmail = 'sendermail.com';
        oec1.emailBody = '';
        oec1.sendDoc();
        oec1.backToTemplateViewer();
        
        // Test Coverage For SyncOrderEmailService
        
        SyncOrderEmailService soes = new SyncOrderEmailService();
        SyncOrderEmailService.SendMailToCustomerResponse_element smcr = new SyncOrderEmailService.SendMailToCustomerResponse_element();   
        
        // Test Coverage For OpportunityUtility      
        //u2.Account_Manager__c = u3.id;
		//update u2;
        OpportunityUtility ou = new OpportunityUtility();
        OpportunityUtility.assignAccountToAM(opp.id);	      
    }
}