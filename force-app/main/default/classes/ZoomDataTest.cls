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
private class ZoomDataTest {

    static testMethod void myUnitTest() {
        // TO DO: implement unit test
        		LeadFormUsers__c lef = new LeadFormUsers__c();			
		lef.UserName__c = 'demo@scs.com';
		lef.Name = 'demo';
		lef.Division__c = 'Rainmakers';
		lef.EMail_ID__c = 'demo@scs.com';
		insert lef;
			system.debug('_______________'+lef.id);
		
		LeadFormUsers__c lef1 = new LeadFormUsers__c();			
		lef1.UserName__c = 'demo1@scs.com';
		lef1.Name = 'demo';
		lef1.Division__c = 'Winners';
		lef1.EMail_ID__c = 'demo1@scs.com';
		insert lef1;	
		
		Session__c ss1=new Session__c();
        ss1.Session_For_LeadFormUsers__c=lef1.id;
        ss1.SessionId__c='38856717452365';   
        insert ss1;

		Session__c ss=new Session__c();
        ss.Session_For_LeadFormUsers__c=lef.id;
        ss.SessionId__c='38856717452355';   
        insert ss;  
   		
   		ApexPages.currentPage().getParameters().Put('Id',lef.id);
	    ApexPages.currentPage().getParameters().Put('sessionId',ss.SessionId__c);
	    ApexPages.currentPage().getParameters().put('UName','Jayabalan');
		ApexPages.currentPage().getParameters().put('Emailid','demo1@scs.com');
		ZoomDataController ZD = new ZoomDataController();
	    ZD.LeadformUserID=lef.Id;
	    ZD.SessionID=ss.SessionId__c;
	   
    }
}