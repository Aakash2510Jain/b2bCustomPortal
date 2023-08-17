public without sharing class LeadGenBonusReportWinners {

    public String Divname{get;set;}
    public String fromDate{get;set;}
    public String toDate{get;set;}
    public String ListMonth{get;set;}
    public String ListYear{get; set;}
    public String fromDatepicker{get;set;}
    public String toDatepicker{get;set;}
    public string Convertedfromdate;
    public string Convertedtodate;
    
  
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
        options.add(new SelectOption('','None'));
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
        options.add(new selectoption('','None'));
        for(integer i=0;i<12;i++)
        {
          string stryear = string.valueof(CurrentYear); 
            options.add(new selectoption(stryear,stryear ));
            CurrentYear-=1;            
        } 
        return options;
    }
    
    
    
 /*  public PageReference save(){ 
   	system.debug('');
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
   } */
         
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
   
 /*   public Pagereference exportReport(){

    Pagereference pg = new Pagereference('/apex/LeadGenExcelReport');
    pg.setRedirect(false);
    return pg;
    } */
     public void doSearch(){
        Divname = 'Winners';  
    String queryLead;
        String linkedqueryLead;
        String queryOpty;
        String queryPay;
        system.debug('@@@@@@2222222222222222@@@@@@@'+fromDatepicker);
            leadGenDivisionReport.clear();
           
           if(ListYear != ''){
            if(ListYear != null){
            fromdate = ListYear+'-'+ListMonth+'-01';
            Datetime myfromDate = datetime.valueOf(fromDate.split(' ')[0]+' 00:00:00');
            string fromdate1 = string.valueOfGmt(myfromDate);
            Convertedfromdate =fromdate1.substring(0,10) +'T'+ fromdate1.substring(11,19)+'z';
            
            
            todate = ListYear+'-'+ListMonth+'-'+Date.daysInMonth(integer.ValueOf(ListYear), integer.ValueOf(ListMonth));
            Datetime mytoDate = datetime.valueOf(toDate.split(' ')[0]+' 23:59:59');
            string todate1 = string.valueOfGmt(mytoDate);
            Convertedtodate = todate1.substring(0,10) +'T'+ todate1.substring(11,19)+'z';
            }}
            if(fromDatepicker != '') {
            if(fromDatepicker != null) {  
             	system.debug('@@@@@@2222222222222222@@@@@@@'+fromDatepicker);
            fromdate = fromDatepicker;
            system.debug('@@@@@@33333333333@@@@@@@'+fromdate);
            Datetime myfromDate = datetime.valueOf(fromDate.split(' ')[0]+' 00:00:00');
            string fromdate1 = string.valueOfGmt(myfromDate);
            Convertedfromdate =fromdate1.substring(0,10) +'T'+ fromdate1.substring(11,19)+'z';
            
            
            todate = toDatepicker;
            Datetime mytoDate = datetime.valueOf(toDate.split(' ')[0]+' 23:59:59');
            string todate1 = string.valueOfGmt(mytoDate);
            Convertedtodate = todate1.substring(0,10) +'T'+ todate1.substring(11,19)+'z';
            	
            }}
            
            
            System.debug('********************'+fromdate);
            System.debug('********************'+todate);
           System.debug('********************'+Divname);
           
           
                      
       
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
            
           
           queryOpty='select Uploaded_By__c,Division__c from Opportunity where  CloseDate >='+fromdate+' and'+
            ' CloseDate <='+todate+' and StageName = \'Deal\' and Uploaded_By__c!= null and Division__c =\''+Divname+
            '\' and Team_Uploaded_By__c!=\'Web team\' and Team_Uploaded_By__c!=\'Sam Green\' and Team_Uploaded_By__c!=\'Campaign\' and Team_Uploaded_By__c!=\'Content\' and'+
            ' Team_Uploaded_By__c!=\'LeadGen\' and Team_Uploaded_By__c!=\'MPO\' and Team_Uploaded_By__c!=NULL  and isDeleted=false  ALL ROWS';
           
           
             queryPay='Select o.Opportunity__c,o.Opportunity__r.Uploaded_By__c,o.Opportunity__r.Division__c  From Opportunity_Payment__c o where  '+
            ' Payment_Date__c >= '+fromdate+' and  Payment_Date__c <='+todate+'and '+
            ' o.Pay_Status__c IN (\'paid\',\'part payment\') and o.Opportunity__r.Uploaded_By__c!=null and  o.First_Payment__c = True  and o.Opportunity__r.Division__c=\''+Divname+
            '\' and o.Opportunity__r.StageName = \'Deal\' and '+
            ' o.Opportunity__r.Team_Uploaded_By__c!=\'Web team\' and o.Opportunity__r.Team_Uploaded_By__c!=\'Sam Green\' and '+
            ' o.Opportunity__r.Team_Uploaded_By__c!=\'Campaign\' and o.Opportunity__r.Team_Uploaded_By__c!=\'Content\' and '+
            ' o.Opportunity__r.Team_Uploaded_By__c!=\'LeadGen\' and o.Opportunity__r.Team_Uploaded_By__c!=\'MPO\' and '+
            ' o.Opportunity__r.Team_Uploaded_By__c!=NULL '+
            ' and isDeleted=false  ALL ROWS';
            
             
            
            system.debug('queryLead'+queryLead);
            system.debug('queryOpty'+queryOpty);
            system.debug('queryPay'+queryPay);
            system.debug('linkedqueryLead '+linkedqueryLead);
            leadsQueried = Database.query(queryLead);
            System.debug('Leads Queried :'+leadsQueried);
            linkedleadsQueried=Database.query(linkedqueryLead);
            System.debug('@@@@@@@@LinkedInLeads Queried :@@@@@@@@'+linkedleadsQueried);
            opportunityQueried = Database.query(queryOpty);
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
        
        for(Lead leadRecord : leadsQueried){
            
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
        
        for(Opportunity opportunityRecord : opportunityQueried){
            
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
        
        Map<String,String> uniqueOpportunity = new Map<String,String>();
        for(Opportunity_Payment__c paymentRecord : oppPaymentQueried){
            
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
         
             return  MaxAtm;
             }            
        }
        
      return 0;
    }
   
}