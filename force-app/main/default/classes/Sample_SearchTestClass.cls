@IsTest(SeeAllData=true)
private class Sample_SearchTestClass {
	static testMethod void myUnitTest_SampleSearchController(){
		Config__c cf=new Config__c();
	        cf.NumberOfDays__c=5;
	        cf.NoLeadActivity__c=3;
	        cf.Division__c='Alex; Blake Cooper; Campaign; Content; Jeff Anderson; LeadGen; Manager_Robin Smith';
	        cf.BrandWise__c='B2B Contacts; B2B Data Partners In';
	        cf.Value__c='dell.com,span.com';
	        cf.Key__c='sample';
        insert cf;
         
         Profile p = [SELECT Id FROM Profile WHERE Name='Account Managers']; 
		 User u = new User(Alias = 'standt', Email='ankur.g@istrategicloud.com', 
				EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
				IsActive=true,Division='winners',Is_Account_Manager__c=true,
				LocaleSidKey='en_US', ProfileId = p.Id,Rating__c='A+',Mapped_UserID_Name__c='Test User (Rainmakers)', 
				TimeZoneSidKey='America/Los_Angeles', UserName='standardtestuser@testorg.com');
		 insert u;
		 
		 lead l2=new lead();
	         l2.LastName='name';
	         l2.Email='sample@sample.com';
	         l2.Company='SOS'; 
	         l2.Division_Name__c='Titans';
	         l2.Primary_Service_Name__c='Email Appending';
	         l2.LeadSource='Customer Service';
	         l2.Status='Yet to Initiate';    
	         l2.Lead_AssignedTo__c ='Chad Hall (Titans)';
        insert l2;
        Sample_Request__c rec3 = new Sample_Request__c();
	        rec3.Lead__c=l2.id;
	        rec3.Name='YYYYYYYY';
	        rec3.Sample_Type__c='SEO';
	        rec3.Status__c='New';
	        rec3.Sample_Type_Description__c='';
        insert rec3; 	
        
        ApexPages.StandardController sc3 = new ApexPages.standardController(rec3);
        Samples_SearchController controller4 = new Samples_SearchController(sc3);
        controller4.searchDateFormat='THIS_YEAR';
        controller4.user_Ip= 'X-Salesforce-SIP';              
        controller4.sampleKeyword='XXXXXXX';        
        controller4.dateCaption='THIS_YEAR';       
        controller4.errMsg='this is error message';      
        controller4.sortDir='desc';
        controller4.soqlSearch='Select Sample_Type_Description__c,Name,Id,Sample_Type__c ,CreatedDate From Sample_Request__c where CreatedDate = ToDay  order by CreatedDate desc Limit 50';
        controller4.sampleType='Custom Business List Sample';
        controller4.getSampleRecord();
        controller4.getSearchResults();
        controller4.getDateC();
        controller4.geterrMsg();
        controller4.DoSearch();
       
         lead le=new lead();
	         le.LastName='name';
	         le.Email='sample@sos.com';
	         le.Company='SOS'; 
	         le.Division_Name__c='Spartans';
	         le.Primary_Service_Name__c='Email Appending';
	         le.LeadSource='Customer Service';
	         le.Status='Yet to Initiate';    
	         le.Lead_AssignedTo__c ='Adam Joseph (Spartans)';
	     insert le;
         
        
		
		Sample_Request__c rec11 = new Sample_Request__c();
	        rec11.Lead__c=le.id;
	        rec11.Name='Test sample';
	        rec11.Sample_Type__c='SEO';
	        rec11.Status__c='New';
	        rec11.Sample_Type_Description__c='Test sample';
        insert rec11;
        Attachment attach1 = new Attachment();	    
		    attach1.Body = Blob.valueOf('Some Text');
	    	attach1.ParentId=rec11.id;
	    	attach1.IsPrivate=false;
	    	attach1.Name='Workorder.pdf';
    	insert attach1;   
    	
    	Id [] fixedSearchResults= new Id[1];
        fixedSearchResults[0] = rec11.id;
        Test.setFixedSearchResults(fixedSearchResults);	
                    
        
        ApexPages.StandardController sc = new ApexPages.standardController(rec11);        
        Samples_SearchController controller = new Samples_SearchController(sc);        
        controller.fromDate='2013-02-01';//(System.today()-20).toString();
        controller.toDate='2013-02-13';
        controller.searchDateFormat=null;
        controller.sampleKeyword='Test sample';
        controller.sampleType='SEO';
        controller.dateCaption='THIS_YEAR';
        controller.flag=true;
        controller.errMsg='this is error message';       
        controller.showResults=true;
        controller.searchRecordForm=rec11;
        controller.sortDir='desc';
        controller.soqlSearch='Select Sample_Type_Description__c,Name,Id,Sample_Type__c ,CreatedDate From Sample_Request__c where CreatedDate = ToDay  order by CreatedDate desc Limit 50';
        controller.DoSearch();
        controller.getSampleRecord();
        controller.getSearchResults();
        controller.getDateC();
        controller.geterrMsg();
        controller.requestIds=''; 
        controller.flag=false;
        controller.showResults=false;
        controller.DoSearch();
        controller.toDate='3000-02-13';        
        controller.DoSearch();
        controller.fromDate = '3000-02-01';
        controller.DoSearch();
        
        
        
        lead l=new lead();
	         l.LastName='name';
	         l.Email='sample2@sample.com';
	         l.Company='SOS'; 
	         l.Division_Name__c='Titans';
	         l.Primary_Service_Name__c='Email Appending';
	         l.LeadSource='Customer Service';
	         l.Status='Yet to Initiate';    
	         l.Lead_AssignedTo__c ='Chad Hall (Titans)';
        insert l;
        Sample_Request__c rec2 = new Sample_Request__c();
	        rec2.Lead__c=l.id;
	        rec2.Name='Test sample';
	        rec2.Sample_Type__c='SEO';
	        rec2.Status__c='New';
	        rec2.Sample_Type_Description__c='';
        insert rec2; 
           
           
        ApexPages.StandardController sc2 = new ApexPages.standardController(rec2);
        Samples_SearchController controller3 = new Samples_SearchController(sc2);
        controller3.searchDateFormat='THIS_YEAR';
        controller3.user_Ip= 'X-Salesforce-SIP';              
        controller3.sampleKeyword='Test sample';        
        controller3.dateCaption='THIS_YEAR';       
        controller3.errMsg='this is error message';      
        controller3.sortDir='desc';
        controller3.soqlSearch='Select Sample_Type_Description__c,Name,Id,Sample_Type__c ,CreatedDate From Sample_Request__c where CreatedDate = ToDay  order by CreatedDate desc Limit 50';
        controller3.sampleType='Custom Business List Sample';
        controller3.getSampleRecord();
        controller3.getSearchResults();
        controller3.getDateC();
        controller3.geterrMsg();
        controller3.DoSearch();
        
        
        
	
	}
}