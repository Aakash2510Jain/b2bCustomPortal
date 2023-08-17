@istest
public class campaignformtest{
static testmethod void campaignformtestmethod(){

 Campaign_Form__c camp=new Campaign_Form__c(Project_ID__c='Cirrologix',Project_Value__c='metricfox');
    insert camp;
    
    ApexPages.StandardController sc1 = new ApexPages.StandardController(camp);
    
    campaignform cp1=new campaignform(sc1);
    Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
    //cp1.Project_ID__c='testing';
       cp1.objAttachment.parentId=camp.id;
       cp1.objAttachment.Name='Unit Test Attachment';
       
       cp1.objAttachment.body=bodyBlob;
           cp1.savecam();   
}
}