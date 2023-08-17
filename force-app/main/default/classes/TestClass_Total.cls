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
private class TestClass_Total {
    
    static testMethod void myUnitTest_Opty(){
        User u1= [select id from User where alias='steam' limit 1];
        try{
            u1.Open_Opportunities_Allowed__c=0;
            u1.Rollup_should_hapen__c=true;
            update u1;
            Opportunity opty1= new Opportunity ();
            opty1.StageName = 'Proposal/Price Quote';
            opty1.CloseDate=System.today();
            opty1.Ownerid=u1.id;
            opty1.name='optytest';
            opty1.Opplead_id__c='testid';
            insert opty1;
        }catch(Exception e){
            u1.Open_Opportunities_Allowed__c=15;
            u1.Rollup_should_hapen__c=true;
            update u1;
        }
        /*Opportunity opty2= new Opportunity ();
opty2.StageName = 'Proposal/Price Quote';
opty2.CloseDate=System.today();
opty2.Ownerid=u1.id;
opty2.name='optytest';
opty2.Opplead_id__c='testid';
insert opty2;

opty2.StageName = 'Closed Won';
update opty2;
delete opty2;
undelete opty2;
opty2.StageName = 'Proposal/Price Quote';
update opty2;
*/
    }
    
}