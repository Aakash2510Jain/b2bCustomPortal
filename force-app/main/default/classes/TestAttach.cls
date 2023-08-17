@isTest
private class TestAttach {
   static testmethod void mytest(){
    	lead newlea=new lead();
        newlea.Email='kevi.maxim@istrategicloud.com';
        newlea.Division_Name__c='Winners';
        newlea.LeadSource='Approved Index';
        newlea.Status='Followup';
        newlea.Company = 'SOS12';
        newlea.FirstName='TestK';
        newlea.LastName='TestSunny';
        newlea.Primary_Service_Name__c='CRM';
        newlea.LinkedIn_URL__c='karthik34/Linkedin.com';
        newlea.Lead_AssignedTo__c='Steve Sujith (Winners)';
        newlea.User_Name__c='Demo test';
        newlea.Team_Identification__c='Manager Steve Sujith';
        insert newlea;
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Account Managers']; 
		User u = new User(Alias = 'standt', Email='ankur.g@istrategicloud.com', 
				EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
				IsActive=true,Division='Rainmakers',Is_Account_Manager__c=true,
				LocaleSidKey='en_US', ProfileId = p.Id,Rating__c='A+',Mapped_UserID_Name__c='Test User (Rainmakers)', 
				TimeZoneSidKey='America/Los_Angeles', UserName='standardtestuser@testorg.com');
		insert u;
      Account acc=new Account();
      acc.Name='SOS12';
      acc.OwnerId=u.id;
      acc.Email__c='sample@in.com';
      acc.Phone='(954) 344-9254';
      acc.Type='Customer';
      insert acc;
      system.debug('*acc*****************'+acc.id);
    
	  Opportunity opp=new Opportunity();
      opp.Name='sample';
      opp.AccountId=acc.id;
      opp.Lead_Source__c='Approved Index';
      opp.Primary_Service_Name__c='Technology List';
      opp.Division__c='Gladiators';
      opp.StageName='Deal';
      opp.Sample_To_Deal__c='other';
      opp.Uploaded_By__c='test';
      opp.ForecastCategoryName='pipeline';
      opp.Amount=5000;
      opp.CloseDate=date.parse('5/13/2013');
      opp.Team_Uploaded_By__c='Winners'; 
      insert opp;
      system.debug('opp******************'+opp);
	    Attachment attach1 = new Attachment();
	     system.debug('*opp*****************'+opp.id);
	    attach1.Body = Blob.valueOf('Some Text');
    	attach1.ParentId=opp.id;
    	attach1.IsPrivate=false;
    	attach1.Name='Workorder.pdf';
    	insert attach1;
	    system.debug('*opp*****************'+attach1);	   
    ApexPages.StandardController ctd = new ApexPages.StandardController(opp);
    AttachmentController attach = new AttachmentController(ctd);
    Apexpages.currentPage().getParameters().put('opportunityId',opp.id);
    attach.opportunityId= Apexpages.currentPage().getParameters().put('opportunityId',opp.id);
       attach.Attach();
       attach.Attachment1();
       attach.Attachment2();
       attach.pdfAttachment(); 
  }
   
}