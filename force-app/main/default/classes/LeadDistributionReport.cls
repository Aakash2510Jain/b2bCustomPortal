public without sharing class LeadDistributionReport {

    public String Divname{get;set;}
    public String fromDate{get;set;}
    public String toDate{get;set;}
    public String ListMonth{get;set;}
    public String ListYear{get; set;}   
    public string Convertedfromdate;
    public string Convertedtodate;
    public integer i = 1;
   
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
        options.add(new SelectOption('','Select'));
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
        options.add(new selectoption('','Select' ));
        for(integer i=0;i<12;i++)
        {
            string stryear = string.valueof(CurrentYear); 
            options.add(new selectoption(stryear,stryear ));
            CurrentYear-=1;            
        } 
        return options;
    }
 
            
    public class LeadGenReport{
       public string userName{get; set;}
       public string divisionName{get; set;}
       public integer leadCount{get; set;}
       public integer dealCount{get; set;}
       public decimal conversionRate{get; set;}
       //public string DealClosedBy {get; set;}
       //public string LeadAssignedTo {get; set;}
       public integer paidCount{get;set;}             
       public map<String,integer> BdNameMap {get; set;}
       public map<String,integer> BdNameMapForClosedDeal {get; set;}      
       
       public  LeadGenReport(){
         userName ='';        
         divisionName = '';
         leadCount = 0;
         dealCount=0;
         conversionRate=0;
         //DealClosedBy ='';
         //LeadAssignedTo='';
         paidCount=0;              
         BdNameMap = new map<String,integer>();
         BdNameMapForClosedDeal = new map<String,integer>();
        
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
    
    List<Lead> leadsQueried = new List<Lead>();
    List<Opportunity> opportunityQueried = new List<Opportunity>();
    List<Opportunity_Payment__c> oppPaymentQueried = new List<Opportunity_Payment__c>();   
   
    public Pagereference exportReport(){
    Pagereference pg = new Pagereference('/apex/LeadDistributionExcelReport');
    pg.setRedirect(false);
    return pg;
    }
    
     public void doSearch(){
        String queryLead;      
        String queryOpty;
        String queryPay;
            leadGenDivisionReport.clear();           
            system.debug('!!!!!!!!!!'+Listyear);
            system.debug('!!!!!!!!!!'+ListMonth);
           
            if(ListYear != ''){
            if(ListYear != null){
            fromdate = ListYear+'-'+ListMonth+'-01';
            Datetime myfromDate = datetime.valueOf(fromDate.split(' ')[0]+' 00:00:00');
            string fromdate1 = string.valueOfGmt(myfromDate);
            Convertedfromdate =fromdate1.substring(0,10) +'T'+ fromdate1.substring(11,19)+'z';
            system.debug('sssssssssssss'+Convertedfromdate);
            
            todate = ListYear+'-'+ListMonth+'-'+Date.daysInMonth(integer.ValueOf(ListYear), integer.ValueOf(ListMonth));
            Datetime mytoDate = datetime.valueOf(toDate.split(' ')[0]+' 23:59:59');
            string todate1 = string.valueOfGmt(mytoDate);
            Convertedtodate = todate1.substring(0,10) +'T'+ todate1.substring(11,19)+'z';
            }}
          
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
            
           
           queryOpty='select Uploaded_By__c,Division__c,OwnerId,Owner.Name from Opportunity where  CloseDate >= '+fromdate+ ' and'+
            ' CloseDate <='+todate+' and StageName = \'Deal\' and Division__c != null and Uploaded_By__c!= null and'+
            ' Team_Uploaded_By__c!=\'Web team\' and Team_Uploaded_By__c!=\'Sam Green\' and Team_Uploaded_By__c!=\'Campaign\' and Team_Uploaded_By__c!=\'Content\' and'+
            ' Team_Uploaded_By__c!=\'LeadGen\' and Team_Uploaded_By__c!=\'MPO\' and Team_Uploaded_By__c!=NULL  and isDeleted=false  ALL ROWS';
           
            
             queryPay='Select o.Opportunity__c,o.Opportunity__r.Uploaded_By__c,o.Opportunity__r.Division__c, o.Opportunity__r.Owner.Name From Opportunity_Payment__c o where  '+
            ' Payment_Date__c >= ' +fromdate+' and  Payment_Date__c <= ' +todate+' and '+
            ' o.Pay_Status__c IN (\'paid\',\'part payment\') and o.Opportunity__r.Uploaded_By__c!=null and o.Opportunity__r.Division__c!=null  and o.First_Payment__c = True  '+
            ' and o.Opportunity__r.StageName = \'Deal\' and '+
            ' o.Opportunity__r.Team_Uploaded_By__c!=\'Web team\' and o.Opportunity__r.Team_Uploaded_By__c!=\'Sam Green\' and '+
            ' o.Opportunity__r.Team_Uploaded_By__c!=\'Campaign\' and o.Opportunity__r.Team_Uploaded_By__c!=\'Content\' and '+
            ' o.Opportunity__r.Team_Uploaded_By__c!=\'LeadGen\' and o.Opportunity__r.Team_Uploaded_By__c!=\'MPO\' and '+
            ' o.Opportunity__r.Team_Uploaded_By__c!=NULL '+
            ' and isDeleted=false  ALL ROWS';      
           
            
            }else {
           queryLead='select User_Name__c, Division_Name__c, Owner.Name from Lead where'+
            ' CreatedDate >='+Convertedfromdate+' and CreatedDate <='+Convertedtodate+' and '+
             'User_Name__c!= null and Team_Identification__c!=\'Web team\' and'+
            ' Team_Identification__c!=\'Campaign\' and Team_Identification__c!=\'Content\' and Team_Identification__c!=\'LeadGen\' and '+
            ' Team_Identification__c!=\'Sam Green\' and Team_Identification__c!=\'MPO\' and Team_Identification__c!=NULL and isDeleted=false and Division_Name__c= \'' +Divname+
            '\' ALL ROWS';          
           
           queryOpty='select Uploaded_By__c,Division__c,OwnerId,Owner.Name from Opportunity where  CloseDate >='+fromdate+' and'+
            ' CloseDate <='+todate+' and StageName = \'Deal\' and Uploaded_By__c!= null and Division__c =\''+Divname+
            '\' and Team_Uploaded_By__c!=\'Web team\' and Team_Uploaded_By__c!=\'Sam Green\' and Team_Uploaded_By__c!=\'Campaign\' and Team_Uploaded_By__c!=\'Content\' and'+
            ' Team_Uploaded_By__c!=\'LeadGen\' and Team_Uploaded_By__c!=\'MPO\' and Team_Uploaded_By__c!=NULL  and isDeleted=false  ALL ROWS';
           
           queryPay='Select o.Opportunity__c,o.Opportunity__r.Uploaded_By__c,o.Opportunity__r.Division__c, o.Opportunity__r.Owner.Name From Opportunity_Payment__c o where  '+
            ' Payment_Date__c >= '+fromdate+' and  Payment_Date__c <='+todate+'and '+
            ' o.Pay_Status__c IN (\'paid\',\'part payment\') and o.Opportunity__r.Uploaded_By__c!=null and  o.First_Payment__c = True  and o.Opportunity__r.Division__c=\''+Divname+
            '\' and o.Opportunity__r.StageName = \'Deal\' and '+
            ' o.Opportunity__r.Team_Uploaded_By__c!=\'Web team\' and o.Opportunity__r.Team_Uploaded_By__c!=\'Sam Green\' and '+
            ' o.Opportunity__r.Team_Uploaded_By__c!=\'Campaign\' and o.Opportunity__r.Team_Uploaded_By__c!=\'Content\' and '+
            ' o.Opportunity__r.Team_Uploaded_By__c!=\'LeadGen\' and o.Opportunity__r.Team_Uploaded_By__c!=\'MPO\' and '+
            ' o.Opportunity__r.Team_Uploaded_By__c!=NULL '+
            ' and isDeleted=false  ALL ROWS';            
             
            }
            
            system.debug('queryLead'+queryLead);
            system.debug('queryOpty'+queryOpty);
            system.debug('queryPay'+queryPay);
           
            leadsQueried = Database.query(queryLead);
            System.debug('Leads Queried :'+leadsQueried);     
            opportunityQueried = Database.query(queryOpty);
            oppPaymentQueried = Database.query(queryPay);
            
            calculateLeadDistributionReport();
            
    }
    Map<String,LeadGenDivisionReport> leadGenDivisionReport = new Map<String,LeadGenDivisionReport>(); // division name is key
    public LeadGenReport totalReport = new LeadGenReport();
    public List<LeadGenDivisionReport> getLeadGenDivisionList(){
        return leadGenDivisionReport.values();
    }
    public LeadGenReport getTotalReport(){
        return totalReport;
    }
    
    public void calculateLeadDistributionReport(){
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
            //**************************************//          
            string LeadAssigned = leadRecord.Owner.Name;         
            if(!leadGenReport.BdNameMap.ContainsKey(LeadAssigned)){ 
                leadGenReport.BdNameMap.put(LeadAssigned,i) ;
             }
            else{
               i = leadGenReport.BdNameMap.get(LeadAssigned) ;
               i++;
               leadGenReport.BdNameMap.put(LeadAssigned,i) ;
               i = 1;
             }  
            //**************************************//           
             system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'+leadGenReport.BdNameMap) ;
             /*If(leadGenReport.LeadAssignedTo == ''){
            leadGenReport.LeadAssignedTo = LeadAssigned;
            }else
            leadGenReport.LeadAssignedTo = leadGenReport.LeadAssignedTo +','+ LeadAssigned;*/                     
        }   
        
          
            system.debug('#######Map####'+leadGenDivisionReport);
        
        
    
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
             
             if(leadGenReport.paidCount!=0){
                Decimal paidcount = leadGenReport.paidCount;
                Decimal leadcount = leadGenReport.leadCount;
                leadGenReport.conversionRate =(paidCount/leadCount)*100; 
                }
                
            //**************************************//          
            string Dealclosed = paymentRecord.Opportunity__r.Owner.Name;
            if(!leadGenReport.BdNameMapForClosedDeal.ContainsKey(Dealclosed)){ 
                leadGenReport.BdNameMapForClosedDeal.put(Dealclosed,i) ;
             }
             else{
               i = leadGenReport.BdNameMapForClosedDeal.get(Dealclosed) ;
               i++;
               leadGenReport.BdNameMapForClosedDeal.put(Dealclosed,i) ;
               i = 1;
             }
            //**************************************//  
           /* If(leadGenReport.DealClosedBy == ''){
            leadGenReport.DealClosedBy = Dealclosed;
            }else
            leadGenReport.DealClosedBy = leadGenReport.DealClosedBy +','+ Dealclosed;*/             
            leadGenDivisionReport.get(paymentRecord.Opportunity__r.Division__c).leadGenReportMap.put(paymentRecord.Opportunity__r.Uploaded_By__c.toLowerCase(),leadGenReport);
        }    
    }
    }