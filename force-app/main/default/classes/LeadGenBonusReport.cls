public without sharing class LeadGenBonusReport {

    public String Divname{get;set;}
    public String fromDate{get;set;}
    public String toDate{get;set;}
    public String ListMonth{get;set;}
    public String ListYear{get; set;}
    public string Convertedfromdate;
    public string Convertedtodate;
    
   /* public LeadGenBonusReport(){
        doSearch();
        System.debug('********************'+Divname);
    }*/
    
    /* LeadDealCount is a wrapper class which will help to bind different types of data userName, divisionName, leadCount, dealCount and initializing the values at the time of construction of LeadDealCount object.
    */
    public class LeadGenDivisionReport{
        public String divisionName {get;set;}
        public Map<String,LeadGenReport> leadGenReportMap = new Map<String,LeadGenReport>();
        public LeadGenDivisionReport(){
            divisionName='';
        }
        public List<LeadGenReport> getLeadGenReportMap(){
            return leadGenReportMap.values();
        }
    }
    
     public List<SelectOption> getOptionMonth() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('01','Jan'));
        options.add(new SelectOption('02','Feb'));
        options.add(new SelectOption('03','Mar'));
        options.add(new SelectOption('04','April'));
        options.add(new SelectOption('05','May'));
        options.add(new SelectOption('06','June'));
        options.add(new SelectOption('07','July'));
        options.add(new SelectOption('08','Aug'));
        options.add(new SelectOption('09','Sep'));
        options.add(new SelectOption('10','Oct'));
        options.add(new SelectOption('11','Nov'));
        options.add(new SelectOption('12','Dec')); 

        return options;
    }
    public List<SelectOption> getOptionYear(){
        Integer CurrentYear = datetime.now().year();
        List<selectoption> options=new List<selectoption>();
        options.clear();
        for(integer i=0;i<12;i++)
        {
            string stryear = string.valueof(CurrentYear); 
            options.add(new selectoption(stryear,stryear ));
            CurrentYear-=1;            
        } 
        return options;
    }
    
    
    
   public PageReference save(){ 
        List<Bonus_Reports__c> bonusReportList = new List<Bonus_Reports__c>();
        System.debug('----------------'+leadGenDivisionReport.size()); 
        for(LeadGenDivisionReport leadGenDivReport : leadGenDivisionReport.values()){
            System.debug('--------1--------'+leadGenDivReport.leadGenReportMap.size());
            for(LeadGenReport leadGenReport : leadGenDivReport.leadGenReportMap.values()){
                Bonus_Reports__c bouns = new Bonus_Reports__c();            
                bouns.Division__c=leadGenReport.divisionName;       
                bouns.Bonus_Amount_Rs__c=leadGenReport.bonusAmount;
                bouns.Leads_with_LinkedIn_Profile__c=leadGenReport.linkedindeal;
                bouns.Lead_to_Deal__c=leadGenReport.leadDeal;
                bouns.Paid_Deals__c=leadGenReport.paidCount;
                bouns.Lead__c=leadGenReport.userName;
                bouns.Total_Leads__c=leadGenReport.leadCount;
                bouns.Total_Deals__c=leadGenReport.dealCount;   
                bouns.From_Date__c=Date.valueOf(fromDate);
                bouns.To_Date__c=Date.valueOf(toDate);
                bouns.uniqueId__c = fromDate+toDate+leadGenReport.userName+leadGenReport.divisionName;
                bonusReportList.add(bouns); 
                
            }
        }
        if(bonusReportList.size() > 0){
            
                List<Bonus_Reports__c> Brq =[select Division__c,Bonus_Amount_Rs__c,Leads_with_LinkedIn_Profile__c,
                                        Lead_to_Deal__c,Paid_Deals__c,Lead__c,Total_Leads__c,Total_Deals__c,
                                        From_Date__c,To_Date__c,UniqueID__c FROM Bonus_Reports__c ];
                    if(Brq !=  NULL && Brq.size() > 0){
                    for (integer j=0;j<bonusReportList.size();j++){ 
                            for(integer i=0;i<Brq.size();i++){  
                                system.debug('$$$i : '+i);
                                if ( Brq[i].UniqueID__c == bonusReportList[j].UniqueID__c){
                                    Brq[i].Division__c = bonusReportList[j].Division__c;
                                    Brq[i].Bonus_Amount_Rs__c = bonusReportList[j].Bonus_Amount_Rs__c;
                                    Brq[i].Leads_with_LinkedIn_Profile__c =bonusReportList[j].Leads_with_LinkedIn_Profile__c;   
                                    Brq[i].Lead_to_Deal__c = bonusReportList[j].Lead_to_Deal__c;
                                    Brq[i].Paid_Deals__c = bonusReportList[j].Paid_Deals__c;
                                    Brq[i].Lead__c = bonusReportList[j].Lead__c;
                                    Brq[i].Total_Leads__c = bonusReportList[j].Total_Leads__c;
                                    Brq[i].Total_Deals__c = bonusReportList[j].Total_Deals__c;
                                    Brq[i].From_Date__c = bonusReportList[j].From_Date__c;
                                    Brq[i].To_Date__c = bonusReportList[j].To_Date__c;
                                    update Brq[i];      
                                    bonusReportList.remove(j);
                                    j--;
                                    break;
                                }
                            }
                                
                            }
                        
                        insert bonusReportList;
        }
        else
                        insert bonusReportList;
        }
        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Report successfully Saved.'));
         return null;
    }
            
    public class LeadGenReport{
       public string userName{get; set;}
       public string divisionName{get; set;}
       public integer leadCount{get; set;}
       public integer dealCount{get; set;}
       public integer paidCount{get;set;}
       public Decimal leadDeal{get;set;}
       public Decimal bonusAmount{get;set;}
       public integer linkedindeal{get;set;}
       public  LeadGenReport(){
         userName ='';
         divisionName = '';
         leadCount = 0;
         dealCount=0;
         paidCount=0;
         leadDeal=0;
         bonusAmount=0;
         linkedindeal=0;  
        }
    }
    public list<selectoption> getDevList(){
            List<SelectOption> Divlist = new List<SelectOption>();
            
            Schema.DescribeFieldResult fieldResult = lead.Division_Name__c.getDescribe();
            List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            Divlist.add(new SelectOption('','None'));  
            Divlist.add(new SelectOption('All','All'));  
               for( Schema.PicklistEntry f : ple)
               {
                  Divlist.add(new SelectOption(f.getLabel(), f.getValue()));
               }  
             
           return Divlist;
     }
    
    
    /*Below varible names explains the use of them */
    public integer totalLeads {get; set;}
    public integer totalDeals {get; set;}
    public integer totalPaidDeals {get;set;}
    public Decimal lead2DealPercent{get;set;}    
    public Decimal totalBonusAmount{get;set;}
    
    List<Lead> leadsQueried = new List<Lead>();
    List<Opportunity> opportunityQueried = new List<Opportunity>();
    List<Opportunity_Payment__c> oppPaymentQueried = new List<Opportunity_Payment__c>();
    List<Lead> linkedleadsQueried = new List<Lead>();
    List<Lead> FillteredLead = new List<Lead>();
   
    public Pagereference exportReport(){

    Pagereference pg = new Pagereference('/apex/LeadGenExcelReport');
    pg.setRedirect(false);
    return pg;
    }
     public void doSearch(){
        String queryLead;
        String linkedqueryLead;
        String queryOpty;
        String queryPay;
            leadGenDivisionReport.clear();
           /*  if(fromDate==null&&toDate==null){
             date dt= date.today();  
             Date dt1 = dt.toStartOfMonth();
             fromdate=string.valueOf(dt1);
             todate=String.valueOf(System.today());
             System.debug('********************'+fromdate);
             System.debug('********************'+todate);
            } */
            fromdate = ListYear+'-'+ListMonth+'-01';
            Datetime myfromDate = datetime.valueOf(fromDate.split(' ')[0]+' 00:00:00');
            string fromdate1 = string.valueOfGmt(myfromDate);
            Convertedfromdate =fromdate1.substring(0,10) +'T'+ fromdate1.substring(11,19)+'z';
            
            
            todate = ListYear+'-'+ListMonth+'-'+Date.daysInMonth(integer.ValueOf(ListYear), integer.ValueOf(ListMonth));
            Datetime mytoDate = datetime.valueOf(toDate.split(' ')[0]+' 23:59:59');
            string todate1 = string.valueOfGmt(mytoDate);
            Convertedtodate = todate1.substring(0,10) +'T'+ todate1.substring(11,19)+'z';
            
            System.debug('********************'+fromdate);
            System.debug('********************'+todate);
           System.debug('********************'+Divname);
           
           
                      
           if(Divname==''||Divname==null){
                Divname='All';
           }
            if(Divname=='All'){
                 queryLead='select User_Name__c,Owner.Name,CreatedDate, Division_Name__c from Lead where'+
            ' CreatedDate >=' +Convertedfromdate+ ' and CreatedDate <=' +Convertedtodate+ ' and '+
            'Division_Name__c!= null and User_Name__c!= null and Team_Identification__c!=\'Web team\' and'+
            ' Team_Identification__c!=\'Campaign\' and Team_Identification__c!=\'Content\' and Team_Identification__c!=\'LeadGen\' and '+
            ' Team_Identification__c!=\'Sam Green\' and Team_Identification__c!=\'MPO\' and Team_Identification__c!=NULL and isDeleted=false '+
            '  Order By Division_Name__c Desc ALL ROWS';
            
            linkedqueryLead='select User_Name__c, Division_Name__c from Lead where'+
            ' CreatedDate >='+Convertedfromdate+ ' and CreatedDate <='+Convertedtodate+' and '+
            'Division_Name__c!= null and LinkedIn_URL__c!=null and User_Name__c!= null and Team_Identification__c!=\'Web team\' and'+
            ' Team_Identification__c!=\'Campaign\' and Team_Identification__c!=\'Content\' and Team_Identification__c!=\'LeadGen\' and '+
            ' Team_Identification__c!=\'Sam Green\' and Team_Identification__c!=\'MPO\' and Team_Identification__c!=NULL and isDeleted=false '+
            '  Order By Division_Name__c Desc ALL ROWS'; 
            // 'LeadSource!=\'Campaign Website\' and LeadSource!=\'PPC Lead\' and LeadSource!=\'Prospecting Website\' and '+
            // 'LeadSource!=\'SEO Leads\' and LeadSource!=\'Web Site Lead\' and LeadSource!=\'White Paper Lead\' and ';
           queryOpty='select Uploaded_By__c,Division__c from Opportunity where  CloseDate >= '+fromdate+ ' and'+
            ' CloseDate <='+todate+' and StageName = \'Deal\' and Division__c != null and Uploaded_By__c!= null and'+
            ' Team_Uploaded_By__c!=\'Web team\' and Team_Uploaded_By__c!=\'Sam Green\' and Team_Uploaded_By__c!=\'Campaign\' and Team_Uploaded_By__c!=\'Content\' and'+
            ' Team_Uploaded_By__c!=\'LeadGen\' and Team_Uploaded_By__c!=\'MPO\' and Team_Uploaded_By__c!=NULL  and isDeleted=false  ALL ROWS';
            //' and LeadSource!=\'Blog Lead\' and'+
            //' LeadSource!=\'Campaign Website\' and LeadSource!=\'PPC Lead\' and LeadSource!=\'Prospecting Website\' and LeadSource!=\'SEO Leads\' and'+
            //' LeadSource!=\'Web Site Lead\' and LeadSource!=\'White Paper Lead\'';
          
          //====================Modified by sathya===================
          /*
           queryPay='Select o.Opportunity__c,o.Opportunity__r.Uploaded_By__c,o.Opportunity__r.Division__c  From Opportunity_Payment__c o where  '+
            ' Payment_Date__c >= ' +fromdate+' and  Payment_Date__c <= ' +todate+' and '+
            ' o.Pay_Status__c IN (\'paid\',\'part payment\') and o.Opportunity__r.Uploaded_By__c!=null and o.Opportunity__r.Division__c!=null  and o.Opportunity__r.Payment_Times__c < 2  '+
            ' and o.Opportunity__r.StageName = \'Deal\' and '+
            ' o.Opportunity__r.Team_Uploaded_By__c!=\'Web team\' and o.Opportunity__r.Team_Uploaded_By__c!=\'Sam Green\' and '+
            ' o.Opportunity__r.Team_Uploaded_By__c!=\'Campaign\' and o.Opportunity__r.Team_Uploaded_By__c!=\'Content\' and '+
            ' o.Opportunity__r.Team_Uploaded_By__c!=\'LeadGen\' and o.Opportunity__r.Team_Uploaded_By__c!=\'MPO\' and '+
            ' o.Opportunity__r.Team_Uploaded_By__c!=NULL '+
            ' and isDeleted=false  ALL ROWS';
            */
             queryPay='Select o.Opportunity__c,o.Opportunity__r.Uploaded_By__c,o.Opportunity__r.Division__c  From Opportunity_Payment__c o where  '+
            ' Payment_Date__c >= ' +fromdate+' and  Payment_Date__c <= ' +todate+' and '+
            ' o.Pay_Status__c IN (\'paid\',\'part payment\') and o.Opportunity__r.Uploaded_By__c!=null and o.Opportunity__r.Division__c!=null  and o.First_Payment__c = True  '+
            ' and o.Opportunity__r.StageName = \'Deal\' and '+
            ' o.Opportunity__r.Team_Uploaded_By__c!=\'Web team\' and o.Opportunity__r.Team_Uploaded_By__c!=\'Sam Green\' and '+
            ' o.Opportunity__r.Team_Uploaded_By__c!=\'Campaign\' and o.Opportunity__r.Team_Uploaded_By__c!=\'Content\' and '+
            ' o.Opportunity__r.Team_Uploaded_By__c!=\'LeadGen\' and o.Opportunity__r.Team_Uploaded_By__c!=\'MPO\' and '+
            ' o.Opportunity__r.Team_Uploaded_By__c!=NULL '+
            ' and isDeleted=false  ALL ROWS';
            
            //====================Modified by sathya===================
            
            }else {
           queryLead='select User_Name__c, Division_Name__c from Lead where'+
            ' CreatedDate >='+Convertedfromdate+' and CreatedDate <='+Convertedtodate+' and '+
             'User_Name__c!= null and Team_Identification__c!=\'Web team\' and'+
            ' Team_Identification__c!=\'Campaign\' and Team_Identification__c!=\'Content\' and Team_Identification__c!=\'LeadGen\' and '+
            ' Team_Identification__c!=\'Sam Green\' and Team_Identification__c!=\'MPO\' and Team_Identification__c!=NULL and isDeleted=false and Division_Name__c= \'' +Divname+
            '\' ALL ROWS';
            
            linkedqueryLead='select User_Name__c, Division_Name__c from Lead where'+
            ' CreatedDate >='+Convertedfromdate+' and CreatedDate <='+Convertedtodate+' and '+
            ' LinkedIn_URL__c!=null and User_Name__c!= null and Team_Identification__c!=\'Web team\' and'+
            ' Team_Identification__c!=\'Campaign\' and Team_Identification__c!=\'Content\' and Team_Identification__c!=\'LeadGen\' and '+
            ' Team_Identification__c!=\'Sam Green\' and Team_Identification__c!=\'MPO\' and Team_Identification__c!=NULL and isDeleted=false and Division_Name__c= \''+Divname+
            '\' ALL ROWS'; 
            // 'LeadSource!=\'Campaign Website\' and LeadSource!=\'PPC Lead\' and LeadSource!=\'Prospecting Website\' and '+
            // 'LeadSource!=\'SEO Leads\' and LeadSource!=\'Web Site Lead\' and LeadSource!=\'White Paper Lead\' and ';
           
           queryOpty='select Uploaded_By__c,Division__c from Opportunity where  CloseDate >='+fromdate+' and'+
            ' CloseDate <='+todate+' and StageName = \'Deal\' and Uploaded_By__c!= null and Division__c =\''+Divname+
            '\' and Team_Uploaded_By__c!=\'Web team\' and Team_Uploaded_By__c!=\'Sam Green\' and Team_Uploaded_By__c!=\'Campaign\' and Team_Uploaded_By__c!=\'Content\' and'+
            ' Team_Uploaded_By__c!=\'LeadGen\' and Team_Uploaded_By__c!=\'MPO\' and Team_Uploaded_By__c!=NULL  and isDeleted=false  ALL ROWS';
           
            //' and LeadSource!=\'Blog Lead\' and'+
            //' LeadSource!=\'Campaign Website\' and LeadSource!=\'PPC Lead\' and LeadSource!=\'Prospecting Website\' and LeadSource!=\'SEO Leads\' and'+
            //' LeadSource!=\'Web Site Lead\' and LeadSource!=\'White Paper Lead\'';
           
            //====================Modified by sathya===================
          /*
           queryPay='Select o.Opportunity__c,o.Opportunity__r.Uploaded_By__c,o.Opportunity__r.Division__c  From Opportunity_Payment__c o where  '+
            ' Payment_Date__c >= '+fromdate+' and  Payment_Date__c <='+todate+'and '+
            ' o.Pay_Status__c IN (\'paid\',\'part payment\') and o.Opportunity__r.Uploaded_By__c!=null and  o.Opportunity__r.Payment_Times__c < 2 and o.Opportunity__r.Division__c=\''+Divname+
            '\' and o.Opportunity__r.StageName = \'Deal\' and '+
            ' o.Opportunity__r.Team_Uploaded_By__c!=\'Web team\' and o.Opportunity__r.Team_Uploaded_By__c!=\'Sam Green\' and '+
            ' o.Opportunity__r.Team_Uploaded_By__c!=\'Campaign\' and o.Opportunity__r.Team_Uploaded_By__c!=\'Content\' and '+
            ' o.Opportunity__r.Team_Uploaded_By__c!=\'LeadGen\' and o.Opportunity__r.Team_Uploaded_By__c!=\'MPO\' and '+
            ' o.Opportunity__r.Team_Uploaded_By__c!=NULL '+
            ' and isDeleted=false  ALL ROWS';
            
            */
             queryPay='Select o.Opportunity__c,o.Opportunity__r.Uploaded_By__c,o.Opportunity__r.Division__c  From Opportunity_Payment__c o where  '+
            ' Payment_Date__c >= '+fromdate+' and  Payment_Date__c <='+todate+'and '+
            ' o.Pay_Status__c IN (\'paid\',\'part payment\') and o.Opportunity__r.Uploaded_By__c!=null and  o.First_Payment__c = True  and o.Opportunity__r.Division__c=\''+Divname+
            '\' and o.Opportunity__r.StageName = \'Deal\' and '+
            ' o.Opportunity__r.Team_Uploaded_By__c!=\'Web team\' and o.Opportunity__r.Team_Uploaded_By__c!=\'Sam Green\' and '+
            ' o.Opportunity__r.Team_Uploaded_By__c!=\'Campaign\' and o.Opportunity__r.Team_Uploaded_By__c!=\'Content\' and '+
            ' o.Opportunity__r.Team_Uploaded_By__c!=\'LeadGen\' and o.Opportunity__r.Team_Uploaded_By__c!=\'MPO\' and '+
            ' o.Opportunity__r.Team_Uploaded_By__c!=NULL '+
            ' and isDeleted=false  ALL ROWS';
            
             //====================Modified by sathya===================
            }
            
            system.debug('queryLead'+queryLead);
            system.debug('queryOpty'+queryOpty);
            system.debug('queryPay'+queryPay);
            system.debug('linkedqueryLead '+linkedqueryLead);
            leadsQueried = Database.query(queryLead);
            System.debug('Leads Queried :'+leadsQueried);
            linkedleadsQueried=Database.query(linkedqueryLead);
            System.debug('@@@@@@@@LinkedInLeads Queried :@@@@@@@@'+linkedleadsQueried);
            opportunityQueried = Database.query(queryOpty);
            system.debug(queryOpty);
            oppPaymentQueried = Database.query(queryPay);
            
            calculateBonusReport();
            
    }
    Map<String,LeadGenDivisionReport> leadGenDivisionReport = new Map<String,LeadGenDivisionReport>(); // division name is key
    public LeadGenReport totalReport = new LeadGenReport();
    public List<LeadGenDivisionReport> getLeadGenDivisionList(){
        return leadGenDivisionReport.values();
    }
    public LeadGenReport getTotalReport(){
        return totalReport;
    }
    public void calculateBonusReport(){
        totalReport = new LeadGenReport();
        //Generate and Update Indivdual Object for every LeadGen in Leads Object
        for(Lead leadRecord : leadsQueried){
            //System.debug('Lead Record : '+leadRecord);
            //System.debug('Lead Division :'+leadGenDivisionReport);
            if(!leadGenDivisionReport.containsKey(leadRecord.Division_Name__c)){
                LeadGenDivisionReport divisionReport = new LeadGenDivisionReport();
                divisionReport.divisionName = leadRecord.Division_Name__c;
                leadGenDivisionReport.put(leadRecord.Division_Name__c,divisionReport);
            }
            LeadGenReport leadGenReport = new LeadGenReport();
            if(leadGenDivisionReport.get(leadRecord.Division_Name__c).leadGenReportMap.containsKey(leadRecord.User_Name__c.toLowerCase())){
                leadGenReport = leadGenDivisionReport.get(leadRecord.Division_Name__c).leadGenReportMap.get(leadRecord.User_Name__c.toLowerCase());
            }
            string LeadUName = leadRecord.User_Name__c;
            leadGenReport.userName = LeadUName.toLowerCase();
            leadGenReport.divisionName = leadRecord.Division_Name__c;
            leadGenReport.leadCount = leadGenReport.leadCount+1;
            leadGenDivisionReport.get(leadRecord.Division_Name__c).leadGenReportMap.put(LeadUName.toLowerCase(),leadGenReport);         
        }
        system.debug('#######Map####'+leadGenDivisionReport);
        
        
        for(Lead LinkedInleadRecord : linkedleadsQueried){
            //System.debug('Lead Record : '+leadRecord);
            //System.debug('Lead Division :'+leadGenDivisionReport);
            if(!leadGenDivisionReport.containsKey(LinkedInleadRecord.Division_Name__c)){
                LeadGenDivisionReport divisionReport = new LeadGenDivisionReport();
                divisionReport.divisionName = LinkedInleadRecord.Division_Name__c;
                leadGenDivisionReport.put(LinkedInleadRecord.Division_Name__c,divisionReport);
            }
            LeadGenReport leadGenReport = new LeadGenReport();
            if(leadGenDivisionReport.get(LinkedInleadRecord.Division_Name__c).leadGenReportMap.containsKey(LinkedInleadRecord.User_Name__c.toLowerCase())){
                leadGenReport = leadGenDivisionReport.get(LinkedInleadRecord.Division_Name__c).leadGenReportMap.get(LinkedInleadRecord.User_Name__c.toLowerCase());
            }
            leadGenReport.userName = LinkedInleadRecord.User_Name__c.toLowerCase();
            leadGenReport.divisionName = LinkedInleadRecord.Division_Name__c;
            
            leadGenReport.linkedindeal = leadGenReport.linkedindeal+1;
            leadGenDivisionReport.get(LinkedInleadRecord.Division_Name__c).leadGenReportMap.put(LinkedInleadRecord.User_Name__c.toLowerCase(),leadGenReport);         
        }
        //Generate and Update Indivdual Object for every LeadGen in Leads Object
        for(Opportunity opportunityRecord : opportunityQueried){
            //System.debug('Opp Record : '+opportunityRecord);
            //System.debug('Opp Division :'+leadGenDivisionReport);
            if(!leadGenDivisionReport.containsKey(opportunityRecord.Division__c)){
                LeadGenDivisionReport divisionReport = new LeadGenDivisionReport();
                divisionReport.divisionName = opportunityRecord.Division__c;
                leadGenDivisionReport.put(opportunityRecord.Division__c,divisionReport);
            }
            LeadGenReport leadGenReport = new LeadGenReport();
            if(leadGenDivisionReport.get(opportunityRecord.Division__c).leadGenReportMap.containsKey(opportunityRecord.Uploaded_By__c.toLowerCase())){
                leadGenReport = leadGenDivisionReport.get(opportunityRecord.Division__c).leadGenReportMap.get(opportunityRecord.Uploaded_By__c.toLowerCase());
            }
            leadGenReport.userName = opportunityRecord.Uploaded_By__c.toLowerCase();
            leadGenReport.divisionName = opportunityRecord.Division__c;
            leadGenReport.dealCount = leadGenReport.dealCount+1;
            leadGenDivisionReport.get(opportunityRecord.Division__c).leadGenReportMap.put(opportunityRecord.Uploaded_By__c.toLowerCase(),leadGenReport);      
        }
        //Payments for unique Opportunity would be 1 paid deal, irrespective of number of payment records
        Map<String,String> uniqueOpportunity = new Map<String,String>();
        for(Opportunity_Payment__c paymentRecord : oppPaymentQueried){
            //System.debug('Payment Record : '+paymentRecord);
            //System.debug('Payment Division :'+leadGenDivisionReport);
            if(!leadGenDivisionReport.containsKey(paymentRecord.Opportunity__r.Division__c)){
                LeadGenDivisionReport divisionReport = new LeadGenDivisionReport();
                divisionReport.divisionName = paymentRecord.Opportunity__r.Division__c;
                leadGenDivisionReport.put(paymentRecord.Opportunity__r.Division__c,divisionReport);
            }
            LeadGenReport leadGenReport = new LeadGenReport();
            if(leadGenDivisionReport.get(paymentRecord.Opportunity__r.Division__c).leadGenReportMap.containsKey(paymentRecord.Opportunity__r.Uploaded_By__c.toLowerCase())){
                leadGenReport = leadGenDivisionReport.get(paymentRecord.Opportunity__r.Division__c).leadGenReportMap.get(paymentRecord.Opportunity__r.Uploaded_By__c.toLowerCase());
            }
            leadGenReport.userName = paymentRecord.Opportunity__r.Uploaded_By__c.toLowerCase();
            leadGenReport.divisionName = paymentRecord.Opportunity__r.Division__c;
            if(!uniqueOpportunity.containsKey(paymentRecord.Opportunity__c)){
                leadGenReport.paidCount = leadGenReport.paidCount+1;
                uniqueOpportunity.put(paymentRecord.Opportunity__c,paymentRecord.Opportunity__c);
            }
            leadGenDivisionReport.get(paymentRecord.Opportunity__r.Division__c).leadGenReportMap.put(paymentRecord.Opportunity__r.Uploaded_By__c.toLowerCase(),leadGenReport);
        }
        
        //calculate bonus for each leadgen
        Set<String> divisions = leadGenDivisionReport.keySet();
        for(String divisionRept : divisions){
            
            Set<String> leadgen = leadGenDivisionReport.get(divisionRept).leadGenReportMap.keySet();
            for(String leadGenPerson : leadgen){
                 system.debug('leadGenPerson : '+leadGenPerson);
            
                leadGenDivisionReport.get(divisionRept).leadGenReportMap.get(leadGenPerson).bonusAmount = 
                    getBonusAmount(leadGenDivisionReport.get(divisionRept).leadGenReportMap.get(leadGenPerson).leadCount,
                                leadGenDivisionReport.get(divisionRept).leadGenReportMap.get(leadGenPerson).paidCount,
                                leadGenDivisionReport.get(divisionRept).leadGenReportMap.get(leadGenPerson).linkedindeal);

                
                if(leadGenDivisionReport.get(divisionRept).leadGenReportMap.get(leadGenPerson).leadCount== 0 ){
                leadGenDivisionReport.get(divisionRept).leadGenReportMap.get(leadGenPerson).leadDeal =0;
                }else{              
                leadGenDivisionReport.get(divisionRept).leadGenReportMap.get(leadGenPerson).leadDeal =
                    (((decimal.valueof(leadGenDivisionReport.get(divisionRept).leadGenReportMap.get(leadGenPerson).paidCount))*100)
                            /(decimal.valueof(leadGenDivisionReport.get(divisionRept).leadGenReportMap.get(leadGenPerson).leadCount)));
                }
                totalReport.leadCount = totalReport.leadCount+leadGenDivisionReport.get(divisionRept).leadGenReportMap.get(leadGenPerson).leadCount;
                totalReport.dealCount = totalReport.dealCount+leadGenDivisionReport.get(divisionRept).leadGenReportMap.get(leadGenPerson).dealCount;
                totalReport.paidCount = totalReport.paidCount+leadGenDivisionReport.get(divisionRept).leadGenReportMap.get(leadGenPerson).paidCount;
                system.debug('####totalReport.linkedindeal####'+totalReport.linkedindeal);
                system.debug('####leadGenDivisionReport.linkedindeal####'+leadGenDivisionReport.get(divisionRept).leadGenReportMap.get(leadGenPerson).linkedindeal);
                totalReport.linkedindeal = totalReport.linkedindeal+leadGenDivisionReport.get(divisionRept).leadGenReportMap.get(leadGenPerson).linkedindeal;
                system.debug('####GrandtotalReport.linkedindeal####'+totalReport.linkedindeal);
                if(totalReport.leadCount+leadGenDivisionReport.get(divisionRept).leadGenReportMap.get(leadGenPerson).leadCount==0 ){
                totalReport.leadDeal = 0.0; 
                }else{
                    system.debug('totalReport.paidCount: '+totalReport.paidCount);
                    system.debug('leadGenDivisionReport.get(divisionRept).leadGenReportMap.get(leadGenPerson).paidCount: '+leadGenDivisionReport.get(divisionRept).leadGenReportMap.get(leadGenPerson).paidCount);
                    system.debug('totalReport.leadCount: '+totalReport.leadCount);
                    system.debug('leadGenDivisionReport.get(divisionRept).leadGenReportMap.get(leadGenPerson).leadCount: '+leadGenDivisionReport.get(divisionRept).leadGenReportMap.get(leadGenPerson).leadCount);
                
               /* totalReport.leadDeal =((decimal.valueof(totalReport.paidCount+leadGenDivisionReport.get(divisionRept).leadGenReportMap.get(leadGenPerson).paidCount)*100)
                                        /(totalReport.leadCount+leadGenDivisionReport.get(divisionRept).leadGenReportMap.get(leadGenPerson).leadCount));
                */
                
                totalReport.leadDeal =((decimal.valueof(totalReport.paidCount)*100)
                                        /(totalReport.leadCount));
                system.debug('totalReport.leadDeal: '+totalReport.leadDeal);
                }   
                totalReport.bonusAmount = totalReport.bonusAmount+leadGenDivisionReport.get(divisionRept).leadGenReportMap.get(leadGenPerson).bonusAmount;
                system.debug('******Leadcount*********'+leadGenDivisionReport.get(divisionRept).leadGenReportMap.get(leadGenPerson).leadCount);
                        system.debug('******LinkedinLeadcount*********'+leadGenDivisionReport.get(divisionRept).leadGenReportMap.get(leadGenPerson).linkedindeal);
                system.debug('******BonusAmount*********'+leadGenDivisionReport.get(divisionRept).leadGenReportMap.get(leadGenPerson).bonusAmount);           
            }
            
        }
        //totalReport.leadDeal =    (((decimal.valueof(totalReport.paidCount))*100)/(decimal.valueof(totalReport.leadCount)));      
        //totalReport.bonusAmount = getBonusAmount(totalReport.leadCount,totalReport.paidCount);

    }
    
    public Decimal getBonusAmount(Integer totalLead, Integer PaidLead,Integer linkedindeal){
             Decimal tempMinAtm = 2500.00;
             Decimal tempMaxAtm = 5000.00;
        if(totalLead!= 0 && linkedindeal>=40){
         if( PaidLead <= 2 && PaidLead !=0 ){
             Decimal MinAtm =  (tempMinAtm * PaidLead)+(linkedindeal*50);
             System.debug('below 50:'+tempMinAtm);
             return MinAtm;
             }        
         else if( PaidLead >= 3 && PaidLead !=0 ){
            Decimal MaxAtm  = ((tempMinAtm  * 2) + ((PaidLead-2)* tempMaxAtm)+(linkedindeal*50));
          //   System.debug('below2 50 :'+tempMaxAtm);
             return  MaxAtm;
             }            
        }else{
         if( PaidLead <= 2 && PaidLead !=0 ){
             Decimal MinAtm =  (tempMinAtm * PaidLead);
             System.debug('below 50:'+tempMinAtm);
             return MinAtm;
             }        
         else if( PaidLead >= 3 && PaidLead !=0 ){
            Decimal MaxAtm  = ((tempMinAtm  * 2) + ((PaidLead-2)* tempMaxAtm));
          //   System.debug('below2 50 :'+tempMaxAtm);
             return  MaxAtm;
             }            
        }
        
      return 0;
    }
    
    static testMethod void myUnitTest_LeadGenController(){
        
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
        newlead.Division_Name__c='Rainmakers';
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
        

       list<Bonus_Reports__c> bonusList = new list<Bonus_Reports__c>();
        Bonus_Reports__c br = new Bonus_Reports__c();
        Br.Division__c ='Titans';
        Br.Bonus_Amount_Rs__c = 76;
        Br.Leads_with_LinkedIn_Profile__c =3;   
        Br.Lead_to_Deal__c = 100;
        Br.Paid_Deals__c = 3;
        Br.Lead__c = 'sam';
        Br.Total_Leads__c = 3;
        Br.Total_Deals__c = 3;
        Br.From_Date__c = Date.parse('10/12/2013');
        //Br.From_Date__c = Date.valueOf(fromDate);
        Br.To_Date__c = Date.today()-90;
        br.uniqueId__c = '2013-05-012013-05-31sample testTitans';
        bonusList.add(br);
        //insert bonusList;
        
        lead newleads=new lead();
        newleads.Email='kavinma@istrategicloud.com';
        newleads.Division_Name__c='Titans';
        newleads.LeadSource='Approved Index';
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
        insert newlea;
        system.debug('**************lead**********'+newlea.id);
        
        
      Account acc=new Account();
      acc.Name='SOS';
      acc.Email__c='sample@in.com';
      acc.Phone='(954) 344-9254';
      acc.Type='Customer'; 
      insert acc;
      system.debug('*acc*****************'+acc.id);
      
   /*   Contact contact=new Contact();
      contact.AccountId=acc.id;
      contact.Email='sample@in.com';
      contact.LastName='Testjo';
      insert contact;
      system.debug('******con************'+contact.id); */
      
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
      opp.CloseDate=date.parse('12/4/2013');
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
        
         
        LeadGenBonusReport Lreport = new LeadGenBonusReport();
        Lreport.Divname='All';
        Lreport.getOptionMonth();
        Lreport.getOptionYear();
        Lreport.fromDate='2013-09-01';
        Lreport.toDate='2013-09-31';
        Lreport.ListMonth = '10';
        Lreport.ListYear = '2013';
        Lreport.totalBonusAmount=3475;
        Lreport.lead2DealPercent=85.05;
        Lreport.totalDeals=20;
        Lreport.totalLeads=60;
        Lreport.totalPaidDeals=20;
        Lreport.getDevList();
        Lreport.doSearch();
        
        List<LeadGenDivisionReport> LDR=new List<LeadGenDivisionReport>();
        LDR=Lreport.getLeadGenDivisionList();
        system.debug(LDR);
        Lreport.getTotalReport();
        Decimal Amount=Lreport.getBonusAmount(60,10,40);
        system.debug('^^^^^^^^^^^^^^^^^^^^^^'+Amount);
        //report.getBonusAmount
        
        
        LeadGenReport LGR=new LeadGenReport();
        LGR.bonusAmount=84.34;
        LGR.dealCount=10;
        LGR.divisionName='Titans';
        LGR.leadCount=60;
        LGR.leadDeal=73.8;
        LGR.linkedindeal=45;
        LGR.paidCount=10;
        LGR.userName='sample';
        //LGR.LeadGenReport();
        LeadGenDivisionReport reportDivGen = new LeadGenDivisionReport();
        reportDivGen.getLeadGenReportMap();
        Lreport.exportReport();
        Lreport.calculateBonusReport();
        Lreport.save();
        test.stoptest();
    }
    
    
}