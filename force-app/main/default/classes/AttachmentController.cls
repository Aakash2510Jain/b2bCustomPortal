public class AttachmentController{
     public String opportunityId {get;set;}
     public String opportunityNo {get;set;}
     public AttachmentController(ApexPages.StandardController controller) {
        opportunityId = apexpages.currentpage().getparameters().get('id');
        opportunityNo = apexpages.currentpage().getparameters().get('no');
    }
     public PageReference Attach(){
       PageReference pdf= new PageReference('/apex/PdfAttachment');
       Attachment attach = new Attachment();
       Blob body;
          try {  
                 body = pdf.getContent();
              } catch (VisualforceException e) {
                body = Blob.valueOf('Some Text');
              }
              system.debug('OppId'+opportunityId);
                attach.Body = body;
                // add the user entered name
                attach.Name = 'WorkOrder.pdf';
                attach.IsPrivate = false;
                // attach the pdf to the opportunity
                attach.ParentId = opportunityId;
              
                insert attach;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'PDF is attached to the Opportunity.' ));
                return null;
     }
      public PageReference Attachment1(){
       PageReference pdf= new PageReference('/apex/PdfAttachmenttemplate5');
       Attachment attach = new Attachment();
       Blob body;
          try {  
                 body = pdf.getContent();
              } catch (VisualforceException e) {
                body = Blob.valueOf('Some Text');
              }
                attach.Body = body;
                // add the user entered name
                attach.Name = 'WorkOrder.pdf';
                attach.IsPrivate = false;
                // attach the pdf to the opportunity
                attach.ParentId = opportunityId;
                insert attach;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'PDF is attached to the Opportunity.' ));
                return null;
     }
      public PageReference Attachment2(){
       PageReference pdf= new PageReference('/apex/PdfAttachmenttemplate7');
       Attachment attach = new Attachment();
       Blob body;
          try {  
                 body = pdf.getContent();
              } catch (VisualforceException e) {
                body = Blob.valueOf('Some Text');
              }
                attach.Body = body;
                // add the user entered name
                attach.Name = 'WorkOrder.pdf';
                attach.IsPrivate = false;
                // attach the pdf to the opportunity
                attach.ParentId = opportunityId;
                insert attach;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'PDF is attached to the Opportunity.' ));
                return null;
     }
     public PageReference pdfAttachment(){
       PageReference pdf= new PageReference('/apex/PdfAttachmenttemplate4');
       Attachment attach = new Attachment();
       Blob body;
          try {  
                 body = pdf.getContent();
              } catch (VisualforceException e) {
                body = Blob.valueOf('Some Text');
              }
                attach.Body = body;
                // add the user entered name
                attach.Name = 'WorkOrder.pdf';
                attach.IsPrivate = false;
                // attach the pdf to the opportunity
                attach.ParentId = opportunityId;
                insert attach;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'PDF is attached to the Opportunity.' ));
                return null;
     }
      
}