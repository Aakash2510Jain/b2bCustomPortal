@isTest (seealldata=true)
public  class GenerateOrdersTestClass {
	
	 public static TestMethod void GenerateOrdersController(){
	 	
	   /*
	   	Profile p = [SELECT Id FROM Profile WHERE Name='Account Managers']; 
		User u = new User(Alias = 'standt', Email='ankur.g@istrategicloud.com', 
				EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
				IsActive=true,Division='Rainmakers',Is_Account_Manager__c=true,
				LocaleSidKey='en_US', ProfileId = p.Id,Rating__c='A+',Mapped_UserID_Name__c='Test User (Rainmakers)', 
				TimeZoneSidKey='America/Los_Angeles', UserName='standardtestuser@testorg.com');
		insert u;
		
		User userInstant = new User(Alias = 'standt', Email='srivarsha.b@istrategicloud.com', 
				EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
				IsActive=true,Division='Rainmakers',
				LocaleSidKey='en_US', ProfileId = p.Id,Mapped_UserID_Name__c='Test User (Rainmakers)', 
				TimeZoneSidKey='America/Los_Angeles', UserName='standardVarsha@testorg.com');
		insert userInstant;
		
		User u2 = [select Id,Mapped_UserID_Name__c,LastLoginDate,Division,Email from User 
					where  Division='Winners' and LastLoginDate != null 
					and isActive=true and Is_Account_Manager__c=false 
					order by LastLoginDate desc limit 1];
					
		
		System.debug('USER 2:'+u2);*/
         Profile p = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];

    User u2 = new User(
      Alias = 'testu', Email = 'tesst@unitingambition.com', EmailEncodingKey = 'UTF-8',  LastName = 'Test', LanguageLocaleKey = 'en_US',
      LocaleSidKey = 'en_US', TimeZoneSidKey='America/Los_Angeles', ProfileId = p.Id, UserName='teest@unitingambition.com',
      Division='Winners',Is_Account_Manager__c=false 
    );

    INSERT u2;
  
					
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
      	opp.CloseDate=date.parse('12/13/2013');
      //	opp.Team_Uploaded_By__c='Winners'; 
      	insert opp;
      	System.debug('OPP INSERTED : '+opp);
     	
     	List<PriceBookEntry> priceBookEntryRec = [select id, unitprice,product2.Name,Product2.Description,Product2.Legal_Name__c,
     						product2.Agency_Cost__c,product2.Family from PricebookEntry where product2.IsActive = true limit 2];		
     	for(PricebookEntry entryRec : priceBookEntryRec){
     		OpportunityLineitem itemRec = new OpportunityLineItem();
     		itemRec.Quantity = 1000;
     		itemRec.Description = entryRec.Product2.Description;
     		itemRec.pricebookEntryId = entryRec.Id;
     		itemRec.UnitPrice = entryRec.UnitPrice;
     		itemRec.OpportunityId = opp.Id;
     		insert itemRec;
     	}
		
	   ApexPages.currentPage().getParameters().put('id',opp.id);
       ApexPages.StandardController sc = new ApexPages.StandardController(opp);
       GenerateOrdersController gstance = new GenerateOrdersController(sc);
       
       gstance.opportunityId=opp.id;    
       gstance.selectedTemplateType='Invoice';
       gstance.selectedTemplateName='B2B Data Partners3';
       gstance.sTemplateURL='apex/pioneerMarketersInvoice';
       gstance.pdfAttachment();
       gstance.previousPage();
      // gstance.saveAttach();	
		
		
      ApexPages.currentPage().getParameters().put('id',opp.id);
    // ApexPages.StandardSetController sc = new ApexPages.StandardSetController(opp);
       GenerateOrdersController gInstance = new GenerateOrdersController();
       
       gInstance.opportunityId=opp.id;    
       gInstance.selectedTemplateType='Invoice';
       gInstance.selectedTemplateName='B2B Data Partners3';
      // gInstance.sTemplateURL='apex/pioneerMarketersInvoice';
       gInstance.pdfAttachment();
       gInstance.previousPage();
       gInstance.getValueToSet();
//       gInstance.saveAttach();
	 	
	 	
	 }
	 

}