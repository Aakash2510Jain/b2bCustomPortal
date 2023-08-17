/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest (seealldata=true)
private class SOSLeadClashProcessTest {
    static testMethod void myUnitTest() {
        
        Profile p = [SELECT Id FROM Profile WHERE Name='eForce Work.com' LIMIT 1]; 
        User u = new User(Alias = 'standt', Email='ankur.g@istrategicloud.com', 
                EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
                IsActive=true,Division='Rainmakers',Is_Account_Manager__c=true,isGM__c = true,GM__c = 'Test',
                LocaleSidKey='en_US', ProfileId = p.Id,Rating__c='A+',Mapped_UserID_Name__c='Test User (Rainmakers)', 
                TimeZoneSidKey='America/Los_Angeles', UserName='standardtestuser@testoreg.com');
        insert u;
        
        User userInstant = new User(Alias = 'standt', Email='srivarsha.b@istrategicloud.com', 
                EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
                IsActive=true,Division='Rainmakers',
                LocaleSidKey='en_US', ProfileId = p.Id,Mapped_UserID_Name__c='Test User (Rainmakers)', 
                TimeZoneSidKey='America/Los_Angeles', UserName='standardVarsha@testorg.com');
        insert userInstant;
    
        List<User> u2 = [select Id,Mapped_UserID_Name__c,LastLoginDate,Division,Email from User 
                    where  Division='Winners' and LastLoginDate != null 
                    and isActive=true and  Rating__c!=null and Is_Account_Manager__c=false order by LastLoginDate desc limit 1];
        
        //User u3 =[select Id,Mapped_UserID_Name__c,LastLoginDate,Division,Email from User where Mapped_UserID_Name__c !=null and Division='Winners'
            //      and isActive=true limit 1]; 
        
        /*[select Id,Mapped_UserID_Name__c,LastLoginDate,Division,Email from User 
                    where Mapped_UserID_Name__c ='alan_jones' and Division='Rainmakers' and LastLoginDate != null 
                    and isActive=true  order by LastLoginDate desc limit 1];*/
                    
                    
        Config__c conList = new Config__c();
        conList.Blacklisted_Domains__c='ya.com,in.com';
        conList.Value__c='istrategic.com,dell.com,span.com';
        conList.Key__c='Blacklisted';
        insert conList;     
    
        System.debug('USER SELECTED : '+u2);
    //  System.debug('USER SELECTED : '+u3);
        
        Account instantAccount= new Account(Name='TestCase');
        instantAccount.OwnerId=u.id;
        insert instantAccount;
        instantAccount.Name='TestLEADIN';
        update instantAccount;  
        
        Date accountDays = System.today() - 10;
        Account dupAccount = [Select Id, Name from Account where LastModifiedDate >= :accountDays limit 1];
        
        Contact instantContact = new Contact(LastName='testUser');
        instantContact.OwnerId=u.id;
        instantContact.AccountId=instantAccount.id;
        
        instantContact.Email='praveen.r@istrategicloud.com';//'karthik147@hotmail.com';
        insert instantContact;
        
        
        Contact instantCont = new Contact(LastName='testUser');
        instantCont.OwnerId=u.id;
        instantCont.AccountId=instantAccount.id;
        instantContact.Email='karthikneo37@gmail.com';//'karthik147@hotmail.com';
        insert instantCont;
        
        Contact dupContact = [Select Id, Name from Contact where LastModifiedDate >= :accountDays limit 1];
         
        Opportunity opp =new Opportunity(); 
        opp.Name='sample';
        opp.AccountId=instantAccount.id;
        opp.Lead_Source__c='Approved Index';
        opp.Primary_Service_Name__c='Technology List';
        opp.Division__c='Rainmakers';
        opp.StageName='Confirmed Criteria (5%)';
        opp.Sample_To_Deal__c='other';
        opp.Uploaded_By__c='test';
        opp.ForecastCategoryName='pipeline';
        opp.Amount=5000;
        opp.CloseDate=date.today()+8;
      //    opp.Team_Uploaded_By__c='Winners'; 
        insert opp;
        
        Spam_Email__c spamEmail = new Spam_Email__c();
        spamEmail.Name='test@cirrologix.com';
        insert spamEmail;
        
        Spam_Domain__c spamDomain = new Spam_Domain__c();
        spamDomain.Name='spamdomain.com';
        insert spamDomain;
        
        
        system.debug('lastmodifieddate'+instantAccount);
        Spam_Email__c spamemaillist = [select Name from Spam_Email__c limit 1] ;
        Spam_Domain__c spamdomainlist = [select Name from Spam_Domain__c limit 1] ;
         
        //===================Added By Rohit===========================//
        LeadFormUsers__c lef = new LeadFormUsers__c();          
        lef.UserName__c = 'demo@scs.com';
        lef.Name = 'demo';
        lef.Division__c = 'Rainmakers';
        lef.EMail_ID__c = 'demo@scs.com';
        insert lef;
            system.debug('_______________'+lef.id);
        
        LeadFormUsers__c lef1 = new LeadFormUsers__c();         
        lef1.UserName__c = 'demo1@scs.com';
        lef1.Name = 'demo';
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
        
        ApexPages.currentPage().getParameters().Put('Id',lef.id);
        ApexPages.currentPage().getParameters().Put('sessionId',ss.SessionId__c);
        ApexPages.currentPage().getParameters().put('UName','Jayabalan');
        ApexPages.currentPage().getParameters().put('Emailid','demo1@scs.com');
        Lead Obj = new Lead();
        Obj.LastName='dontknow';
        Insert Obj;
        PageReference pageRef = Page.NewLead_view;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('Id', String.valueOf(obj.Id));
        ApexPages.StandardController sc = new ApexPages.StandardController(obj);
        SOSLeadClashProcess sosTest1 = new SOSLeadClashProcess(sc);
        
       // sosTest1.LeadformUserID=lef.Id;
        sosTest1.msgValid ='Testdata'; 
        sosTest1.theHiddenOut = true; 
        sosTest1.emailToValidate = 'san@abc.com';
        sosTest1.SessionID=ss.SessionId__c;
        sosTest1.FinalUName1=lef.UserName__c;
        sosTest1.FinaldivisionUser = lef.Division__c;
        sosTest1.FinalEmail = lef.EMail_ID__c;
        
    //========================================================================//
        
        sosTest1.divisionUser='Rainmakers';
        //sosTest1.Emailid='demo@scs.com';
        //sosTest1.UName1='Jayabalan';
        //sosTest1.sessionId='75901702043385';
        
        //sostest1.FinaldivisionUser = 'Rainmakers';
        //sostest1.FinalUName1 = 'Jayabalan';
        //sostest1.FinalEmail ='demo@scs.com';
        //sostest1.FinalsessionId ='75901702043385';
        
        sostest1.getDomainlist();
        sostest1.getTeamList();
        sostest1.save();
        
        ApexPages.currentPage().getParameters().Put('Id',lef.id);
        ApexPages.currentPage().getParameters().Put('sessionId',ss.SessionId__c);
        ApexPages.currentPage().getParameters().put('div','Winners');
        ApexPages.currentPage().getParameters().put('UName','Jayabalan');
        ApexPages.currentPage().getParameters().put('Emailid','demo1@scs.com');
        SOSLeadClashProcess sosTest6 = new SOSLeadClashProcess(sc);
        sosTest6.init();
       // sosTest1.LeadformUserID=lef.Id;
        ApexPages.currentPage().getParameters().Put('Id',lef.id);
        ApexPages.currentPage().getParameters().Put('sessionId',ss.SessionId__c);
        ApexPages.currentPage().getParameters().put('div','Rainmakers');
        ApexPages.currentPage().getParameters().put('UName','Jayabalan');
        ApexPages.currentPage().getParameters().put('Emailid','demo1@scs.com');
        SOSLeadClashProcess sosTest7 = new SOSLeadClashProcess(sc);
        
        ApexPages.StandardController std1=new ApexPages.StandardController(lef);
        SOSLeadClashProcess stdSoStest = new SOSLeadClashProcess(std1);
        
        String LogSess=String.valueOf(Math.random()).substring(2,12);
        ApexPages.currentPage().getParameters().put('Id',lef.id);
        ApexPages.currentPage().getParameters().Put('sessionId',null);
        ApexPages.currentPage().getParameters().put('div','Stallions');
        ApexPages.currentPage().getParameters().put('UName','Jayabalan');
        ApexPages.currentPage().getParameters().put('Emailid','demo2@scs.com');
        ApexPages.currentPage().getParameters().put('sessionIdLog',null);
        
        SOSLeadClashProcess sostest = new SOSLeadClashProcess(sc);
        sosTest.divisionUser='Rainmakers';
        sosTest.Emailid='demo@scs.com';
        sosTest.UName1='Jayabalan';
        //sosTest.sessionId='75901702043385';
        
        sostest.FinaldivisionUser = 'Rainmakers';
        sostest.FinalUName1 = 'Jayabalan';
        sostest.FinalEmail ='demo@scs.com';
        //sostest.FinalsessionId ='75901702043385';
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
        //sosTest.strUse='Team WML';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        sosTest.Att1.body=bodyBlob;
        sosTest.Att2.body=bodyBlob;
        sosTest.Att3.body=bodyBlob;
        sosTest.Att4.body=bodyBlob;
        sosTest.Att5.body=bodyBlob;
        
        // for invalid fields and spam
        Lead leadReclet1 = new Lead();
        leadReclet1.Company = 'TestLEADIN@';
        leadReclet1.Country = 'India';
        leadReclet1.Title='title@';
        leadReclet1.Email=spamemaillist.Name;
        leadReclet1.FirstName='firstname123';
        leadReclet1.LastName='testing123';
        leadReclet1.Website='@sign.com';
        leadReclet1.LeadSource='Other';
        leadReclet1.Lead_AssignedTo__c='Test User (Rainmakers)';
        leadReclet1.Primary_Service_Name__c='InfocheckPoint';
        leadReclet1.Sub_Division_Name__c='Health Care Data Group';
        leadReclet1.Division_Name__c='Rainmakers';
        leadReclet1.Status='Yet to Initiate';
        leadReclet1.LinkedIn_URL__c='srivarsha379/linkedin.com';
        leadReclet1.Users__c='sraj';
        leadReclet1.IgnoreTriggerCheck__c=true;
        leadReclet1.Account_Name__c=instantAccount.id;
        //leadReclet1.Team_Identification__c='Web team';
        leadReclet1.Users__c='Francis';             
        sosTest.leadRecord=leadReclet1;
        
        
        
        test.startTest();
        sosTest.save();
        test.stopTest();
        
        // for no lead activity and no login
        Lead leadReclet2 = new Lead();
        leadReclet2.Company = 'TestLEADIN';
        leadReclet2.Country = 'India';
        leadReclet2.Title='title';
        leadReclet2.Email='kartik147@gmailes.com';
        leadReclet2.FirstName='firstname';
        leadReclet2.LastName='testing';
        leadReclet2.Website='www.sign.com';
        leadReclet2.LeadSource='Other';
        leadReclet2.Lead_AssignedTo__c= 'Alex Cooper (Rainmakers)';
        leadReclet2.Primary_Service_Name__c='InfocheckPoint';
        leadReclet2.Sub_Division_Name__c='Health Care Data Group';
        leadReclet2.Division_Name__c='Rainmakers';
        leadReclet2.Status='Yet to Initiate';
        leadReclet2.LinkedIn_URL__c='srivarsha379/linkedin.com';
        leadReclet2.Users__c='sraj';
        leadReclet2.IgnoreTriggerCheck__c=true;
        leadReclet2.Account_Name__c=instantAccount.id;
        //leadReclet2.Team_Identification__c='Web team';
        leadReclet2.Users__c='Francis';
        sosTest.leadRecord=leadReclet2;
        sosTest.save();
        
        System.debug('BEGINNING FOR ACCOUNT CLASH');
        System.debug('U2:'+u2);
        // Account Clash              
        Lead leadReclet3 = new Lead();
        leadReclet3.Company = dupAccount.Name;
        leadReclet3.Country = 'India';
        leadReclet3.Title='title';
        leadReclet3.Email='karthikneo37@gmail.com';
        leadReclet3.FirstName='firstname';
        leadReclet3.LastName='testing';
        leadReclet3.Website='www.sign.com';
        leadReclet3.LeadSource='Other';
        // leadReclet3.Lead_AssignedTo__c=u2.Mapped_UserID_Name__c;
        leadReclet3.Primary_Service_Name__c='InfocheckPoint';
        leadReclet3.Sub_Division_Name__c='Email Data Group';
        leadReclet3.Division_Name__c='Spartans';
        leadReclet3.Status='Yet to Initiate';
        leadReclet3.LinkedIn_URL__c='srivarsha379/linkedin.com';
        leadReclet3.Users__c='sraj';
        leadReclet3.IgnoreTriggerCheck__c=true;
        leadReclet3.Account_Name__c=instantAccount.id;
        leadReclet3.Team_Identification__c='Web team';
        leadReclet3.Users__c='Francis';
            
        sosTest.leadRecord=leadReclet3;
        sosTest.save();
        
        System.debug('END  FOR ACCOUNT CLASH');
        system.debug('inserted lead'+leadReclet3);
        
        DateTime dt1 = DateTime.valueOf('2011-01-01 2:35:21'); //datetime start variable
        DateTime dt2 = DateTime.valueOf('2013-01-02 3:56:45'); //datetime end variable
        sosTest.getDifferenceInMinutes(dt1,dt2);
/*      SOSLeadClashProcess sosTest = new SOSLeadClashProcess();
        sosTest.leadRecord=leadReclet3;
        sosTest.closePopup();
        sosTest.displayPopup=true;
        sosTest.showPopup();
        sosTest.save();
        sosTest.getDifferenceInMinutes(dt1,dt2);
        sosTest.lastDate=Date.Today(); 
    */
    // LEAD CLASS - TEST CASES  
        Lead leadReclist = new Lead();
        leadReclist.Company = 'TestLEACON';
        leadReclist.Country = 'India';
        leadReclist.Email='karthik@spam.com';
        leadReclist.LastName='testing';
        leadReclist.Website='www.leadclash.com';
        leadReclist.LeadSource='Other';
        // leadReclist.Lead_AssignedTo__c=u2.Mapped_UserID_Name__c;
        leadReclist.Primary_Service_Name__c='InfocheckPoint';
        leadReclist.Sub_Division_Name__c='Health Care Data Group';
        leadReclist.Division_Name__c='Gladiators';
        leadReclist.Status='Yet to Initiate';
        leadReclist.LinkedIn_URL__c='srivarsha379/linkedin.com';
        leadReclist.User_Name__c='test';
        leadReclist.IgnoreTriggerCheck__c=true;
        leadReclist.Users__c='sraj';
        leadReclist.Team_Identification__c=null;
        leadReclist.Users__c='Francis';
        
        insert leadReclist;
      
        System.debug('INSERTED LEAD IS :'+leadReclist.OwnerId);
        System.debug('INSERTED LEAD IS :'+leadReclist);
        sosTest.leadRecord=leadReclist;
        
        
        sosTest.save();
        sosTest.doCancel();
        sosTest.doCancel();
        
         String LogSess3=String.valueOf(Math.random()).substring(2,16); 
        ApexPages.currentPage().getParameters().put('Id',lef.id);
        ApexPages.currentPage().getParameters().Put('sessionId',null);
        ApexPages.currentPage().getParameters().put('div',null);
        ApexPages.currentPage().getParameters().put('UName','Jayabalan');
        ApexPages.currentPage().getParameters().put('Emailid','demo5@scs.com');
        ApexPages.currentPage().getParameters().put('sessionIdLog',LogSess3);
        SOSLeadClashProcess sosTestold12 = new SOSLeadClashProcess(sc);
         
         
         String LogSess2=String.valueOf(Math.random()).substring(2,16); 
        ApexPages.currentPage().getParameters().put('Id',lef.id);
        ApexPages.currentPage().getParameters().Put('sessionId',null);
        ApexPages.currentPage().getParameters().put('div','Content');
        ApexPages.currentPage().getParameters().put('UName','Jayabalan');
        ApexPages.currentPage().getParameters().put('Emailid','demo5@scs.com');
        ApexPages.currentPage().getParameters().put('sessionIdLog',LogSess2);
        SOSLeadClashProcess sosTestold1 = new SOSLeadClashProcess(sc);
        
        //sosTest.attachNoteAndUpdateLead(leadReclist, leadReclet3, true);
        System.debug('LEAD CLASH ENDED HERE');
        //String LogSess1=String.valueOf(Math.random()).substring(2,16); 
        ApexPages.currentPage().getParameters().put('Id',lef.id);
        ApexPages.currentPage().getParameters().Put('sessionId',null);
        ApexPages.currentPage().getParameters().put('div','Gladiators');
        ApexPages.currentPage().getParameters().put('UName','Jayabalan');
        ApexPages.currentPage().getParameters().put('Emailid','demo5@scs.com');
        ApexPages.currentPage().getParameters().put('sessionIdLog',null);
        SOSLeadClashProcess sosTestold = new SOSLeadClashProcess(sc);
        

        List<Lead> testLead =[Select Id, LeadID__c,Relevant_Partners1__c,Relevant_Partners2__c,
                    Top_Customers1__c,Top_Customers2__c,CreatedDate,LastModifiedDate,FirstName,LastName,Company,
                    LinkedIn_URL__c,User_Name__c,Twitter_URL__c,Division_Name__c,LinkedIn_Photo_URL__c,Customer_Products_and_Services__c,
                    Other_Locations_Branches__c,LastActivityDate,Owner.Name,Owner.Email,
                    CRM_Used__c,OwnerId from Lead where LinkedIn_URL__c != '' and Division_Name__c != '' and isConverted =false limit 10];
        Lead leadClashlist = new Lead();
        leadClashlist.Company = 'TestLEADINGRule';
        leadClashlist.Country = 'India';
        leadClashlist.Email='praveen.r1@istrategicloud.com';
        leadClashlist.LastName='testing2';
        leadClashlist.LeadSource='Other';
        leadClashlist.Website='leadclash.com';
        // leadClashlist.Lead_AssignedTo__c=u2.Mapped_UserID_Name__c;
        leadClashlist.Primary_Service_Name__c='InfocheckPoint';
        leadClashlist.Sub_Division_Name__c='Health Care Data Group';
        leadClashlist.Division_Name__c='Mavericks';
        leadClashlist.Status='Yet to Initiate';
        leadClashlist.LinkedIn_URL__c='srivarsha379/linkedin.com';
        leadClashlist.User_Name__c='test';
        leadClashlist.IgnoreTriggerCheck__c=true;
        leadClashlist.Users__c='sraj';
        leadClashlist.Team_Identification__c='Marshal Sequira';
        leadClashlist.Users__c='Francis';
        insert leadClashlist; 
        
        List<LeadFormUsers__c> logFormUser=[select EMail_ID__c,Name,Password__c,Division__c,Floor__c,
                                Last_Login__c from LeadFormUsers__c limit 1];
       
        System.debug('INSERTED LEAD IS :'+leadReclist.OwnerId);
        System.debug('INSERTED LEAD IS :'+leadReclist);
        sosTest.leadRecord=leadClashlist;
        sosTest.save();
        sosTest.doCancel();
        List<User> gmUser  = [Select Id, Name, Email,GM__c,IsGM__c,Division,Mapped_UserID_Name__c from User where isActive=true and IsGM__c = true and GM__c!=null limit 1];
        sosTest.attachNoteAndUpdateLead(testLead[0], leadClashlist, true,gmUser);
        sosTest.attachNoteAndUpdateLead(testLead[0], leadClashlist, false,null);
        
        ApexPages.currentPage().getParameters().Put('Id',lef1.id);
        ApexPages.currentPage().getParameters().Put('sessionId',ss1.SessionId__c);
        ApexPages.currentPage().getParameters().put('UName','Jayabalan');
        ApexPages.currentPage().getParameters().put('Emailid','demo6@scs.com');
        
        SOSLeadClashProcess sosTesto = new SOSLeadClashProcess(sc);
        //sosTesto.leadRecord=leadReclist;
        //system.debug('@@@@@@@@@@@@@@@@@@@@'+sosTesto.leadRecord);
        sosTesto.closePopup();
        sosTesto.displayPopup=true;
        sosTesto.showPopup();
  //        sosTesto.save();
        //sosTesto.strUse='Campaign';
        sosTesto.cancelRecord();
        sosTesto.getDifferenceInMinutes(dt1,dt2);
        Blob bodyBlobw1=Blob.valueOf('Unit Test Attachment Body');
        sosTesto.Att1.body=bodyBlobw1;
        sosTesto.Att2.body=bodyBlobw1;
        sosTesto.Att3.body=bodyBlobw1;
        sosTesto.Att4.body=bodyBlobw1;
        sosTesto.Att5.body=bodyBlobw1;
        sosTesto.divisionUser=logFormUser[0].Division__c;
        sosTesto.UName1=logFormUser[0].Name;
        sosTesto.Emailid= logFormUser[0].EMail_ID__c;
        
        
        Lead leadRecCON = new Lead();
        leadRecCON.Company = dupAccount.Name;
        leadRecCON.Country = 'India';
        leadRecCON.Title='title';
        leadRecCON.Email='karthikneo37@in.com';
        leadRecCON.FirstName='firstname';
        leadRecCON.LastName='testing';
        leadRecCON.Website='www.sign.com';
        leadRecCON.LeadSource='Other';
       // leadRecCON.Lead_AssignedTo__c=u2.Mapped_UserID_Name__c;
        leadRecCON.Primary_Service_Name__c='InfocheckPoint';
        leadRecCON.Sub_Division_Name__c='Email Data Group';
        leadRecCON.Division_Name__c='Rainmakers';
        leadRecCON.Status='Yet to Initiate';
        leadRecCON.LinkedIn_URL__c='srivarsha379/linkedin.com';
        leadRecCON.Users__c='sraj';
        leadRecCON.IgnoreTriggerCheck__c=true;
        leadRecCON.Account_Name__c=instantAccount.id;
        leadRecCON.Team_Identification__c=null;
        leadRecCON.Users__c='Francis';
        insert leadRecCON;
        system.debug('inserted lead'+leadRecCON);   
        sosTesto.leadRecord=leadRecCON;
        system.debug('@@@@@@@@@@@RRRRRR@@@@@@@@@'+sosTesto.leadRecord);
        sosTesto.save();
        
        System.debug('END  FOR ACCOUNT CLASH');
        
        
        
      }  
 
     
}