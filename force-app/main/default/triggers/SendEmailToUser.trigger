trigger SendEmailToUser on Bookings__c (after insert,after update) {
    
    for(Bookings__c b:Trigger.new){
     if(trigger.isInsert){
     if(b.Status__c=='Pending'){
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        User user = [select email from user where Id= :UserInfo.getUserId()];
        String[] toAddresses = new String[] {user.Email};
        mail.setToAddresses(toAddresses);
        mail.setSubject('Send To Email: ');
        mail.setHtmlBody('Dear User, '+'<br/>'+'<br/>'+'We have accepted your request and will notify the booking status through an Email Shortly'+'<br/>'+'<br/>'+'Thank You,'+'<br/>'+'Admin');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        
        Messaging.SingleEmailMessage mail1 = new Messaging.SingleEmailMessage();
        String[] toAddresses1 = new String[] {'abdul.s@cirrologix.com'};
        mail1.setToAddresses(toAddresses1);
        mail1.setSubject('Send To Email: ');
        mail1.setHtmlBody('Dear Admin,'+'<br/>'+'<br/>'+'We have new Booking please respond accordingly'+'<br/>'+'<br/>'+'Thank You,'+'<br/>'+'Salesforce Team');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail1 });
       }
    }  
       if(trigger.isUpdate){
       if(b.Status__c=='Approved'){
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        User user = [select email from user where Id= :UserInfo.getUserId()];
        String[] toAddresses = new String[] {user.Email};
        mail.setToAddresses(toAddresses);
        mail.setSubject('Send To Email: ');
        mail.setHtmlBody('Hi,'+'<br/>'+'<br/>'+'isApproved'+'<br/>'+'<br/>'+'Thank You,'+'<br/>'+'Salesforce Team');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        
        Messaging.SingleEmailMessage mail1 = new Messaging.SingleEmailMessage();
        String[] toAddresses1 = new String[] {'abdul.s@cirrologix.com'};
        mail1.setToAddresses(toAddresses1);
        mail1.setSubject('Send To Email: ');
        mail1.setHtmlBody('Dear Admin,'+'<br/>'+'<br/>'+'isApproved'+'<br/>'+'<br/>'+'Thank You,'+'<br/>'+'Salesforce Team');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail1 });
       }
     
      }
    if(trigger.isUpdate){
       if(b.Status__c=='Rejected'){
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        User user = [select email from user where Id= :UserInfo.getUserId()];
        String[] toAddresses = new String[] {user.Email};
        mail.setToAddresses(toAddresses);
        mail.setSubject('Send To Email: ');
        mail.setHtmlBody('Hi,'+'<br/>'+'<br/>'+'isApproved'+'<br/>'+'<br/>'+'Thank You,'+'<br/>'+'Salesforce Team');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        
        Messaging.SingleEmailMessage mail1 = new Messaging.SingleEmailMessage();
        String[] toAddresses1 = new String[] {'abdul.s@cirrologix.com'};
        mail1.setToAddresses(toAddresses1);
        mail1.setSubject('Send To Email: ');
        mail1.setHtmlBody('Dear Admin,'+'<br/>'+'<br/>'+'isApproved'+'<br/>'+'<br/>'+'Thank You,'+'<br/>'+'Salesforce Team');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail1 });
       }
       }
    
    }
}