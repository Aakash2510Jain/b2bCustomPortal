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
private class Test_DocumentEmailController {
	
    static testMethod void myUnitTest() {
        //Client_Profile_Folder%
    	List<Folder> folders = [Select Id, Name from Folder where Name = 'Client Profiling'];
     	System.debug('***************'+folders);
     	List<Lead> leadsIn = new List<Lead>();
     	Lead newLead = new Lead();
        newLead.Company = 'TestClientProfile';
        newLead.FirstName='TestCP';
        newLead.LastName='TestLNCP';
        newLead.Email = 'rpraveenc1@gmail.com';
        newLead.Division_Name__c='Winners';
        newLead.Primary_Service_Name__c='CRM';
        newLead.LeadSource='Test';
        newLead.Lead_AssignedTo__c='Alex Cooper';
        newLead.Status='InProgress';
       // insert newLead;
        leadsIn.add(newLead);
      /*  Lead newLead2 = new Lead();
        newLead2.Company = 'TestClientProfile1';
        newLead2.FirstName='TestP';
        newLead2.LastName='TestLNP';
        newLead2.Email = 'rpraveenctest1@gmail.com';
        newLead2.Division_Name__c='Winners';
        newLead2.Primary_Service_Name__c='CRM';
        newLead2.LeadSource='Test';
        newLead2.Lead_AssignedTo__c='Alex Cooper';
        newLead2.Status='InProgress';*/
        //insert newLead2;
        //leadsIn.add(newLead2);
         insert leadsIn;
	   Document	document = new Document();
		document.Body = Blob.valueOf('Some Text');
		document.ContentType = 'application/pdf';
		document.DeveloperName = 'my_document';
		document.IsPublic = true;
		document.Name = 'My Document';
		document.FolderId = [select id from folder where name = 'Shared Documents'].id;
		insert document;
		 User usr = [Select id from User where Id = :UserInfo.getUserId()];
		  System.RunAs(usr)
        {
		list<Folder> fd =[Select f.Type, f.Name, f.Id, f.DeveloperName, f.CreatedDate, f.CreatedById, f.AccessType From Folder f where name='CMS'];
       // string fd_id = fd.id;
        //EmailTemplate e = new EmailTemplate ();
        //e.developerName = 'test';
        //e.FolderId = fd_id;
        //e.TemplateType= 'Text';
        //e.Name = 'test'; // plus any other fields that you want to set
		//insert e;
		System.debug('-----------------------'+document);    
        
        ApexPages.currentPage().getParameters().put('leadId',leadsIn[0].id);
        ApexPages.StandardSetController sc = new ApexPages.StandardSetController(leadsIn);
        DocumentEmailController der1 = new DocumentEmailController(sc);
        DocumentEmailController der= new DocumentEmailController();
        der1.documentId = document.Id;
        //der1.templateId = e.id;
        //der1.getTemplate();
        //der1.getDocuments();
        der1.cancel();
        der1.email='praveen.r@istrategicloud.com';
        der1.templateAssign();
        der1.emailBCc='rpraveenc@gmail.com';
        der1.emailCc='rpraveenc@gmail.com';
        der1.emailBody='test';
        der1.sendemailUser(leadsIn);
        der1.sendDoc();
        der1.cancel();
        der1.SingleEmailsend(); 
            try{
                der1.getDocuments();
                der1.getTemplate();
            	
            }catch(Exception ex){}
        }
        
     //   List<Document> documentList = [Select FolderId,Id,Name from Document where Name = 'profile1' limit 1];// where FolderId =: folders[0].Id];
              
     }
    static testMethod void unitTestDocEmail(){
        //Client_Profile_Folder%
        List<Folder> folders = [Select Id, Name from Folder where Name = 'Client Profiling'];
        System.debug('***************'+folders);
        List<Lead> leadsIn = new List<Lead>();
        Lead newLead = new Lead();
        newLead.Company = 'TestClientProfile';
        newLead.FirstName='TestCP';
        newLead.LastName='TestLNCP';
        newLead.Email = 'rpraveenc1@gmail.com';
        newLead.Division_Name__c='Winners';
        newLead.Primary_Service_Name__c='CRM';
        newLead.LeadSource='Test';
        newLead.Lead_AssignedTo__c='Alex Cooper';
        newLead.Status='InProgress';
        leadsIn.add(newLead);
        insert leadsIn;
        Document document = new Document();
        document.Body = Blob.valueOf('Some Text');
        document.ContentType = 'application/pdf';
        document.DeveloperName = 'my_document';
        document.IsPublic = true;
        document.Name = 'My Document';
        document.FolderId = [select id from folder where name = 'Shared Documents'].id;
        insert document;
        User usr = [Select id from User where Id = :UserInfo.getUserId()];
        System.RunAs(usr)
        {
            ApexPages.currentPage().getParameters().put('leadId',leadsIn[0].id);
            ApexPages.StandardSetController sc = new ApexPages.StandardSetController(leadsIn);
            DocumentEmailController der1 = new DocumentEmailController(sc);
            der1.Subject = '';
            der1.templateId = null;
            der1.sendDoc();
            der1.SingleEmailsend();
            try{
                der1.getTemplate();
            	der1.getDocuments();
            }catch(Exception ex){}
            
        }
    }
    
}