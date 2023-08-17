@isTest
private class TestClass_For_total {
// trigger for UpdateCustomeObject_Trigger

    static testMethod void myUnitTest() {
        test.starttest();
        Config__c con = new  Config__c();
        con.Value__c='istrategic.com,dell.com,span.com';
        con.BrandWise__c='B2B Contacts; B2B Data Partners In; B2B List; B2B Lists; Biz Contrive; Brigade Big; Data 2 Directory; Direct Healthcare Leads; Email Data Group; European Lists;';
        con.Division__c='Alex; Blake Cooper; Campaign; Content; Jeff Anderson; LeadGen; Manager_Robin Smith; Manager_Roger Smith; Manger_Steve Sujith; MPO; Marshall; Max Tyler; Michelle; Raymond Phillips; Sam Green(Cuesent); Sean Fischer(Stallions); SM _Gary_Mayers; Web Team';
        con.NumberOfDays__c=10;
        con.NoLeadActivity__c=1;
        con.Blacklisted_Domains__c='spam.com,google.com,kam.com';
        insert con;
              
        lead newlead=new lead();
        newlead.Email='kristen.m@istrategicloud.com';
        newlead.Division_Name__c='Rainmakers';
        newlead.LeadSource='Approved Index';
        newlead.Status='Followup';
        newlead.Company = 'Nokia';
        newlead.FirstName='tanker';
        newlead.LastName='tusker';
        newlead.Primary_Service_Name__c='CRM';
        newlead.LinkedIn_URL__c='karthik37/Linkedin.com';
        newlead.Lead_AssignedTo__c='William Perry (Rainmakers)';
        newlead.User_Name__c='testuser';
        newlead.Team_Identification__c='Raymond Phillips';
        //newlead.IsConverted=false;
        insert newlead;
        system.debug('********ISconverted******'+newlead.IsConverted);
        //newlead.IsConverted=true;
        //update newlead;
        system.debug('**************lead**********'+newlead.id);
        
        Account acc=new Account();
        acc.Name='Nokia';
        acc.Email__c='sample@nokia.com';
        acc.Phone='(954) 344-9254';
        acc.Type='Customer';
        insert acc;
        system.debug('*acc*****************'+acc.id);
        
        contact cont=new contact();
        cont.AccountId=acc.id;
        cont.LastName='subhash';
        cont.Email='suba@gmail.com';
        insert cont;
        
        Opportunity opp=new Opportunity();
        opp.Name='sample';
        opp.AccountId=acc.id;
        opp.Lead_Source__c='Approved Index';
        opp.Primary_Service_Name__c='Technology List';
        opp.Division__c='Gladiators';
        opp.StageName='Deal';
        opp.Sample_To_Deal__c='other';
        opp.Uploaded_By__c='test';
        opp.ForecastCategoryName='pipeline';
        opp.Amount=5000;
        opp.CloseDate=date.parse('1/13/2013');
        opp.Team_Uploaded_By__c='Winners'; 
        insert opp;
        system.debug('opp******************'+opp.id);
        try{
        Database.LeadConvert lc = new database.LeadConvert();
        lc.setLeadId(newlead.id);
        lc.setAccountId(acc.id);
        lc.setContactId(cont.id);
        LeadStatus convertStatus = [Select Id, MasterLabel from LeadStatus where IsConverted=true limit 1];
        lc.setConvertedStatus(convertStatus.MasterLabel);
        //lc.setConvertedStatus('Closed - Converted');
        
        Database.LeadConvertResult lcr = Database.convertLead(lc);
        System.assert(lcr.isSuccess());
        update newlead;
        
        List<Sample_Request__c> listSR = new List<Sample_Request__c>();
        Sample_Request__c SR= new Sample_Request__c();
        SR.Name='TEST';
        SR.Sample_Type__c='Custom Business List Sample';
        SR.Sample_Type_Description__c='TEST DESCRIPTION';
        SR.Lead__c=newlead.Id;
        listSR.add(SR);
        insert listSR;
        }catch(exception e){}
    }

// trigger Task Duedate update on Lead,contact and Opportunity'

static testMethod void myUnitTest_Task(){
User u1= [select id from User where alias='steam' limit 1];

Lead l1= new Lead();
l1.Company='1';
l1.Ownerid=u1.id;
l1.lastname='testclass';
l1.Status='Working';
insert l1;

Opportunity opty2= new Opportunity ();
opty2.StageName = 'Warm';
opty2.CloseDate=System.today();
opty2.Ownerid=u1.id;
opty2.name='optytest';
opty2.Opplead_id__c='testid';
insert opty2;

Task t = new Task();
t.WhoId=l1.Id;
t.Ownerid=u1.Id;
t.Subject='Call';
t.Status='Deferred';
t.Priority='High';
t.ActivityDate=System.Today();
insert t;
delete t;

Task t1 = new Task();  
t1.WhatId=opty2.Id;
t1.Ownerid=u1.Id;
t1.Subject='Call';
t1.Status='Deferred';
t1.Priority='High';
t1.ActivityDate=System.Today();
insert t1;
delete t1;
}

//trigger Event date update in Lead,Contact,Opportunity

static testMethod void myUnitTest_Event(){
User u1= [select id from User where alias='steam' limit 1];

set<ID> leadIds = new set<ID>();
set<ID> optyIds = new set<ID>();

//set<ID> leadIds1 = new set<ID>();
//set<ID> optyIds1 = new set<ID>();
Lead l1= new Lead();
l1.Company='1';
l1.Ownerid=u1.id;
l1.lastname='testclass';
l1.Status='Working';
insert l1;
leadIds.add(l1.id);

Opportunity opty2= new Opportunity ();
opty2.StageName = 'Warm';
opty2.CloseDate=System.today();
opty2.Ownerid=u1.id;
opty2.name='optytest';
opty2.Opplead_id__c='testid';
insert opty2;
optyIds.add(opty2.id);

Event e=new Event();
//e.WhoId=l1.Id;
e.WhatId=opty2.Id;
e.Ownerid=u1.Id;
e.Subject='Call';
e.ActivityDate=System.Today();
e.DurationInMinutes=4;
e.ActivityDateTime=System.NOW();
insert e;
delete e;
/*Event en=new Event();
//e.WhoId=l1.Id;
en.WhatId=opty2.Id;
en.Ownerid=u1.Id;
en.Subject='Call';
en.ActivityDate=System.Today();
en.DurationInMinutes=4;
en.ActivityDateTime=System.NOW();
*/


Event e1=new Event();
//e1.WhatId=opty2.Id;
e1.WhoId=l1.Id;
e1.Ownerid=u1.Id;
e1.Subject='Call';
e1.ActivityDate=System.Today();
e1.DurationInMinutes=4;
e1.ActivityDateTime=System.NOW();
insert e1;
delete e1;
/*Event e1n=new Event();
//e1.WhatId=opty2.Id;
e1n.WhoId=l1.Id;
e1n.Ownerid=u1.Id;
e1n.Subject='Call';
e1n.ActivityDate=System.Today();
e1n.DurationInMinutes=4;
e1n.ActivityDateTime=System.NOW();
delete e1n;*/

}

//for trigger Validate_email_And_Getresponse
static testMethod void myUnitTest_ValidateEmail(){
    
Lead l2= new Lead();
l2.Company='sorceone';
//l1.Ownerid=u1.id;
l2.lastname='testclass';
l2.Status='Yet to Initiate';
l2.User_Name_LeadGen__c='Deepak';  
l2.Division_Name__c='Spartans';
l2.Email='sample@sample.com';
l2.Lead_AssignedTo__c ='Adam Joseph (Spartans)';
l2.Primary_Service_Name__c='Data Management & List Updates';
l2.LeadSource='Customer Service';
insert l2;

  /*  SOS__c sosSettings = new SOS__c();
    sosSettings.Run_Crediefeye_Trigger__c=true;
    insert sosSettings;    
*/
CredifeyeDuplication cd=new CredifeyeDuplication();
            boolean fla=cd.getmaildomain(l2.Email);

}

//for trigger Assign_User_To_LeadupLoadedBy

static testMethod void myUnitTest_AssignTo(){
User u1= [select id from User where alias='steam' AND Rollup_should_hapen__c=false limit 1];
update u1;

LeadFormUsers__c LFU=new LeadFormUsers__c();
LFU.Name='Deepak';
LFU.EMail_ID__c='test@testmail.com';
insert LFU;
LeadFormUsers__c LFU1=new LeadFormUsers__c();
LFU1.Name='Zabi';
LFU1.EMail_ID__c='test1@testmail.com';
insert LFU1;

Lead l1= new Lead();
l1.Company='1';
l1.Ownerid=u1.id;
l1.lastname='testclass';
l1.Status='Working';
l1.User_Name__c='Sean Anderson';
l1.User_Name_Campaign__c='murali';
l1.User_Name_LeadGen__c='Deepak';
l1.User_Name_Sales_Manager_Joshua_Raj__c='alan';
l1.Division_Name__c='Cuesent';
insert l1;
l1.User_Name_LeadGen__c='Zabi';
update l1;
}
// trigger 'user_lead_count_bulk'

static testMethod void myUnitTest_Lead(){
User u1= [select id from User where alias='steam' limit 1];
            try{
            u1.Rollup_should_hapen__c=true;
            u1.Open_Leads_Allowed__c=0;
            update u1;
            Lead l1= new Lead();
            l1.Company='1';
            l1.Ownerid=u1.id;
            l1.lastname='testclass';
            l1.Status='Working';
            insert l1;
            }
            catch(Exception e){
            u1.Open_Leads_Allowed__c=15;
            update u1;
            }
            Lead l2= new Lead();
            l2.Company='1';
            l2.Ownerid=u1.id;
            l2.lastname='testclass';
            l2.Status='Working';
            l2.Email= 'piyush12345@gmail.com';
            l2.Status='Qualified - Convert';
            insert l2;
            try{
            u1.Open_Leads_Allowed__c=0;
            update u1;
            l2.status='Open';
            update l2;
            }
            catch(Exception e){
            u1.Open_Leads_Allowed__c=15;
            update u1;
            }
            Lead l3= new Lead();
            l3.Company='1';
            l3.Ownerid=u1.id;
            l3.lastname='testclass';
            l3.Email='piyush@gmail.com';
            l3.Status='Qualified - Convert';
            l3.Comments__c = 'Test';
            insert l3;
            delete l3;
            undelete l3;
            delete l2;
            undelete l2;
        
}

//for trigger CountLeads_AfterCheck

static testMethod void myUnitTest_count_User_aftercheck(){

User u1= [select id from User where alias='steam' AND Rollup_should_hapen__c=false limit 1];
u1.Rollup_should_hapen__c=true; 
update u1;
/*
Lead l1= new Lead();
l1.Company='1';
l1.Ownerid=u1.id;
l1.lastname='testclass';
l1.Status='Working';
insert l1;

Lead l2= new Lead();
l2.Company='1test';
l2.Ownerid=u1.id;
l2.lastname='testclass2';
l2.Email='test12345@test.com';
l2.Status='Working';
insert l2;

Opportunity opp1=new Opportunity(Name='test oppty',CloseDate=system.today(),StageName='Qualification',Ownerid=u1.id);
insert opp1;

Opportunity opp2=new Opportunity(Name='test oppty1',CloseDate=system.today(),StageName='Closed Lost',Ownerid=u1.id);
insert opp2;
*/
}
 
// trigger 'user_Oppty_count_bulk'

static testMethod void myUnitTest_Opty(){
User u1= [select id from User where alias='steam' limit 1];
try{
u1.Open_Opportunities_Allowed__c=0;
u1.Rollup_should_hapen__c=true;
update u1;

/*lead newlead=new lead(Email='kavin.m@istrategicloud.com',Division_Name__c='MPO',LeadSource='Approved Index',Status='Followup',Company = 'SOS',FirstName='TestN',LastName='TestJohn',Primary_Service_Name__c='CRM',LinkedIn_URL__c='karthik37/Linkedin.com',Lead_AssignedTo__c='Neil Andersonn (MPO)',User_Name__c='test',Team_Identification__c='testteam');
        insert newlead;
        
        Account acc=new Account();
      acc.Name='SOS';
      acc.Email__c='sample@in.com';
      acc.Phone='(954) 344-9254';
      acc.Type='Customer';
      insert acc;
      
      Opportunity opp=new Opportunity();
      opp.Name='sample';
      opp.AccountId=acc.id;
      opp.Lead_Source__c='Approved Index';
      opp.Primary_Service_Name__c='Technology List';
      opp.Division__c='Gladiators';
      opp.StageName='Deal';
      opp.Sample_To_Deal__c='other';
      opp.Uploaded_By__c='test';
      opp.ForecastCategoryName='pipeline';
      opp.Amount=5000;
      opp.CloseDate=date.parse('1/13/2013');
      opp.Team_Uploaded_By__c='Winners'; 
      insert opp;  */

Opportunity opty1= new Opportunity ();
opty1.StageName = 'Proposal/Price Quote';
opty1.CloseDate=System.today();
opty1.Ownerid=u1.id;
opty1.name='optytest1';
opty1.Opplead_id__c='testid1';
insert opty1;
}catch(Exception e){
u1.Open_Opportunities_Allowed__c=15;
u1.Rollup_should_hapen__c=true;
update u1;
}
Opportunity opty2= new Opportunity ();

opty2.StageName = 'Proposal/Price Quote';
opty2.CloseDate=System.today();
opty2.Ownerid=u1.id;
opty2.name='optytest2';
opty2.Opplead_id__c='testid2';
insert opty2;

opty2.StageName = 'Closed Won';
update opty2;
delete opty2;
undelete opty2;
opty2.StageName = 'Proposal/Price Quote';
update opty2;

}

//for the trigger 'Account_contact_namefetch'
static testMethod void myUnitTest_Lead_namefetch(){

Account a= new Account();
a.Email__c='testabc123@test.com';
a.Name= 'aname';
insert a;
Contact c= new Contact();
c.Email='testabc123@test.com';
c.Accountid=a.id;
c.Lastname='cname';
insert c;

Lead l1= new Lead();
l1.Company='1';
l1.lastname='testclass';
l1.Status='Working';
l1.Email='testabc123@test.com';
insert l1;

}
//Test for Trigger BlackListLeads
static testMethod void myUnitTest_BlackList(){
Account a1= new Account();
a1.Email__c='testabc1234@test.com';
a1.Name= 'aname';
a1.Is_Account_Blacklisted__c=false;
insert a1;

Lead l2= new Lead();
l2.Company='1';
l2.lastname='testclass1';
l2.Status='Working';
l2.Email='testabc1234@test.com';
insert l2;
}

//For trigger DupeCheck
static testMethod void myUnitTest_Opportunity_DupeCheck(){
Account acc=new Account();
acc.Name='ABC';
acc.Email__c='test123t@test.com';
insert acc;
try{
Opportunity opty1= new Opportunity ();
opty1.StageName ='Closed Won';
opty1.CloseDate=System.today();
opty1.name='optytest';
//opty1.Email__c ='testopty123@opty.com';
opty1.Division__c = ''; 
insert opty1;
}
catch(Exception e){
System.debug('will get error of :StageName should not be Closed Won for new record:');
}
try{
Opportunity opty2= new Opportunity ();
opty2.StageName ='Proposal/Price Quote';
opty2.CloseDate=System.today();
opty2.name='optytest';
opty2.Accountid=acc.id;
//opty2.Email__c ='testopty123@opty.com';
opty2.Division__c = 'Customer Service'; 
insert opty2;

Opportunity opty3= new Opportunity ();
opty3.StageName ='Proposal/Price Quote';
opty3.CloseDate=System.today();
opty3.name='optytest';
opty3.Accountid=acc.id;
//opty3.Email__c ='testopty123@opty.com';
opty3.Division__c = 'Customer Service'; 
insert opty3;
}
catch(Exception e){
System.debug('will get error of :Duplicate redord found:');
}
}

//*************Start Test code for controllers**********************************
    //Test code for ctrl open leads allowed
    static testMethod void myUnitTest_OpenLeadsAllowed(){
        openleads_allowed_ctrl x=new openleads_allowed_ctrl();
        x.save();
       
    }

