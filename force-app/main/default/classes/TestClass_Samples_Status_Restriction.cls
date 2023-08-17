@isTest
private class TestClass_Samples_Status_Restriction {   
    
    //Test code for Samples_Restriction Class
    
    static testMethod void myUnitTest_SampleRestriction(){
       /* User u1= [select id,Profile.Name from User where Id =: UserInfo.getUserId() limit 1];
        Opportunity opty2= new Opportunity ();
        opty2.StageName = 'Warm';
        opty2.CloseDate=System.today();
        opty2.Ownerid=u1.id;
        opty2.name='optytest';
        opty2.Opplead_id__c='testid';
        opty2.Uploaded_By__c='frankb';
        opty2.Division__c='Gladiators';
        opty2.Emt__c='idh';
        insert opty2;
        Lead l1= new Lead();
        l1.Company='1';
        l1.Ownerid=u1.id;
        l1.lastname='testclass';
        l1.Status='Working';
        l1.CreatedDate=System.today();
        l1.User_Name__c='frankb';
        l1.Division_Name__c='Gladiators';
        
        insert l1;
        
        Sample_Request__c SR= new Sample_Request__c();
        SR.Name='TEST';
        SR.Sample_Type__c='Custom Business List Sample';
        SR.Status__c='New';
        SR.Sample_Type_Description__c='TEST DESCRIPTION';
        SR.Lead__c=l1.Id;
        sr.Opportunity__c=opty2.id;
        insert SR;
    
        Sample_Request__c SR1= new Sample_Request__c();
        SR1.Name='TEST';
        SR1.Sample_Type__c='Custom Business List Sample';
        SR1.Sample_Type_Description__c='TEST DESCRIPTION';
        SR1.Status__c='New';
        insert SR1;
        SR1.Opportunity__c=opty2.Id;
        SR1.Lead__c=l1.Id;
        update SR1;
        Test.startTest();

        test.stopTest();
       
        */
        Profile p = [SELECT Id FROM Profile WHERE Name='Technologylist_Helpdesk' LIMIT 1];
        Account act = new Account(Name='Accenture');
        insert act;
        Contact con = new Contact(LastName='Meiyang Chang');
        insert con;
       
         User u = new User(Alias = 'standt', Email='sossfdc@cirrologix.com', 
        EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
        IsActive=true,Division='Rainmakers',Is_Account_Manager__c=true,
        LocaleSidKey='en_US', ProfileId = p.Id,Rating__c='A+',Mapped_UserID_Name__c='Test User(Rainmakers)', 
        TimeZoneSidKey='America/Los_Angeles', UserName='sossfdceeeee@cirrologix.com',Date_of_Joining__c=System.Today().addDays(1));
            
        
        insert u;
       
            Opportunity opp = new Opportunity(Client_Name__c = con.Id,Client_Company__c=act.id,Lead_Source__c='Lead Blog',Name=act.id,
                                            Amount=120000,Primary_Service_Name__c='CRM',Division__c='Rainmakers',StageName='Deal',Closedate=System.Today().addDays(1),EMT__c='IDH'
                                            );
         
        insert opp;
        
    }
}