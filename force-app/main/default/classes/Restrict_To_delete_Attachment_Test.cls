@isTest
public class Restrict_To_delete_Attachment_Test{ 
static testmethod void TestMethodAttachment(){

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

Attachment attach=new Attachment();       
         attach.Name='Unit Test Attachment';
         Blob bodyBlob = Blob.valueOf('Unit Test Attachment Body');
          attach.body = bodyBlob;
          attach.parentId = l2.id;
        insert attach;
    
    Delete attach;
    
    Note n = new Note();    
n.Body = 'bodyBlob';
n.Title='title';
n.ParentId = l2.id; // Lead Id
n.IsPrivate = false;
Insert n;
    Delete n;
}
}