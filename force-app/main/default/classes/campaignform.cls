public with sharing class campaignform {

public Campaign_Form__c cam {get; set;}
Public attachment objAttachment{get; set;}
Public attachment objAttachment1{get; set;}
Public attachment objAttachment2{get; set;}
Public attachment objAttachment3{get; set;}
Public attachment objAttachment4{get; set;}
Public attachment objAttachment5{get; set;}

    public campaignform(ApexPages.StandardController controller) {
    cam = (Campaign_Form__c )controller.getRecord();
    objAttachment = new Attachment();
    objAttachment1 = new Attachment();
    objAttachment2 = new Attachment();
    objAttachment3 = new Attachment();
    objAttachment4 = new Attachment();
    objAttachment5 = new Attachment();
    }

    public PageReference savecam(){
       try{
              upsert cam;
              objAttachment.ParentId = cam.id;
    Insert objAttachment; 
    objAttachment1.ParentId = cam.id;
    Insert objAttachment1;
    objAttachment2.ParentId = cam.id;
    Insert objAttachment2;
    objAttachment3.ParentId = cam.id;
    Insert objAttachment3;
    objAttachment4.ParentId = cam.id;
    Insert objAttachment4;
    objAttachment5.ParentId = cam.id;
    Insert objAttachment5;
    }
    catch(Exception e){
    }
    
              PageReference pageRef= page.sucess1;
              return pageRef;

       

    }
}