    //Test code for ctrl Raymond
    static testMethod void myUnitTest_Blakectrl1(){
        
     User u1= [select id from User where alias='steam' AND Rollup_should_hapen__c=false limit 1];
     update u1;
        Spam_Email__c SE=new Spam_Email__c();
        SE.Name='test@test.co.in';
        insert SE;
        Lead l1= new Lead();
        l1.Company='test123';
        l1.lastname='testclass';
        l1.Status='Working';
        l1.Email='testabc1234@test.com';
        l1.Lead_AssignedTo__c='Andy Rodgers (Winners)';
        SOSLeadFormCtrl_Raymond Blake=new SOSLeadFormCtrl_Raymond();
        Blake.App = l1;
        //Blake.save();
        Blake.checkemail();
        
        Blake.leadSucess();
    }
    
    //Test code for samGreen Form
    static testMethod void myUnitTest_SamGreen(){
    
        Spam_Email__c SE=new Spam_Email__c();
        SE.Name='test@test.co.in';
        insert SE;
        Lead l1= new Lead();
        l1.Company='test123';
        l1.lastname='testclass';
        l1.Status='Working';
        l1.Email='testabc1234@test.com';
        l1.Lead_AssignedTo__c='Sam Green (Cuesent)';
        l1.Team_Identification__c='Sam Green';
        //insert l1;
        SOSLeadFormCtrl_SamGreen Webteam=new SOSLeadFormCtrl_SamGreen();
        
        Webteam.App = l1;
        Webteam.checkemail();
        Webteam.Att.ParentId = l1.id;
        Webteam.save();
        Webteam.leadSucess();
        
    } 
    
