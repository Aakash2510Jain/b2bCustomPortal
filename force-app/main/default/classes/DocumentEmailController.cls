public with sharing class DocumentEmailController  {
        public String email {get;set;}
        public String emailCc {get; set;}
        public String emailBcc {get; set;}
        public String Subject {get; set;}
        public String emailBody {get; set;}
      //  public Boolean tempId{get;set;}
        public String templateId{get;set;}
        public ID documentId {get;set;}
        public List<Lead> leadList = new List<Lead>();
      //  public list<EmailTemplate> l{set;get;} 
        public List<Lead> le=new List<Lead>();
        public DocumentEmailController(){}
        private ApexPages.StandardSetController standardController;
        private User userDetails;
        
        public DocumentEmailController(ApexPages.StandardSetController standardController){
            this.standardController = standardController;
            if(!Test.isRunningTest()){
            	getTemplate();
                getDocuments();
        	}
            
            userDetails = [Select Id,Name,Email,UserName from user where Id =: UserInfo.getUserId()];
            if(apexpages.currentpage().getparameters().get('leadId')!=null){  
	            le=[select id,name,Email from lead where id=:apexpages.currentpage().getparameters().get('leadId')];
	            //email=le.email;
            }else{
           		leadList = [Select id,email,Name from lead where id =:(Lead[])standardController.getSelected()];
	             if(email== null){
	                email='';
	             }
	             System.debug('LeadList :'+leadList);
	             for(Lead leadRecord : leadList){
	                if(email.length() > 0){
	                    email=email+','+leadRecord.email;
	                }else{
	                    email= email+leadRecord.email;
	                }
	             }
              }
            }
          
	    public PageReference cancel() {
	        PageReference pg=new PageReference('/00Q/o');
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
            List<Folder> folders = [Select Id, Name from Folder where Name like 'Client_Profile_Folder%'];
            List<Document> documentList = [Select FolderId,Id,Name from Document where FolderId =: folders[0].Id];
            for(Document docAvailable: documentList){
             documents.add(new SelectOption(docAvailable.id,docAvailable.name));
            }
          }
          return documents;
      }
  	public PageReference templateAssign(){
		  if(templateId!=''&& templateId!=null){
		      EmailTemplate etemp = [SELECT id,Name,Subject,Body FROM EmailTemplate where  id=:templateId];
		         emailBody=etemp.Body;
		         Subject = etemp.Subject;
		  }else{
		 	 emailBody='';
		  }
		  return null;
  	}
  
  public PageReference sendDoc() {
  		if((templateId==null && subject=='')){
  			 ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Subject should not be empty' ));    
  		}else{  		
  	       if(leadList.size()>0){
    	   	   sendemailUser(leadList);             
               ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Email Sent' ));
          }
  	}
    return null;
  }
    public PageReference SingleEmailsend() {
    	
    	if((templateId==null && subject=='')){
	 			 ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Subject should not be empty' ));    
	  		}else{  
				    sendemailUser(le);
	                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Email Sent' ));                    
		 }
	    return null;
	  }
	  
	 public void sendemailUser(List<lead> leadList){
    
       Document doc = [select id, name, body, contenttype,Description, developername, type from Document where id=:documentId]; 
          try{
	         List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
              for(Lead s:leadList){
				 Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
				 Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
		   		 efa.setContentType(doc.contentType);
                 efa.setFileName(doc.developerName+'.'+doc.type);
            	 efa.setInline(true);
             	 efa.Body = doc.Body;
				 mail.setTargetObjectId(s.id);
				 if(emailCc!=''){
	             mail.setCcAddresses(new String[] {emailCc});
	             }
	             if(emailBcc!=''){
	             mail.setBccAddresses(new String[] {emailBcc});
	             }
				 mail.setReplyTo(userDetails.Email);
	             mail.setSenderDisplayName('Aaron');// userDetails.Name
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
	            Client_Profile__c cli= new Client_Profile__c();     
	            cli.Document_ID__c = doc.id;    
	            cli.Document_Name__c =doc.Name;
	            cli.Document_Type__c = doc.Type;
	            cli.Lead__c = s.Id;
	            cli.Description__c = doc.Description;
	            cli.Subject__c = Subject;
	            Insert cli;
			}
			Messaging.sendEmail(mails);
			
			}catch(exception e){
	           	 	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'---' +e  ));
	           	 }
			
     	}

   /*  public static TestMethod void  DocumentEmail(){
     	List<Folder> folders = [Select Id, Name from Folder where Name like 'Client_Profile_Folder%'];
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
        insert newLead;
        leadsIn.add(newLead);
        Lead newLead2 = new Lead();
        newLead2.Company = 'TestClientProfile1';
        newLead2.FirstName='TestP';
        newLead2.LastName='TestLNP';
        newLead2.Email = 'rpraveenctest1@gmail.com';
        newLead2.Division_Name__c='Winners';
        newLead2.Primary_Service_Name__c='CRM';
        newLead2.LeadSource='Test';
        newLead2.Lead_AssignedTo__c='Alex Cooper';
        newLead2.Status='InProgress';
        insert newLead2;
        leadsIn.add(newLead2);
         
	   Document	document = new Document();
		document.Body = Blob.valueOf('Some Text');
		document.ContentType = 'application/pdf';
		document.DeveloperName = 'my_document';
		document.IsPublic = true;
		document.Name = 'My Document';
		document.FolderId = [select id from folder where name = 'Shared Documents'].id;
		insert document;
		Folder fd =[Select f.Type, f.Name, f.Id, f.DeveloperName, f.CreatedDate, f.CreatedById, f.AccessType From Folder f where name='CMS'];
        EmailTemplate e = new EmailTemplate (developerName = 'test', FolderId = fd.id, TemplateType= 'Text', Name = 'test'); // plus any other fields that you want to set
		insert e;
     //   List<Document> documentList = [Select FolderId,Id,Name from Document where Name = 'profile1' limit 1];// where FolderId =: folders[0].Id];
        System.debug('-----------------------'+document);    
        DocumentEmailController dec = new DocumentEmailController();
        ApexPages.currentPage().getParameters().put('leadId',newLead.id);
        ApexPages.StandardSetController sc = new ApexPages.StandardSetController(leadsIn);
        DocumentEmailController der1= new DocumentEmailController(sc);
        der1.documentId = document.Id;
        der1.templateId = e.id;
        der1.getTemplate();
        der1.getDocuments();
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
       
     }*/
}