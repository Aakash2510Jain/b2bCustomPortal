public without Sharing class GeneratePasswordForUser {
    public static void afterSignupGeneratePassword(List<User_Portal__c> portalUserList){
       // List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>(); 
        list<User_Portal__c> updatePortaluserlist = new list<User_Portal__c>();
        set<id> userid = new set<id>();
        for(User_Portal__c portalUserRec :portalUserList){
            if(portalUserRec.id !=  null){
                userid.add(portalUserRec.id);
            }
        }
        portalUserList = [Select id,First_Name__c,Last_Name__c,User_Name__c,Phone__c,Password__c from User_Portal__c where id =:userid ];
        string username = portalUserList[0].User_Name__c;
        // string recid =  portalUserList.id;
        string firstName =  portalUserList[0].First_Name__c;
        string password ;
        system.debug('portalUserList===>'+portalUserList);
        if(!portalUserList.isEmpty()){
            for(User_Portal__c userPortal :portalUserList){
                if(userPortal.First_Name__c != null){
                    password = userPortal.First_Name__c.substring(0,4).toUpperCase()+'@123' ;
                }
                
                updatePortaluserlist.add(userPortal);
                if(username != null &&  firstName != null && password != null ){
                    EmailTemplate emailTemp = [SELECT Id, Name,DeveloperName, Subject, Body, HtmlValue FROM EmailTemplate Where Name ='Create New User'];
                    String subject = emailTemp.Subject;
                    String hBody = emailTemp.Body;
                    string HtmlBody=emailTemp.HtmlValue;
                    
                     htmlBody = htmlBody.replace('{User_Portal__c.First_Name__c}',firstName);
                    htmlBody = htmlBody.replace('{User_Portal__c.User_Name__c}',username);
                    htmlBody = htmlBody.replace('{User_Portal__c.Password__c}',password);
                     System.debug('htmlBody == >'+htmlBody);
                    hBody = hBody.replace('{User_Portal__c.First_Name__c}',firstName);
                    hBody = hBody.replace('{User_Portal__c.User_Name__c}',firstName);
                    hBody = hBody.replace('{User_Portal__c.Password__c}',password); 
                    
                    
                    List<String> recipients = new List<String>();
                    
                    recipients.add(portalUserList[0].User_Name__c);                            
                    System.debug('recipients == >'+recipients);
                    List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
                    
                    Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();  
                    email.setToAddresses(recipients);
                    email.setSubject(subject);
                    email.setHtmlBody(htmlBody);
                    email.setPlainTextBody(hBody);
                     mails.add(email);
                    
                     Messaging.SendEmailResult[] sendResults = Messaging.sendEmail(mails);
                    
                    
                     for (Messaging.SendEmailResult result : sendResults) {
                        if (result.isSuccess()) {
                            System.debug('Email sent successfully.');
                        } else {
                            System.debug('Email sending failed. Error: ' + result.getErrors()[0].getMessage());
                            for(Messaging.SendEmailError err : result.getErrors()) {
                                System.debug('The following error has occurred.');                    
                                System.debug(err.getStatusCode() + ': ' + err.getMessage());
                                System.debug('fields that affected this error: ' + err.getFields());
                            }
                        }
                     }
                    
                }
            }
            
        }
    }
    
    public static void beforeSignupGeneratePassword(List<User_Portal__c> portalUserList){
        if(!portalUserList.isempty()){
            for(User_Portal__c userportal : portalUserList){
                if(userportal.First_Name__c != null){
                    userportal.Password__c = userportal.First_Name__c.substring(0,4).toUpperCase()+'@123' ;
                }
            }
        }
    }
    
    
}