    //Test code for MPO Form
    static testMethod void myUnitTest_MPO(){
    
        Spam_Email__c SE=new Spam_Email__c();
        SE.Name='test@test.co.in';
        insert SE;
        Lead l1= new Lead();
        l1.Company='test123';
        l1.lastname='testclass';
        l1.Status='Working';
        l1.Email='testabc1234@test.com';
        l1.Lead_AssignedTo__c='Neil Anderson(MPO)';
        l1.Team_Identification__c='Neil';
        insert l1;
        SOSLeadFormCtrl_MPO Webteam=new SOSLeadFormCtrl_MPO();
        
        Webteam.App = l1;
        Webteam.checkemail();
        Webteam.Att.ParentId = l1.id;
        Webteam.save();
        Webteam.leadSucess();
    
    }
    //Test code for SeanFischer Form
       static testMethod void myUnitTest_SeanFischer(){
    
        Spam_Email__c SE=new Spam_Email__c();
        SE.Name='test@test.co.in';
        insert SE;
        Lead l1= new Lead();
        l1.Company='test123';
        l1.lastname='testclass';
        l1.Status='Working';
        l1.Email='testabc1234@test.com';
        l1.Lead_AssignedTo__c='Roy Smith (Stallions)';
        l1.Team_Identification__c='Sean Fischer';
        insert l1;
        SOSLeadFormCtrl_Sean_Fischer Webteam=new SOSLeadFormCtrl_Sean_Fischer();
        
        Webteam.App = l1;
        Webteam.checkemail();
        Webteam.Att.ParentId = l1.id;
        Webteam.save();
        Webteam.leadSucess();
        
    } 
    
