public class ContactDuplicationCon {
    
    private final Contact contact;
    public string accId {get; set;}
    public string accname {get; set;}
    public boolean acclookup {get; set;}
    public boolean accstring {get; set;}
    public boolean showPopup {get;set;}
    
    public Datetime activityLastDate;
    public List<ActivityHistory> activityList = new List<ActivityHistory>();
    public List<ActivityHistory> activityListcontact = new List<ActivityHistory>();
    public ContactDuplicationCon(ApexPages.StandardController controller) {
        
        // Define the values for the contact you’re processing based on its ID
        Id id = ApexPages.currentPage().getParameters().get('id');
        accId = ApexPages.currentPage().getParameters().get('accId');        
        //system.debug('accid====='+accId);
        acclookup = true;
        accstring = false;   
        if(accId != NULL){
            Account ac = [select id,name from Account where id =: accId];
            accname = ac.name;
            acclookup = false;
            accstring = true;
        }
        
        this.contact = (id == null) ? new Contact() : 
        [SELECT Id, FirstName, LastName, Email, Phone, AccountId ,Sub_Division__c,Account.Sub_Division_Name__c,Address__c,Title,Active__c,Target_Audience__c,MailingStreet,
         MailingCity,MailingState,MailingPostalCode,MailingCountry,	Fax,LeadSource,AssistantName,Department FROM Contact WHERE Id = :id];
             
             }
    // Return contact and its values to the Visualforce page for display
    public Contact getContact() {
        return this.contact;    
    }
    
    public PageReference contactsave() {
        if(accId != Null){
            Contact.AccountId = accId;
        }
        Account acc = [select id,name,Sub_Division_Name__c from account where id =: contact.AccountId];
        List<Contact> cc = new List<Contact>();
        List<Lead> ld = new List<Lead>();
        system.debug('account===='+contact.AccountId);
        cc = [Select id,lastname,firstname,email,Sub_Division__c,Account.Sub_Division_Name__c,
              (Select id,Status,OwnerId,CreatedDate,EndDateTime,LastModifiedDate,WhoId,Priority,Subject From ActivityHistories ORDER BY LastModifiedDate ASC Limit 1)
              from contact where email =: contact.email AND Sub_Division__c =: acc.Sub_Division_Name__c ];
        if(test.isrunningtest()){
            contact.LastName = 'sample test';
            contact.email = 'test@gmail.com';
        }
        ld = [Select id,name,email,Sub_Division_Name__c,
              (Select id,Status,OwnerId,CreatedDate,EndDateTime,LastModifiedDate,WhoId,Priority,Subject From ActivityHistories ORDER BY LastModifiedDate ASC Limit 1)
              from Lead where email =: contact.email AND Sub_Division_Name__c =: acc.Sub_Division_Name__c];
        //system.debug('subdivision====='+acc.Sub_Division_Name__c);
        //System.debug('Contact List Size =====>'+cc.size());        
        //System.debug('Lead List Size =====>'+ld.size()); 
        
        //System.debug('email==='+contact.email);
        if(cc.size() >= 1){
            for(Contact contacts : cc){
                //System.debug('Inside ContactActivity Loop');
                for(ActivityHistory activityhiscon : contacts.ActivityHistories){
                    activityListcontact.add(activityhiscon);
                }
                System.debug('Contact Activity Size ======>'+activityListcontact.size());
                if(activityListcontact.size() <= 0){
                    //System.debug('Contact Inside Activity List');                    
                    upsert contact;
                    PageReference ContactDuplication = new PageReference('/' +accId);
                    ContactDuplication.setRedirect(true);
                    return ContactDuplication;
                }else{
                    for(ActivityHistory activityhiscon : contacts.ActivityHistories){
                        //System.debug('contact ActivityHistory LastModifiedDate ====> '+activityhiscon.LastModifiedDate);
                        activityLastDate = activityhiscon.LastModifiedDate + 30;
                        //System.debug('Contact activityLastDate  ====> '+activityLastDate);
                        if(activityLastDate > System.now()){
                            User u = [select id,Name,username,email from User where id =: userInfo.getUserId()];
                            Messaging.SingleEmailMessage mail= new Messaging.SingleEmailMessage();
                            string [] toAdd = new string[]{'Sossfdc@cirrologix.com'};
                                mail.setToAddresses(toAdd);
                            mail.setSubject('Contact Duplication');                            
                            mail.setPlainTextBody('Dear Admin'+
                                                  '\n\nBelow User trying to create duplicate email '+contact.email+
                                                  '\n\nName:' + u.Name+
                                                  '\nUserName : '+ u.Username +                                      
                                                  '\n\nThank You.'+
                                                  '\n\nCHAMPIONS TEAM.');
                            Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage> {mail};
                                Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
                            if (results[0].success) {
                                System.debug('The email was sent successfully.');
                            } else {
                                System.debug('The email failed to send: '
                                             + results[0].errors[0].message);
                            }
                            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Email already exist with same subdivision in Contact'));                        }                              
                    }                                              
                }
            }
        }
        else if(ld.size() >= 1){
            System.debug('Inside Lead Loop');
            for(Lead leads : ld){
                //System.debug('Inside LeadActivity Loop');
                for(ActivityHistory activityhis : leads.ActivityHistories){
                    activityList.add(activityhis);
                }
                //System.debug('Activity Size ======>'+activityList.size());
                if(activityList.size() <= 0){
                    //System.debug('Lead Inside Activity List');
                    insert contact;
                    PageReference ContactDuplication = new PageReference('/' + accId);
                    ContactDuplication.setRedirect(true);
                    return ContactDuplication;
                }else{
                    for(ActivityHistory activityhis : leads.ActivityHistories){
                        //System.debug('Lead ActivityHistory LastModifiedDate ====> '+activityhis.LastModifiedDate);
                        activityLastDate = activityhis.LastModifiedDate + 30;
                        //System.debug('Lead activityLastDate  ====> '+activityLastDate);
                        if(activityLastDate > System.now()){
                            User u = [select id,Name,username,email from User where id =: userInfo.getUserId()];
                            Messaging.SingleEmailMessage mail= new Messaging.SingleEmailMessage();
                            string [] toAdd = new string[]{'Sossfdc@cirrologix.com'};
                                mail.setToAddresses(toAdd);
                            mail.setSubject('Lead Duplication');                            
                            mail.setPlainTextBody('Dear Admin'+
                                                  '\n\nBelow User trying to create duplicate email '+contact.email+
                                                  '\n\nName:' + u.Name+
                                                  '\nUserName : '+ u.Username +                                      
                                                  '\n\nThank You.'+
                                                  '\n\nCHAMPIONS TEAM.');
                            Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage> {mail};
                                Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
                            if (results[0].success) {
                                System.debug('The email was sent successfully.');
                            } else {
                                System.debug('The email failed to send: '
                                             + results[0].errors[0].message);
                            }
                            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Email already exist with same subdivision in Lead'));                            
                        }                              
                    }                                              
                }
            }
        }
        else{
            insert contact;
            PageReference ContactDuplication = new PageReference('/' +accId);
            ContactDuplication.setRedirect(true);
            return ContactDuplication;
        }        
        return null;
    }
    
    public PageReference Cancel(){        
        PageReference pageRef = new PageReference('/lightning/o/Contact/list?filterName=Recent'); 
        pageRef.setRedirect(true); 
        return pageRef;          
    }
}