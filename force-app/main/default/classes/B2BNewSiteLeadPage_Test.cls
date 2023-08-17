/**
 * Author : Jarvis Business
 * Date : 14th Aug 2022.
 * Functionality : Site's Lead Creation New Form
 */
@isTest (seealldata=true)
private class B2BNewSiteLeadPage_Test {

    static testMethod void B2BNewSiteLeadPage_TestMethod() {
      
       Profile p = [SELECT Id FROM Profile WHERE Name='Second Floor Work.com']; 
    User u = new User(Alias = 'standt', Email='sossfdc@jarvisbusiness.io', 
        EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
        IsActive=true,Division='Rainmakers',Is_Account_Manager__c=true,
        LocaleSidKey='en_US', ProfileId = p.Id,Rating__c='A+',Mapped_UserID_Name__c='Test User (Rainmakers)', 
        TimeZoneSidKey='America/Los_Angeles', UserName='sossfdce@jarvisbusiness.io');
    insert u;
    
    User userInstant = new User(Alias = 'standt', Email='sossfdc@jarvisbusiness.io', 
        EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
        IsActive=true,Division='Rainmakers',
        LocaleSidKey='en_US', ProfileId = p.Id,Mapped_UserID_Name__c='Test User (Rainmakers)', 
        TimeZoneSidKey='America/Los_Angeles', UserName='standardVarsha@testorg.com');
    insert userInstant;
  
   /* User u2 = [select Id,Mapped_UserID_Name__c,LastLoginDate,Division,Email from User 
          where  Division='Winners' and LastLoginDate != null 
          and isActive=true and  Rating__c!=null and Is_Account_Manager__c=false order by LastLoginDate desc limit 1];  */  
        User u2 = new User(Alias = 'standt', Email='sossfdc@jarvisbusiness.io', 
        EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
        IsActive=true,Division='Rainmakers',Is_Account_Manager__c=true,
        LocaleSidKey='en_US', ProfileId = p.Id,Rating__c='A+',Mapped_UserID_Name__c='Test User (Rainmakers)', 
        TimeZoneSidKey='America/Los_Angeles', UserName='sossfdce234@jarvisbusiness.io');
    insert u2;
    system.runas(u){ 
    Config__c conList = new Config__c();
    conList.Blacklisted_Domains__c='ya.com,in.com';
    conList.Value__c='istrategic.com,dell.com,span.com';
    conList.Key__c='Blacklisted';
    insert conList;    
    }
    //System.debug('USER SELECTED : '+u2);    
    
    Account instantAccount= new Account(Name='TestCase');
    instantAccount.OwnerId=u.id;
    insert instantAccount;
    instantAccount.Name='TestLEADIN';
    update instantAccount;  
    instantAccount.Division__c='RainMakers';
    update instantAccount;
    
    Date accountDays = System.today() - 10;
    Account dupAccount = [Select Id, Name from Account where LastModifiedDate >= :accountDays limit 1];
    
    Contact instantContact = new Contact(LastName='testUser');
    instantContact.OwnerId=u.id;
    instantContact.AccountId=instantAccount.id;
    
    instantContact.Email='praveen.r@istrategicloud.com';
    insert instantContact;
    
    
    Contact instantCont = new Contact(LastName='testUser');
    instantCont.OwnerId=u.id;
    instantCont.AccountId=instantAccount.id;
    instantContact.Email='karthikneo7@gmail.com';
    insert instantCont;
    
    Contact dupContact = [Select Id, Name from Contact where LastModifiedDate >= :accountDays limit 1];
     
    Opportunity opp =new Opportunity(); 
    opp.Name='sample12';
        opp.AccountId=instantAccount.id;
        opp.Lead_Source__c='Approved Index';
        opp.Primary_Service_Name__c='Health Care';
        opp.Division__c='Rainmakers';
        opp.StageName='Confirmed Criteria (5%)';
        opp.Sample_To_Deal__c='other';
        opp.Uploaded_By__c='test12';
        opp.Employee_Real_Name__c = 'George M';
        opp.ForecastCategoryName='pipeline';
        opp.Amount=5000;
        opp.CloseDate=date.today()+8;
        opp.Special_Instruction__c='Abcd';
      //opp.Team_Uploaded_By__c='Winners'; 
        insert opp;
    
    Spam_Email__c spamEmail = new Spam_Email__c();
    spamEmail.Name='kevi21.maxim@loggis.com';
    insert spamEmail;
    
    Spam_Domain__c spamDomain= new Spam_Domain__c();
    spamDomain.Name='sample';
    insert spamDomain;
    Spam_Domain__c spamDomain1= new Spam_Domain__c();
    spamDomain1.name = 'loggis.com';
    insert spamDomain1;
    
    system.debug('lastmodifieddate'+instantAccount);
    Spam_Email__c spamemaillist = [select Name from Spam_Email__c limit 1] ;
    Spam_Domain__c spamdomainlist = [select Name from Spam_Domain__c limit 1] ;     
    
    LeadFormUsers__c lef = new LeadFormUsers__c();      
    lef.UserName__c = 'pruthvi.kr@istrategicloud.com';
    lef.Password__c = 'qwerty';
    lef.Name = 'demo1';
    lef.Division__c = 'Rainmakers';
    lef.EMail_ID__c = 'demo@scs.com';
    insert lef;
      system.debug('_______________'+lef.id);
    
    LeadFormUsers__c lef1 = new LeadFormUsers__c();      
    lef1.UserName__c = 'pruthvi.kr@istrategicloud.com';
    lef1.Password__c = 'qwerty';
    lef1.Name = 'demo2';
    lef1.Division__c = 'Winners';
    lef1.EMail_ID__c = 'demo1@scs.com';
    insert lef1;  
    
    Session__c ss1=new Session__c();
        ss1.Session_For_LeadFormUsers__c=lef1.id;
        ss1.SessionId__c='38856717452365';   
        insert ss1;

    Session__c ss=new Session__c();
        ss.Session_For_LeadFormUsers__c=lef.id;
        ss.SessionId__c='38856717452355';   
        insert ss;  
        
        LeadFormUsers__c le1 = new LeadFormUsers__c();      
    le1.UserName__c = 'pruthvi.kr@istrategicloud.com';
    le1.Password__c = 'qwerty';
    le1.Name = 'demo2';
    le1.Division__c = 'Stallions';
    le1.EMail_ID__c = 'demo1@scs.com';
    insert le1;  
    
    Session__c s1=new Session__c();
        s1.Session_For_LeadFormUsers__c=le1.id;
        s1.SessionId__c='38856717452365';   
        insert s1;
        
        WebFormLeadController__c WFL = new WebFormLeadController__c();
        WFL.Account_Validity__c=90;
            WFL.Lead_Validity__c=30;
            WFL.NoActivityLeads__c=1000;
            WFL.NoLoginTime__c=7200;
            WFL.Name='Lead';
            
        test.startTest();
       ApexPages.StandardController std1=new ApexPages.StandardController(lef);       
    String LogSess=String.valueOf(Math.random()).substring(2,16); 
    ApexPages.currentPage().getParameters().put('Id',lef.id);
    ApexPages.currentPage().getParameters().Put('sessionId',ss1.SessionId__c);
    //ApexPages.currentPage().getParameters().put('div','Stallions');
    ApexPages.currentPage().getParameters().put('UName','Jayabalan');
    ApexPages.currentPage().getParameters().put('Emailid','demo2@scs.com');
    ApexPages.currentPage().getParameters().put('sessionIdLog',null);
    B2BNewSiteLeadPage_Con sosTest1 = new B2BNewSiteLeadPage_Con();
    B2BNewSiteLeadPage_Con sosTesting123  = new B2BNewSiteLeadPage_Con(std1);
    sostest1.setdomainname('Michelle');
      sosTest1.LeadformUserID=lef.Id;
      sosTest1.SessionID=ss.SessionId__c;
      sosTest1.FinalUName1=lef.UserName__c;
      sosTest1.FinaldivisionUser = lef.Division__c;
      sosTest1.FinalEmail = lef.EMail_ID__c;
      sosTest1.theHiddenOut = True;
      sosTest1.theHiddenInput = True;
      sosTest1.firstname = 'Test Name';
      sosTest1.UserName = 'TESTUSER';
      sosTest1.Password = 'TestPassword';
      sosTest1.msgValid = 'Test';
      sosTest1.emailToValidate = 'pruthvi.kr@istrategicloud.com';
      sosTest1.divisionUser='Winners';
    sosTest1.Emailid='demo@scs.com';
    sosTest1.UName1='Jayabalan';
    //sosTest1.FinaldivisionUser = 'Rainmakers';
    sosTest1.FinalUName1 = 'Jayabalan';
    sosTest1.FinalEmail ='demo@scs.com';  
    //sosTest1.divisionUser='Gladiators';
    sosTest1.getDomainlist();
    //<-- Praveen Code -->
    //sosTesting123.FinalDivision = null;
    sosTesting123.getDomainlist();
    //sosTesting123.FinalTeam = null;
    sosTesting123.getTeamList();
    sosTesting123.divisionUser = null;
    sosTesting123.init();
    
    lead newlea123=new lead();
    newlea123.OwnerId = u.id;
        //newlea123.Email='kevi.maxim@istrategicloud.com';
        newlea123.Division_Name__c='Rainmakers';
        newlea123.LeadSource='Approved Index';
        newlea123.Level__c='C-Level';
        newlea123.Employee_Size__c='0 - 50';
        newlea123.MQL_Marketing_Qualified_Lead__c='Yes';
        newlea123.Country = 'India';
        newlea123.State = 'KA';
        newlea123.Phone = '123456789';
        newlea123.Status='Followup';
        newlea123.Company = 'SOS12';
        newlea123.FirstName='TestK';
        newlea123.LastName='TestSunny';
        newlea123.Primary_Service_Name__c='InfocheckPoint';
        newlea123.Industry='Professional';
        newlea123.LeadSource='Other';
        newlea123.LinkedIn_URL__c='karthik34/Linkedin.com';
    newlea123.Lead_AssignedTo__c='Test User (Rainmakers)';
        newlea123.User_Name__c='Demo test'; 
        newlea123.Sub_Division_Name__c='Health Care Data Group'; 
        newlea123.Team_Identification__c=null;
        newlea123.Website='sign.com';     
    sosTesting123.leadRecord=newlea123;
    sosTesting123.save();
    System.debug('----------------------------------------1');
    //lead newlea123=new lead();
    newlea123.OwnerId = u.id;
        newlea123.Email='kevi.maxim@istrategicloud.com';
        newlea123.Division_Name__c='Rainmakers';
        newlea123.LeadSource='Approved Index';
        newlea123.Level__c='C-Level';
        newlea123.Employee_Size__c='0 - 50';
        newlea123.MQL_Marketing_Qualified_Lead__c='Yes';
        newlea123.Country = 'India';
        newlea123.State = 'KA';
        newlea123.Phone = '123456789';
        newlea123.Status='Followup';
        newlea123.Company = 'SOS12';
        newlea123.FirstName='TestK';
        newlea123.LastName='TestSunny';
        newlea123.Primary_Service_Name__c='InfocheckPoint';
        newlea123.Industry='Professional';
        newlea123.LeadSource='Other';
        newlea123.LinkedIn_URL__c='karthik34/Linkedin.com';
        newlea123.Lead_AssignedTo__c= NULL;
        newlea123.User_Name__c='Demo test'; 
        newlea123.Sub_Division_Name__c='Health Care Data Group'; 
        newlea123.Team_Identification__c=null;
        newlea123.Website='www.sign.com';     
        newlea123.title='manager';
    sosTesting123.leadRecord=newlea123;
    sosTesting123.strUse = null;
    sosTesting123.save();
    sosTesting123.strUse = 'test';
    sosTesting123.save();
    System.debug('----------------------------------------2');
    //sosTesting123.isSpamEmail = false;
    //sosTesting123.isSpamList = false;
    sosTesting123.save();
    System.debug('----------------------------------------3');
    
    
    //<-- end of Ravi -->
    sosTest1.getdomainname();
    sosTest1.getTeamList();
    sosTest1.ValidDomain();
    sosTest1.init();
    sosTest1.saveRecord();
    sosTest1.closePopup();
    sosTest1.cancelRecord();
    
    lead newlea=new lead();
    newlea.OwnerId = u.id;
        newlea.Email='kevi.maxim@istrategicloud.com';
        newlea.Division_Name__c='Rainmakers';
        newlea.LeadSource='Approved Index';
        newlea.Level__c='C-Level';
        newlea.Employee_Size__c='0 - 50';
        newlea.MQL_Marketing_Qualified_Lead__c='Yes';
        newlea.Country = 'India';
        newlea.State = 'KA';
        newlea.Phone = '123456789';
        newlea.Status='Followup';
        newlea.Company = 'SOS12';
        newlea.FirstName='TestK';
        newlea.LastName='TestSunny';
        newlea.Primary_Service_Name__c='InfocheckPoint';
        newlea.Industry='Professional';
        newlea.LeadSource='Other';
        newlea.LinkedIn_URL__c='karthik34/Linkedin.com';
        newlea.Lead_AssignedTo__c=null;
        newlea.User_Name__c='Demo test'; 
        newlea.Sub_Division_Name__c='Health Care Data Group'; 
        newlea.Team_Identification__c=null;
        newlea.Website='sign.com';     
    sostest1.leadRecord=newlea;
    sostest1.getDomainlist();
    sostest1.getTeamList();
    sostest1.save();
    newlea.Team_Identification__c='Rainmakers';
    newlea.Company = null;
    newlea.Email='kevi1.maxim@istrategicloud.com';
    sostest1.leadRecord=newlea;
    sostest1.getDomainlist();
    sostest1.getTeamList();
    sostest1.save();
    newlea.Team_Identification__c='Rainmakers';
    newlea.Company = 'ABC';
    newlea.Email=null;
    sostest1.leadRecord=newlea;
    sostest1.getDomainlist();
    sostest1.getTeamList();
    sostest1.save();
    newlea.Company = 'SOS12';
    newlea.Email = null;
    newlea.Email='kevi2.maxim@istrategicloud.com';
    sostest1.leadRecord=newlea;
    sostest1.getDomainlist();
    sostest1.getTeamList();
    sostest1.save();
    newlea.Website='si@@#.com';  
    newlea.Email='kevi3.maxim@istrategicloud.com';
    sostest1.leadRecord=newlea;
    sostest1.getDomainlist();
    sostest1.getTeamList();
    sostest1.save();
    newlea.Company = 'SO$$S12';    
    newlea.Email='kevi4.maxim@istrategicloud.com';
    sostest1.leadRecord=newlea;
    sostest1.getDomainlist();
    sostest1.getTeamList();
    sostest1.save();
    newlea.Email='kevi5.maxim@eparivarthan.com';
    newlea.FirstName = null;    
    sostest1.leadRecord=newlea;
    sostest1.getDomainlist();
    sostest1.getTeamList();
    sostest1.save();    
    newlea.FirstName='TestK';
    newlea.LastName = null;    
    newlea.Email='kevi6.maxim@istrategicloud.com';
    sostest1.leadRecord=newlea;
    sostest1.getDomainlist();
    sostest1.getTeamList();
    sostest1.save();
    newlea.FirstName='Te^^##K';    
    newlea.Email='kevi7.maxim@istrategicloud.com';    
    sostest1.leadRecord=newlea;
    sostest1.getDomainlist();
    sostest1.getTeamList();  
    newlea.Title='T##K';        
    sostest1.leadRecord=newlea;
    sostest1.getDomainlist();
    sostest1.getTeamList();
    sostest1.save();
    newlea.LastName='TestSunny';
    newlea.Email='kevi8.maxim@istrategicloud.com';
    newlea.Division_Name__c = null;    
    sostest1.leadRecord=newlea;
    sostest1.getDomainlist();
    sostest1.getTeamList();
    sostest1.save();
    newlea.Division_Name__c='Winners';
    newlea.Email='kevi9.maxim@istrategicloud.com';
    newlea.Sub_Division_Name__c = null;    
    sostest1.leadRecord=newlea;
    sostest1.getDomainlist();
    sostest1.getTeamList();
    sostest1.save();
    newlea.Sub_Division_Name__c='Health Care Data Group';
    newlea.Email='kevi11.maxim@istrategicloud.com';
    newlea.Lead_AssignedTo__c = null;    
    sostest1.leadRecord=newlea;
    sostest1.getDomainlist();
    sostest1.getTeamList();
    sostest1.save();      
    newlea.Lead_AssignedTo__c='Test User (Rainmakers)1';
    newlea.Email='kevi12.maxim@istrategicloud.com';
    newlea.Primary_Service_Name__c = null;    
    sostest1.leadRecord=newlea;
    sostest1.getDomainlist();
    sostest1.getTeamList();
    sostest1.save();  
    newlea.Lead_AssignedTo__c='Test User (Rainmakers)';
    newlea.Email='kevi13.maxim@istrategicloud.com';
    newlea.Primary_Service_Name__c = null;    
    sostest1.leadRecord=newlea;
    sostest1.getDomainlist();
    sostest1.getTeamList();
    sostest1.save();  
    newlea.Primary_Service_Name__c='InfocheckPoint';
    newlea.Email='kevi14.maxim@istrategicloud.com';
    newlea.Industry = null;  
    sostest1.leadRecord=newlea;
    sostest1.getDomainlist();
    sostest1.getTeamList();
    sostest1.save();
    newlea.Industry='Professional';
    newlea.Email='kevi15.maxim@istrategicloud.com';
    newlea.LeadSource = null;  
    newlea.Level__c=null;
    newlea.Employee_Size__c=null;
    newlea.MQL_Marketing_Qualified_Lead__c=null;
    sostest1.leadRecord=newlea;
    sostest1.getDomainlist();
    sostest1.getTeamList();
    sostest1.save();
    newlea.LeadSource='Approved Index';
    newlea.Level__c='C-Level';
    newlea.Employee_Size__c='0 - 50';
    newlea.MQL_Marketing_Qualified_Lead__c='Yes';
    newlea.Email='kevi16.maxim@istrategicloud.com';
    newlea.Country = null;
    sostest1.leadRecord=newlea;
    sostest1.getDomainlist();
    sostest1.getTeamList();
    sostest1.save();
    newlea.Country = 'India';
    newlea.Email='kevi17.maxim@istrategicloud.com';
    newlea.State = null;
    sostest1.leadRecord=newlea;
    sostest1.getDomainlist();
    sostest1.getTeamList();
    sostest1.save();
    newlea.State = 'KA';
    newlea.Email='kevi18.maxim@istrategicloud.com';
    newlea.LinkedIn_URL__c= null;  
    sostest1.leadRecord=newlea;
    sostest1.getDomainlist();
    sostest1.getTeamList();
    sostest1.save();
    newlea.LinkedIn_URL__c='karthik34/Linkedin.com';
    newlea.Email='kevi19.maxim@loggis.com';
    newlea.Phone = null;
    sostest1.leadRecord=newlea;
    sostest1.getDomainlist();
    sostest1.getTeamList();
    sostest1.save();
    
    newlea.FirstName='asffewe';
    newlea.LastName='hhsajsd';
    newlea.title = 'sales';
    newlea.Phone = '123456789';  
    newlea.company ='ABC';
    newlea.Website='www.website.com';
    newlea.Email='kevi212.maxim@log.com';
    
    /*newlea.Team_Identification__c = 'None';
    newlea.Company='!@#';*/  
    
    sostest1.leadRecord=newlea;
    sostest1.getDomainlist();
    sostest1.getTeamList();
    sostest1.init();
    sostest1.setdomainname('loggis');
    sostest1.getdomainname();
    sostest1.ValidDomain();
    sostest1.getDomainlist();
    sostest1.getTeamList();
    sostest1.closePopup();
       sostest1.displayPopup=true;
       sostest1.showPopup();
       sostest1.saveRecord();
    
    // Insert for NoActivity Leads
    
   /* Lead leadReclet16 = new Lead();
    leadReclet16.Company = 'TestLEADIN@';
    leadReclet16.OwnerId = u.id;
        leadReclet16.Country = 'India';
        leadReclet16.Title='title@';
        leadReclet16.Email=spamemaillist.Name;
        leadReclet16.FirstName='firstname123';
        leadReclet16.LastName='testing123';
        leadReclet16.Website='sign.com';
        leadReclet16.LeadSource='Other';
        leadReclet16.Level__c='C-Level';
        leadReclet16.Employee_Size__c='0 - 50';
        leadReclet16.MQL_Marketing_Qualified_Lead__c='Yes';
        leadReclet16.Lead_AssignedTo__c='Test User (Rainmakers)';
        leadReclet16.Primary_Service_Name__c='InfocheckPoint';
        leadReclet16.Sub_Division_Name__c='Health Care Data Group';
        leadReclet16.Division_Name__c='Rainmakers';
        leadReclet16.Status='Yet to Initiate';
        leadReclet16.LinkedIn_URL__c='srivarsha379/linkedin.com';
        leadReclet16.Users__c='sraj';
        leadReclet16.IgnoreTriggerCheck__c=true;
        leadReclet16.Account_Name__c=instantAccount.id;
        leadReclet16.Team_Identification__c='Rainmakers';
       leadReclet16.Users__c='Francis';  
       insert leadReclet16;
       Lead leadReclet17 = new Lead();
       leadReclet17.OwnerId = u.id;
    leadReclet17.Company = 'TestLEADIN@';
        leadReclet17.Country = 'India';
        leadReclet17.Title='title@';
        leadReclet17.Email=spamemaillist.Name;
        leadReclet17.FirstName='firstname123';
        leadReclet17.LastName='testing123';
        leadReclet17.Website='sign.com';
        leadReclet17.LeadSource='Other';
        newlea123.Level__c='C-Level';
        newlea123.Employee_Size__c='0 - 50';
        newlea123.MQL_Marketing_Qualified_Lead__c='Yes';
        leadReclet17.Lead_AssignedTo__c='Test User (Rainmakers)';
        leadReclet17.Primary_Service_Name__c='InfocheckPoint';
        leadReclet17.Sub_Division_Name__c='Health Care Data Group';
        leadReclet17.Division_Name__c='Rainmakers';
        leadReclet17.Status='Yet to Initiate';
        leadReclet17.LinkedIn_URL__c='srivarsha379/linkedin.com';
        leadReclet17.Users__c='sraj';
        leadReclet17.IgnoreTriggerCheck__c=true;
        leadReclet17.Account_Name__c=instantAccount.id;
        leadReclet17.Team_Identification__c='Rainmakers';
       leadReclet17.Users__c='Francis';  
       insert leadReclet17;*/
       
         Lead objLead = new Lead (LastName = 'Test data', Email = 'test@gmail.com', mobilephone = '+1234567890', Company = 'Test company');
    insert objLead;
       Test.StopTest();
       newlea.FirstName='as!@#$bc23';
    newlea.LastName='as!@#$bc23';
    newlea.title = '123@!#123';
    newlea.website='123!@#.com';
    newlea.Phone = '123456789';  
    newlea.Email='kevi21.maxim@loggis.com';
    //newlea.Team_Identification__c = 'None';
    newlea.Company='!@#';  
    sostest1.leadRecord=newlea;
    sostest1.getDomainlist();
    sostest1.getTeamList();
    sostest1.init();
    sostest1.setdomainname('loggis');
    sostest1.getdomainname();
    sostest1.ValidDomain();
    sostest1.getDomainlist();
    sostest1.getTeamList();
    sostest1.closePopup();
       sostest1.displayPopup=true;
       sostest1.showPopup();
       sostest1.saveRecord();
       
       
       ///////////////////////////////
       newlea.Lead_AssignedTo__c = u2.Mapped_UserID_Name__c;
       newlea.FirstName='Check';
    newlea.LastName='LastName';
    newlea.title = 'director';
    newlea.website='www.sos.com';
    newlea.Phone = '123456789';  
    newlea.Email='kevi21.maxim123@sos.com';
    newlea.Company='SOS';  
    sostest1.leadRecord=newlea;
       sostest1.saveRecord();
       
       newlea.email = 'abc@sample.com';
       sostest1.leadRecord = newlea;
       sostest1.saveRecord();
       
       

    newlea.Email='kevi23.maxim@in.com';
    //newlea.Phone = null;
    sostest1.leadRecord=newlea;
    sostest1.getDomainlist();
    sostest1.getTeamList();
    sostest1.save();

    newlea.Lead_AssignedTo__c = 'test assignee';  
       newlea.Email='kevi22.maxim@istrategicloud.com';
       sostest1.strUse='None';
       sostest1.leadRecord=newlea;
    sostest1.getDomainlist();
    sostest1.getTeamList();
    sostest1.save();   
    
    //newlea.Lead_AssignedTo__c = null;
       newlea.Email='kevi24.maxim@ya.com';
       sostest1.strUse='None';
       sostest1.leadRecord=newlea;
    sostest1.getDomainlist();
    sostest1.getTeamList();
    sostest1.save();    
    system.debug('#####INSERTED LEAD####'+newlea);
       //insert newlea;
    
    lead newlea1=new lead();
    newlea1.OwnerId = u.id;
        newlea1.Email='maxim@istrategicloud.com';
        newlea1.Division_Name__c='Rainmakers';
        newlea1.LeadSource='Approved Index';
        newlea1.Level__c='C-Level';
        newlea1.Employee_Size__c='0 - 50';
        newlea1.MQL_Marketing_Qualified_Lead__c='Yes';
        newlea1.Country = 'India';
        newlea1.State = 'KA';
        newlea1.Phone = '123456789';
        newlea1.Status='Followup';
        newlea1.Company = 'SOS12';
        newlea1.FirstName='TestK';
        newlea1.LastName='TestSunny';
        newlea1.Primary_Service_Name__c='InfocheckPoint';
        newlea1.Industry='Professional';
        newlea1.LeadSource='Other';
        newlea1.LinkedIn_URL__c='karthik34/Linkedin.com';
        newlea1.Lead_AssignedTo__c='max user';
        newlea1.User_Name__c='Demo test'; 
        newlea1.Sub_Division_Name__c='Health Care Data Group'; 
        newlea1.Team_Identification__c=null;
        newlea1.Website='sign.com';    
    
    //Without Session ID
    ApexPages.currentPage().getParameters().put('div','Rainmakers');
    ApexPages.currentPage().getParameters().Put('sessionId',null);
    ApexPages.currentPage().getParameters().put('UName','Jayabalan');
    ApexPages.currentPage().getParameters().put('Emailid','demo2@scs.com');
    ApexPages.currentPage().getParameters().put('sessionIdLog',ss.SessionId__c);
    B2BNewSiteLeadPage_Con sosTest2 = new B2BNewSiteLeadPage_Con();
    sostest2.leadRecord=newlea1;
    sosTest2.saveRecord();
    
    
    ApexPages.currentPage().getParameters().put('div','Stallions');
    ApexPages.currentPage().getParameters().Put('sessionId',null);
    ApexPages.currentPage().getParameters().put('UName','Jayabalan');
    ApexPages.currentPage().getParameters().put('Emailid','demo2@scs.com');
    ApexPages.currentPage().getParameters().put('sessionIdLog',s1.SessionId__c);
    B2BNewSiteLeadPage_Con sosTest3 = new B2BNewSiteLeadPage_Con();
    sosTest3.saveRecord();
    
    
    
    ApexPages.currentPage().getParameters().put('div',null);
    ApexPages.currentPage().getParameters().Put('sessionId',null);
    ApexPages.currentPage().getParameters().put('UName','Jayabalan');
    ApexPages.currentPage().getParameters().put('Emailid','demo2@scs.com');
    ApexPages.currentPage().getParameters().put('sessionIdLog',s1.SessionId__c);
    B2BNewSiteLeadPage_Con sosTest4 = new B2BNewSiteLeadPage_Con();
    sosTest4.saveRecord();
     
     
       
       Task t = new Task();
        t.Status = 'Not Started';
        t.Priority = 'Normal';
        t.Type = 'Scheduled Call Back';            
        t.WhoId = newlea.Id;        
        insert t;
        Task t2 = new Task();
        t2.Status = 'Completed';
        t2.Priority = 'Normal';
        t2.Type = 'Scheduled Call Back';            
        t2.WhoId = newlea.Id;        
        insert t2;
        
    List<Lead> testLead =[Select Id, LeadID__c,Relevant_Partners1__c,Relevant_Partners2__c,
          Top_Customers1__c,Top_Customers2__c,CreatedDate,LastModifiedDate,FirstName,LastName,Company,
          LinkedIn_URL__c,User_Name__c,Twitter_URL__c,Division_Name__c,LinkedIn_Photo_URL__c,Customer_Products_and_Services__c,
          Other_Locations_Branches__c,LastActivityDate,Owner.Name,Owner.Email,
          CRM_Used__c,OwnerId from Lead where LinkedIn_URL__c != '' and Division_Name__c != '' and isConverted =false limit 10];  
      
      
      List<LeadFormUsers__c> logFormUser=[select UserName__c,EMail_ID__c,Name,Password__c,Division__c,Floor__c,
                   Last_Login__c from LeadFormUsers__c limit 1];     
    sostest1.leadRecord=newlea;
       sostest1.save();
       sostest1.doCancel();
       List<User> gmUser  = [Select Id, Name, Email,GM__c,IsGM__c,Division,Mapped_UserID_Name__c from User where isActive=true and isGM__c = true and GM__c!=null];
   Lead newl = testLead[0].clone(false,false,false,false);
        String LeadClashUser = System.Label.LeadClash;
                    List<User> gmUser2  = [Select Id, Name, Email from User where isActive=true and username=:LeadClashUser];
        sostest1.attachNoteAndUpdateLead(testLead[0], newlea, true,gmUser);
       sostest1.attachNoteAndUpdateLead(newl, newlea, false,gmUser2);           
    sostest1.attachNoteAndUpdateLead2(testLead[0], newlea, true,gmUser);
       sostest1.attachNoteAndUpdateLead2(newl, newlea, false,gmUser2);  
    
    B2BNewSiteLeadPage_Con sostest = new B2BNewSiteLeadPage_Con();
    sosTest.divisionUser='Rainmakers';
    sosTest.Emailid='demo@scs.com';
    sosTest.UName1='Jayabalan';    
    sostest.FinaldivisionUser = 'Rainmakers';
    sostest.FinalUName1 = 'Jayabalan';
    sostest.FinalEmail ='demo@scs.com';    
    sostest.init();
    sostest.setdomainname('Alex');
    sostest.getdomainname();
    sostest.ValidDomain();
    sostest.getDomainlist();
    sostest.getTeamList();
    sosTest.closePopup();
       sosTest.displayPopup=true;
       sosTest.showPopup();
       sosTest.saveRecord();       
       Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
      sosTest.Att1.body=bodyBlob;
      sosTest.Att2.body=bodyBlob;
      sosTest.Att3.body=bodyBlob;
      sosTest.Att4.body=bodyBlob;
      sosTest.Att5.body=bodyBlob;       
       
    Lead leadReclet1 = new Lead();
    leadReclet1.Company = 'TestLEADIN@';
        leadReclet1.Country = 'India';
        leadReclet1.Title='title@';
        leadReclet1.Email=spamemaillist.Name;
        leadReclet1.FirstName='firstname123';
        leadReclet1.LastName='testing123';
        leadReclet1.Website='sign.com';
        leadReclet1.LeadSource='Other';
        leadReclet1.Level__c='C-Level';
        leadReclet1.Employee_Size__c='0 - 50';
        leadReclet1.MQL_Marketing_Qualified_Lead__c='Yes';
        leadReclet1.Lead_AssignedTo__c='Test User (Rainmakers)';
        leadReclet1.Primary_Service_Name__c='InfocheckPoint';
        leadReclet1.Sub_Division_Name__c='Health Care Data Group';
        leadReclet1.Division_Name__c='Rainmakers';
        leadReclet1.Status='Yet to Initiate';
        leadReclet1.LinkedIn_URL__c='srivarsha379/linkedin.com';
        leadReclet1.Users__c='sraj';
        leadReclet1.IgnoreTriggerCheck__c=true;
        leadReclet1.Account_Name__c=instantAccount.id;
        leadReclet1.Team_Identification__c='Rainmakers';
       leadReclet1.Users__c='Francis';         
       sosTest.leadRecord=leadReclet1;      
       sosTest.save();     
    
  
       DateTime dt1 = DateTime.valueOf('2011-01-01 2:35:21'); //datetime start variable
        DateTime dt2 = DateTime.valueOf('2013-01-02 3:56:45'); //datetime end variable
       sosTest.getDifferenceInMinutes(dt1,dt2); 

       
        String LogSess3=String.valueOf(Math.random()).substring(2,15); 
    ApexPages.currentPage().getParameters().put('Id',lef.id);
    ApexPages.currentPage().getParameters().Put('sessionId',null);
    ApexPages.currentPage().getParameters().put('div',null);
    ApexPages.currentPage().getParameters().put('UName','Jayabalan');
    ApexPages.currentPage().getParameters().put('Emailid','demo5@scs.com');
    ApexPages.currentPage().getParameters().put('sessionIdLog',LogSess3);
    B2BNewSiteLeadPage_Con sosTestold12 = new B2BNewSiteLeadPage_Con();
        
        
        String LogSess2=String.valueOf(Math.random()).substring(2,16); 
    ApexPages.currentPage().getParameters().put('Id',lef.id);
    ApexPages.currentPage().getParameters().Put('sessionId',null);
    ApexPages.currentPage().getParameters().put('div','Content');
    ApexPages.currentPage().getParameters().put('UName','Jayabalan');
    ApexPages.currentPage().getParameters().put('Emailid','demo5@scs.com');
    ApexPages.currentPage().getParameters().put('sessionIdLog',LogSess2);
    B2BNewSiteLeadPage_Con sosTestold1 = new B2BNewSiteLeadPage_Con();       
       
            
    ApexPages.currentPage().getParameters().put('Id',lef.id);
    ApexPages.currentPage().getParameters().Put('sessionId',null);
    ApexPages.currentPage().getParameters().put('div','Gladiators');
    ApexPages.currentPage().getParameters().put('UName','Jayabalan');
    ApexPages.currentPage().getParameters().put('Emailid','demo5@scs.com');
    ApexPages.currentPage().getParameters().put('sessionIdLog',null);
        B2BNewSiteLeadPage_Con sosTestold = new B2BNewSiteLeadPage_Con();     
        
       
    }
 
     
}