global class InboundEmail_myHandler implements Messaging.InboundEmailHandler {
 
  global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email,
    Messaging.InboundEnvelope envelope) {
 
    Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
    String[] emailBody = email.plainTextBody.split('\n', 0);
    integer i1=0;
    string parentid1;
     for(i1=0; i1<emailbody.size(); i1++)
{
if(emailbody[i1].contains('record id '))
{
List<String> name=emailBody[i1].split('record id ');
parentid1=name[1];
}
}
  Id id1=parentid1;
  system.debug('record id is***'+parentid1);
    
    Sample_Request__c SR=[select Id,Name,Intimation_To_BD__c from Sample_Request__c where Id =: id1];
    SR.Intimation_To_BD__c=TRUE;
    update SR;
    
    Note n=new Note();
       n.ParentId =parentid1;
       //system.debug('parent id of the attachment'+n.ParentId);
       n.Title=email.subject;
       n.Body=email.plainTextBody;
       insert n;
    if (email.binaryAttachments != null && email.binaryAttachments.size() > 0) {
        for (integer i = 0 ; i < email.binaryAttachments.size() ; i++) {
        Attachment attachment = new Attachment();
        attachment.ParentId =parentid1;
        attachment.Name = email.binaryAttachments[i].filename;
        attachment.Body = email.binaryAttachments[i].body;
        insert attachment;
      }
    }
  return result;
  } 

//Test code start 
static testMethod void testMe() {
 
  // create a new email and envelope object
  Messaging.InboundEmail email = new Messaging.InboundEmail() ;
  Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
   
  // query for the contact the email service created
  Opportunity oppty = new Opportunity();
  oppty.Name='Test Name';
  oppty.StageName='Qualification';
  oppty.CloseDate =system.Today();
    oppty.EMT__c='IDH';
  insert oppty;
  Lead objLead = new Lead (LastName = 'Test data', Email = 'test@gmail.com', mobilephone = '+1234567890', Company = 'Test company');
    insert objLead;
  Sample_Request__c SR1=new Sample_Request__c();
  SR1.Name='testname';
    SR1.Opportunity__c=oppty.Id;
    SR1.Lead__c	=objLead.Id;
  insert SR1;
  
  // setup the data for the email
  email.subject = 'Test Job Applicant';
  email.fromname = 'FirstName LastName';
  env.fromAddress = 'someaddress@email.com';
  email.plainTextBody= 'test data record id '+SR1.id;
  //email.TextAttachment='textfile.txt';
 
  
  // add an attachment
  Messaging.InboundEmail.BinaryAttachment attachment = new Messaging.InboundEmail.BinaryAttachment();
  attachment.body = blob.valueOf('my attachment text');
  attachment.fileName = 'textfile.txt';
  attachment.mimeTypeSubType = 'text/plain';
  
  //attachment.parentId =oppty.id;
  Attachment att=new Attachment();
  att.body = blob.valueOf('my attachment text');
  att.Name = 'textfile.txt';
  //att.mimeTypeSubType = 'text/plain';
  att.Parentid=oppty.Id;
  insert att;
  
  Messaging.InboundEmail.TextAttachment inbTextAttchment = new Messaging.InboundEmail.TextAttachment();
  inbTextAttchment.body = 'Test Test Test Test Test Test Test Test Test';
  inbTextAttchment.fileName = 'myAttachment.txt';
  Messaging.InboundEmail.TextAttachment[] textAttachs = new Messaging.InboundEmail.TextAttachment[1];
  textAttachs[0] = inbTextAttchment;   
  email.textAttachments = textAttachs;
 
  email.binaryAttachments =
    new Messaging.inboundEmail.BinaryAttachment[] { attachment };
 
  // call the email service class and test it with the data in the testMethod
  InboundEmail_myHandler emailProcess = new InboundEmail_myHandler();
  emailProcess.handleInboundEmail(email, env);
 
  //System.assertEquals(a.name,'textfile.txt');
 }
}