    //Test code for ctrl Blakecooper
    static testMethod void myUnitTest_Blakectrl(){
        Lead l1= new Lead();
        l1.Company='test123';
        l1.lastname='testclass';
        l1.Status='Working';
        l1.Email='testabc1234@test.com';
        SOSLeadFormCtrl_BlakeCooper Blake=new SOSLeadFormCtrl_BlakeCooper();
        
        Blake.App = l1;
        Blake.checkemail();
        Blake.save();
        Blake.leadSucess();
    }
    
     //Test code for ctrl Campaign
    static testMethod void myUnitTest_Campaign(){
        Lead l1= new Lead();
        l1.Company='test123';
        l1.lastname='testclass';
        l1.Status='Working';
        l1.Email='testabc1234@test.com';
        SOSLeadFormCtrl_Campaign campaign=new SOSLeadFormCtrl_Campaign();
        
        campaign.App = l1;
        campaign.checkemail();
        campaign.save();
        campaign.leadSucess();
    }
    
    //Test code for ctrl Campaign
    static testMethod void myUnitTest_Alex(){
        Lead l1= new Lead();
        l1.Company='test123';
        l1.lastname='testclass';
        l1.Status='Working';
        l1.Email='praveen.r@istrategicloud.com';
        SOSLeadFormCtrl_Alex campaign=new SOSLeadFormCtrl_Alex();
        
        campaign.App = l1;
        campaign.checkemail();
        campaign.Att.ParentId = l1.id;
        campaign.save();
        campaign.leadSucess();
      
    }
    
