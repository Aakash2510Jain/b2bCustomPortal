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
private class Test_Validate_email {

    
       static testMethod void myUnitTest_ValidateEmail(){
	
			Config__c con=new Config__c();
			con.NumberOfDays__c=5;
            con.NoLeadActivity__c=3;
            con.Division__c='Alex; Blake Cooper; Campaign; Content; Jeff Anderson; LeadGen; Manager_Robin Smith';
            con.BrandWise__c='B2B Contacts; B2B Data Partners In';
            con.Value__c='dell.com,span.com';
            insert con;
            
	
	Lead l2= new Lead();
	l2.Company='sorceone';
	//l1.Ownerid=u1.id;
	l2.lastname='testclass';
	l2.Status='Yet to Initiate';
	l2.User_Name_LeadGen__c='Deepak';  
	l2.Division_Name__c='Spartans';
	l2.Email='sample@sample.com';
	l2.Lead_AssignedTo__c ='Adam Joseph (Spartans)';
	l2.Primary_Service_Name__c='Data Management & List Updates';
	l2.LeadSource='Customer Service';
	insert l2;

    SOS__c sosSettings = new SOS__c();
    sosSettings.Run_Crediefeye_Trigger__c=true;
	insert sosSettings;    

	CredifeyeDuplication cd=new CredifeyeDuplication();
            boolean fla=cd.getmaildomain(l2.Email);


       
    }
}