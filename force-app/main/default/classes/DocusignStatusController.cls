@RestResource(urlMapping='/Docusign')
global with sharing class DocusignStatusController {
    global static string responseGot {get;set;}
    
   
    @HttpPost
	webservice static string analysePost(){
		//public string pdfValue;
    //public string docType;
    	
		RestRequest req = RestContext.request;
        Blob body = req.requestBody;
        system.debug('response body'+body);
	    responseGot = body.toString();
	    system.debug('response in string'+responseGot);
	    List<String> orgInfo=new List<String>();
		Dom.Document doc = new Dom.Document();
		WrapperList instantsList = new WrapperList();
		doc.load(responseGot);
		//Retrieve the root element for this document.
		Dom.XMLNode Envelope = doc.getRootElement();
		Dom.XMLNode EnvelopeBody= Envelope.getChildElements()[0];
		for(Dom.XMLNode child : EnvelopeBody.getChildElements()) {
			System.debug('CHILD ELEMENT :'+child.getName());
			if(child.getName()=='RecipientStatuses' || child.getName()=='DocumentStatuses'){
				for(Dom.XMLNode childlist:child.getChildElements()){
					for(Dom.XMLNode childvalue:childlist.getChildElements()){
						if(childvalue.getName()=='type'){
							instantsList.typeName=childvalue.getText();
							}
						if(childvalue.getName()=='email'){
							instantsList.email=childvalue.getText();
							}
						if(childvalue.getName()=='sent'){
							instantsList.sentValue=childvalue.getText();
							}	
						if(childvalue.getName()=='Delivered'){
							instantsList.deliveredValue=childvalue.getText(); 
							}
						if(childvalue.getName()=='signed'){
							instantsList.signedvalue=childvalue.getText();
							}
						
						if(childvalue.getName()=='declineReason'){
							instantsList.declineReason=childvalue.getText();
							}
						if(childvalue.getName()=='status'){
							instantsList.statusValue=childvalue.getText();
							}
						if(childvalue.getName()=='recipientIpAddress'){
							instantsList.recipientIpAddress=childvalue.getText();
							}
						if(childvalue.getName()=='recipientId'){
							instantsList.recipientId=childvalue.getText();
							}
						if(childvalue.getName()=='Name'){
							instantsList.documentName=childvalue.getText();
							}
					}
				}	
			}
		    if(child.getName()=='envelopeId'){
	     		instantsList.envelopeId=child.getText();
				}
			if(child.getName()=='Completed'){
				instantsList.completedvalue=child.getText();
				}
			String dName; string dPDFBytes; string DocumentType;	
					
		}
		if(Envelope.getChildElements().size() > 1){
			String dName; string dPDFBytes; string DocumentType;	
			Dom.XMLNode EnvelopeDocBody= Envelope.getChildElements()[1];
			for(Dom.XMLNode childDoc : EnvelopeDocBody.getChildElements()) {
				System.debug('DOCUMENT CHILD ELEMENT :'+childDoc.getName());
				for(Dom.XMLNode childvalueDoc:childDoc.getChildElements()){
					if(childvalueDoc.getName()=='Name'){
						dName =childvalueDoc.getText();
						}
					if(childvalueDoc.getName()=='PDFBytes'){
						dPDFBytes=childvalueDoc.getText();
						}
					if(childvalueDoc.getName()=='DocumentType'){
						DocumentType=childvalueDoc.getText();
						}
					System.debug('ATTACHMENT INFO:'+dName+'-------------'+DocumentType);
				}
				DocumentList d1=new DocumentList(dName,dPDFBytes,DocumentType);	
				instantsList.docPdf.add(d1);
				
			}
			
			
		}
		system.debug('finalResult::::::::'+instantsList);
		Docusign_Status__c status = new Docusign_Status__c ();
		status.Envelope_Id__c = instantsList.envelopeId;		
		status.status__c = instantsList.statusValue;
		status.Email__c = instantsList.email;
		status.Type__c = instantsList.typeName;
		status.Recipient_Id__c = instantsList.recipientId;
		status.Recipient_IP_Address__c = instantsList.recipientIpAddress;
		status.Decline_Reason__c = instantsList.declineReason;
		status.Document_Name__c = instantsList.documentName;
		//status.Sent_Date_Time__c = dateTime.valueOf(instantsList.sentValue);
		//status.Delivered_Date_Time__c= dateTime.ValueOf(instantsList.deliveredValue);
		///system.debug('$$$$$$$$$$$$$$$'+status.Delivered_Date_Time__c);
		//status.Signed_Date_Time__c = dateTime.ValueOf(instantsList.signedvalue);
		//status.Completed_Date_Time__c= dateTime.ValueOf(instantsList.completedvalue); 
		insert status;	
		
		for(DocumentList singeldoc:instantsList.docPdf){		
				Attachment  attachment = new Attachment();
				attachment.Name = 'Signed -'+singeldoc.Name;
		    	attachment.ParentId =status.id; 
		    	attachment.ContentType='Application/PDF';
		    	attachment.Body = EncodingUtil.base64Decode(singeldoc.PDFBytes);
		    	   try {
				      insert attachment;
				      System.debug('Attachment Record :'+attachment);
				    } catch (DMLException e) {
				  
				    }
			}
		
		system.debug('DOCUSIGN STATUS'+status);
		
		return 'None';
 	}
 	
 
 	
 	public class WrapperList{
 	
 		public string typeName{get;set;}
 		public string email{get;set;}
 		public string sentValue{get;set;}
 		public string deliveredValue{get;set;}
 		public string signedvalue{get;set;}
 		public string declineReason{get;set;}
 		public string statusValue{get;set;}
 		public string recipientIpAddress{get;set;}
 		public string recipientId{get;set;}
 		public string envelopeId{get;set;}
 		public string documentName{get;set;}
 		public string completedvalue{get;set;}
 		public List<DocumentList> docPdf{get;set;}
 		
 		
 		public WrapperList(){
 		
 			typeName='';
	 		email='';
	 		sentValue='';
	 		deliveredValue='';
	 		signedvalue='';
	 		declineReason='';
	 		statusValue='';
	 		recipientIpAddress='';
	 		recipientId='';
	 		envelopeId='';
	 		documentName='';
	 		completedvalue='';
	 		docPdf = new List<DocumentList>();
	 		
 		}
 		
 	}
 	public class DocumentList{
 		
 		public string Name{get;set;}
 		public string PDFBytes{get;set;}
 		public string DocumentType{get;set;}
 		
 		public DocumentList(string Name, string PDFBytes,string DocumentType){
 			
 			this.Name=Name;
 			this.PDFBytes = PDFBytes;
 			this.DocumentType=DocumentType;
 			}
 		}
 	
 	
 }