    //Test code for ctrl Campaign
    static testMethod void myUnitTest_Michelle(){
        Lead l1= new Lead();
        l1.Company='test123';
        l1.lastname='testclass';
        l1.Status='Working';
        l1.Email='testabc1234@test.com';
        SOSLeadFormCtrl_Michelle campaign=new SOSLeadFormCtrl_Michelle();
        
        campaign.App = l1;
        campaign.checkemail();
        campaign.save();
        campaign.leadSucess();
    }
    
    //Test code for ctrl Marshal
    static testMethod void myUnitTest_Marshal(){
        Lead l1= new Lead();
        l1.Company='test123';
        l1.lastname='testclass';
        l1.Status='Working';
        l1.Email='testabc1234@test.com';
    //    l1.Lead_AssignedTo__c='Andy Rodgers (Winners)';
        SOSLeadFormCtrl_Marshal campaign=new SOSLeadFormCtrl_Marshal();
        
        campaign.App = l1;
        campaign.checkemail();
        campaign.save();
        campaign.leadSucess();
    }
    
     //Test code for ctrl Maxtyler
    static testMethod void myUnitTest_Maxtyler(){
        Lead l1= new Lead();
        l1.Company='test123';
        l1.lastname='testclass';
        l1.Status='Working';
        l1.Email=' testabc1234@test.com';
        l1.Lead_AssignedTo__c='Andy Rodgers (Winners)';
        SOSLeadFormCtrl_MaxTyler campaign=new SOSLeadFormCtrl_MaxTyler();
      
        campaign.App = l1;
        campaign.checkemail();
        campaign.save();
        campaign.leadSucess();
        
    }
    
