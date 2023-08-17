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
    private class testcountbulk {
        static testMethod void myUnitTest_UpdateCustomObject(){
            User u1= [select id from User where alias='steam' limit 1];
            Lead l1= new Lead();    
            l1.Company='1';
            l1.Ownerid=u1.id;
            l1.lastname='testclass';
            l1.Status='Working';
            insert l1;
            //l1.IsConverted = true;
            Update l1;
            
            Account acc=new Account();
            acc.Name='1';
            acc.Email__c='sample@in.com';
            acc.Phone='(954) 344-9254';
            acc.Type='Customer';
            insert acc;
            
            Lead l2= new Lead();
            l2.Company='1';
            l2.Ownerid=u1.id;
            l2.lastname='testclass';
            l2.Status='Working';
            l2.Email= 'piyush12345@gmail.com';
            //l1.IsConverted = false;
            insert l2;
            
            Opportunity opty2= new Opportunity ();
            opty2.StageName = 'Warm';
            opty2.CloseDate=System.today();
            opty2.Ownerid=u1.id;
            opty2.name='optytest';
            opty2.Opplead_id__c='testid';
            insert opty2;
            
            Sample_Request__c sam = new Sample_Request__c(); 
            sam.Opportunity__c=opty2.id;
            sam.Lead__c=l1.id;
            sam.Name='samtest';
            sam.Sample_Type__c='Others';
            sam.Status__c='New';
            sam.Sample_Type_Description__c='the sample description';
            insert sam;
        
        /*static testMethod void myUnitTest_Lead() {
            // TO DO: implement unit test
            // trigger 'user_lead_count_bulk'
            User u1= [select id from User where alias='AUser' limit 1];
            try{
            u1.Rollup_should_hapen__c=true;
            u1.Open_Leads_Allowed__c=0;
            update u1;
            Lead l1= new Lead();
            l1.Company='1';
            l1.Ownerid=u1.id;
            l1.lastname='testclass';
            l1.Status='Working';
            insert l1;
            }
            catch(Exception e){
            u1.Open_Leads_Allowed__c=15;
            update u1;
            }
            Lead l2= new Lead();
            l2.Company='1';
            l2.Ownerid=u1.id;
            l2.lastname='testclass';
            l2.Status='Working';
            l2.Email= 'piyush12345@gmail.com';
            l2.Status='Qualified - Convert';
            insert l2;
            try{
            u1.Open_Leads_Allowed__c=0;
            update u1;
            l2.status='Open';
            update l2;
            }
            catch(Exception e){
            u1.Open_Leads_Allowed__c=15;
            update u1;
            }
            Lead l3= new Lead();
            l3.Company='1';
            l3.Ownerid=u1.id;
            l3.lastname='testclass';
            l3.Email='piyush@gmail.com';
            l3.Status='Qualified - Convert';
            insert l3;
            delete l3;
            undelete l3;
            delete l2;
            undelete l2;
        }*/
        }
}