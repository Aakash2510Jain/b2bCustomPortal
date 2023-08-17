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
private class TestSampleSearchCount {

    static testMethod void myUnitTest() {
        // TO DO: implement unit test
        Sample_Download_Logs__c sdl= new Sample_Download_Logs__c();
        sdl.DocumentName__c='sample.doc';
        sdl.Email__c='karthik@cirrologix.com';
        sdl.Keyword__c='test';
        sdl.Sample_Type__c='Blogs';
        sdl.User_Ip__c='58.68.52.50';
        insert sdl;
        
        WorkOrder_Download_Log__c wdl= new WorkOrder_Download_Log__c();
        wdl.Brand_Name__c='Procure Data Inc';
        wdl.DocumentName__c='sampledoc.doc';
        wdl.Email__c='samplework@download.com';
        wdl.User_Ip__c='58.68.52.50';
        insert wdl;
    }
}