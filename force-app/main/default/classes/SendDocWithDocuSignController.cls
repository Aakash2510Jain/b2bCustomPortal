global  class SendDocWithDocuSignController {
    
    public string attachmentName{get;set;}
    public string EmailSubject {get;set;}
    public string EmailBody {get;set;}
    global string recipientEmail {get;set;}
    global string recipientName {get;set;}
    public String opportunityId {get;set;} 
    public string typeofService{get;set;}
    public ID documentId {get;set;}
    public ID attachmentId {get;set;}
    public ID folderId {get;set;}
    public List<selectOption> attachments {get;set;}
    public List<SelectOption> docfiles {get;set;}
    public List<SelectOption> folderslist {get;set;}
    //public List<SelectOption> selectItems {get;set;}
    public List<Opportunity> oppList = new List<Opportunity>();
    public string selectedEmail{get;set;}
    public String selcontactid;
   	public List<contact> selectcon;
   	
    public SendDocWithDocuSignController(){
        opportunityId = apexpages.currentpage().getparameters().get('id');
        getAttachments();
        //system.debug('*******************'+SelectItems);    
    }
      
     
        public List<contact> getAllContacts()
        {
            Opportunity  opp=[select id,name ,accountId from opportunity where id=:opportunityId];
            List<contact> allcons =  [Select Id,FirstName,LastName,Name,Email,Phone,accountId from Contact where accountId=:opp.accountId];
            return allcons;
        }  
        
        public void selectcon()
        {
            selcontactid = System.currentPagereference().getParameters().get('conid');
            Contact con = [Select Id,FirstName,LastName,Email,Phone,Name,accountId from Contact where Id=:selcontactid ];
            selectcon =  new List<contact>();
            selectcon.add(con);
        } 
        
        public List<contact> getselectedContact()
        {
            return selectcon;
        } 
      
        //Displays the attachments of opportunity
        
         public List<SelectOption> getAttachments(){
              if (attachments == null) {
                    attachments = new List<SelectOption>();
                    List<Attachment> attachmentList = [Select Id,Name from Attachment where ParentId =: opportunityId];
                    for(Attachment attachAvailable: attachmentList){
                         attachments.add(new SelectOption(attachAvailable.id,attachAvailable.name));
                    }
              }
              return attachments;
          }
         
         
         public List<SelectOption> getTypeService(){
                  List<SelectOption>  attachments = new List<SelectOption>();
                  attachments.add(new SelectOption('','None'));
                  attachments.add(new SelectOption('workorder','Work Order'));
                  attachments.add(new SelectOption('invoice','Invoice'));
                  attachments.add(new SelectOption('proposal','Proposal'));
                    
              return attachments;
          }
         
         //Displays the folders 
         
         public List<SelectOption> getDocfolder(){
            folderslist = new List<SelectOption>();
            List<Folder> folders = [Select Id, Name from Folder where type like '%Document%' ];
                for(Folder docAvailable: folders){
                    if(docAvailable.name!=null){
                        folderslist.add(new SelectOption(docAvailable.id,docAvailable.name));
                    }
                  }
          return folderslist;
          }
          
        //Displays the documents
        
         public Pagereference getDocuments(){
            docfiles = new List<SelectOption>();
            if(folderId!=null){
                    List<Folder> folders = [Select Id, Name from Folder where id=:folderId];
                    List<Document> documentList = [Select FolderId,Id,Name from Document where folderId=:folders[0].id];
                    for(Document docAvailable: documentList){
                        docfiles.add(new SelectOption(docAvailable.id,docAvailable.name));
                     }
                } 
         return null;
        }
        
        //Adding the attachment or document
        
        public Pagereference addDocuments(){
            
            Attachment attach = [select id, name from Attachment where id=:attachmentId]; 
            attachmentName = attach.Name;
        /*  
        PageReference page=new PageReference('/apex/SendWithDocuSign?id='+opportunityId+'&attachID='+attachmentId+'&DocuID='+documentId);
        page.setRedirect(true);
         */    
        return null;
        }
        
        //Redirects to selectdocuments page
        
        public PageReference selectDocument() {
                PageReference pg=new PageReference('/apex/SelectDocuments?id='+opportunityId);
                pg.setRedirect(true);
        return pg;            
        }
        
        //Send email to selected Recipient 
        
        public Pagereference sendDocsToDS(){
          Pagereference page = null;
            
              try{
                
                
                if(EmailSubject==''){
                    Apexpages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,'Email subject sholud not be empty.'));
                    return null; 
                }
                
                if(attachmentName == null || attachmentName == ''){
                	 Apexpages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,'Please attach the workorder.'));
                    return null;
                }
                if(typeofService =='' || typeofService == null){
                    Apexpages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,'Type of Service sholud not be empty.'));
                    return null; 
                }
                
                 Contact Rec = [Select Id,FirstName,LastName,Email,Phone,Name,accountId from Contact where Id=:selcontactid ];
                    system.debug('#######opp'+opportunityId+'@@@@@@@@@@@email'+Rec.Name+'$$$$$$$$$$$name'+Rec.Email+'^^^^^^^^^^body'+EmailBody+'&&&&&&&&&&&&sub'+EmailSubject);
                 page = processDocument(opportunityId,attachmentId,Rec.Name,Rec.Email,EmailSubject,EmailBody,attachmentName,typeofService);
                  
              }
              catch(Exception ex){
                 ApexPages.addMessages(ex);
              }
           return page;
         }
         
        public static String authHeader(){
        //Get Paramter from Custom Object and construct auth header
 		Opportunity   opp = [select id,Client_Name__c,Docu_Sign_Setting__r.Salesforce_UserName__c, Docu_Sign_Setting__r.Integrator_Key__c, 
                            Docu_Sign_Setting__r.AccountID__c, Docu_Sign_Setting__r.Password__c, Docu_Sign_Setting__r.UserName__c, 
                            Docu_Sign_Setting__c From Opportunity where id=:ApexPages.currentPage().getParameters().get('id')];
             return '<DocuSignCredentials>'+
                    '<Username>'+opp.Docu_Sign_Setting__r.UserName__c+'</Username>'+
                    '<Password>'+opp.Docu_Sign_Setting__r.Password__c+'</Password>'+
                    '<IntegratorKey>'+opp.Docu_Sign_Setting__r.Integrator_Key__c+'</IntegratorKey>'+
                	'</DocuSignCredentials>';
    	}
    
        //Call Create and send envelope method
        
        public static Pagereference processDocument(Id oppId,Id attach,string Name,string Email,string emailSub,string emailBody, string attachmentName,string typeofService){
            //Account Id
            Opportunity   oppInstants = [select id,Client_Name__c,Docu_Sign_Setting__r.Salesforce_UserName__c, Docu_Sign_Setting__r.Integrator_Key__c, 
                                Docu_Sign_Setting__r.AccountID__c, Docu_Sign_Setting__r.Password__c, Docu_Sign_Setting__r.UserName__c, 
                                Docu_Sign_Setting__c From Opportunity where id=:oppId];
            String accId = oppInstants.Docu_Sign_Setting__r.AccountID__c;
            //Create Draft Envelope
            String envstatus = creatAndSendEnvelope(accId,oppId,attach,Name,Email,emailSub,emailBody,attachmentName,typeofService);
            System.debug('Env Status = '+envstatus);
               if(envstatus=='sent'){
                return new Pagereference('/'+oppId);
               }
               else{
               //Apexpages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,'Service request is invalid'));
                return null;
               }
           
        } 
    
        //Create And Send Envelope - Creates Dynamic PDF Document, Create Recipient, Tabs and Sends for singature in one step
        
        public static string creatAndSendEnvelope(String accKey, Id oppId,Id attach,string Name, string Email, string emailSub,string emailBody,string attachmentName,string typeofService){
            Opportunity oppDocuRec = [Select id, Docu_Sign_Setting__r.Salesforce_UserName__c, Docu_Sign_Setting__r.Brand_Name__c, Docu_Sign_Setting__r.Integrator_Key__c, 
            Docu_Sign_Setting__r.AccountID__c, Docu_Sign_Setting__r.Password__c, Docu_Sign_Setting__r.UserName__c, Docu_Sign_Setting__c From Opportunity where id=:oppId];
            
            Attachment attachmentRec = [Select Id,Name,body from Attachment where id=:attach];
            Blob body;
            body =  attachmentRec.Body;
            String passString = authHeader();                   
            //MyBoundary - used to indicate benging/end of document in multi-part request
            String contentType = '\r\n--myBoundary'+'\r\n'+'Content-Type:application/octet-stream'+ '\r\n'+
                                    'Content-Transfer-Encoding: base64'+'\r\n'+'Content-Disposition:attachment; '+'filename=\"contract.pdf\";'+
                                    'documentid=1 '+'\r\n\r\n\r\n';
            String cheader = '\r\n--myBoundary'+'\r\n'+' Content-Type: application/json'+ '\r\n'+' Content-Disposition: form-data'+ '\r\n'+'\r\n';
           
            String envelop = createJSONString(oppId,Name,Email,emailSub,emailBody,attachmentName);
          
            System.debug('request body => '+envelop);
            String envEOF = '\r\n'+'--myBoundary--';                    
            Http httpProtocol = new Http();
            HttpRequest request = new HttpRequest();
            String endpoint = 'https://na2.docusign.net/restapi/v2/accounts/'+accKey+'/envelopes';
            //string endpoint = 'http://requestb.in/1cv47cd1'; // https://na2.docusign.net/
            request.setEndPoint(endpoint);
            request.setMethod('POST');
            request.setHeader('Accept', 'application/json');
            request.setHeader('X-DocuSign-Authentication', passString);
            request.setHeader('content-type', 'multipart/form-data;boundary=myBoundary'); 
            
            //Generate PDF
            String bcontent = EncodingUtil.base64Encode(body);
            request.setHeader('content-length', String.valueOf(bcontent.length()));
            
            //Body
            request.setBody(cheader+''+envelop+'\r\n'+contentType+'\r\n'+bcontent+'\r\n'+envEOF);
            System.debug('Request Body = '+cheader+''+envelop+'\r\n'+contentType+'\r\n'+bcontent+'\r\n'+envEOF);
            HttpResponse response1 = new HttpResponse();
            try{
                response1 = httpProtocol.send(request);
                System.debug('response1.getStatusCode()'+response1.getStatusCode());
                integer num=response1.getStatusCode();
                if(num==401){
                	Apexpages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,'USER_AUTHENTICATION_FAILED, One or both of Username and Password are invalid.'));
                return 'failure';
                }
                if(num==404){
                	Apexpages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,'SERVICE REQUEST IS INVALID, Please Contact Your Administrator.'));
                return 'failure';
                }
                
            }catch(exception e){
             
            return null;
            }
            System.debug('response1 =>'+response1.getBody());
            JSONParser parse = JSON.createParser(response1.getBody());
            system.debug('JSON parse results'+parse);
            EnvResponse envstat = (EnvResponse)parse.readValueAs(EnvResponse.class);
          
            Docusign_Status__c docuRec = new Docusign_Status__c();
            docuRec.status__c = envstat.status;
            docuRec.Envelope_Id__c = envstat.envelopeId;
            docuRec.Email__c = Email;
            docuRec.Opportunity__c = oppId;
            docuRec.Document_Name__c = attachmentName;
            docuRec.Type__c = typeofService;
            //docuRec.Username__c = oppDocuRec.Docu_Sign_Setting__r.UserName__c;
            //docuRec.Password__c = oppDocuRec.Docu_Sign_Setting__r.Password__c;
            //docuRec.Account_ID__c = oppDocuRec.Docu_Sign_Setting__r.AccountID__c;
            //docuRec.Integrator_Key__c = oppDocuRec.Docu_Sign_Setting__r.Integrator_Key__c;
            insert docuRec;
            
            system.debug('^^^^^^^^^^^^^'+docuRec);
            System.debug('De-Serialized class is envstats => '+envstat);
            system.debug('@@@@@@@@@@@@@@@@@'+envstat.status);
            return envstat.status;
        }
        
        
        //Util helper for constructing JSON request for createandsend all in one method 
        
        public static String createJSONString(String oppId,string Name,string Email,string emailSub,string emailBody,string attachmentName){  
            
            JSONGenerator gen = JSON.createGenerator(true);
            gen.writeStartObject();
            gen.writeStringField('emailBlurb', emailBody);
            gen.writeStringField('emailSubject',emailSub );
            //document
            gen.writeFieldName('documents');
            gen.writeStartArray();
            gen.writeStartObject();
            gen.writeStringField('documentId', '1');
            gen.writeStringField('name', attachmentName);
            gen.writeEndObject();
            gen.writeEndArray(); //end of doc
            //start recip
            gen.writeFieldName('recipients');
            //signer -1
            gen.writeStartObject();
            //array of singers
            gen.writeFieldName('signers');
            gen.writeStartArray();
            //gen.writeObject(new Signers('rpachaiyappan@gmail.com', 'Ram', '1', '1') );
            gen.writeStartObject();
            gen.writeObjectField('email', Email);
            gen.writeObjectField('name', Name);
            gen.writeObjectField('recipientId', '1');
            gen.writeObjectField('routingOrder', '1');
            gen.writeEndObject();//end Signer-1
            gen.writeEndArray(); 
            gen.writeEndObject();//end recip
            gen.writeStringField('status', 'sent');
            gen.writeFieldName('customFields');
            gen.writeStartObject();
            gen.writeFieldName('textCustomFields');
            gen.writeStartArray();
            gen.writeStartObject();
            gen.writeObjectField('name', 'ContractId');
            gen.writeObjectField('show', 'true');
            gen.writeObjectField('required', 'False');
            gen.writeObjectField('value', oppId);
            gen.writeObjectField('customFieldType', 'text');
            gen.writeEndObject();
            gen.writeEndArray();
            gen.writeEndObject();
            
            gen.writeEndObject();
            System.debug('JSON String => '+gen.getAsString());
            return gen.getAsString();
        }
        
        //Signer Class
        
        public class Signers{
            String email;
            String name;
            String recipientId;
            String routingOrder;
            
            public Signers(String emailAddr, String nam, String recpId, String routId){
                email = emailAddr;
                name = nam;
                recipientId = recpId;
                routingOrder = routId;      
            }   
        }
    
        //Envelope Data Class
        
        public class EnvResponse{
            String envelopeId;
            String status;
            String statusDateTime;
            String uri;
            
        }
        
        
}