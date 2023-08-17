@isTest
private class TestClass_SampleRequestTrigger {
public static testmethod void testEmail()
    {
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {'me@email1.com','you@email2.com'};
        mail.setToAddresses(toAddresses);
        
       // Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator' limit 1]; 
        //User u =[select id,Email from User where profileId =: p.Id];
        //System.runas(u)
        {
        Lead l=new Lead(LastName='test lead',Company='Test-nih',Test_mandatory_check__c='test check');
        insert l;
        Sample_Request__c SR=new Sample_Request__c(Name='Test sample',Lead__c=l.Id,Sample_Type__c='Custom Business List Sample' );
        Insert SR;
        Attachment at = new Attachment();
        String s = 'abc';
        Blob b = Blob.valueOf(s);
        at.Body =b;
        at.Name= 'test';
        at.parentId = SR.Id;
        insert at;
        
        SR.Send_Request__c=true;
        update SR;
        
        SR.Sample_Type__c='News Letter';
        SR.Send_Request__c=true;
        update SR;
        
        SR.Sample_Type__c='Email Campaign';
        SR.Send_Request__c=true;
        update SR;
        
          SR.Sample_Type__c='Articles';
        SR.Send_Request__c=true;
        update SR;
        
          SR.Sample_Type__c='Technology List Sample';
        SR.Send_Request__c=true;
        update SR;
        
        SR.Sample_Type__c='Demand Generation';
        SR.Send_Request__c=true;
        update SR;
        
       
        
        
        
     // Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        
       
        }
    }
        
 
    }