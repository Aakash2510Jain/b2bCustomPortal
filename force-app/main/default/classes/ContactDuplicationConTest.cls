@isTest
public class ContactDuplicationConTest {
    
    static testMethod void testMethod1(){
        lead ld = new lead ();
        ld.LastName = 'Test';
        ld.email = 'testlead@gmail.com';
        ld.Company = 'testcomp';
        ld.Status = 'Followup';
        ld.LeadSource = '360 campaigner';
        ld.Division_Name__c = 'Gladiators';
        ld.Sub_Division_Name__c = 'Cirrologix';        
        insert ld;
        
        
        Account a = new Account();
        a.Name = 'testaccount';
        a.Sub_Division_Name__c = 'Global Business Archives';
        insert a;
        
        contact con = new contact();
        con.LastName = 'testcon';
        con.AccountId = a.id;
        con.Email= 'test@gmail.com';
        insert con;
        
        
        Event e = new Event();
        e.WhoId=con.id;
        e.StartDateTime=system.today();
        e.EndDateTime=system.today()+5;
        insert e;
        
        Task taskCreate = new Task();
        taskCreate.WhoId = con.Id;
        taskCreate.Status = 'Completed';
        taskCreate.Priority = 'Normal';
        taskCreate.Subject = 'Email';
        taskCreate.ActivityDate = system.today();
        insert taskCreate;
        
        /* User u = new User(
Alias = 'testu',
Email = 'test@unitingambition.com',
EmailEncodingKey = 'UTF-8',
LastName = 'Test',
LanguageLocaleKey = 'en_US',
LocaleSidKey = 'en_US',
TimeZoneSidKey='America/Los_Angeles',
UserName='test@unitingambition.com'
);
INSERT u;
}*/
        
        
        apexPages.Currentpage().getParameters().put('Id',con.id);
        apexPages.Currentpage().getParameters().put('accId',a.id);
        Apexpages.StandardController sc = new Apexpages.StandardController(con);
        ContactDuplicationCon ext = new ContactDuplicationCon(sc); 
        
        ext.cancel();
        ext.contactsave();
        ext.getContact();
    }
    static testMethod void testMethod2(){ 
        
        lead ld = new lead ();
        ld.LastName = 'Test123';
        ld.Email = 'test1232345575676579@gmail.com';
        ld.Company = 'testcomp123';
        ld.Status = 'Followup';
        ld.LeadSource = '360 campaigner';
        ld.Division_Name__c = 'Gladiators';
        ld.Sub_Division_Name__c = 'Cirrologix';
        insert ld;
        
        Event e = new Event();
        e.WhoId=ld.id;
        e.StartDateTime=system.today();
        e.EndDateTime=system.today()+5;
        insert e;
        
        Task taskCreate = new Task();
        taskCreate.WhoId = ld.Id;
        taskCreate.Status = 'Completed';
        taskCreate.Priority = 'Normal';
        taskCreate.Subject = 'Dummy subject';
        taskCreate.ActivityDate = system.today();
        insert taskCreate;
        
        Account a = new Account();
        a.Name = 'testaccount';
        a.Sub_Division_Name__c = 'Global Business Archives';
        insert a;        
        
        contact con1 = new contact();
        con1.LastName = 'testcon1';
        con1.AccountId = a.id;
        con1.Email = 'testcon1@gmail.com';        
        insert con1;
        
        apexPages.Currentpage().getParameters().put('Id',con1.id);
        apexPages.Currentpage().getParameters().put('accId',a.id);
        Apexpages.StandardController sc = new Apexpages.StandardController(con1);
        ContactDuplicationCon ext = new ContactDuplicationCon(sc);
        
        ext.cancel();
        ext.contactsave();
        ext.getContact();
        
    }
    static testMethod void testMethod3(){
        lead ld = new lead ();
        ld.LastName = 'Test';
        ld.email = 'test@gmail.com';
        ld.Company = 'testcomp';
        ld.Status = 'Followup';
        ld.LeadSource = '360 campaigner';
        ld.Division_Name__c = 'Gladiators';
        ld.Sub_Division_Name__c = 'Global Business Archives';        
        insert ld;
        
        
        Account a = new Account();
        a.Name = 'testaccount';
        a.Sub_Division_Name__c = 'Global Business Archives';
        insert a;
        
        contact con = new contact();
        con.LastName = 'testcon';
        con.AccountId = a.id;
        con.Email= 'test@gmail.com';
        
        
        
        Event e = new Event();
        e.WhoId=ld.id;
        e.StartDateTime=system.today();
        e.EndDateTime=system.today()+5;
        insert e;
        
        Task taskCreate = new Task();
        taskCreate.WhoId = ld.Id;
        taskCreate.Status = 'Completed';
        taskCreate.Priority = 'Normal';
        taskCreate.Subject = 'Email';
        taskCreate.ActivityDate = system.today();
        insert taskCreate;
        
        /* User u = new User(
Alias = 'testu',
Email = 'test@unitingambition.com',
EmailEncodingKey = 'UTF-8',
LastName = 'Test',
LanguageLocaleKey = 'en_US',
LocaleSidKey = 'en_US',
TimeZoneSidKey='America/Los_Angeles',
UserName='test@unitingambition.com'
);
INSERT u;
}*/
        
        
        apexPages.Currentpage().getParameters().put('Id',con.id);
        apexPages.Currentpage().getParameters().put('accId',a.id);
        Apexpages.StandardController sc = new Apexpages.StandardController(con);
        ContactDuplicationCon ext = new ContactDuplicationCon(sc); 
        
        ext.cancel();
        ext.contactsave();
        ext.getContact();
    }
    static testMethod void testMethod4(){ 
        Account a = new Account();
        a.Name = 'testaccount';
        a.Sub_Division_Name__c = 'Global Business Archives';
        insert a;        
        
        contact con1 = new contact();
        con1.LastName = 'testcon1';
        con1.AccountId = a.id;
        con1.Email = 'testcon1@gmail.com';        
        // insert con1;
        
        apexPages.Currentpage().getParameters().put('Id',con1.id);
        apexPages.Currentpage().getParameters().put('accId',a.id);
        Apexpages.StandardController sc = new Apexpages.StandardController(con1);
        ContactDuplicationCon ext = new ContactDuplicationCon(sc);
        
        ext.cancel();
        ext.contactsave();
        ext.getContact();
        
    }
}