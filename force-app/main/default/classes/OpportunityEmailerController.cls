public with sharing class OpportunityEmailerController  {
        public String email {get;set;}
        public String emailCc {get; set;}
        public String emailBcc {get; set;}
        public String Subject {get; set;} 
        public String emailBody {get; set;}
       // public Boolean tempId{get;set;}
        public String templateId{get;set;}
        public ID documentId {get;set;}
        public String fromEmail {set;get;}
        public String fromName {get;set;}
        public List<Opportunity> oppList = new List<Opportunity>();
        public list<EmailTemplate> l{set;get;} 
        private ApexPages.StandardSetController standardController;
        private User userDetails;
        public String opportunityId {get;set;}
         public OpportunityEmailerController(){
            opportunityId = apexpages.currentpage().getparameters().get('id');
            getDocuments();
            getTemplate();
            userDetails = [Select Id,Name,Email,UserName from user where Id =: UserInfo.getUserId()];
            //fromEmail=userDetails.Email;
            fromEmail='documents@syncorders.com';
            fromName=userDetails.Name;
            oppList = [select id, name, account.name from opportunity where id=:opportunityId];
        }
        
       
        public OpportunityEmailerController(ApexPages.StandardSetController standardController){
            this.standardController = standardController;
            opportunityId = apexpages.currentpage().getparameters().get('id');
            getDocuments();
            getTemplate();
            userDetails = [Select Id,Name,Email,UserName from user where Id =: UserInfo.getUserId()];
            oppList = [select id, name, account.name from opportunity where id=:opportunityId];
        }
          
        public PageReference cancel() {
            PageReference pg=new PageReference('/'+opportunityId);
            pg.setRedirect(true);
            return pg;            
           }
        public List<SelectOption> template {get;set;}
   
        public List<SelectOption> getTemplate(){
            template = new List<SelectOption>();
            List<Folder> emailFolder = [Select Id,Name from Folder where Name = 'Client Profiling'];
            List<EmailTemplate> etemp = [SELECT id,FolderId,Name FROM EmailTemplate where FolderId=: emailFolder[0].Id];
            template.add(new SelectOption('','-------------------None------------------'));
            for(EmailTemplate s: etemp){
             template.add(new SelectOption(s.id,s.name));
            }
          return template;
         }       
     public List<SelectOption> documents {get;set;}
     
      public List<SelectOption> getDocuments(){
          if (documents == null) {
            documents = new List<SelectOption>();
            List<Attachment> documentList = [Select Id,Name from Attachment where ParentId =: opportunityId];
            for(Attachment docAvailable: documentList){
             documents.add(new SelectOption(docAvailable.id,docAvailable.name));
            }
          }
          return documents;
      }
 /*   public PageReference templateAssign(){
          if(templateId!=''&& templateId!=null){
              EmailTemplate etemp = [SELECT id,Name,Subject,Body FROM EmailTemplate where  id=:templateId];
                 emailBody=etemp.Body;
                 Subject = etemp.Subject;
          }else{
             emailBody='';
          }
          return null;
    }*/
  
  public PageReference sendDoc() {
        if((Subject=='' && fromName=='')){
             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Subject and From Name should not be empty' ));  
	     }else if
		((Subject=='' && email=='')) {
          ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Subject and To should not be empty' ));
         }else if
		((Subject=='' && emailCc=='')) {
          ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Subject and CC should not be empty,Please enter your email address' ));
         }else if
		((Subject==null && subject=='')) {
          ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Subject should not be empty' ));
	     }else if
		((Subject=='' && emailBody=='')) {
          ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Subject and Body should not be empty' ));
         }else {
          if(oppList.size()>0){
               boolean result = sendemailUser(oppList);
               if(result){             
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Email Sent' ));
               }
               email='';
               emailBcc = '';
               emailBody = '';
               emailCc = '';
               Subject = '';
               fromEmail = '';
               fromName  = '';
          }
    }
    return null;
  }
  
  public PageReference backToTemplateViewer(){
  PageReference pageRef = new PageReference('/apex/GenerateOrders'+'?id='+opportunityId);
  pageRef.setRedirect(true);
  return pageRef;
   
  }
   public boolean result;
     public boolean sendemailUser(List<Opportunity> oppList){
    
       Attachment doc = [select id, name, body, contenttype,Description  from Attachment where id=:documentId]; 
          try{
            String body = EncodingUtil.base64Encode(doc.body);
            SyncOrderEmailService.BasicHttpBinding_IService emailService = new SyncOrderEmailService.BasicHttpBinding_IService();
             result = emailService.SendMailToCustomer('pwd$#123',email,fromEmail,Subject,emailBody,body,fromName,emailCc,emailBcc,'',fromEmail);
            
                        
            //SyncOrderService.BasicHttpBinding_IService emailS = new SyncOrderService.BasicHttpBinding_IService();
            //boolean result = emailS.SendMailToCustomer('pwd$#123', 'praveen.r@istrategicloud.com', 'praveen.r@cirrologix.com', 
             //               'TEST EMAIL', 'Hi<br>This is test', body);
            System.debug('EMAIL SENT :'+result);
            if(!result){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Email Could not be sent, Please check with Administrator'));
                return false;
            }else{
                Task newTask = new Task();
                 newTask.WhatId = opportunityId;
                 newTask.WhoId=null;
                 newTask.Status='completed'; 
                 newTask.Subject = Subject;
                 newTask.Description = 'Email Sent with attachment to '+email;
                 newTask.ActivityDate = System.today();
                 insert newTask;
               
                 Attachment attachment = doc;
                 attachment.Id = null;
                 attachment.ParentId = newTask.Id;
                 insert attachment;
                 return true;
            }
            /*
                 List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
                  for(Opportunity s:oppList){
                     Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                     Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
                     efa.setContentType(doc.contentType);
                     efa.setFileName(doc.name+'.pdf');
                     efa.setInline(true);
                     efa.Body = doc.Body;
                     mail.setToAddresses(new String[] {email});
                    // mail.setTargetObjectId(s.id);
                     if(emailCc!=''){
                     mail.setCcAddresses(new String[] {emailCc});
                     }
                     if(emailBcc!=''){
                     mail.setBccAddresses(new String[] {emailBcc});
                     }
                     mail.setReplyTo(fromEmail);
                     mail.setSenderDisplayName(fromName);// userDetails.Name
                     mail.setSaveAsActivity(false);
                     mail.setUseSignature(true);
                     if(templateId != null && templateId != ''){
                        mail.setTemplateId(templateId);
                     }else{
                         mail.setSubject(Subject);
                         mail.setPlainTextBody(emailBody);
                     }
                    mail.setFileAttachments(new Messaging.EmailFileAttachment[] {efa});
                    mails.add(mail);
                   
                }
                Messaging.sendEmail(mails);
                */
            }
            catch(exception e){
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'---' +e  ));
            }
            return true;
        }

     
}