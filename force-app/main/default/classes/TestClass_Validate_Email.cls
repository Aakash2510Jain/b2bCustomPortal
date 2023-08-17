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
public class TestClass_Validate_Email {

    static testMethod void testUserOpptyCountBulkTrigger() {
        // TO DO: implement unit test
        Account accRec = new Account();
        accRec.Name ='Test Account';
        insert accRec;
        Opportunity oppRec = new Opportunity();
        oppRec.Name='Test Opportunity';
        oppRec.AccountId=accRec.Id;
        oppRec.Account_Id__c=accRec.Id;
        oppRec.LeadSource='Prospecting Website';
        oppRec.Primary_Service_Name__c='CRM';
        oppRec.Division__c='Gladiators';
        oppRec.Brand_Name__c='B2B List';
        oppRec.StageName='Prospecting';
        oppRec.ForecastCategoryName='Closed';
        oppRec.Sample_To_Deal__c='OTHER';
        oppRec.Amount=100.00;
        oppRec.CloseDate=System.today();
        insert oppRec;
        
        Sample_Request__c sampleReqRec = new Sample_Request__c();
        sampleReqRec.Name='Test Sample';
        sampleReqRec.Sample_Type__c='Website';
        sampleReqRec.Status__c='New';
        sampleReqRec.Sample_Type_Description__c='Test the Website Data';
        sampleReqRec.Opportunity__c = oppRec.Id;
        insert sampleReqRec;
        
         System.debug('---------------------------1');
        try{ 
        oppRec.StageName='Deal';
        oppRec.Sample_To_Deal__c='OTHER;HELPDESK COUNTS ONLY;ADAMS';
        update oppRec;
        }catch(Exception e){}
        System.debug('---------------------------2');
        try{
        oppRec.Sample_To_Deal__c='HELP DESK SAMPLES';
        update oppRec;
        }catch(Exception e){}
        System.debug('---------------------------3');
        try{
        	oppRec.Sample_Request__c=sampleReqRec.Id;
        	oppRec.ADAMS_Reference_Key__c='asdasd';
        	update oppRec;
        }catch(Exception e){}
        
		try{
		oppRec.Sample_To_Deal__c='ADAMS';
		oppRec.ADAMS_Reference_Key__c=null;
		update oppRec;
		}catch(Exception e){}
		
		try{		
		oppRec.ADAMS_Reference_Key__c='asdasd';
		update oppRec;
		}catch(Exception e){}
		try{
		oppRec.Sample_To_Deal__c='OTHER';
		update oppRec;
		}catch(Exception e){}
		try{
		oppRec.Sample_To_Deal__c='OTHER;HELPDESK COUNTS ONLY';
		update oppRec;
		}catch(Exception e){}
		try{
		oppRec.Sample_To_Deal__c='HELPDESK COUNTS ONLY';
		update oppRec;
		}catch(Exception e){}
		try{
		oppRec.Sample_To_Deal__c='ADAMS;HELP DESK SAMPLES';
		oppRec.Sample_Request__c=null;
		oppRec.ADAMS_Reference_Key__c =null;
		update oppRec;
		}catch(Exception e){}
		try{
		oppRec.ADAMS_Reference_Key__c='asdasd';
		update oppRec;
		}catch(Exception e){}
		try{
		oppRec.Sample_Request__c=sampleReqRec.Id;
		oppRec.ADAMS_Reference_Key__c=null;
		update oppRec;
		}catch(Exception e){}
		try{
		oppRec.Sample_To_Deal__c='HELP DESK SAMPLES;OTHER';
		oppRec.Sample_Request__c=null;
		oppRec.ADAMS_Reference_Key__c='asdasd';
		update oppRec;
		}catch(Exception e){}
		try{
		oppRec.Sample_To_Deal__c='OTHER;ADAMS';
		oppRec.ADAMS_Reference_Key__c=null;
		update oppRec;
		}catch(Exception e){}
		try{
		oppRec.Sample_To_Deal__c='HELPDESK COUNTS ONLY;HELP DESK SAMPLES';
		oppRec.Sample_Request__c=null;
		update oppRec;
		}catch(Exception e){}
		try{
		oppRec.Sample_To_Deal__c='HELPDESK COUNTS ONLY;ADAMS';
		oppRec.ADAMS_Reference_Key__c=null;
		update oppRec;
		}catch(Exception e){}
		try{
		oppRec.Sample_To_Deal__c='ADAMS;HELPDESK COUNTS ONLY;HELP DESK SAMPLES';
		oppRec.ADAMS_Reference_Key__c=null;
		oppRec.Sample_Request__c=null;
		update oppRec;
		}catch(Exception e){}
		try{
		oppRec.Sample_To_Deal__c=null;
		update oppRec;
		}catch(Exception e){}
		try{
		oppRec.Sample_To_Deal__c='ADAMS';
		oppRec.ADAMS_Reference_Key__c=null;
		oppRec.Sample_Request__c=null;
		update oppRec;
		}catch(Exception e){}
		try{
		oppRec.Sample_To_Deal__c='OTHER;TECHNOLOGY COUNTS ONLY';
		oppRec.ADAMS_Reference_Key__c='asdasd';
		oppRec.Sample_Request__c=sampleReqRec.Id;
		update oppRec;
		}catch(Exception e){}
		try{
		oppRec.Sample_To_Deal__c='ADAMS;TECHNOLOGY COUNTS ONLY';
		oppRec.ADAMS_Reference_Key__c=null;
		update oppRec;
		}catch(Exception e){}
		try{
		oppRec.Sample_To_Deal__c='TECHNOLOGY COUNTS ONLY;HELP DESK SAMPLES';
		oppRec.Sample_Request__c=null;
		oppRec.ADAMS_Reference_Key__c='asdasd';
		update oppRec;
		}catch(Exception e){}
		try{
		oppRec.Sample_To_Deal__c='TECHNOLOGY COUNTS ONLY';
		oppRec.Sample_Request__c=sampleReqRec.Id;
		update oppRec;
		}catch(Exception e){}
		
    }
  /* static testMethod void testAssign_User_To_LeadupLoadedBy(){
    	lead le=new lead();
    	le.Email='kavin.m@istrategicloud.com';
    	le.Division_Name__c='Rainmakers';
    	le.LeadSource='Approved Index';
    	le.Status='Followup';
    	le.Company = 'SOS';
    	le.FirstName='TesM';
    	le.LastName='TestJohn';
    	le.Primary_Service_Name__c='CRM';
    	le.LinkedIn_URL__c='karthik37/Linkedin.com';
    	le.Lead_AssignedTo__c='William Perry (Rainmakers)';
    	le.User_Name_Manager_Robin_Smith__c='nickw';
    //	le.User_Name_Campaign__c='Aravindan';
    //	le.User_Name_LeadGen__c='Deepak';
    	le.Team_Identification__c='Raymond Phillips';
    	insert le;
    	lead led=new lead();
    	led.Email='kavinmax.m@istrategicloud.com';
    	led.Division_Name__c='Rainmakers';
    	led.LeadSource='Approved Index';
    	led.Status='Followup';
    	led.Company = 'SOS1';    	
    	led.LastName='TestJohny';
    	led.Primary_Service_Name__c='CRM';
    	led.LinkedIn_URL__c='karthik37/Linkedin.com';
    	led.Lead_AssignedTo__c='William Perry (Rainmakers)';
    	led.User_Name_Alexc__c='edwinc';
    	led.Team_Identification__c='Raymond Phillips';
    	insert led;
    	lead lea=new lead();
    	lea.Email='kevinsam.m@istrategicloud.com';
    	lea.Division_Name__c='Rainmakers';
    	lea.LeadSource='Approved Index';
    	lea.Status='Followup';
    	lea.Company = 'SCS';
    	lea.LastName='TesJohnny';
    	lea.Primary_Service_Name__c='CRM';
    	lea.LinkedIn_URL__c='karthik37/Linkedin.com';
    	lea.Lead_AssignedTo__c='William Perry (Rainmakers)';
    	lea.User_Name_Marshal__c='russellw';
    	lea.Team_Identification__c='Raymond Phillips';
    	insert lea;
    	lead lea1=new lead();
    	lea1.Email='kelvin.m@istrategicloud.com';
    	lea1.Division_Name__c='Rainmakers';
    	lea1.LeadSource='Approved Index';
    	lea1.Status='Followup';
    	lea1.Company = 'STar';
    	lea1.LastName='Johnnydep';
    	lea1.Primary_Service_Name__c='CRM';
    	lea1.LinkedIn_URL__c='karthik37/Linkedin.com';
    	lea1.Lead_AssignedTo__c='William Perry (Rainmakers)';
    	lea1.User_Name_Manger_Steve_Sujith__c='davidwlg';
    	lea1.Team_Identification__c='Raymond Phillips';
    	insert lea1;
    	lead le1=new lead();
    	le1.Email='kelvinone.m@istrategicloud.com';
    	le1.Division_Name__c='Rainmakers';
    	le1.LeadSource='Approved Index';
    	le1.Status='Followup';
    	le1.Company = 'STarr';
    	le1.LastName='Johnndep';
    	le1.Primary_Service_Name__c='CRM';
    	le1.LinkedIn_URL__c='karthik37/Linkedin.com';
    	le1.Lead_AssignedTo__c='William Perry (Rainmakers)';
    	le1.User_Name_Manager_Roger_Smith__c='Sandram';
    	le1.Team_Identification__c='Raymond Phillips';
    	insert le1;
    	lead le2=new lead();
    	le2.Email='kevinpeterson.m@istrategicloud.com';
    	le2.Division_Name__c='Rainmakers';
    	le2.LeadSource='Approved Index';
    	le2.Status='Followup';
    	le2.Company = 'stark';
    	le2.LastName='Johnson';
    	le2.Primary_Service_Name__c='CRM';
    	le2.LinkedIn_URL__c='karthik37/Linkedin.com';
    	le2.Lead_AssignedTo__c='William Perry (Rainmakers)';
    	le2.User_Name_Maxtyler__c='Richard_w';
    	le2.Team_Identification__c='Raymond Phillips';
    	insert le2;
    	lead le3=new lead();
    	le3.Email='kelvinsamson.m@istrategicloud.com';
    	le3.Division_Name__c='Rainmakers';
    	le3.LeadSource='Approved Index';
    	le3.Status='Followup';
    	le3.Company = 'STarrer';
    	le3.LastName='Johnnwalker';
    	le3.Primary_Service_Name__c='CRM';
    	le3.LinkedIn_URL__c='karthik37/Linkedin.com';
    	le3.Lead_AssignedTo__c='William Perry (Rainmakers)';
    	le3.User_Name_Michelle__c='Edwinc';
    	le3.Team_Identification__c='Raymond Phillips';
    	insert le3;
    	lead le4=new lead();
    	le.Email='praveen.m@istrategicloud.com';
    	le4.Division_Name__c='Rainmakers';
    	le4.LeadSource='Approved Index';
    	le4.Status='Followup';
    	le4.Company = 'gforce';
    	le4.LastName='praveen';
    	le4.Primary_Service_Name__c='CRM';
    	le4.LinkedIn_URL__c='karthik37/Linkedin.com';
    	le4.Lead_AssignedTo__c='William Perry (Rainmakers)';
    	le4.UserName_SamGreen__c='Adrian';
    	le4.Team_Identification__c='Raymond Phillips';
    	insert le4;
    	lead le5=new lead();
    	le5.Email='srikar.m@istrategicloud.com';
    	le5.Division_Name__c='Rainmakers';
    	le5.LeadSource='Approved Index';
    	le5.Status='Followup';
    	le5.Company = 'walmart';
    	le5.LastName='aditya';
    	le5.Primary_Service_Name__c='CRM';
    	le5.LinkedIn_URL__c='karthik37/Linkedin.com';
    	le5.Lead_AssignedTo__c='William Perry (Rainmakers)';
    	le5.User_Name_MPO__c='Aravind.TV';
    	le5.Team_Identification__c='Raymond Phillips';
    	insert le5;
    	lead le6=new lead();
    	le6.Email='aditya.m@istrategicloud.com';
    	le6.Division_Name__c='Rainmakers';
    	le6.LeadSource='Approved Index';
    	le6.Status='Followup';
    	le6.Company = 'followone';
    	le6.LastName='srikar';
    	le6.Primary_Service_Name__c='CRM';
    	le6.LinkedIn_URL__c='karthik37/Linkedin.com';
    	le6.Lead_AssignedTo__c='William Perry (Rainmakers)';
    	le6.User_Name_Sean_Fischer__c='Mark Taylor';
    	le6.Team_Identification__c='Raymond Phillips';
    	insert le6;
    	LeadFormUsers__c LFU=new LeadFormUsers__c();
		LFU.Name='Edwinc';
		LFU.EMail_ID__c='testform@testmail.com';
		insert LFU;
		
		LeadFormUsers__c LFU1=new LeadFormUsers__c();
		LFU1.Name='Rickh';
		LFU1.EMail_ID__c='test1@testmail.com';   
		insert LFU1;
    	
    }
    */
}