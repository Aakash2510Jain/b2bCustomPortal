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
@isTest (seealldata=true)
public class OpportunityPriceListTestClass {

    public static TestMethod void OpportunityPriceListTestCase(){
    	
    	Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
	 	/*User u2 = [select Id,Mapped_UserID_Name__c,LastLoginDate,Division,Email from User 
					where  Division='Rainmakers' and LastLoginDate != null 
					and isActive=true and Is_Account_Manager__c=false 
					order by LastLoginDate desc limit 1];*/
		User u2 = new User(Alias = 'standt', Email='sossfdc@cirrologix.com', 
				EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
				IsActive=true,Division='Rainmakers',Is_Account_Manager__c=true,
				LocaleSidKey='en_US', ProfileId = p.Id,Rating__c='A+',Mapped_UserID_Name__c='Test User (Rainmakers)', 
				TimeZoneSidKey='America/Los_Angeles', UserName='sossfdcs@cirrologix.com');
		insert u2;			
		
		System.debug('USER 2:'+u2);
					
		Account instantAccount= new Account(Name='TestCase');
		instantAccount.OwnerId=u2.id;
		instantAccount.Division__c = 'Winners';
		insert instantAccount;
		instantAccount.Name='TestLEADIN';
		update instantAccount;  
		
		Date accountDays = System.today() - 10;
		Account dupAccount = [Select Id, Name from Account where LastModifiedDate >= :accountDays limit 1];
		
		Contact instantContact = new Contact(LastName='testUser');
		instantContact.OwnerId=u2.id;
		instantContact.AccountId=instantAccount.id;
		//instantContact.Country__c='India';
		instantContact.Email='praveen.r@istrategicloud.com';//'karthik147@hotmail.com';
		insert instantContact;
		
		
		Contact instantCont = new Contact(LastName='testUser');
		instantCont.OwnerId=u2.id;
		instantCont.AccountId=instantAccount.id;
		//instantCont.Country__c='India';
		instantContact.Email='karthikneo37@gmail.com';//'karthik147@hotmail.com';
		insert instantCont;
		
		Contact dupContact = [Select Id, Name from Contact where LastModifiedDate >= :accountDays limit 1];
		 
		Opportunity opp =new Opportunity(); 
		opp.Name='sample';
      	opp.AccountId= instantAccount.id;
      	opp.Lead_Source__c='Approved Index';
      	opp.Primary_Service_Name__c='Technology List';
      	opp.Brand_Name__c='B2B Data Partners';
      	opp.Division__c='Winners';
      	opp.StageName='Warm';
      	opp.Sample_To_Deal__c='other';
      	opp.Uploaded_By__c='test';
      	opp.ForecastCategoryName='pipeline';
      	opp.Amount=5000;
      	opp.CloseDate=date.today();
      //	opp.Team_Uploaded_By__c='Winners'; 
      	insert opp;
      	System.debug('OPP INSERTED : '+opp);
     	
     	List<PriceBookEntry> priceBookEntryRec = [select id, unitprice,product2.Name,Product2.Description,Product2.Legal_Name__c,Product2.Parent_Product__c,
     						Product2.isParent__c,Product2.Min_req_Units__c,product2.Agency_Cost__c,product2.Family from PricebookEntry where product2.IsActive = true limit 2];		
        Product2 pro = new Product2(Name = 'iPhone X', Family = 'Mobile',isParent__c = true,IsActive = true);
        Insert pro;
        
        Pricebook2 standardPricebook = new Pricebook2(
            Id = Test.getStandardPricebookId(),
            IsActive = true
        );
        
        
        Update standardPricebook;
        
        standardPricebook = [SELECT Id, IsStandard FROM Pricebook2 WHERE Id = :standardPricebook.Id];
        
        PricebookEntry pbe = new PricebookEntry(
            Pricebook2Id = standardPricebook.Id,
            Product2Id = pro.Id,
            UnitPrice = 1020,
            IsActive = true
        );
        Insert pbe;
        /*for(PricebookEntry entryRec : priceBookEntryRec){
     		OpportunityLineitem itemRec = new OpportunityLineItem();
     		itemRec.Quantity = 1000;
     		itemRec.Description = entryRec.Product2.Description;
     		itemRec.pricebookEntryId = entryRec.Id;
     		itemRec.UnitPrice = entryRec.UnitPrice;
     		itemRec.OpportunityId = opp.Id;
     		insert itemRec;
     	}*/
     	ApexPages.StandardController sc = new ApexPages.StandardController(opp);
     	ApexPages.currentPage().getParameters().put('id',opp.id);
	 	OpportunityPriceList listObject = new OpportunityPriceList(sc);
        listObject.selected = true;
        listObject.targetFieldCon = 'lastname';
        OpportunityPriceList opList = new OpportunityPriceList();
	 	OpportunityPriceList.OpportunityLineItemsWrapper oppWrapper = new  OpportunityPriceList.OpportunityLineItemsWrapper(pbe,opp.id);
	 	oppWrapper.generateLineItem(pbe);
	 	OpportunityPriceList.listwrapper oppListWrapper = new OpportunityPriceList.listwrapper();
	 	listObject.getParentName(opp.id);
	 	listObject.getpr();
	 	listObject.getLable1();
	 	listObject.SaveRecord();
	 	listObject.getFamily();
	 	listObject.getfamilyParentProducts();
	 	listObject.getLable1();
	 	listObject.getSelected();
	 } 

   
}