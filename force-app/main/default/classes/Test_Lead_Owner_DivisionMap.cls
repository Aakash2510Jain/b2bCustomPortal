@IsTest 

private class Test_Lead_Owner_DivisionMap{    
    static testmethod void DivisionMap() 
    {
        User u1= [select id from User where alias='steam' limit 1];
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        User u2 = new User(Alias = 'suser', Email='vinay.k@cirrologix.com', 
                                EmailEncodingKey='UTF-8', LastName='sampleuser', LanguageLocaleKey='en_US', 
                                            LocaleSidKey='en_US',  ProfileId = p.Id, 
                                                    TimeZoneSidKey='America/Los_Angeles', UserName='sampleuser@testsample.com', Division='IT Data Group');  
        insert u2;                                              
        system.debug('$$$$'+u2);
        test.startTest();
        Lead l1= new Lead();
       l1.Country = 'India';
        l1.Title='title';
        l1.Email='kartik147@gmailes.com';
        l1.FirstName='firstname';
        l1.LastName='testing';
        l1.Website='www.sign.com';
        l1.LeadSource='Other';
        l1.Lead_AssignedTo__c= 'Alex Cooper (Rainmakers)';
        l1.Primary_Service_Name__c='InfocheckPoint';
        l1.LinkedIn_URL__c='srivarsha379/linkedin.com';
        l1.Users__c='sraj';
        l1.IgnoreTriggerCheck__c=true;
        l1.Team_Identification__c='Web team';
        l1.Company='1';
        l1.Ownerid=u1.id;
        l1.lastname='testclass';
        l1.Division_Name__c='Spartans';
        l1.Sub_Division_Name__c='IT Data Group';
        l1.Status='Working';
        insert l1;
    
       l1.Ownerid=u2.id;
 test.stopTest();  
      //  update l1;
       
     } 
        }