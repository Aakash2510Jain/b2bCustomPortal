@istest
public class TestLeadGenBonusReportWinners{
static testMethod void Test_LeadGenController(){
        
        test.starttest();
       Config__c con = new  Config__c();
      con.Value__c='istrategic.com,dell.com,span.com';
      con.BrandWise__c='B2B Contacts; B2B Data Partners In; B2B List; B2B Lists; Biz Contrive; Brigade Big; Data 2 Directory; Direct Healthcare Leads; Email Data Group; European Lists;';
      con.Division__c='Alex; Blake Cooper; Campaign; Content; Jeff Anderson; LeadGen; Manager_Robin Smith; Manager_Roger Smith; Manger_Steve Sujith; MPO; Marshall; Max Tyler; Michelle; Raymond Phillips; Sam Green(Cuesent); Sean Fischer(Stallions); SM _Gary_Mayers; Web Team';
      con.NumberOfDays__c=10;
      con.NoLeadActivity__c=1;
      con.Blacklisted_Domains__c='spam.com,google.com,kam.com';
      insert con;
      
     /* lead newlead=new lead(Email='kavin.m@istrategicloud.com',Division_Name__c='Spartans',LeadSource='Approved Index',Status='Followup',Company = 'SOS',FirstName='TestN',LastName='TestJohn',Primary_Service_Name__c='CRM',LinkedIn_URL__c='karthik37/Linkedin.com',Lead_AssignedTo__c='Richard Williams (Spartans)',User_Name__c='test',Team_Identification__c='testteam');
        insert newlead; */
        
         
           
        lead newlead=new lead();
        newlead.Email='kavn.m@istrtegicloud.com';
        newlead.Division_Name__c='Winners';
        newlead.LeadSource='Approved Index';
        newlead.Status='Followup';
        newlead.Company = 'SOS';
        newlead.FirstName='TestN';
        newlead.LastName='TestJohn';
        newlead.Primary_Service_Name__c='CRM';
        newlead.LinkedIn_URL__c='karthik37/Linkedin.com';
        newlead.Lead_AssignedTo__c='William Perry (Rainmakers)';
        newlead.User_Name__c='test';
        newlead.Team_Identification__c='Raymond Phillips';
        insert newlead;
        system.debug('**************lead**********'+newlead);
        system.debug('**************leadowner**********'+newlead.owner.Name);
        system.debug('*******LeadCreatedDate****** '+newlead.CreatedDate);
        

      /* list<Bonus_Reports__c> bonusList = new list<Bonus_Reports__c>();
        Bonus_Reports__c br = new Bonus_Reports__c();
        Br.Division__c ='Titans';
        Br.Bonus_Amount_Rs__c = 76;
        Br.Leads_with_LinkedIn_Profile__c =3;   
        Br.Lead_to_Deal__c = 100;
        Br.Paid_Deals__c = 3;
        Br.Lead__c = 'sam';
        Br.Total_Leads__c = 3;
        Br.Total_Deals__c = 3;
        Br.From_Date__c = Date.today()-25;
        //Br.From_Date__c = Date.valueOf(fromDate);
        Br.To_Date__c = Date.today();
        br.uniqueId__c = '2013-05-012013-05-31sample testTitans';
        bonusList.add(br);
        //insert bonusList;
        */
        lead newleads=new lead();
        newleads.Email='kavinma@istrategicloud.com';
        newleads.Division_Name__c='Winners';
        newleads.LeadSource='Approved Index';
    	newleads.Division_Name__c = 'Synergy';
        newleads.Status='Followup';
        newleads.Company = 'SOS1';
        newleads.FirstName='TestS';
        newleads.LastName='TestJohnny';
        newleads.Primary_Service_Name__c='CRM';
        newleads.LinkedIn_URL__c='karthik35/Linkedin.com';
        newleads.Lead_AssignedTo__c='Sam Carter (Titans)';
        newleads.User_Name__c='sample test';
        newleads.Team_Identification__c='Blake Cooper';
        insert newleads;
        system.debug('**************lead**********'+newleads.id);
        system.debug('**************leadowner**********'+newlead.owner.name);
        system.debug('*******LeadCreatedDate****** '+newlead.CreatedDate);
        
        lead newlea=new lead();
        newlea.Email='kevi.maxim@istrategicloud.com';
        newlea.Division_Name__c='Winners';
        newlea.LeadSource='Approved Index';
        newlea.Status='Followup';
        newlea.Company = 'SOS12';
        newlea.FirstName='TestK';
        newlea.LastName='TestSunny';
        newlea.Primary_Service_Name__c='CRM';
        newlea.LinkedIn_URL__c='karthik34/Linkedin.com';
        newlea.Lead_AssignedTo__c='Steve Sujith (Winners)';
        newlea.User_Name__c='Demo test';
        newlea.Team_Identification__c='Manager Steve Sujith';
        newlea.Division_Name__c = 'Synergy';
        insert newlea;
        system.debug('**************lead**********'+newlea.id);
        
        
      Account acc=new Account();
      acc.Name='SOS';
      acc.Email__c='sample@in.com';
      acc.Phone='(954) 344-9254';
      acc.Type='Customer'; 
      insert acc;
      system.debug('*acc*****************'+acc.id);
      
      Contact contact=new Contact();
      contact.AccountId=acc.id;
      contact.Email='sample@in.com';
      contact.LastName='Testjo';
      insert contact;
      system.debug('******con************'+contact.id);
      
      Opportunity opp=new Opportunity();
      opp.Name='sample';
      opp.AccountId=acc.id;
      opp.Lead_Source__c='Approved Index';
      opp.Primary_Service_Name__c='Technology List';
      opp.Division__c='Gladiators';
      opp.StageName='Counts Provided (30%)';
      opp.Sample_To_Deal__c='other';
      opp.Uploaded_By__c='test';
      opp.ForecastCategoryName='pipeline';
      opp.Amount=5000;
      opp.CloseDate=date.today()+5;
      opp.Team_Uploaded_By__c='Winners'; 
      //opp.CreatedDate=datetime.newInstance(2013, 12, 1, 12, 30, 2);
      insert opp;
      system.debug('opp******************'+opp.id);
        
        Opportunity_Payment__c opppay=new Opportunity_Payment__c();
        opppay.Opportunity__c=opp.id;
        opppay.Pay_Status__c='paid';
        opppay.Payment_Amount__c=23442;
        opppay.Payment_Mode__c='Cash';
        insert opppay;
        
         
        LeadGenBonusReportWinners Lreport = new LeadGenBonusReportWinners();
        Lreport.getOptionMonth();
        Lreport.getOptionYear();
        Lreport.ListMonth ='11';
        Lreport.ListYear = '2013';
        Lreport.totalBonusAmount=3475;
        Lreport.lead2DealPercent=85.05;
        Lreport.totalDeals=20;
        Lreport.totalLeads=60;
        Lreport.totalPaidDeals=20;
        Lreport.doSearch();
       // Lreport.getDevList();
        
        
        
        
        
        List<LeadGenBonusReportWinners.LeadGenDivisionReport> LDR=new List<LeadGenBonusReportWinners.LeadGenDivisionReport>();
        LDR=Lreport.getLeadGenDivisionList();
        system.debug(LDR);
        Lreport.getTotalReport();
        Decimal Amount=Lreport.getBonusAmount(60,10,40);
        system.debug('^^^^^^^^^^^^^^^^^^^^^^'+Amount);
        //report.getBonusAmount
        
        
        LeadGenBonusReportWinners.LeadGenReport LGR=new LeadGenBonusReportWinners.LeadGenReport();
        LGR.bonusAmount=84.34;
        LGR.dealCount=10;
        LGR.divisionName='Titans';
        LGR.leadCount=60;
        LGR.leadDeal=73.8;
        LGR.linkedindeal=45;
        LGR.paidCount=10;
        LGR.userName='sample';
        //LGR.LeadGenReport();
        LeadGenBonusReportWinners.LeadGenDivisionReport reportDivGen = new LeadGenBonusReportWinners.LeadGenDivisionReport();
        reportDivGen.getLeadGenReportMap();
        
        test.stoptest();
    }
    static testMethod void unitTestReport(){
        LeadGenBonusReportWinners reportDivGen = new LeadGenBonusReportWinners();
        reportDivGen.getBonusAmount(0,2,20);
        reportDivGen.getBonusAmount(0,3,20);
        reportDivGen.getBonusAmount(1,2,50);
        
    }
}