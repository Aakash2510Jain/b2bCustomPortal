public class NelsonReport {


   public string UserName{get;set;}
    public String fromDate{get;set;}
    public String toDate{get;set;}
    public NelsonReport(){
        doSearch();
        System.debug('********UserName************'+UserName);
    }
    
    /* LeadDealCount is a wrapper class which will help to bind different types of data userName, divisionName, leadCount, dealCount and initializing the values at the time of construction of LeadDealCount object.
    */
    /*public class LeadGenDivisionReport{
        public String divisionName {get;set;}
        public Map<String,LeadGenReport> leadGenReportMap = new Map<String,LeadGenReport>();
        public LeadGenDivisionReport(){
            divisionName='';
        }
        public List<LeadGenReport> getLeadGenReportMap(){
            return leadGenReportMap.values();
        }
    }*/
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
     //  public Decimal bonusAmount{get;set;}
     //  public integer linkedindeal{get;set;}
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
       //  linkedindeal=0;  
        }
    }
   public List<SelectOption> getUserlist(){
    	List<User> Users=new List<User>();
		List<SelectOption> tUser = new List<SelectOption>();
	   	tUser.add(new SelectOption('','None'));
	   	tUser.add(new SelectOption('All','All'));
         Users = [SELECT Id,Name,Division FROM User where Division ='Winners' and isactive=true ORDER BY Name];
        for(User u: Users ){
            tUser.add(new SelectOption(u.name,u.name));
        }
        return tUser;
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
    public Pagereference exportReport(){
    Pagereference pg = new Pagereference('/apex/NelsonReportExcel');
    pg.setRedirect(false);
    return pg;
    }

     public void doSearch(){
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
             todate=String.valueOf(System.today());
            }
           System.debug('********************'+UserName);
         
            if(UserName=='All'){
                 queryLead='SELECT Owner.Name,Division_Name__c FROM Lead where Division_Name__c=\'Winners\' and CreatedDate >='
                    +fromDate.split(' ')[0]+'T00:00:00+01:00 and CreatedDate <='
                    +toDate.split(' ')[0]+'T23:59:59-07:00 '; // and isConverted=false
            
	            convertedLead='SELECT Owner.Name,Division_Name__c FROM Lead where Division_Name__c=\'Winners\' and Lead_AssignedTo__c!=null and CreatedDate >='
	                    +fromDate.split(' ')[0]+'T00:00:00+01:00 and CreatedDate <='
	                    +toDate.split(' ')[0]+'T23:59:59-07:00 and isConverted=true';
	
	           queryOpty='SELECT Owner.Name,Division__c FROM Opportunity where Division__c=\'Winners\' and CreatedDate >='
	                    +fromDate.split(' ')[0]+'T00:00:00+01:00 and CreatedDate <='
	                    +toDate.split(' ')[0]+'T23:59:59-07:00';  
			   oppotunityActivity = 'SELECT Owner.Name,Division__c FROM Opportunity where Division__c=\'Winners\' and LastActivityDate = null and CreatedDate >='
	                    +fromDate.split(' ')[0]+'T00:00:00+01:00 and CreatedDate <='
	                    +toDate.split(' ')[0]+'T23:59:59-07:00'; 
				/*oppotunityActivity = 'SELECT Owner.Name,Division__c,(Select Id, Status  From ActivityHistories),(Select Id, Status  From OpenActivities)'+
						' FROM Opportunity where Division__c=\'Winners\' and CreatedDate >='
	                    +fromDate.split(' ')[0]+'T00:00:00-07:00 and CreatedDate <='
	                    +toDate.split(' ')[0]+'T23:59:59-07:00'; */
	
	           OppClosed='SELECT Owner.Name,Division__c FROM Opportunity where Division__c=\'Winners\' and StageName= \'Deal\' and CreatedDate >='
	                    +fromDate.split(' ')[0]+'T00:00:00+01:00 and CreatedDate <='
	                    +toDate.split(' ')[0]+'T23:59:59-07:00';
	                    
	           Actvcount='SELECT Owner.Name,Division_Name__c,(Select Id, Status  From ActivityHistories),(Select Id, Status  From OpenActivities)  FROM Lead where Division_Name__c=\'Winners\' and CreatedDate >='
	                    +fromDate.split(' ')[0]+'T00:00:00+01:00 and CreatedDate <='
	                    +toDate.split(' ')[0]+'T23:59:59-07:00'; 
	           ActvPending='SELECT Owner.Name,Division_Name__c, (Select Id, Status  From OpenActivities) From Lead  where Division_Name__c=\'Winners\' and CreatedDate >='
	                    +fromDate.split(' ')[0]+'T00:00:00+01:00 and CreatedDate <='
	                    +toDate.split(' ')[0]+'T23:59:59-07:00';
				queryPay='Select o.Opportunity__c,o.Opportunity__r.Owner.Name,o.Opportunity__r.Division__c  From Opportunity_Payment__c o where o.Pay_Status__c IN (\'paid\',\'part payment\') and o.Opportunity__r.Uploaded_By__c!=null and o.Opportunity__r.Division__c=\'Winners\'  and Payment_Date__c >='
	                    +fromDate+'and Payment_Date__c <='
	                    +toDate;
				payamount='Select o.Opportunity__c,o.Opportunity__r.Owner.Name,o.Opportunity__r.Division__c,Payment_Amount__c  From Opportunity_Payment__c o where o.Pay_Status__c IN (\'paid\',\'part payment\') and o.Opportunity__r.Uploaded_By__c!=null and o.Opportunity__r.Division__c=\'Winners\'  and Payment_Date__c >='
	                    +fromDate+' and Payment_Date__c <='
	                    +toDate;    
	            noActivityLeads='SELECT Owner.Name,Division_Name__c FROM Lead where Division_Name__c=\'Winners\' and LastActivityDate = null and CreatedDate >='
	                    +fromDate.split(' ')[0]+'T00:00:00+01:00 and CreatedDate <='
	                    +toDate.split(' ')[0]+'T23:59:59-07:00';       
	         
	         /*  queryPay= 'Select Owner.Name, Division__c, (Select Name, Pay_Status__c From Opportunity_Payment__r where Pay_Status__c=\'paid\' or  Pay_Status__c=\'part payment\')  From Opportunity  where Division__c=\'Winners\'  and CreatedDate >='
	                    +fromDate.split(' ')[0]+'T00:00:03Z and CreatedDate <='
                    +toDate.split(' ')[0]+'T23:59:59Z'; */
            }else {
	           queryLead='SELECT Owner.Name,Division_Name__c FROM Lead where Owner.Name=\''+UserName+'\' and CreatedDate >='
	                    +fromDate.split(' ')[0]+'T00:00:00+01:00 and CreatedDate <='
	                    +toDate.split(' ')[0]+'T23:59:59-07:00';// and isConverted=false 
	            
	            convertedLead='SELECT Owner.Name,Division_Name__c FROM Lead where Owner.Name=\''+UserName+'\' and Lead_AssignedTo__c!=null and CreatedDate >='
	                    +fromDate.split(' ')[0]+'T00:00:00+01:00 and CreatedDate <='
	                    +toDate.split(' ')[0]+'T23:59:59-07:00 and isConverted=true';
	            
	           queryOpty='SELECT Owner.Name,Division__c FROM Opportunity where Owner.Name=\''+UserName+'\' and CreatedDate >='
	                    +fromDate.split(' ')[0]+'T00:00:00+01:00 and CreatedDate <='
	                    +toDate.split(' ')[0]+'T23:59:59-07:00'; 
	           
	           oppotunityActivity = 'SELECT Owner.Name,Division__c FROM Opportunity where Owner.Name=\''+UserName+'\' and LastActivityDate = null and CreatedDate >='
                    +fromDate.split(' ')[0]+'T00:00:00+01:00 and CreatedDate <='
                    +toDate.split(' ')[0]+'T23:59:59-07:00';  
                    
	           /*oppotunityActivity = 'SELECT Owner.Name,Division__c,(Select Id, Status  From ActivityHistories),(Select Id, Status  From OpenActivities)'+
						' FROM Opportunity where Owner.Name=\''+UserName+'\'  and CreatedDate >='
	                    +fromDate.split(' ')[0]+'T00:00:00-07:00 and CreatedDate <='
	                    +toDate.split(' ')[0]+'T23:59:59-07:00'; */
	                    
	           OppClosed='SELECT Owner.Name,Division__c FROM Opportunity where Owner.Name=\''+UserName+'\' and StageName= \'Deal\' and CreatedDate >='
	                    +fromDate.split(' ')[0]+'T00:00:00+01:00 and CreatedDate <='
	                    +toDate.split(' ')[0]+'T23:59:59-07:00';
	           Actvcount='SELECT Owner.Name,Division_Name__c,(Select Id, Status  From ActivityHistories),(Select Id, Status  From OpenActivities) FROM Lead where Owner.Name=\''+UserName+'\' and CreatedDate >='
	                    +fromDate.split(' ')[0]+'T00:00:00+01:00 and CreatedDate <='
	                    +toDate.split(' ')[0]+'T23:59:59-07:00'; 
	           ActvPending='SELECT Owner.Name,Division_Name__c, (Select Id, Status  From OpenActivities) From Lead  where Owner.Name=\''+UserName+'\' and CreatedDate >='
	                    +fromDate.split(' ')[0]+'T00:00:00+01:00 and CreatedDate <='
	                    +toDate.split(' ')[0]+'T23:59:59-07:00';
	           /* queryPay= 'Select Owner.Name, Division__c, (Select Name, Pay_Status__c From Opportunity_Payment__r where Pay_Status__c=\'paid\' or  Pay_Status__c=\'part payment\')  From Opportunity  where Owner.Name=\''+UserName+'\' and CreatedDate >='
	                    +fromDate.split(' ')[0]+'T00:00:03Z and CreatedDate <='
	                    +toDate.split(' ')[0]+'T23:59:59Z'; */
	          	queryPay='Select o.Opportunity__c,o.Opportunity__r.Owner.Name,o.Opportunity__r.Division__c  From Opportunity_Payment__c o where o.Pay_Status__c IN (\'paid\',\'part payment\') and o.Opportunity__r.Uploaded_By__c!=null and o.Opportunity__r.Owner.Name=\''+UserName+'\' and Payment_Date__c >='
	                    +fromDate+'and Payment_Date__c <='
	                    +toDate;          
	         	payamount='Select o.Opportunity__c,o.Opportunity__r.Owner.Name,o.Opportunity__r.Division__c,Payment_Amount__c  From Opportunity_Payment__c o where o.Pay_Status__c IN (\'paid\',\'part payment\') and o.Opportunity__r.Uploaded_By__c!=null and o.Opportunity__r.Owner.Name=\''+UserName+'\'  and Payment_Date__c >='
	                    +fromDate+'and Payment_Date__c <='
	                    +toDate;
	            noActivityLeads='SELECT Owner.Name,Division_Name__c FROM Lead where Owner.Name=\''+UserName+'\' and LastActivityDate = null and CreatedDate >='
                    +fromDate.split(' ')[0]+'T00:00:00+01:00 and CreatedDate <='
                    +toDate.split(' ')[0]+'T23:59:59-07:00';    
                    
            }  
            
            leadsQueried = Database.query(queryLead);
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
             opportunityActivityList = database.query(oppotunityActivity);
            calculateBonusReport();
    }
    // Map<String,LeadGenDivisionReport> leadGenDivisionReport = new Map<String,LeadGenDivisionReport>(); // division name is key
     public Map<String,LeadGenReport> leadGenReportMap = new Map<String,LeadGenReport>();
    public LeadGenReport totalReport = new LeadGenReport();
    /*public List<LeadGenDivisionReport> getLeadGenDivisionList(){
        return leadGenDivisionReport.values();
    }*/
    public List<LeadGenReport> getLeadGenList(){
    	return leadGenReportMap.values();
    }
    public LeadGenReport getTotalReport(){
        return totalReport;
    }
    public void calculateBonusReport(){
    	sortedResult.clear();
        totalReport = new LeadGenReport();
        //Generate and Update Indivdual Object for every LeadGen in Leads Object
         System.debug('DDDDDDDDDDDDDDD^^DDDDDDDDDDDDDDDD'+leadsQueried);
        for(Lead leadRecord : leadsQueried){
            System.debug('Lead Record : '+leadRecord);
            //System.debug('Lead Division :'+leadGenDivisionReport);
            System.debug('DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD'+leadRecord.Division_Name__c);
            /*if(!leadGenDivisionReport.containsKey(leadRecord.Division_Name__c)){
                LeadGenDivisionReport divisionReport = new LeadGenDivisionReport();
                divisionReport.divisionName = leadRecord.Division_Name__c;
                leadGenDivisionReport.put(leadRecord.Division_Name__c,divisionReport);
            }*/
            LeadGenReport leadGenReport = new LeadGenReport();
            if(leadGenReportMap.containsKey(leadRecord.Owner.Name)){
                leadGenReport = leadGenReportMap.get(leadRecord.Owner.Name);
            }
            leadGenReport.uName = leadRecord.Owner.Name;
            leadGenReport.divisionName = leadRecord.Division_Name__c;
            leadGenReport.leadCount = leadGenReport.leadCount+1;
            leadGenReportMap.put(leadRecord.Owner.Name,leadGenReport);         
        }
        for( Opportunity opportunityRecord : opportunityQueried){
            //System.debug('Lead Record : '+leadRecord);
            //System.debug('Lead Division :'+leadGenDivisionReport);
            /*if(!leadGenDivisionReport.containsKey(opportunityRecord.Division__c)){
                LeadGenDivisionReport divisionReport = new LeadGenDivisionReport();
                divisionReport.divisionName = opportunityRecord.Division__c;
                leadGenDivisionReport.put(opportunityRecord.Division__c,divisionReport);
            }*/
            LeadGenReport leadGenReport = new LeadGenReport();
            if(leadGenReportMap.containsKey(opportunityRecord.Owner.Name)){
                leadGenReport = leadGenReportMap.get(opportunityRecord.Owner.Name);
            }
            leadGenReport.uName = opportunityRecord.Owner.Name;
            leadGenReport.divisionName = opportunityRecord.Division__c;
            
            leadGenReport.Opptycount = leadGenReport.Opptycount+1;
            leadGenReportMap.put(opportunityRecord.Owner.Name,leadGenReport);         
        }
        //Generate and Update Indivdual Object for every LeadGen in Leads Object
      	
        Map<String,String> uniqueOpportunity = new Map<String,String>();
        for(Opportunity_Payment__c paymentRecord : oppPaymentQueried){
            //System.debug('Payment Record : '+paymentRecord);
            //System.debug('Payment Division :'+leadGenDivisionReport);
           /* if(!leadGenDivisionReport.containsKey(paymentRecord.Opportunity__r.Division__c)){
                LeadGenDivisionReport divisionReport = new LeadGenDivisionReport();
                divisionReport.divisionName = paymentRecord.Opportunity__r.Division__c;
                leadGenDivisionReport.put(paymentRecord.Opportunity__r.Division__c,divisionReport);
            }*/
            LeadGenReport leadGenReport = new LeadGenReport();
            if(leadGenReportMap.containsKey(paymentRecord.Opportunity__r.Owner.Name)){
                leadGenReport = leadGenReportMap.get(paymentRecord.Opportunity__r.Owner.Name);
            }
            leadGenReport.uName = paymentRecord.Opportunity__r.Owner.Name;
            leadGenReport.divisionName = paymentRecord.Opportunity__r.Division__c;
                leadGenReport.PaidDeals = leadGenReport.PaidDeals+1;
            leadGenReportMap.put(paymentRecord.Opportunity__r.Owner.Name,leadGenReport);
        }
        Map<String,String> uniquepayOpportunity = new Map<String,String>();
        for(Opportunity_Payment__c paymentamtRecord : oppPaymentamount){
            //System.debug('Payment Record : '+paymentRecord);
            //System.debug('Payment Division :'+leadGenDivisionReport);
            /*if(!leadGenDivisionReport.containsKey(paymentamtRecord.Opportunity__r.Division__c)){
                LeadGenDivisionReport divisionReport = new LeadGenDivisionReport();
                divisionReport.divisionName = paymentamtRecord.Opportunity__r.Division__c;
                leadGenDivisionReport.put(paymentamtRecord.Opportunity__r.Division__c,divisionReport);
            }*/
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
        //Payments for unique Opportunity would be 1 paid deal, irrespective of number of payment records
        
        for(Lead Convertedleadsrecord : Convertedleadsqueried){
         
           /* if(!leadGenDivisionReport.containsKey(Convertedleadsrecord.Division_Name__c)){
                LeadGenDivisionReport divisionReport = new LeadGenDivisionReport();
                divisionReport.divisionName = Convertedleadsrecord.Division_Name__c;
                leadGenDivisionReport.put(Convertedleadsrecord.Division_Name__c,divisionReport);
            }*/
            LeadGenReport leadGenReport = new LeadGenReport();
            if(leadGenReportMap.containsKey(Convertedleadsrecord.Owner.Name)){
                leadGenReport = leadGenReportMap.get(Convertedleadsrecord.Owner.Name);
            }
            leadGenReport.uName = Convertedleadsrecord.Owner.Name;
            leadGenReport.divisionName = Convertedleadsrecord.Division_Name__c;
            leadGenReport.Convertedleadcount = leadGenReport.Convertedleadcount+1;
            leadGenReportMap.put(Convertedleadsrecord.Owner.Name,leadGenReport);         
        }
         for( Opportunity closedoppRecord : closedoppqueried){
         
            /*if(!leadGenDivisionReport.containsKey(closedoppRecord.Division__c)){
                LeadGenDivisionReport divisionReport = new LeadGenDivisionReport();
                divisionReport.divisionName = closedoppRecord.Division__c;
                leadGenDivisionReport.put(closedoppRecord.Division__c,divisionReport);
            }*/
            LeadGenReport leadGenReport = new LeadGenReport();
            if(leadGenReportMap.containsKey(closedoppRecord.Owner.Name)){
                leadGenReport = leadGenReportMap.get(closedoppRecord.Owner.Name);
            }
            leadGenReport.uName = closedoppRecord.Owner.Name;
            leadGenReport.divisionName = closedoppRecord.Division__c;
            
            leadGenReport.Closedoptycount = leadGenReport.Closedoptycount+1;
            leadGenReportMap.put(closedoppRecord.Owner.Name,leadGenReport);         
        }
         for(Lead ActivityCountrecord : ActivityCount){
           /* if(!leadGenDivisionReport.containsKey(ActivityCountrecord.Division_Name__c)){
                LeadGenDivisionReport divisionReport = new LeadGenDivisionReport();
                divisionReport.divisionName = ActivityCountrecord.Division_Name__c;
                leadGenDivisionReport.put(ActivityCountrecord.Division_Name__c,divisionReport);
            }*/
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
        
        for( Opportunity opportunityActivity : opportunityActivityList){
         
           /* if(!leadGenDivisionReport.containsKey(opportunityActivity.Division__c)){
                LeadGenDivisionReport divisionReport = new LeadGenDivisionReport();
                divisionReport.divisionName = opportunityActivity.Division__c;
                leadGenDivisionReport.put(opportunityActivity.Division__c,divisionReport);
            }*/
            LeadGenReport leadGenReport = new LeadGenReport();
            if(leadGenReportMap.containsKey(opportunityActivity.Owner.Name)){
                leadGenReport = leadGenReportMap.get(opportunityActivity.Owner.Name);
            }
            leadGenReport.uName = opportunityActivity.Owner.Name;
            leadGenReport.divisionName = opportunityActivity.Division__c;
            leadGenReport.noActivityOpportunity = leadGenReport.noActivityOpportunity+1;
            
           /*  leadGenReport.Actvtycount = leadGenReport.Actvtycount+ opportunityActivity.ActivityHistories.size();
            leadGenReport.Actvtycount = leadGenReport.Actvtycount+ opportunityActivity.OpenActivities.size();
            leadGenReport.pendingactvtycount = leadGenReport.pendingactvtycount+opportunityActivity.OpenActivities.size();
            if(opportunityActivity.OpenActivities.size() < 1){
            	leadGenReport.noActivityOpportunity = leadGenReport.noActivityOpportunity+1;
            }  */
            leadGenReportMap.put(opportunityActivity.Owner.Name,leadGenReport);         
        }
        for(Lead Activitypendingrecord : Activitypending){
         
           /* if(!leadGenDivisionReport.containsKey(Activitypendingrecord.Division_Name__c)){
                LeadGenDivisionReport divisionReport = new LeadGenDivisionReport();
                divisionReport.divisionName = Activitypendingrecord.Division_Name__c;
                leadGenDivisionReport.put(Activitypendingrecord.Division_Name__c,divisionReport);
            }*/
            LeadGenReport leadGenReport = new LeadGenReport();
            if(leadGenReportMap.containsKey(Activitypendingrecord.Owner.Name)){
                leadGenReport = leadGenReportMap.get(Activitypendingrecord.Owner.Name);
            }
            leadGenReport.uName = Activitypendingrecord.Owner.Name;
            leadGenReport.divisionName = Activitypendingrecord.Division_Name__c;
            
            leadGenReport.pendingactvtycount = leadGenReport.pendingactvtycount+Activitypendingrecord.OpenActivities.size();
            leadGenReportMap.put(Activitypendingrecord.Owner.Name,leadGenReport);         
        }   
        
        for(Lead noActivityLeadRecord : noActivityLeadsList){
         
          /*  if(!leadGenDivisionReport.containsKey(noActivityLeadRecord.Division_Name__c)){
                LeadGenDivisionReport divisionReport = new LeadGenDivisionReport();
                divisionReport.divisionName = noActivityLeadRecord.Division_Name__c;
                leadGenDivisionReport.put(noActivityLeadRecord.Division_Name__c,divisionReport);
            }*/
            LeadGenReport leadGenReport = new LeadGenReport();
            if(leadGenReportMap.containsKey(noActivityLeadRecord.Owner.Name)){
                leadGenReport = leadGenReportMap.get(noActivityLeadRecord.Owner.Name);
            }
            leadGenReport.uName = noActivityLeadRecord.Owner.Name;
            leadGenReport.divisionName = noActivityLeadRecord.Division_Name__c;
            leadGenReport.noActivityLeads = leadGenReport.noActivityLeads + 1;
            leadGenReportMap.put(noActivityLeadRecord.Owner.Name,leadGenReport);         
        }  
        
       //calculate bonus for each leadgen
      //  Set<String> Employeename = leadGenDivisionReport.keySet();
      //  for(String EmpDivisionRept : Employeename){
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
            
     //   }
        //totalReport.leadDeal =    (((decimal.valueof(totalReport.paidCount))*100)/(decimal.valueof(totalReport.leadCount)));      
        //totalReport.bonusAmount = getBonusAmount(totalReport.leadCount,totalReport.paidCount);
     
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
        
        test.starttest();
              
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
       // newlead.Ownerid=usr11.id;
       
        insert newlead;
       
        system.debug('**************lead1**********'+newlead.id);
     
     
      Account acc=new Account();
      acc.Name='SOScompany';
      acc.Email__c='sample@in.com';
      acc.Phone='(954) 344-9254';
      acc.Type='Customer';
      insert acc;
      system.debug('*acc1*****************'+acc.id);
      
      Contact contact=new Contact();
      contact.AccountId=acc.id;
      contact.Email='sample@in.com';
      contact.LastName='Testjo';
      insert contact;
      system.debug('******con1************'+contact.id);
      
      Opportunity opp=new Opportunity();
      opp.Name='sample';
      opp.AccountId=acc.id;
      opp.Lead_Source__c='Approved Index';
      opp.Primary_Service_Name__c='Technology List';
      opp.Division__c='Winners';
      opp.StageName='Deal';
      opp.Sample_To_Deal__c='other';
      opp.Uploaded_By__c='test';
      opp.ForecastCategoryName='pipeline';
      opp.Amount=5000;
      opp.CloseDate=date.today()+20;
      opp.Team_Uploaded_By__c='Winners'; 
        opp.EMT__c='IDH';
      insert opp;
      system.debug('opp1******************'+opp.id);
      system.debug('opp1******************'+opp.owner.name); 

 	  Opportunity_Payment__c opppay=new Opportunity_Payment__c();
	  opppay.Opportunity__c=opp.id;
	  opppay.Pay_Status__c='paid';
	  opppay.Payment_Amount__c=23442;
	  opppay.Payment_Mode__c='Cash';
   	  insert opppay;
	  system.debug('opppay1******************'+opppay.id);

         
        NelsonReport Lreport = new NelsonReport();
        Lreport.UserName='All';
       // Lreport.fromDate='2012-02-09';
       // Lreport.toDate='2013-02-13';
        Lreport.getUserlist();
        Lreport.doSearch();
        List<LeadGenReport> LDR=new List<LeadGenReport>();
      	 LDR=Lreport.getLeadGenList();
        system.debug(LDR);
        Lreport.getTotalReport();
        Lreport.exportReport();
        Lreport.getSearchResults();
        Lreport.calculateBonusReport();
        
        NelsonReport report = new NelsonReport();
        report.UserName='Bryan Kumar';
      //  Lreport.fromDate='2013-02-01';
      //  Lreport.toDate='2013-02-23';
        report.getUserlist();
        report.getLeadGenList();
        report.doSearch();
        List<LeadGenReport> LDRs=new List<LeadGenReport>();
        LDRs=report.getLeadGenList();
        system.debug(LDRs);
        report.getTotalReport();
        report.exportReport();
        report.calculateBonusReport();
        
        test.stoptest();
    } 

}