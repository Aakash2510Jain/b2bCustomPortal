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
@istest (seealldata=true)
public with sharing class Lead_Test {

/*static testMethod void Validate_Email_Test() {
   
        
                 lead le=new lead();
                 le.Firstname='first';
                 le.LastName='name';
                 le.Email='sample@sos.com';
                 le.Company='SOS'; 
                 le.Division_Name__c='Spartans';
                 le.Primary_Service_Name__c='Email Appending';
                 le.LeadSource='Customer Service';
                 le.Status='Yet to Initiate';    
                 le.Lead_AssignedTo__c ='Adam Joseph (Spartans)';
                 insert le;  
                 system.debug('^^^^leadId^^^^'+le.id);
                 
                 list<account> aclist=new list<account>();
                 Account ac=new Account();
                  ac.Name='SOS';
                  ac.Email__c='sample@gmail.com';
                  ac.Phone='(954) 344-9274';
                  ac.Type='Customer';
                  ac.Is_Account_Blacklisted__c=true;
                  insert ac;
                  aclist.add(ac);
                  system.debug('#####Accountid#####'+ac.id);
                 
    }*/
    public static testmethod void testCredifeyeDuplication(){
            CredifeyeDuplication cd=new CredifeyeDuplication();
            Config__c cf=new Config__c();
            cf.NumberOfDays__c=5;
            cf.NoLeadActivity__c=3;
            cf.Division__c='Alex; Blake Cooper; Campaign; Content; Jeff Anderson; LeadGen; Manager_Robin Smith';
            cf.BrandWise__c='B2B Contacts; B2B Data Partners In';
            cf.Value__c='dell.com,span.com';
            //cf.Key__c='sample';
            insert cf;
            
            list<string> mailDomain=new list<string>(); 
            List<String> parts= new List<String>();
            List<String> st= new List<String>();
            cd.getmaildomain('karthik@in.com');
            
         }  
}