    //Test code for ctrl Content
    static testMethod void myUnitTest_Content(){
        Lead l1= new Lead();
        l1.Company='test123';
        l1.lastname='testclass';
        l1.Status='Working';
        l1.Email='testabc1234@test.com';
        SOSLeadFormCtrl_Content content=new SOSLeadFormCtrl_Content();
        content.Att.ParentId=l1.id;
        content.App = l1;
        content.checkemail();
        content.save();
        content.leadSucess();
        
    }
    
    //Test code for ctrl Jeff Anderson
    static testMethod void myUnitTest_Anderson(){
        Lead l1= new Lead();
        l1.Company='test123';
        l1.lastname='testclass';
        l1.Status='Working';
        l1.Email='testabc1234@test.com';
        SOSLeadFormCtrl_Jeff_Anderson anderson=new SOSLeadFormCtrl_Jeff_Anderson();
        
        anderson.App = l1;
        anderson.checkemail();
        anderson.save();
        anderson.leadSucess();
    }
    
    //Test code for ctrl LeadGen
    static testMethod void myUnitTest_LeadGen(){
        Lead l1= new Lead();
        l1.Company='test123';
        l1.lastname='testclass';
        l1.Status='Working';
        l1.Email='testabc1234@test.com';
        SOSLeadFormCtrl_LeadGen LeadGen=new SOSLeadFormCtrl_LeadGen();
        
        LeadGen.App = l1;
        LeadGen.checkemail();
        LeadGen.Att.ParentId = l1.id;
        LeadGen.save();
        LeadGen.leadSucess();
       
    }
    
