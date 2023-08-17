@isTest
private class TestClass_Samples_Restriction {

//Test code for Samples_Restriction Class

static testMethod void myUnitTest_SampleRestriction(){
//User u1= [select id from User where alias='AUser' limit 1];
Profile p = [SELECT Id FROM Profile WHERE Name='Technologylist_Helpdesk']; 
      User u2 = new User(Alias = 'suser', Email='sampleuser@testorg.com', 
         EmailEncodingKey='UTF-8', LastName='sampleuser', LanguageLocaleKey='en_US', 
         LocaleSidKey='en_US', ProfileId = p.Id, 
         TimeZoneSidKey='America/Los_Angeles', UserName='sampleuser@testsample.com');

      System.runAs(u2) {

		Lead l1= new Lead();
		l1.Company='1';
		l1.Ownerid=u2.id;
		l1.lastname='testclass';
		l1.Status='Working';
		//l1.CreatedDate=System.today();
		l1.User_Name__c='frankb';
		l1.Division_Name__c='Gladiators';
		
		insert l1;
		try{
		Sample_Request__c SR= new Sample_Request__c();
		SR.Status__c='New';
		SR.Name='TEST';
		SR.Sample_Type__c='Custom Business List Sample';
		SR.Sample_Type_Description__c='TEST DESCRIPTION';
		SR.Lead__c=l1.Id;
		insert SR;
		}catch(Exception e){}
		Opportunity opty2= new Opportunity ();
		opty2.StageName = 'Warm';
		opty2.CloseDate=System.today();
		opty2.Ownerid=u2.id;
		opty2.name='optytest';
		opty2.Opplead_id__c='testid';
		opty2.Uploaded_By__c='frankb';
		opty2.Division__c='Gladiators';
		insert opty2;
		
		Sample_Request__c SR1= new Sample_Request__c();
		SR1.Name='TEST';
		SR1.Sample_Type__c='Custom Business List Sample';
		SR1.Sample_Type_Description__c='TEST DESCRIPTION';
		SR1.Opportunity__c=opty2.Id;
		insert SR1;
      }
}
}