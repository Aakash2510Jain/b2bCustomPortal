public  without sharing class CommonTeamwiseReport {

    public string UserName{get;set;}
    public String fromDate{get;set;}
    public String toDate{get;set;}
    public string Userid;
    public string divisionstr;
    public string Convertedfromdate;
    public string Convertedtodate;
    public String thirdFloorStr = '(\'Rainmakers\',\'Titans\',\'Team WML\')';
    public String secondFloorStr = '(\'Spartans\',\'Mauryas\',\'Mavericks\',\'Stallions\')';
    public String firstFloorStr = '(\'Winners\',\'Jaguars\')';
    public Map<String,String> GmFloorMap = new Map<string,String>();
    public user loggedinUser; 
    public List<User> Userlist=new List<User>();
    
    public CommonTeamwiseReport(){
        Userid=UserInfo.getUserId();
        doSearch();
        getUserlist();
    }
    
    public class LeadGenReport{
       public string uName{get; set;}
       public string divisionName{get; set;}
       public integer leadCount{get; set;}
       public integer Opptycount{get; set;}
       public integer Convertedleadcount{get;set;}
       public integer Closedoptycount{get;set;}
       public integer PaidDeals{get;set;}
       public integer Actvtycount{get;set;}
       public integer pendingactvtycount{get;set;}
       public decimal paymentAmount{get;set;}
       public integer noActivityOpportunity {set;get;}
    
       public integer noActivityLeads {get;set;}
       public  LeadGenReport(){
         uName ='';
         divisionName = '';
         leadCount = 0;
         Opptycount=0;
         Convertedleadcount=0;
         Closedoptycount=0;
         PaidDeals=0;
         Actvtycount=0;
         pendingactvtycount=0;
         paymentAmount=0;
         noActivityLeads = 0;
         noActivityOpportunity = 0;
      
        }
    }
   public List<SelectOption> getUserlist(){
        
            GmFloorMap.put('Rainmakers',thirdFloorstr);
            GmFloorMap.put('Titans',thirdFloorstr);
            GmFloorMap.put('Team WML',thirdFloorstr);
            GmFloorMap.put('Spartans',secondFloorstr);
            GmFloorMap.put('Mauryas',secondFloorstr);
            GmFloorMap.put('Mavericks',secondFloorstr);
            GmFloorMap.put('Stallions',secondFloorstr);
            GmFloorMap.put('Winners',firstFloorstr);
            GmFloorMap.put('Jaguars',firstFloorstr);
            
        List<SelectOption> PicklistUser = new List<SelectOption>();
        PicklistUser.add(new SelectOption('All','All'));
        loggedinUser=[SELECT Id,Name,Division,IsGM__c,IFISAM__c FROM User where id=:Userid and isactive=true];
        if(loggedinUser.Division!=null){
            divisionstr=loggedinUser.Division;
        }
        //=========================sathya==============================
        if(loggedinUser.IsGM__c ==True){
            string Userstr = 'SELECT Id,Name,Division FROM User where Division IN'+GmFloorMap.get(divisionstr)+'and isactive=true ORDER BY Name';
            Userlist = Database.query(Userstr);
            //Userlist = [SELECT Id,Name,Division FROM User where Division in :GmFloorMap.get(divisionstr) and isactive=true ORDER BY Name];    
            system.debug('______DIVISION________'+Userlist);
            if(Userlist.size()>0){
            for(User u: Userlist ){
            //  if (u.Id != Userid)
                PicklistUser.add(new SelectOption(u.name,u.name));
             }
           }
         }else if(loggedinUser.IFISAM__c==True ){
            Userlist = [SELECT Id,Name,Division,IFISAM__c FROM User where Manager_Report__c=:Userid and isactive=true ORDER BY Name];
            if(Userlist.size()>0){
               for(User u: Userlist ){
             //    if (u.Id != Userid)
                       PicklistUser.add(new SelectOption(u.name,u.name));
              }
            }
        }
        //=========================sathya==============================
        return PicklistUser;
    }

    
    List<Lead> leadsQueried = new List<Lead>();
    List<Opportunity> opportunityQueried = new List<Opportunity>();
    List<Lead> Convertedleadsqueried = new List<Lead>();
    List<Opportunity> closedoppqueried = new List<Opportunity>();
    list<Lead> ActivityCount= new list<Lead>();
    List<Opportunity_Payment__c> oppPaymentQueried = new List<Opportunity_Payment__c>();
    list<Lead> Activitypending= new list<Lead>();
    List<Opportunity_Payment__c> oppPaymentamount = new List<Opportunity_Payment__c>();
    List<Lead> noActivityLeadsList = new List<Lead>();
    List<Opportunity> opportunityActivityList = new List<Opportunity>();
    //=========================sathya==============================
    /*List<Lead> leadsQueried1 = new List<Lead>();
    List<Opportunity> opportunityQueried1 = new List<Opportunity>();
    List<Lead> Convertedleadsqueried1 = new List<Lead>();
    List<Opportunity> closedoppqueried1 = new List<Opportunity>();
    list<Lead> ActivityCount1= new list<Lead>();
    List<Opportunity_Payment__c> oppPaymentQueried1 = new List<Opportunity_Payment__c>();
    list<Lead> Activitypending1= new list<Lead>();
    List<Opportunity_Payment__c> oppPaymentamount1 = new List<Opportunity_Payment__c>();
    List<Lead> noActivityLeadsList1 = new List<Lead>();
    List<Opportunity> opportunityActivityList1 = new List<Opportunity>();*/
    //=========================sathya==============================
    public Pagereference exportReport(){
    Pagereference pg = new Pagereference('/apex/CommonReportForManagersExcel');
    pg.setRedirect(false);
    return pg;
    }

     public void doSearch(){
        //=========================sathya==============================
        /*leadsQueried1.clear();
        opportunityQueried1.clear();
        Convertedleadsqueried1.clear();
        closedoppqueried1.clear();
        ActivityCount1.clear();
        oppPaymentQueried1.clear();
        Activitypending1.clear();
        oppPaymentamount1.clear();
        noActivityLeadsList1.clear();
        opportunityActivityList1.clear();*/
        //=========================sathya==============================
        String queryLead;
        String convertedLead;
        String queryOpty;
        String OppClosed;
        string queryPay;
        string Actvcount;
        string ActvPending;
        string payamount;
        String noActivityLeads;
        String noActivityOpportunity;
        String oppotunityActivity;
        
            leadGenReportMap.clear();
            if(fromDate==null&&toDate==null){
             date dt= date.today();  
             Date dt1 = dt.toStartOfMonth();
             fromdate=string.valueOf(dt1);
             Datetime myfromDate = datetime.valueOf(fromDate.split(' ')[0]+' 00:00:00');
             string fromdate1 = string.valueOfGmt(myfromDate);
             Convertedfromdate =fromdate1.substring(0,10) +'T'+ fromdate1.substring(11,19)+'z';
             
             todate=String.valueOf(System.today());
             Datetime mytoDate = datetime.valueOf(toDate.split(' ')[0]+' 23:59:59');
             string todate1 = string.valueOfGmt(mytoDate);
             Convertedtodate = todate1.substring(0,10) +'T'+ todate1.substring(11,19)+'z';
            }
            else{
             Datetime myfromDate = datetime.valueOf(fromDate.split(' ')[0]+' 00:00:00');
             string fromdate1 = string.valueOfGmt(myfromDate);
             Convertedfromdate =fromdate1.substring(0,10) +'T'+ fromdate1.substring(11,19)+'z';
             system.debug('==========ConvertedfrmDate============'+Convertedfromdate);
             Datetime mytoDate = datetime.valueOf(toDate.split(' ')[0]+' 23:59:59');
             string todate1 = string.valueOfGmt(mytoDate);
             Convertedtodate = todate1.substring(0,10) +'T'+ todate1.substring(11,19)+'z';
             system.debug('==========ConvertedtoDate============'+Convertedtodate);
            }
            
            
           System.debug('********************'+UserName);
         
            if(UserName=='All'){  
                //=========================sathya==============================
                
                    queryLead='SELECT Owner.Name,Division_Name__c FROM Lead where CreatedDate >='
                        +Convertedfromdate+' and CreatedDate <='
                        +Convertedtodate+'and Division_Name__c IN '+GmFloorMap.get(divisionstr); // and isConverted=false
                
                    convertedLead='SELECT Owner.Name,Division_Name__c FROM Lead where  Lead_AssignedTo__c!=null and CreatedDate >='
                        +Convertedfromdate+' and CreatedDate <='
                        +Convertedtodate+' and isConverted=true and Division_Name__c IN '+GmFloorMap.get(divisionstr);
        
                    queryOpty='SELECT Owner.Name,Division__c FROM Opportunity where StageName != \'Deal\' and StageName != \'Lost\' and CreatedDate >='
                        +Convertedfromdate+' and CreatedDate <='
                        +Convertedtodate+'and Division__c IN '+GmFloorMap.get(divisionstr);  
                    
                    oppotunityActivity = 'SELECT Owner.Name,Division__c FROM Opportunity where LastActivityDate = null and StageName != \'Deal\' and  StageName != \'Lost\' and CreatedDate >='
                        +Convertedfromdate+' and CreatedDate <='
                        +Convertedtodate+'and Division__c IN '+GmFloorMap.get(divisionstr);
                
                    /*  oppotunityActivity = 'SELECT Owner.Name,Division__c,(Select Id, Status  From ActivityHistories),(Select Id, Status  From OpenActivities)'+
                        ' FROM Opportunity where Division__c=\''+div+ '\' and CreatedDate >='
                        +fromDate.split(' ')[0]+'T00:00:00-07:00 and CreatedDate <='
                        +toDate.split(' ')[0]+'T23:59:59-07:00'; */
    
                    OppClosed='SELECT Owner.Name,Division__c FROM Opportunity where StageName= \'Deal\' and CreatedDate >='
                        +Convertedfromdate+' and CreatedDate <='
                        +Convertedtodate+'and Division__c IN '+GmFloorMap.get(divisionstr);
                        
                    Actvcount='SELECT Owner.Name,Division_Name__c,(Select Id, Status  From ActivityHistories order by ActivityDate DESC, LastModifiedDate DESC limit 2 ),(Select Id, Status  From OpenActivities limit 2 )  FROM Lead where  CreatedDate >='
                        +Convertedfromdate+' and CreatedDate <='
                        +Convertedtodate+' and Division_Name__c IN '+GmFloorMap.get(divisionstr); 
                    
                    ActvPending='SELECT Owner.Name,Division_Name__c, (Select Id, Status  From OpenActivities) From Lead  where  CreatedDate >='
                        +Convertedfromdate+' and CreatedDate <='
                        +Convertedtodate+'and Division_Name__c IN '+GmFloorMap.get(divisionstr);
                    
                    queryPay='Select o.Opportunity__c,o.Opportunity__r.Owner.Name,o.Opportunity__r.Division__c  From Opportunity_Payment__c o where o.Pay_Status__c IN (\'paid\',\'part payment\') and o.First_Payment__c = True  and o.Opportunity__r.Uploaded_By__c!=null and Payment_Date__c >='
                        +fromDate+'and Payment_Date__c <='
                        +toDate+'and o.Opportunity__r.Division__c IN '+GmFloorMap.get(divisionstr);
                    
                    payamount='Select o.Opportunity__c,o.Opportunity__r.Owner.Name,o.Opportunity__r.Division__c,Payment_Amount__c  From Opportunity_Payment__c o where o.Pay_Status__c IN (\'paid\',\'part payment\') and o.Opportunity__r.Uploaded_By__c!=null and  Payment_Date__c >='
                        +fromDate+' and Payment_Date__c <='
                        +toDate+'and o.Opportunity__r.Division__c IN '+GmFloorMap.get(divisionstr);    
                    
                    noActivityLeads='SELECT Owner.Name,Division_Name__c FROM Lead where  LastActivityDate = null and CreatedDate >='
                        +Convertedfromdate+' and CreatedDate <='
                        +Convertedtodate+'and Division_Name__c IN '+GmFloorMap.get(divisionstr);      
             
                    leadsQueried = Database.query(queryLead);
                    //system.debug('******leadsQueried*******'+leadsQueried);
                    //for(lead le:leadsQueried)
                    //leadsQueried1.add(le);
                     
                    closedoppqueried=Database.query(OppClosed);
                    //for(Opportunity op:closedoppqueried)
                    //closedoppqueried1.add(op);
                    opportunityQueried = Database.query(queryOpty);
                    //for(Opportunity opp:opportunityQueried)
                    //opportunityQueried1.add(opp);
                    
                    Convertedleadsqueried = Database.query(convertedLead);
                    //for(Lead le:Convertedleadsqueried)
                    //Convertedleadsqueried1.add(le);
                    ActivityCount=Database.query(Actvcount);
                    //for(Lead le:ActivityCount)
                    //ActivityCount1.add(le);
                    oppPaymentQueried=Database.query(queryPay);
                    //for(Opportunity_Payment__c opa:oppPaymentQueried)
                    //oppPaymentQueried1.add(opa);
                    Activitypending=Database.query(ActvPending);
                    //for(Lead le:Activitypending)
                    //Activitypending1.add(le);
                    oppPaymentamount=database.query(payamount);
                    //for(Opportunity_Payment__c opa:oppPaymentamount)
                    //oppPaymentamount1.add(opa);
                    noActivityLeadsList= database.query(noActivityLeads); 
                    //for(Lead le:noActivityLeadsList)
                    //noActivityLeadsList1.add(le);  
                    opportunityActivityList = database.query(oppotunityActivity);  
                    //for(Opportunity op:opportunityActivityList)  
                    //opportunityActivityList1.add(op); 
                
                    system.debug('&&&&&&&&Leadss&&&&&&&'+leadsQueried.size());
            }
            else {
                    queryLead='SELECT Owner.Name,Division_Name__c FROM Lead where Owner.Name=\''+UserName+'\' and CreatedDate >='
                        +Convertedfromdate+' and CreatedDate <='
                        +Convertedtodate;// and isConverted=false 
                
                    convertedLead='SELECT Owner.Name,Division_Name__c FROM Lead where Owner.Name=\''+UserName+'\' and Lead_AssignedTo__c!=null and CreatedDate >='
                        +Convertedfromdate+' and CreatedDate <='
                        +Convertedtodate+' and isConverted=true';
                
                    queryOpty='SELECT Owner.Name,Division__c FROM Opportunity where StageName != \'Deal\' and StageName != \'Lost\' and Owner.Name=\''+UserName+'\' and CreatedDate >='
                        +Convertedfromdate+' and CreatedDate <='
                        +Convertedtodate; 
             
                    oppotunityActivity = 'SELECT Owner.Name,Division__c FROM Opportunity where Owner.Name=\''+UserName+'\' and LastActivityDate = null and CreatedDate >='
                        +Convertedfromdate+' and CreatedDate <='
                        +Convertedtodate +' and StageName != \'Deal\' and  StageName != \'Lost\'';
             
                    /*   oppotunityActivity = 'SELECT Owner.Name,Division__c,(Select Id, Status  From ActivityHistories),(Select Id, Status  From OpenActivities)'+
                        ' FROM Opportunity where Owner.Name=\''+UserName+'\'  and CreatedDate >='
                        +fromDate.split(' ')[0]+'T00:00:00-07:00 and CreatedDate <='
                        +toDate.split(' ')[0]+'T23:59:59-07:00'; */
                        
                    OppClosed='SELECT Owner.Name,Division__c FROM Opportunity where Owner.Name=\''+UserName+'\' and StageName= \'Deal\' and CreatedDate >='
                        +Convertedfromdate+' and CreatedDate <='
                        +Convertedtodate;
                    
                    Actvcount='SELECT Owner.Name,Division_Name__c,(Select Id, Status  From ActivityHistories),(Select Id, Status  From OpenActivities) FROM Lead where Owner.Name=\''+UserName+'\' and CreatedDate >='
                        +Convertedfromdate+' and CreatedDate <='
                        +Convertedtodate; 
                    
                    ActvPending='SELECT Owner.Name,Division_Name__c, (Select Id, Status  From OpenActivities) From Lead  where Owner.Name=\''+UserName+'\' and CreatedDate >='
                        +Convertedfromdate+' and CreatedDate <='
                        +Convertedtodate;
             
                    queryPay='Select o.Opportunity__c,o.Opportunity__r.Owner.Name,o.Opportunity__r.Division__c  From Opportunity_Payment__c o where o.Pay_Status__c IN (\'paid\',\'part payment\') and o.First_Payment__c = True  and o.Opportunity__r.Uploaded_By__c!=null and o.Opportunity__r.Owner.Name=\''+UserName+'\' and Payment_Date__c >='
                        +fromDate+'and Payment_Date__c <='
                        +toDate;          
                    payamount='Select o.Opportunity__c,o.Opportunity__r.Owner.Name,o.Opportunity__r.Division__c,Payment_Amount__c  From Opportunity_Payment__c o where o.Pay_Status__c IN (\'paid\',\'part payment\') and o.Opportunity__r.Uploaded_By__c!=null and o.Opportunity__r.Owner.Name=\''+UserName+'\'  and Payment_Date__c >='
                        +fromDate+'and Payment_Date__c <='
                        +toDate;
                    noActivityLeads='SELECT Owner.Name,Division_Name__c FROM Lead where Owner.Name=\''+UserName+'\' and LastActivityDate = null and CreatedDate >='
                        +Convertedfromdate+' and CreatedDate <='
                        +Convertedtodate;    
                    
                    leadsQueried = Database.query(queryLead);
                    closedoppqueried=Database.query(OppClosed);
                    opportunityQueried = Database.query(queryOpty);
                    Convertedleadsqueried = Database.query(convertedLead);
                    ActivityCount=Database.query(Actvcount);
                    oppPaymentQueried=Database.query(queryPay);
                    Activitypending=Database.query(ActvPending);
                    oppPaymentamount=database.query(payamount);
                    noActivityLeadsList= database.query(noActivityLeads);   
                    opportunityActivityList = database.query(oppotunityActivity);   
            }  
            System.debug('Leads Queried :'+leadsQueried.size());
            
             /*    leadsQueried = Database.query(queryLead);
            leadsQueried.sort();
            System.debug('Leads Queried :'+leadsQueried.size());
            closedoppqueried=Database.query(OppClosed);
            closedoppqueried.sort();
            System.debug('@@@@@@@@OppClosed Queried :@@@@@@@@'+closedoppqueried.size());
            opportunityQueried = Database.query(queryOpty);
            opportunityQueried.sort();
            system.debug('***********opportunityQueried*********'+opportunityQueried.size());
            Convertedleadsqueried = Database.query(convertedLead);
            Convertedleadsqueried.sort();
            system.debug('**************Convertedleadsqueried************'+Convertedleadsqueried.size());
            ActivityCount=Database.query(Actvcount);
            ActivityCount.sort();
            system.debug('**************ActivityCount************'+ActivityCount.size());
            system.debug('**************ActivityCount Details************'+ActivityCount);
            oppPaymentQueried=Database.query(queryPay);
            oppPaymentQueried.sort();
            system.debug('**************oppPaymentQueried************'+oppPaymentQueried.size());
            Activitypending=Database.query(ActvPending);
            Activitypending.sort();   
            system.debug('**************Activitypending************'+Activitypending.size());   
            oppPaymentamount=database.query(payamount);
            noActivityLeadsList= database.query(noActivityLeads);   
            opportunityActivityList = database.query(oppotunityActivity);  */
             
            calculateBonusReport();
    }
   
    public Map<String,LeadGenReport> leadGenReportMap = new Map<String,LeadGenReport>();
    public LeadGenReport totalReport = new LeadGenReport();
   
    public List<LeadGenReport> getLeadGenList(){
        return leadGenReportMap.values();
    }
    public LeadGenReport getTotalReport(){
        return totalReport;
    }
    public void calculateBonusReport(){
        map<string,string> mapBDUsers = new map<string,string>{};
        for (User hd :Userlist) {
            mapBDUsers.put(hd.Name, hd.id); 
        }
        system.debug('________MAPPEDBD__________'+mapBDUsers.keyset());
        sortedResult.clear();
        totalReport = new LeadGenReport();
        //Generate and Update Indivdual Object for every LeadGen in Leads Object
        for(Lead leadRecord : leadsQueried){
            System.debug('Lead Record : '+leadRecord.Owner.Name);
            //System.debug('Lead Division :'+leadGenDivisionReport);
            System.debug('DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD'+leadRecord.Division_Name__c);
            system.debug('___Mappedowner____'+leadRecord.Owner.Name);
            if(mapBDUsers.containsKey(leadRecord.Owner.Name)){
                system.debug('___MappedBDowner____'+leadRecord.Owner.Name);
                LeadGenReport leadGenReport = new LeadGenReport();
                if(leadGenReportMap.containsKey(leadRecord.Owner.Name)){
                    leadGenReport = leadGenReportMap.get(leadRecord.Owner.Name);
                }
                leadGenReport.uName = leadRecord.Owner.Name;
                leadGenReport.divisionName = leadRecord.Division_Name__c;
                leadGenReport.leadCount = leadGenReport.leadCount+1;
                leadGenReportMap.put(leadRecord.Owner.Name,leadGenReport);
          }         
        }
        for( Opportunity opportunityRecord : opportunityQueried){
            if(mapBDUsers.containsKey(opportunityRecord.Owner.Name)){
            LeadGenReport leadGenReport = new LeadGenReport();
            if(leadGenReportMap.containsKey(opportunityRecord.Owner.Name)){
                leadGenReport = leadGenReportMap.get(opportunityRecord.Owner.Name);
            }
            leadGenReport.uName = opportunityRecord.Owner.Name;
            leadGenReport.divisionName = opportunityRecord.Division__c;
            leadGenReport.Opptycount = leadGenReport.Opptycount+1;
            leadGenReportMap.put(opportunityRecord.Owner.Name,leadGenReport); 
           }         
        }
        //Generate and Update Indivdual Object for every LeadGen in Leads Object
        
        
        Map<String,String> uniqueOpportunity = new Map<String,String>();
        for(Opportunity_Payment__c paymentRecord : oppPaymentQueried){
           if(mapBDUsers.containsKey(paymentRecord.Opportunity__r.Owner.Name)){
            LeadGenReport leadGenReport = new LeadGenReport();
            if(leadGenReportMap.containsKey(paymentRecord.Opportunity__r.Owner.Name)){
                leadGenReport = leadGenReportMap.get(paymentRecord.Opportunity__r.Owner.Name);
            }
            leadGenReport.uName = paymentRecord.Opportunity__r.Owner.Name;
            leadGenReport.divisionName = paymentRecord.Opportunity__r.Division__c;
                leadGenReport.PaidDeals = leadGenReport.PaidDeals+1;
            leadGenReportMap.put(paymentRecord.Opportunity__r.Owner.Name,leadGenReport);
          }
        }
        Map<String,String> uniquepayOpportunity = new Map<String,String>();
        for(Opportunity_Payment__c paymentamtRecord : oppPaymentamount){
            if(mapBDUsers.containsKey(paymentamtRecord.Opportunity__r.Owner.Name)){
                LeadGenReport leadGenReport = new LeadGenReport();
                if(leadGenReportMap.containsKey(paymentamtRecord.Opportunity__r.Owner.Name)){
                    leadGenReport = leadGenReportMap.get(paymentamtRecord.Opportunity__r.Owner.Name);
                }
                leadGenReport.uName = paymentamtRecord.Opportunity__r.Owner.Name;
                leadGenReport.divisionName = paymentamtRecord.Opportunity__r.Division__c;
                if(leadGenReport.paymentAmount==0){
                    leadGenReport.paymentAmount = paymentamtRecord.Payment_Amount__c;
                }else{
                    leadGenReport.paymentAmount = paymentamtRecord.Payment_Amount__c+leadGenReport.paymentAmount;
                }
                leadGenReportMap.put(paymentamtRecord.Opportunity__r.Owner.Name,leadGenReport);
           }   
        }
        //Payments for unique Opportunity would be 1 paid deal, irrespective of number of payment records
        
        for(Lead Convertedleadsrecord : Convertedleadsqueried){
            if(mapBDUsers.containsKey(Convertedleadsrecord.Owner.Name)){
                LeadGenReport leadGenReport = new LeadGenReport();
                if(leadGenReportMap.containsKey(Convertedleadsrecord.Owner.Name)){
                    leadGenReport = leadGenReportMap.get(Convertedleadsrecord.Owner.Name);
                }
                leadGenReport.uName = Convertedleadsrecord.Owner.Name;
                leadGenReport.divisionName = Convertedleadsrecord.Division_Name__c;
                leadGenReport.Convertedleadcount = leadGenReport.Convertedleadcount+1;
                leadGenReportMap.put(Convertedleadsrecord.Owner.Name,leadGenReport);   
           }        
        }
        for( Opportunity closedoppRecord : closedoppqueried){
            if(mapBDUsers.containsKey(closedoppRecord.Owner.Name)){
                LeadGenReport leadGenReport = new LeadGenReport();
                if(leadGenReportMap.containsKey(closedoppRecord.Owner.Name)){
                    leadGenReport = leadGenReportMap.get(closedoppRecord.Owner.Name);
                }
                leadGenReport.uName = closedoppRecord.Owner.Name;
                leadGenReport.divisionName = closedoppRecord.Division__c;
                leadGenReport.Closedoptycount = leadGenReport.Closedoptycount+1;
                leadGenReportMap.put(closedoppRecord.Owner.Name,leadGenReport);  
            }         
        }
        for(Lead ActivityCountrecord : ActivityCount){
           if(mapBDUsers.containsKey(ActivityCountrecord.Owner.Name)){
                LeadGenReport leadGenReport = new LeadGenReport();
                if(leadGenReportMap.containsKey(ActivityCountrecord.Owner.Name)){
                    leadGenReport = leadGenReportMap.get(ActivityCountrecord.Owner.Name);
                }
                leadGenReport.uName = ActivityCountrecord.Owner.Name;
                leadGenReport.divisionName = ActivityCountrecord.Division_Name__c;
                leadGenReport.Actvtycount = leadGenReport.Actvtycount+ ActivityCountrecord.ActivityHistories.size();
                leadGenReport.Actvtycount = leadGenReport.Actvtycount+ ActivityCountrecord.OpenActivities.size();
                leadGenReportMap.put(ActivityCountrecord.Owner.Name,leadGenReport);       
           }    
        }
        
        for( Opportunity opportunityActivity : opportunityActivityList){
            if(mapBDUsers.containsKey(opportunityActivity.Owner.Name)){
                LeadGenReport leadGenReport = new LeadGenReport();
                if(leadGenReportMap.containsKey(opportunityActivity.Owner.Name)){
                    leadGenReport = leadGenReportMap.get(opportunityActivity.Owner.Name);
                }
                leadGenReport.uName = opportunityActivity.Owner.Name;
                leadGenReport.divisionName = opportunityActivity.Division__c;
                leadGenReport.noActivityOpportunity = leadGenReport.noActivityOpportunity+1;
            
                /*   leadGenReport.Actvtycount = leadGenReport.Actvtycount+ opportunityActivity.ActivityHistories.size();
                leadGenReport.Actvtycount = leadGenReport.Actvtycount+ opportunityActivity.OpenActivities.size();
                leadGenReport.pendingactvtycount = leadGenReport.pendingactvtycount+opportunityActivity.OpenActivities.size();
                if(opportunityActivity.OpenActivities.size() < 1){
                    leadGenReport.noActivityOpportunity = leadGenReport.noActivityOpportunity+1;
                } */
                leadGenReportMap.put(opportunityActivity.Owner.Name,leadGenReport);  
            }         
        }
        for(Lead Activitypendingrecord : Activitypending){
            if(mapBDUsers.containsKey(Activitypendingrecord.Owner.Name)){
                LeadGenReport leadGenReport = new LeadGenReport();
                if(leadGenReportMap.containsKey(Activitypendingrecord.Owner.Name)){
                    leadGenReport = leadGenReportMap.get(Activitypendingrecord.Owner.Name);
                }
                leadGenReport.uName = Activitypendingrecord.Owner.Name;
                leadGenReport.divisionName = Activitypendingrecord.Division_Name__c;
                leadGenReport.pendingactvtycount = leadGenReport.pendingactvtycount+Activitypendingrecord.OpenActivities.size();
                leadGenReportMap.put(Activitypendingrecord.Owner.Name,leadGenReport);   
            }        
        }   
        
        for(Lead noActivityLeadRecord : noActivityLeadsList){
            if(mapBDUsers.containsKey(noActivityLeadRecord.Owner.Name)){
                LeadGenReport leadGenReport = new LeadGenReport();
                if(leadGenReportMap.containsKey(noActivityLeadRecord.Owner.Name)){
                    leadGenReport = leadGenReportMap.get(noActivityLeadRecord.Owner.Name);
                }
                leadGenReport.uName = noActivityLeadRecord.Owner.Name;
                leadGenReport.divisionName = noActivityLeadRecord.Division_Name__c;
                leadGenReport.noActivityLeads = leadGenReport.noActivityLeads + 1;
                leadGenReportMap.put(noActivityLeadRecord.Owner.Name,leadGenReport); 
           }          
       }
   
       Set<String> leadgen = leadGenReportMap.keySet();
       for(String leadGenPerson : leadgen){
            sortedResult.add(new ResultSorter(leadGenReportMap.get(leadGenPerson)));
            System.debug('--------------------------'+leadGenReportMap.get(leadGenPerson).leadCount);
            totalReport.leadCount = totalReport.leadCount+leadGenReportMap.get(leadGenPerson).leadCount;
            totalReport.Opptycount = totalReport.Opptycount+leadGenReportMap.get(leadGenPerson).Opptycount;
            totalReport.Convertedleadcount = totalReport.Convertedleadcount+leadGenReportMap.get(leadGenPerson).Convertedleadcount;
            system.debug('####totalReport.Opptycount####'+totalReport.Opptycount);
            system.debug('####leadGenDivisionReport.Convertedleadcount####'+leadGenReportMap.get(leadGenPerson).Convertedleadcount);
            totalReport.Closedoptycount = totalReport.Closedoptycount+leadGenReportMap.get(leadGenPerson).Closedoptycount;
            totalReport.PaidDeals = totalReport.PaidDeals+leadGenReportMap.get(leadGenPerson).PaidDeals;
            totalReport.Actvtycount = totalReport.Actvtycount+leadGenReportMap.get(leadGenPerson).Actvtycount;
            system.debug('####GrandtotalReport.Closedoptycount####'+totalReport.Closedoptycount);
            totalReport.paymentAmount=totalReport.paymentAmount+leadGenReportMap.get(leadGenPerson).paymentAmount;
            system.debug('####totalReport.paymentAmount####'+totalReport.paymentAmount);
            totalReport.pendingactvtycount = totalReport.pendingactvtycount+leadGenReportMap.get(leadGenPerson).pendingactvtycount;
            system.debug('******Leadcount*********'+leadGenReportMap.get(leadGenPerson).leadCount);
            system.debug('******PaidDeals*********'+leadGenReportMap.get(leadGenPerson).PaidDeals);
            system.debug('******Actvtycount*********'+leadGenReportMap.get(leadGenPerson).Actvtycount);           
            system.debug('******pendingactvtycount*********'+leadGenReportMap.get(leadGenPerson).pendingactvtycount);
            totalReport.noActivityLeads = totalReport.noActivityLeads + leadGenReportMap.get(leadGenPerson).noActivityLeads;
            totalReport.noActivityOpportunity = totalReport.noActivityOpportunity + leadGenReportMap.get(leadGenPerson).noActivityOpportunity;
       }
    }
    public ResultSorter[] sortedResult = new List<ResultSorter>();
 
    public ResultSorter[] getSearchResults(){
        System.debug('BEFORE SORT :'+sortedResult);
        sortedResult.sort();
        System.debug('AFTER SORT :'+sortedResult);
        return sortedResult;
    }
    class ResultSorter implements Comparable {
        public LeadGenReport ssrRec {get;set;}
        // Constructor 
        public ResultSorter(LeadGenReport ssr) {
            
            ssrRec = ssr;
        }
        // Compare opportunities based on the opportunity amount. 
        public Integer compareTo(Object compareTo) {
            // Cast argument to OpportunityWrapper 
            ResultSorter compareToOppy = (ResultSorter)compareTo;
            // The return value of 0 indicates that both elements are equal. 
            Integer returnValue = 0;
            System.debug('NEW REC :'+ssrRec+'-----&&&&------OLD REC :'+compareToOppy.ssrRec);
            if (ssrRec.leadCount > compareToOppy.ssrRec.leadCount) {
                // Set return value to a positive value. 
                returnValue = -1;
            } else if (ssrRec.leadCount < compareToOppy.ssrRec.leadCount) {
                // Set return value to a negative value. 
                returnValue = 1;
            }
            return returnValue;       
        }
    }
    static testMethod void myUnitTest_LeadGenController(){
        
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Account Managers']; 
        
        User u3 = new User(Alias = 'standtd', Email='ankur.g@istrategcloud.com', 
                EmailEncodingKey='UTF-8', LastName='Joe obinson', LanguageLocaleKey='en_US',
                IsActive=true,Division='Winners',Is_Account_Manager__c=true,
                LocaleSidKey='en_US', ProfileId = p.Id,Rating__c='A+',Mapped_UserID_Name__c='Test User (Winners)', 
                TimeZoneSidKey='America/Los_Angeles', UserName='standardtest@testorg.com',IFISAM__c=false,IsGM__c= True );
        insert u3;
        
        User u2 = new User(Alias = 'standt', Email='ankur.g@istrategicloud.com', 
                EmailEncodingKey='UTF-8', LastName='Joe Robinson', LanguageLocaleKey='en_US',
                IsActive=true,Division='Winners',Is_Account_Manager__c=true,
                LocaleSidKey='en_US', ProfileId = p.Id,Rating__c='A+',Mapped_UserID_Name__c='Test User (Rainmakers)', 
                TimeZoneSidKey='America/Los_Angeles', UserName='standardtestuser@testorg.com',IFISAM__c=true);
        insert u2;
        
        
        User u4 = new User(Alias = 'standtd', Email='ankur.g@istrtegcloud.com', 
                EmailEncodingKey='UTF-8', LastName='Joe obinson', LanguageLocaleKey='en_US',
                IsActive=true,Division='Winners',Is_Account_Manager__c=true,
                LocaleSidKey='en_US', ProfileId = p.Id,Rating__c='A+',Mapped_UserID_Name__c='Test Uer (Winners)', 
                TimeZoneSidKey='America/Los_Angeles', UserName='standadtet@testorg.com',Manager_Report__c =u2.Id );
        insert u4;
        
        user u=[select name,id from user where Division='winners' and isactive=true limit 1];
        
        test.starttest();
        
        System.runAs(u4) {      
              
        lead newlead=new lead();
        newlead.Email='peterjohnson.m@istrategicloud.com';
        newlead.Division_Name__c='Winners';
        newlead.LeadSource='Approved Index';
        newlead.Status='Followup';
        newlead.Company = 'SOScompany';
        newlead.FirstName='TestN';
        newlead.LastName='TestJohn';
        newlead.Primary_Service_Name__c='CRM';
        newlead.LinkedIn_URL__c='karthik37/Linkedin.com';
        newlead.Lead_AssignedTo__c='bryan Kumar (Winners)';
        newlead.User_Name__c='Sean Anderson';
        newlead.Team_Identification__c='Raymond Phillips';
       // newlead.Ownerid=u2.id;
       
        insert newlead;
       
        system.debug('**************lead1**********'+newlead.id);
     
     
      Account acc=new Account();
      acc.Name='SOScompany';
      acc.Email__c='sample@google.com';
      acc.Phone='(954) 344-9254';
      acc.Type='Customer';
      insert acc;   
      system.debug('*acc1*****************'+acc.id);
      
      Contact contact=new Contact();
      contact.AccountId=acc.id;
      contact.Email='sample@google.com';
      contact.LastName='Testjo';
      insert contact;
      system.debug('******con1************'+contact.id);
      
      Opportunity opp=new Opportunity();
      opp.Name='sample1';
      opp.AccountId=acc.id;
      opp.Lead_Source__c='Approved Index';
      opp.Primary_Service_Name__c='Technology List';
      opp.Division__c='Winners';
      opp.StageName='Deal';
      opp.Sample_To_Deal__c='other';
      opp.Uploaded_By__c='test';
      opp.ForecastCategoryName='pipeline';
      opp.Amount=500;
      opp.CloseDate=date.parse('1/13/2013');
      opp.Team_Uploaded_By__c='Winners';
            opp.Emt__c='idh';
      insert opp;
      system.debug('opp1******************'+opp.id);
      system.debug('opp1******************'+opp.owner.name); 
    
      Opportunity_Payment__c opppay=new Opportunity_Payment__c();
      opppay.Opportunity__c=opp.id;
      opppay.Pay_Status__c='paid';
      opppay.Payment_Amount__c=23442;
      opppay.Payment_Mode__c='Cash';
      opp.EMt__C='idh';
      insert opppay;
      system.debug('opppay1******************'+opppay.id);
     }
         System.runAs(u3) {
        CommonTeamwiseReport Lreport = new CommonTeamwiseReport();
        Lreport.UserName='All';
       // Lreport.Convertedfromdate='2012-03-14T00:56:36Z';
       // Lreport.Convertedtodate='2012-03-16T00:56:36Z';
       // Lreport.fromDate='2012-02-09';
       // Lreport.toDate='2013-04-13';
        Lreport.getUserlist();
        Lreport.doSearch();
        List<LeadGenReport> LDR=new List<LeadGenReport>();
        LDR=Lreport.getLeadGenList();
        system.debug(LDR);
        Lreport.getTotalReport();
        Lreport.exportReport();
        Lreport.getSearchResults();
        Lreport.calculateBonusReport();
        
        CommonTeamwiseReport report = new CommonTeamwiseReport();
        report.UserName='Bryan Kumar';
       // report.Convertedfromdate='2012-03-14T00:56:36Z';
       // report.Convertedtodate='2012-03-16T00:56:36Z';
        Lreport.fromDate='2013-01-01';
        Lreport.toDate='2013-06-23';
        report.getUserlist();
        report.getLeadGenList();
        report.doSearch();
        List<LeadGenReport> LDRs=new List<LeadGenReport>();
        LDRs=report.getLeadGenList();
        system.debug(LDRs);
        report.getTotalReport();
        report.exportReport();
        report.calculateBonusReport();
       }  
       
      /* System.runAs(u2) {
        CommonTeamwiseReport Lreport = new CommonTeamwiseReport();
        Lreport.UserName='All';
       // Lreport.Convertedfromdate='2012-03-14T00:56:36Z';
       // Lreport.Convertedtodate='2012-03-16T00:56:36Z';
       // Lreport.fromDate='2012-02-09';
       // Lreport.toDate='2013-04-13';
        Lreport.getUserlist();
        Lreport.doSearch();
        List<LeadGenReport> LDR=new List<LeadGenReport>();
        LDR=Lreport.getLeadGenList();
        system.debug(LDR);
        Lreport.getTotalReport();
        Lreport.exportReport();
        Lreport.getSearchResults();
        Lreport.calculateBonusReport();
        
        CommonTeamwiseReport report = new CommonTeamwiseReport();
        report.UserName='Bryan Kumar';
       // report.Convertedfromdate='2012-03-14T00:56:36Z';
       // report.Convertedtodate='2012-03-16T00:56:36Z';
        Lreport.fromDate='2013-02-01';
        Lreport.toDate='2013-02-23';
        report.getUserlist();
        report.getLeadGenList();
        report.doSearch();
        List<LeadGenReport> LDRs=new List<LeadGenReport>();
        LDRs=report.getLeadGenList();
        system.debug(LDRs);
        report.getTotalReport();
        report.exportReport();
        report.calculateBonusReport();
       }  */
        test.stoptest();
    } 


}