    //Test code for ctrl Gary Mayersrs
    static testMethod void myUnitTest_Mayer(){
        Lead l1= new Lead();
        l1.Company='test123';
        l1.lastname='testclass';
        l1.Status='Working';
        l1.Email='testabc1234@test.com';
        SOSLeadFormCtrl_Manager_Gary_Mayersrs mayer=new SOSLeadFormCtrl_Manager_Gary_Mayersrs();
        
        mayer.App = l1;
        mayer.checkemail();
        mayer.Att.ParentId = l1.id;
        mayer.save();
        mayer.leadSucess();
    }
    
    //Test code for ctrl Robin Smith
    static testMethod void myUnitTest_Smith(){
        Lead l1= new Lead();
        l1.Company='test123';
        l1.lastname='testclass';
        l1.Status='Working';
        l1.Email='testabc1234@test.com';
        SOSLeadFormCtrl_Manager_Robin_Smith smith=new SOSLeadFormCtrl_Manager_Robin_Smith();
        
        smith.App = l1;
        smith.checkemail();
        smith.Att.ParentId = l1.id;
        smith.save();
        smith.leadSucess();
    }
    
    //Test code for ctrl Roger
    static testMethod void myUnitTest_Roger(){
        Lead l1= new Lead();
        l1.Company='test123';
        l1.lastname='testclass';
        l1.Status='Working';
        l1.Email='testabc1234@test.com';
        SOSLeadFormCtrl_Manager_Roger_Smith smith=new SOSLeadFormCtrl_Manager_Roger_Smith();
        
        smith.App = l1;
        smith.checkemail();
        smith.Att.ParentId = l1.id;
        smith.save();
        smith.leadSucess();
    }
    
    //Test code for ctrl Steve
    static testMethod void myUnitTest_Steve(){
        Lead l1= new Lead();
        l1.Company='test123';
        l1.lastname='testclass';
        l1.Status='Working';
        l1.Email='testabc1234@test.com';
        SOSLeadFormCtrl_Manger_Steve_Sujith sujith=new SOSLeadFormCtrl_Manger_Steve_Sujith();
        
        sujith.App = l1;
        sujith.checkemail();
        sujith.Att.ParentId = l1.id;
        sujith.save();
        sujith.leadSucess();
    }
    
    //Test code for ctrl Webteam
    static testMethod void myUnitTest_Webteam(){
        Lead l1= new Lead();
        l1.Company='test123';
        l1.lastname='testclass';
        l1.Status='Working';
        l1.Email='testabc1234@test.com';
        SOSLeadFormCtrl_Webteam Webteam=new SOSLeadFormCtrl_Webteam();
        
        Webteam.App = l1;
        Webteam.checkemail();
        Webteam.Att.ParentId = l1.id;
        Webteam.save();
        Webteam.leadSucess();
    } 
    
    static testMethod void testMe() {
 
  // create a new email and envelope object
  Messaging.InboundEmail email = new Messaging.InboundEmail() ;
  Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
 
  // setup the data for the email
  email.subject = 'Test Job Applicant';
  email.fromname = 'FirstName LastName';
  env.fromAddress = 'someaddress@email.com';
  email.PlainTextBody='XYZ';
 
  // query for the contact the email service created
  Opportunity oppty = new Opportunity();
  oppty.Name='Test Name';
  oppty.StageName='Qualification';
  oppty.CloseDate =system.Today();
  oppty.Opplead_id__c='testid';
  
  insert oppty;
  
  // add an attachment
  Messaging.InboundEmail.BinaryAttachment attachment = new Messaging.InboundEmail.BinaryAttachment();
  attachment.body = blob.valueOf('my attachment text');
  attachment.fileName = 'textfile.txt';
  attachment.mimeTypeSubType = 'text/plain';
  //attachment.parentId =oppty.id;
 
  email.binaryAttachments =
    new Messaging.inboundEmail.BinaryAttachment[] { attachment };
 
  // call the email service class and test it with the data in the testMethod
  //InboundEmail_myHandler emailProcess = new InboundEmail_myHandler();
 // emailProcess.handleInboundEmail(email, env);
 
  //System.assertEquals(a.name,'textfile.txt');
 } 
}