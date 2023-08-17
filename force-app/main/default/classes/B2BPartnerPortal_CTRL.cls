public without sharing class B2BPartnerPortal_CTRL {
    
    
    @AuraEnabled
    public static string GetPartnerLeads(String PartnerId){
        System.debug('PartnerId =======> ' + PartnerId);
        return JSON.serializePretty(B2BPartnerPortal_Helper.GetPartnerLeads(PartnerId));
    }
    
    @AuraEnabled
    public static string GetPartnerAccounts(String PartnerId){
        System.debug('PartnerId =======> ' + PartnerId);
        return JSON.serializePretty(B2BPartnerPortal_Helper.GetPartnerAccounts(PartnerId));
    }
    @AuraEnabled
    public static string GetPartnerOpportunity(String PartnerId){
        System.debug('PartnerId =======> ' + PartnerId);
        return JSON.serializePretty(B2BPartnerPortal_Helper.GetPartnerOpportunity(PartnerId));
    }
    
    @AuraEnabled
    public static string GetPartnerFollowUpActivities1(String PartnerId){
        System.debug('PartnerId =======> ' + PartnerId);
        return JSON.serializePretty(B2BPartnerPortal_Helper.GetPartnerFollowUpActivities1(PartnerId));
    }
    
     @AuraEnabled
    public static string GetFilteredPartnerLeadFollowUpActivities(String PartnerId, String StartDate, String endDate, String status){
        System.debug('PartnerId =======> ' + PartnerId);
        return JSON.serializePretty(B2BPartnerPortal_Helper.GetFilteredPartnerLeadFollowUpActivities(PartnerId, StartDate, endDate, status));
    }
    
         @AuraEnabled
    public static string GetFilteredPartnerOppFollowUpActivities(String PartnerId, String StartDate, String endDate, String stage){
        System.debug('PartnerId =======> ' + PartnerId);
        return JSON.serializePretty(B2BPartnerPortal_Helper.GetFilteredPartnerOppFollowUpActivities(PartnerId, StartDate, endDate, stage));
    }
    
    @AuraEnabled
    public static string GetPartnerLeadStatus(String PartnerId){
        System.debug('PartnerId =======> ' + PartnerId);
        return JSON.serializePretty(B2BPartnerPortal_Helper.GetPartnerLeadStatus());
    }
    @AuraEnabled
    public static string GetOpprtunityStagePicklist(String PartnerId){
        System.debug('PartnerId =======> ' + PartnerId);
        return JSON.serializePretty(B2BPartnerPortal_Helper.GetOpprtunityStagePicklist());
    }
    
    @AuraEnabled
    public static string GetTaskPicklists(){
        return JSON.serializePretty(B2BPartnerPortal_Helper.GetTaskPicklists());
    }
    
    @AuraEnabled
    public static LeadEditWrapper UpdateLeadRec(Lead LeadRec,string PartnerId){
        string message = '';
        try {
            LeadEditWrapper leadwrapper = new LeadEditWrapper();
            System.debug('LeadRec =====> ' +LeadRec );
            if(LeadRec.status == 'Qualified'){
                System.debug('LeadRec.status =====> ' +LeadRec.status );
                message = B2BPartnerPortal_Helper.convertLead(LeadRec);
                leadwrapper.message = message;
            }
            else{
                update LeadRec;
                message = 'Success';
                leadwrapper.message = message;
            }
            List<Lead> leadlist =[SELECT Lead_Number__c,Address,AnnualRevenue,City,Company,ConvertedAccountId,Country,CreatedDate,Description,Designation__c,Email,FirstName,Id,Industry,IsConverted,LastModifiedDate,LastName,LastViewedDate,LeadSource,Longitude,MasterRecordId,Name,Next_Follow_up_Date__c,NumberOfEmployees,OwnerId,Phone,Owner.Name,
                                  PhotoUrl,PostalCode,Rating,Remarks__c,Salutation,State,Status,Street,Title,Website 
                                  FROM Lead
                                  Where  Partner__c =: PartnerId AND IsConverted = false ];
            leadwrapper.CompleteleadList = leadlist;
            
            return leadwrapper;
            
        } catch (Exception e) {
            System.debug('The error has occured due to ======> ' + e.getMessage());
            System.debug('The error has occured due to ======> ' + e.getLineNumber());
            
        }
        return null;
    }
    Public Class LeadEditWrapper{
        @AuraEnabled 
        Public List<Lead> CompleteleadList {get; set;}
        @AuraEnabled 
        Public string message {get; set;}
        
    }
    @AuraEnabled
    public static clashLeadWrapper CreateNewLeadRec(Lead NewLeadRec, string PartnerId){
        clashLeadWrapper wrapCL = new clashLeadWrapper();
        try {
            System.debug('NewLeadRec =====> ' +NewLeadRec );
            System.debug('PartnerId =====> ' +PartnerId );
            if(NewLeadRec.Email != null || NewLeadRec.Email != ''){
                List<Lead> existLeadList = [SELECT Id, Name, Partner__c FROM Lead WHERE Email =: NewLeadRec.Email Order by CreatedDate desc  LIMIT 1];
                System.debug(existLeadList.size());
                if(existLeadList.size()>0){
                    Clash_Lead__c newClashLeadRec = new Clash_Lead__c();
                    newClashLeadRec.Parent_Lead__c = existLeadList[0].Id;
                    newClashLeadRec.Partner__c = PartnerId;
                    insert newClashLeadRec;
                    wrapCL.message = 'Clash Lead Created';
                }else{
                    NewLeadRec.Partner__c = PartnerId;
                    insert NewLeadRec;
                    System.debug('NewLeadRec =====> ' +NewLeadRec);
                    System.debug('NewLeadRecID =====> ' +NewLeadRec.id );
                    wrapCL.message = 'Success';
                }
            }
            else{
                NewLeadRec.Partner__c = PartnerId;
                insert NewLeadRec;
                System.debug('NewLeadRec =====> ' +NewLeadRec);
                System.debug('NewLeadRecID =====> ' +NewLeadRec.id );
                wrapCL.message = 'Success';
            }
            list<Lead> leadlist = [SELECT Lead_Number__c,Address,AnnualRevenue,City,Company,ConvertedAccountId,Country,CreatedDate,Description,Designation__c,Email,FirstName,Id,Industry,IsConverted,LastModifiedDate,LastName,LastViewedDate,LeadSource,Longitude,MasterRecordId,Name,Next_Follow_up_Date__c,NumberOfEmployees,OwnerId,Phone,Owner.Name,
                                   PhotoUrl,PostalCode,Rating,Remarks__c,Salutation,State,Status,Street,Title,Website,Client_Name__c,Lead_Assigned_BD_name__c,Company_Recent_Blogs__c,Webinar_Links__c,Client_Time_Zone__c
                                   FROM Lead
                                   Where  Partner__c =: PartnerId AND IsConverted = false ];
            wrapCL.leadList1 = leadlist;
            //return wrapCL;
            
        } catch (Exception e) {
            System.debug('The error has occured due to ======> ' + e.getMessage());
            System.debug('The error has occured due to ======> ' + e.getLineNumber());
            list<Lead> leadlist = [SELECT Lead_Number__c,Address,AnnualRevenue,City,Company,ConvertedAccountId,Country,CreatedDate,Description,Designation__c,Email,FirstName,Id,Industry,IsConverted,LastModifiedDate,LastName,LastViewedDate,LeadSource,Longitude,MasterRecordId,Name,Next_Follow_up_Date__c,NumberOfEmployees,OwnerId,Phone,Owner.Name,
                                   PhotoUrl,PostalCode,Rating,Remarks__c,Salutation,State,Status,Street,Title,Website,Client_Name__c,Lead_Assigned_BD_name__c,Company_Recent_Blogs__c,Webinar_Links__c,Client_Time_Zone__c
                                   FROM Lead
                                   Where  Partner__c =: PartnerId AND IsConverted = false ];
            wrapCL.leadList1 = leadlist;
            wrapCL.message = 'ERROR';
        }
        
        return wrapCL;
    }
    
    @AuraEnabled
    public static string saveNewLeadTask(Task tk, String PartnerId){
        tk.Partner__c = PartnerId;
        upsert tk;
        return 'Success';
    }
    
    public class clashLeadWrapper{
        @auraEnabled
        public List<Lead> leadList1;
        @auraEnabled
        public String message;
    }
    
    @AuraEnabled
    public static String deleteLeadrecords(List<Id> LeadstobeDeleted){
        List<Lead> ListLeadsToReturn=new List<Lead>();
        set<String> deletedLeadIds = new Set<String>();
        System.debug('LeadList =====> ' + LeadstobeDeleted);
        try {
            //set<String> LeadIds
            List<PE_Lead__e> DeleteLeadRecordList = new List<PE_Lead__e>();
            
            if (!LeadstobeDeleted.isEmpty()) {
                for(id LeadRec : LeadstobeDeleted) {
                    
                    PE_Lead__e DeleteLeadRecord = new PE_Lead__e();
                    DeleteLeadRecord.Delete_Lead_Id__c = Leadrec;
                    DeleteLeadRecordList.add(DeleteLeadRecord);
                }
            }
            
            if (!DeleteLeadRecordList.isEmpty()) {
                Database.SaveResult[] results = EventBus.publish(DeleteLeadRecordList);
                for (Integer i = 0, s = results.size(); i < s; i++){
                    if (!results[i].isSuccess()){
                        
                        for (Database.Error e : results[i].getErrors()){
                            System.debug('Error ====> ' + e);
                        }
                    }
                    else if(results[i].isSuccess()){
                        System.debug('Success Id ====> ' + results[i]);
                        //deletedLeadIds.add(results[i].getId());
                        System.debug('Success Id ====> ' + results[i].getId());
                    }
                }
            }  
            
            
        } catch (Exception e) {
            System.debug('The error has occured due to ======> ' + e.getMessage());
            System.debug('The error has occured due to ======> ' + e.getLineNumber());
        }
        return 'SUCCESS';
    }
    
    @AuraEnabled
    public static String deleteExistingLeadRec(String recordId){
        
        System.debug('recordId =====> ' + recordId);
        try {
            Lead leadRec = [Select id from Lead Where id =:recordId];
            List<PE_Lead__e> DeleteLeadRecordList = new List<PE_Lead__e>();
            if(leadRec != null) {
                PE_Lead__e DeleteLeadRecord = new PE_Lead__e();
                DeleteLeadRecord.Delete_Lead_Id__c = leadRec.id;
                DeleteLeadRecordList.add(DeleteLeadRecord);
            }
            
            if (!DeleteLeadRecordList.isEmpty()) {
                Database.SaveResult[] results = EventBus.publish(DeleteLeadRecordList);
                for (Integer i = 0, s = results.size(); i < s; i++){
                    if (!results[i].isSuccess()){
                        
                        for (Database.Error e : results[i].getErrors()){
                            System.debug('Error ====> ' + e);
                        }
                    }
                    else if(results[i].isSuccess()){
                        System.debug('Success Id ====> ' + results[i]);
                        //deletedLeadIds.add(results[i].getId());
                        System.debug('Success Id ====> ' + results[i].getId());
                    }
                }
            }  
            
        } catch (Exception e) {
            System.debug('The error has occured due to ======> ' + e.getMessage());
            System.debug('The error has occured due to ======> ' + e.getLineNumber());
        }
        return 'SUCCESS';
    }   
    
    @AuraEnabled
    public static string GetGroupList(){
        return JSON.serializePretty(B2BPartnerPortal_Helper.GetGroupList());
    }
    
    
    @AuraEnabled
    Public Static transferdatawrapper getUserbyGroup(){
        
        map<string,list<User>> usersByGroupsid = new map<string,list<User>>();
        
        List<Group> Groups=[SELECT DeveloperName,DoesIncludeBosses,DoesSendEmailToMembers,Email,Id,Name FROM Group ];  //WHERE type = 'Queue'
        List<GroupMember> GroupMembers=[SELECT GroupId,Id,UserOrGroupId FROM GroupMember];
        List<User> Users=[SELECT AccountId,Alias,Email,FirstName,Id,Name FROM User];
        system.debug('Users-->'+Users);
        system.debug('Users-->size '+Users.size());
        transferdatawrapper trpwrap = new transferdatawrapper();
        trpwrap.Groups=Groups;
        trpwrap.GroupMembers=GroupMembers;
        trpwrap.Users=Users;
        system.debug('trpwrap'+trpwrap);
        return trpwrap;
    }
    
    Public Class transferdatawrapper{
        @AuraEnabled 
        Public List<Group> Groups {get; set;}
        @AuraEnabled 
        Public  List<GroupMember> GroupMembers {get; set;}
        @AuraEnabled 
        Public List<User> Users {get;set;}
    }
    
    @AuraEnabled
    Public Static List<Lead> TransferLead(List<id> leadsTobeTransfredByIDs,string selectedOwnerid){
        system.debug('leadsTobeTransfredByIDs'+leadsTobeTransfredByIDs);
        List<Lead> leadListTobeUpdated = new List<Lead>();
        if(!leadsTobeTransfredByIDs.isEmpty()){
            for(Id recordid : leadsTobeTransfredByIDs){
                Lead leadtobeUpdated = new Lead();
                leadtobeUpdated.id = recordid;
                leadtobeUpdated.OwnerId = selectedOwnerid;
                leadListTobeUpdated.add(leadtobeUpdated);
            }
            update leadListTobeUpdated;
            system.debug('leadListTobeUpdated==='+leadListTobeUpdated);
        }
        
        return leadListTobeUpdated;
    }
    
    @AuraEnabled
    public static string PartnerdashboardChartsData(String userPortalid,date startDate,date endDate){
        return JSON.serializePretty(B2BPartnerPortal_Helper.PartnerdashboardChartsData(userPortalid ,startDate,endDate));
    }
   /* @AuraEnabled
    public static string PartnerdashboardChartsData1(string userPortalid, string startDate, string endDate){
        return JSON.serializePretty(B2BPartnerPortal_Helper.PartnerdashboardChartsData1(userPortalid ,startDate,endDate));
    }*/
    
    @AuraEnabled
    public static wrapperDashboard getUserDashboardData(string userPortalid,string startDate,string EndDate){
        try{
            if(startDate!=null || EndDate!=null){
               DateTime StartDateTime = Date.valueOf(startDate); 
                 system.debug('StartDateTime--'+StartDateTime);
               DateTime EndDateTime= Date.valueOf(EndDate);
                 system.debug('EndDateTime--'+EndDateTime);
            } 
            Map<Id,Lead> LeadMap=new Map<Id,Lead>([Select Id,Name,(Select Id,Name From Clash_Leads__r) From Lead]);
            String OpportunityStatus='Closed Won';
            wrapperDashboard wrapper = new wrapperDashboard();
        String Revenue,LeadCount,Deals,TotalConversion,RevenuePerLead,LeadXClashLead; 
    if(startDate==null && EndDate==null && userPortalid != null){ 
    system.debug('I am inside today');
        Revenue ='SELECT Partner__c, SUM(AMOUNT) total FROM Opportunity WHERE Partner__c =:userPortalid AND CreatedDate=TODAY  GROUP BY Partner__c';
        LeadCount='Select Id,Name From Lead Where Partner__c=:userPortalid AND CreatedDate=TODAY';
        Deals='Select Id,Name From Opportunity Where Partner__c=:userPortalid AND StageName=:OpportunityStatus AND CreatedDate=TODAY';
        TotalConversion='SELECT COUNT(Id) CID FROM Lead User WHERE IsConverted = true And Partner__c=:userPortalid AND CreatedDate=TODAY';
        RevenuePerLead='Select Partner__c,AVG(AnnualRevenue) From Lead Where Partner__c=:userPortalid AND CreatedDate=TODAY GROUP BY Partner__c'; 
        LeadXClashLead='Select Id,Name,Parent_Lead__c From Clash_Lead__c Where  Partner__c=:userPortalid AND CreatedDate=TODAY';
}else{
    system.debug('I am not in today');
        Revenue ='SELECT SUM(AMOUNT) total FROM Opportunity WHERE Partner__c =:userPortalid AND CreatedDate >=:StartDateTime AND CreatedDate <=:EndDateTime GROUP BY Partner__c';
        system.debug('Revenue--'+Revenue);
        LeadCount='Select Id,Name From Lead Where Partner__c=:userPortalid AND CreatedDate >=:StartDateTime AND CreatedDate <=:EndDateTime';
        system.debug('LeadCount--'+LeadCount);
        Deals='Select Id,Name From Opportunity Where Partner__c=:userPortalid AND StageName=:OpportunityStatus AND CreatedDate >=:StartDateTime AND CreatedDate <=:EndDateTime';
    system.debug('Deals--'+Deals);
        TotalConversion='SELECT COUNT(Id) CID FROM Lead User WHERE IsConverted = true And Partner__c=:userPortalid AND CreatedDate >=:StartDateTime AND CreatedDate <=:EndDateTime';
    system.debug('TotalConversion--'+TotalConversion);
    RevenuePerLead='Select Partner__c, AVG(AnnualRevenue) From Lead Where Partner__c=:userPortalid AND CreatedDate >=:StartDateTime AND CreatedDate <=:EndDateTime GROUP BY Partner__c';
        LeadXClashLead='Select Id,Name,Parent_Lead__c From Clash_Lead__c Where  Partner__c=:userPortalid AND CreatedDate >=:StartDateTime AND CreatedDate <=:EndDateTime';
    system.debug('LeadXClashLead--'+LeadXClashLead);
    system.debug('RevenuePerLead--'+RevenuePerLead);
  //  RevenuePerLead = 'SELECT Partner__c, AVG(AnnualRevenue)FROM Lead WHERE Partner__c=:userPortalid AND CreatedDate >=:StartDateTime AND CreatedDate <=:EndDateTime GROUP BY Partner__c';
}
Integer totalCount = [SELECT COUNT() FROM Lead where Partner__c=:userPortalid];

    //Revenue
    List<AggregateResult> RevenueResult=Database.query(Revenue); 
    if(!RevenueResult.isEmpty()){
            String Str='' + RevenueResult[0].get('total'); 
            if( Decimal.valueOf(Str) != null){
                wrapper.Revenue=Decimal.valueOf(Str);  

            }
            
            system.debug('Decimal.valueOf(Str)--'+Decimal.valueOf(Str));
        } 

    
    List<AggregateResult> RevenueResult1=Database.query(RevenuePerLead); 
for (AggregateResult ar : RevenueResult1)  {
System.debug('Industry: ' + ar.get('Partner__c') );
string leadPerRevenue = '' + ar.get('expr0');
Decimal originalValue =  Decimal.valueOf(leadPerRevenue);
Decimal rounded = originalValue.setScale(0);
if(rounded != null){
    wrapper.RevenuePerLead =rounded ; 
}

System.debug('Sum of employees: ' + ar.get('expr0'));

//System.debug('Max number of employees: ' + ar.get('expr2'));
}
        
        //LeadCount
        List<Lead> Leadlist=Database.query(LeadCount);
        if(!Leadlist.isEmpty()){
            wrapper.LeadCount=Leadlist.size();
            system.debug('Leadlist.size()--'+Leadlist.size());
        }
                
        
        //Opportunity Count
        List<Opportunity> OpportunityList=Database.query(Deals); 
            if(!OpportunityList.isEmpty()){
            wrapper.Deals=OpportunityList.size();
            system.debug('OpportunityList.size()--'+OpportunityList.size());

            }
                
        //ConversionLead Ratio
        List<AggregateResult> ConverstionList = Database.query(TotalConversion);
        if(!ConverstionList.isEmpty()){
            String Str2='' + ConverstionList[0].get('CID');
            Decimal convertedCount=Decimal.valueOf(Str2);
            Decimal formattedNumber = totalCount > 0 ? (convertedCount / Decimal.valueOf(totalCount)) * 100 : 0;
            Decimal conversionRatio =  formattedNumber.setScale(2);
            wrapper.ConvertedLeadRatio = conversionRatio;
            system.debug('conversionRatio--'+conversionRatio);
        }
        
        //Revenue Per Lead
            /*List<AggregateResult> AvgRevenue=Database.query(Revenue); 
        system.debug('AvgRevenue--'+AvgRevenue);
        for (AggregateResult ar : AvgRevenue) { 
                System.debug('Average amount' + ar.get('expr0'));
        }
        String AVgStr='' + AvgRevenue[0].get('expr0'); 
        wrapper.RevenuePerLead=Decimal.valueOf(AVgStr);*/
        //Clash Lead
        List<Clash_Lead__c> ClashLeadList=Database.query(LeadXClashLead);
        if(!ClashLeadList.isEmpty()){
            wrapper.LeadNameXClashLeadCount=ClashLeadList.size();
        }


      /*  Map<String,Integer> LdXClashLeadCount=new Map<String,Integer>();
        if(!ClashLeadList.isEmpty()){
            For(Clash_Lead__c cls:ClashLeadList){
                if(LdXClashLeadCount.containsKey(cls.Parent_Lead__c)){
                    LdXClashLeadCount.put(cls.Parent_Lead__c,new List<Clash_Lead__c>{cls}.size()+LdXClashLeadCount.get(cls.Parent_Lead__c));
                }else{
                    LdXClashLeadCount.put(cls.Parent_Lead__c,new List<Clash_Lead__c>{cls}.size());
                }
            }
        }
        if(!LdXClashLeadCount.isEmpty()){
            for(Id LdId:LdXClashLeadCount.keyset()){
                if(LeadMap.containsKey(LdId)){
                }     //wrapper.LeadNameXClashLeadCount=new Map<String,Integer>{LeadMap.get(LdId).Name=>LdXClashLeadCount.get(LdId)}; 
            } 
            wrapper.LeadNameXClashLeadCount=LeadMap;
            system.debug('LeadMap--'+LeadMap);
        }*/
        
        system.debug('wrapper.Revenue--'+wrapper.Revenue);
        system.debug('wrapper.LeadCount--'+wrapper.LeadCount);
        system.debug('wrapper.Deals--'+wrapper.Deals);
        system.debug('wrapper.ConvertedLeadRatio--'+wrapper.ConvertedLeadRatio);
        system.debug('wrapper.RevenuePerLead--'+wrapper.RevenuePerLead);
        system.debug('wrapper.LeadNameXClashLeadCount--'+wrapper.LeadNameXClashLeadCount);
        /*
            List<AggregateResult> TotalRevList = [SELECT Partner__c, SUM(AMOUNT) total FROM Opportunity WHERE Partner__c =:userPortalid AND CreatedDate=TODAY  GROUP BY Partner__c]; 
                Decimal decimalRevenue = 0; 
                Decimal decimalLastMonth = 0; 
                if(TotalRevList.size() >0){
                    String str = '' + TotalRevList[0].get('total') ;
                    decimalRevenue = Decimal.ValueOf(str) ;
                    System.debug('decimalRevenue ::::: ' + decimalRevenue) ; 
                }
                wrapper.Revenue = decimalRevenue;
        
            
            //Leads/LeadCount
            List<Lead> LeadList=[Select Id,Name From Lead Where Partner__c=:userPortalid AND CreatedDate=TODAY];
            if(!LeadList.isEmpty()){
                wrapper.LeadCount=LeadList.size();
            }
            
            //Deals
            List<Opportunity> OpportunityList=[Select Id,Name From Opportunity Where Partner__c=:userPortalid AND StageName='ClosedWon'AND CreatedDate=TODAY];
            if(!OpportunityList.isEmpty()){
                wrapper.Deals=OpportunityList.size();
            }
            
            //Revenue-Per-Lead
            List<AggregateResult> AVGRevenuePerLead=[Select Count(Id),AVG(AnnualRevenue) AVR From Lead Where Partner__c=:userPortalid AND CreatedDate=TODAY];
            Decimal decimalRevenue = 0; 
            Decimal decimalLastMonth = 0; 
            if(AVGRevenuePerLead.size() >0){
                String str = '' + AVGRevenuePerLead[0].get('AVR') ;
                decimalRevenue = Decimal.ValueOf(str) ;
                System.debug('decimalRevenue ::::: ' + decimalRevenue) ; 
            }
            wrapper.RevenuePerLead = decimalRevenue;
            
            //Conversation
            
            System.debug('conversionRatio ::::: ' + conversionRatio) ;
         }
            
            /*AggregateResult result = [SELECT SUM(Amount) totalRevenue,Partner__c
                                      FROM Opportunity
                                      WHERE CloseDate >= :lastMonthStartDate AND CloseDate <= :lastMonthEndDate   AND Partner__c =:userPortalid   GROUP BY Partner__c] ;
            if(result != null){
                String revnu = '' + result.get('totalRevenue') ;
                decimalLastMonth =Decimal.ValueOf(revnu) ; 
                System.debug('decimalLastMonth ::::: ' + decimalLastMonth) ; 
            }
            wrapper.lastMonthReturnRevenue = decimalLastMonth;
            
            Integer convertedCount = [SELECT COUNT() FROM Lead User WHERE IsConverted = true And Partner__c=:userPortalid ];
            Integer totalCount = [SELECT COUNT() FROM Lead where Partner__c=:userPortalid];
            
            Decimal formattedNumber = totalCount > 0 ? (Decimal.valueOf(convertedCount) / Decimal.valueOf(totalCount)) * 100 : 0;
            Decimal conversionRatio =  formattedNumber.setScale(2);
            wrapper.ConvertedLeadRatio = conversionRatio;
            System.debug('conversionRatio ::::: ' + conversionRatio) ;
            
            set<id> accIds = new  set<id>();
            
            Decimal totalOppchurnRatio;
            List<Opportunity> oppList = [Select id ,Recurring__c,Opp_Created_Date__c,AccountId from Opportunity where Recurring__c = true AND Partner__c =:userPortalid AND  Opp_Created_Date__c = LAST_MONTH  ];
            system.debug('oppList=====>>'+oppList);
            integer LastMonthOppCount = oppList.size();
            system.debug('LastMonthOppCount=====>>'+LastMonthOppCount);
            system.debug('oppListSize======>>'+oppList.size());
            if(oppList.size()>0){
                for(Opportunity opp :oppList){
                    accIds.add(opp.AccountId);
                }
            }
            system.debug('accIds=====>>'+accIds);
            //   List<Account> acclist =   [Select id,(Select id ,Recurring__c from opportunities where Recurring__c = true AND  CreatedDate = THIS_MONTH)from Account where id IN:accIds AND  Partner__c =:partnerid ];
            if(!accIds.isEmpty()){
                system.debug('accIds=====>>'+accIds);
                List<Opportunity> ThisMonthoppList = [Select id ,Recurring__c,Opp_Created_Date__c from Opportunity where Recurring__c = true AND Partner__c =:userPortalid AND  AccountID IN :accIds AND Opp_Created_Date__c = THIS_MONTH  ];
                system.debug('ThisMonthoppList=====>>'+ThisMonthoppList);
                integer ThisMonthOppCount = ThisMonthoppList.size();
                system.debug('ThisMonthOppCount=====>>'+ThisMonthOppCount);
                Decimal  OppchurnRatioA = LastMonthOppCount - ThisMonthOppCount   ;
                Decimal  OppchurnRatio1 = OppchurnRatioA / LastMonthOppCount;
                system.debug('OppchurnRatio1=====>>'+OppchurnRatio1);
                totalOppchurnRatio = (OppchurnRatio1 * 100 ).setScale(2);
                system.debug('totalOppchurnRatio=====>>'+totalOppchurnRatio);
            }
            wrapper.churnRatio = totalOppchurnRatio;*/
            return wrapper;
        }catch(Exception e){
            system.debug('Error Message==>'+e.getMessage()+ 'Erro in Line==>'+e.getLineNumber());
        }
        return null;
    }
    
    public class wrapperDashboard {
        @AuraEnabled 
        public Decimal Revenue{get;set;}//Get Total Revenue Count Under That PartnerId
        @AuraEnabled 
        public Integer LeadCount {get;set;}//Get Total Lead Count Under That PartnerId
        @AuraEnabled 
        public Integer Deals {get;set;}//Get All Total ClosedWon Opportunity Under That PartnerId
        @AuraEnabled
        public decimal RevenuePerLead {get;set;}//Average Revenue Per Lead
        @AuraEnabled
        public Decimal ConvertedLeadRatio {get;set;}//Converted Lead Ratio
        @AuraEnabled
        public Decimal ClashLeads  {get;set;}//Clash Leads
        @AuraEnabled
        public integer LeadNameXClashLeadCount{get;set;}
        
    }
    
    @AuraEnabled
    public static List<TasK> getTodaysTaskForUserPortal(string userPortalid){
        set<id> leadID = new set<id>();
        
        List<Lead> listlead =[Select id ,FirstName,LastName,Partner__c  From Lead where Partner__c =: userPortalid];
        system.debug('listlead===='+listlead);
        for(Lead lead :listlead){
            leadID.add(lead.id);
        }
        
        system.debug('leadID====='+leadID);
        
        list<Task> listOfTodaysTask = [SELECT Id, Subject, ActivityDate,CreatedDate, Status,Who.Name 
                                       FROM Task  
                                       WHERE Whoid IN: leadID AND ActivityDate = TODAY ];
        system.debug('listOfTodaysTask===='+listOfTodaysTask);
        return listOfTodaysTask;
    }
    
    @AuraEnabled
    public static oppWrapper getOpportunityTaskUnderProposal(string userPortalid){
        system.debug('userPortalid==='+userPortalid);
        oppWrapper wrapper = new oppWrapper();
        List<Opportunity> opplist = [Select id,StageName,Account.Name,  (SELECT Id, Subject,Status,CreatedDate FROM Tasks  WHERE  Status != 'Completed' Order by CreatedDate)  from Opportunity  where Partner__c =:userPortalid AND StageName ='Proposal/Price Quote'];
        
        // system.debug('tasklist==='+opplist[0].Tasks);
        system.debug('opplist==='+opplist);
        
        wrapper.accname = opplist[0].Account.Name;
        wrapper.taskRec = opplist[0].Tasks;
        system.debug('wrapper==='+wrapper);
        return wrapper;
    }
    public class oppWrapper{
        @AuraEnabled 
        public string  accname {get;set;}
        @AuraEnabled 
        public Task  taskRec {get;set;}
    }
    
    @AuraEnabled
    public static List<Opportunity> getCloseLostOpportunityofAccont(string userPortalid){
        set<string> accountID = new set<string>();
        List<Account> acclist=[Select id ,Name,Partner__c From Account where Partner__c =:userPortalid];
        for(Account acc :acclist ){
            id accid = acc.id;
            accountID.add(accid);
        }
        list<Opportunity> oppList = [SELECT Id, Account.Name,CloseDate FROM Opportunity  WHERE AccountId =:accountID And StageName = 'Closed Lost'];
        system.debug('oppList===='+oppList);
        return oppList;
    }
    @AuraEnabled
    public static List<Task> getOverudeTaskList(string userPortalid){
         
        List<Task> tasklist =[SELECT Id,WhoId ,Who.Name ,Subject,ActivityDate,CreatedDate FROM Task where IsClosed = False AND Partner__C=:userPortalid AND ActivityDate < Today];
         
         system.debug('tasklist===='+tasklist);
        return tasklist;
    }
    @AuraEnabled
    public static List<Lead> getLeadsAndClashLeads(string userPortalid){

        List<Lead> LeadswithMultipleClashLeads = new List<Lead>();

           Map<Id, Lead> LeadidwithLleadMap = new Map<Id, Lead>(

          [Select id,FirstName,LastName,Industry,Company,(Select Id,Name,Parent_Lead__c,Parent_Lead__r.FirstName,Parent_Lead__r.LastName From Clash_Leads__r) from Lead Where  Partner__c=:userPortalid]
          );
           for (Lead led : LeadidwithLleadMap.values()) {
            if (led.Clash_Leads__r.size() >= 1) {
                LeadswithMultipleClashLeads.add(led);
            }
        }
         system.debug('LeadswithMultipleClashLeads===='+LeadswithMultipleClashLeads);
        return LeadswithMultipleClashLeads;
    }
    
    @AuraEnabled
    public static List<Task> getFollowuPTaskOnLead(string userPortalid){
        set<id> leadID = new set<id>();
        
        List<Lead> listlead =[Select id ,FirstName,LastName,Partner__c From Lead where Partner__c =: userPortalid];
        system.debug('listlead===='+listlead);
        for(Lead lead :listlead){
            leadID.add(lead.id);
        }
        system.debug('leadID===='+leadID);
        List<Task> tasklist =[SELECT Id, Subject, ActivityDate, Status,who.Name
                              FROM Task
                              WHERE Whoid IN:leadID AND Subject LIKE:'%Followup%'];
        system.debug('tasklist===='+tasklist);
        return tasklist;
    }
    
    @AuraEnabled
    public static List<String> getFieldValues() {
        String objectName='Lead';
        String fieldName='Status';
        List<String> fieldValues = new List<String>();
        
        Schema.SObjectType objectType = Schema.getGlobalDescribe().get(objectName);
        if (objectType != null) {
            Schema.DescribeSObjectResult objectDescribe = objectType.getDescribe();
            
            if (objectDescribe.fields.getMap().containsKey(fieldName)) {
                Schema.DescribeFieldResult fieldDescribe = objectDescribe.fields.getMap().get(fieldName).getDescribe();
                
                if (fieldDescribe.isAccessible()) {
                    List<Schema.PicklistEntry> picklistEntries = fieldDescribe.getPicklistValues();
                    
                    for (Schema.PicklistEntry entry : picklistEntries) {
                        fieldValues.add(entry.getValue());
                    }
                }
            }
        }
        system.debug('fieldValues--'+fieldValues);
        return fieldValues;
    }
    
    @AuraEnabled
    Public Static String updateLeadStatus(String recordId,String Statusvalue, String PartnerId){
        system.debug('recordId'+recordId);
        system.debug('Statusvalue'+Statusvalue);
        Lead leadRec= new lead ();
        leadRec.Id = recordId;
        leadRec.Status=Statusvalue;
        string message = '';
        LeadEditWrapper leadwrapper = new LeadEditWrapper();
        try {
            System.debug('LeadRec =====>' +LeadRec );
            if(LeadRec.status == 'Qualified'){
                message = B2BPartnerPortal_Helper.convertLead(LeadRec);
                leadwrapper.message = message;
                leadwrapper.CompleteleadList = [SELECT Lead_Number__c,Address,AnnualRevenue,City,Company,ConvertedAccountId,Country,CreatedDate,Description,Designation__c,Email,FirstName,Id,Industry,IsConverted,LastModifiedDate,LastName,LastViewedDate,LeadSource,Longitude,MasterRecordId,Name,Next_Follow_up_Date__c,NumberOfEmployees,OwnerId,Phone,Owner.Name,
                                                PhotoUrl,PostalCode,Rating,Remarks__c,Salutation,State,Status,Street,Title,Website,Client_Name__c,Lead_Assigned_BD_name__c,Company_Recent_Blogs__c,Webinar_Links__c,Client_Time_Zone__c 
                                                FROM Lead
                                                Where  Partner__c =: PartnerId AND IsConverted = false ];
            }
            else{
                update LeadRec;
                message = 'Success';
                leadwrapper.message = message;
                leadwrapper.CompleteleadList = [SELECT Lead_Number__c,Address,AnnualRevenue,City,Company,ConvertedAccountId,Country,CreatedDate,Description,Designation__c,Email,FirstName,Id,Industry,IsConverted,LastModifiedDate,LastName,LastViewedDate,LeadSource,Longitude,MasterRecordId,Name,Next_Follow_up_Date__c,NumberOfEmployees,OwnerId,Phone,Owner.Name,
                                                PhotoUrl,PostalCode,Rating,Remarks__c,Salutation,State,Status,Street,Title,Website,Client_Name__c,Lead_Assigned_BD_name__c,Company_Recent_Blogs__c,Webinar_Links__c,Client_Time_Zone__c 
                                                FROM Lead
                                                Where  Partner__c =: PartnerId and Id=:recordId AND IsConverted = false ];
            }
            
            return message;
            
        } catch (Exception e) {
            System.debug('The error has occured due to ======> ' + e.getMessage());
            System.debug('The error has occured due to ======> ' + e.getLineNumber());
            
        }
        return message;
    }
    
    @AuraEnabled
    public static List<SObJectResult> getResults(String ObjectName, String fieldName, String value) {
        List<SObJectResult> sObjectResultList = new List<SObJectResult>();
        for(sObject so : Database.Query('Select Id,'+fieldName+' FROM '+ObjectName+' WHERE '+fieldName+' LIKE \'%' + value + '%\'')) {
            String fieldvalue = (String)so.get(fieldName);
            sObjectResultList.add(new SObjectResult(fieldvalue, so.Id));
        }
        
        return sObjectResultList;
    }
    
    public class SObJectResult {
        @AuraEnabled
        public String recName;
        @AuraEnabled
        public Id recId;
        
        public SObJectResult(String recNameTemp, Id recIdTemp) {
            recName = recNameTemp;
            recId = recIdTemp;
        }
    }
    /*@AuraEnabled
public static void deleteRecordsByIds(List<Id> LeadstobeDeleted) {
List<Lead> recordsToDelete = new List<Lead>();

// Retrieve records by their Ids
for (Id recordId : LeadstobeDeleted ) {
Lead record = [SELECT Id FROM Lead WHERE Id = :recordId];
if (record != null) {
recordsToDelete.add(record);
}
}

// Delete records
if (!recordsToDelete.isEmpty()) {
Database.DeleteResult[] deleteResults = Database.delete(recordsToDelete, false);
for (Database.DeleteResult deleteResult : deleteResults) {
if (!deleteResult.isSuccess()) {
// Handle error if needed
System.debug('Error deleting record with Id: ' + deleteResult.getId() + ', Error Message: ' + deleteResult.getErrors()[0].getMessage());
}
}
}
}*/
    
    @AuraEnabled 
    public static List<Lead> getLeadRecordByListViewByname(String listViewName,Id partnerId) {
        system.debug('listViewName==='+listViewName);
        system.debug('partnerId==='+partnerId);
        list<Lead> leadlist1 = new list<Lead>();
        if(listViewName =='All'){
            system.debug('All');
            List<Lead> LeadL1 = [SELECT LeadID__c,Lead_Number__c,Address,AnnualRevenue,City,Company,ConvertedAccountId,Country,CreatedDate,Description,Designation__c,Email,FirstName,Id,Industry,IsConverted,LastModifiedDate,LastName,LastViewedDate,LeadSource,Longitude,MasterRecordId,Name,Next_Follow_up_Date__c,NumberOfEmployees,OwnerId,Phone,Owner.Name,
                                 PhotoUrl,PostalCode,Rating,Remarks__c,Salutation,State,Status,Street,Title,Website ,LastActivityDate,Creted_Time__C 
                                 FROM Lead
                                 Where  Partner__c =: partnerId AND IsConverted = false];
            leadlist1=LeadL1;
        }
        else if(listViewName =='Today Lead'){
            system.debug('TodaysLead===');
            List<Lead> LeadL1 = [SELECT LeadID__c, Lead_Number__c,Address,AnnualRevenue,City,Company,ConvertedAccountId,Country,CreatedDate,Description,Designation__c,Email,FirstName,Id,Industry,IsConverted,LastModifiedDate,LastName,LastViewedDate,LeadSource,Longitude,MasterRecordId,Name,Next_Follow_up_Date__c,NumberOfEmployees,OwnerId,Phone,Owner.Name,
                                 PhotoUrl,PostalCode,Rating,Remarks__c,Salutation,State,Status,Street,Title,Website ,LastActivityDate,Creted_Time__C 
                                 FROM Lead
                                 
                                 Where  Partner__c =: partnerId AND IsConverted = false AND CreatedDate = TODAY];
            leadlist1=LeadL1;
        } else if (listViewName =='Last Week Lead'){
            system.debug('Last Week Lead===');
            List<Lead> LeadL1 = [SELECT  LeadID__c,Lead_Number__c,Address,AnnualRevenue,City,Company,ConvertedAccountId,Country,CreatedDate,Description,Designation__c,Email,FirstName,Id,Industry,IsConverted,LastModifiedDate,LastName,LastViewedDate,LeadSource,Longitude,MasterRecordId,Name,Next_Follow_up_Date__c,NumberOfEmployees,OwnerId,Phone,Owner.Name,
                                 PhotoUrl,PostalCode,Rating,Remarks__c,Salutation,State,Status,Street,Title,Website ,LastActivityDate,Creted_Time__C 
                                 FROM Lead
                                
                                 Where  Partner__c =: partnerId AND IsConverted = false AND CreatedDate > LAST_WEEK ORDER BY NAME];
            leadlist1=LeadL1;
        }else if (listViewName =='Last Month Lead'){
            system.debug('Last Month Lead===');
            List<Lead> LeadL1 = [SELECT LeadID__c,Lead_Number__c,Address,AnnualRevenue,City,Company,ConvertedAccountId,Country,CreatedDate,Description,Designation__c,Email,FirstName,Id,Industry,IsConverted,LastModifiedDate,LastName,LastViewedDate,LeadSource,Longitude,MasterRecordId,Name,Next_Follow_up_Date__c,NumberOfEmployees,OwnerId,Phone,Owner.Name,
                                 PhotoUrl,PostalCode,Rating,Remarks__c,Salutation,State,Status,Street,Title,Website ,LastActivityDate,Creted_Time__C 
                                 FROM Lead
                                 
                                 Where  Partner__c =: partnerId AND IsConverted = false AND CreatedDate < LAST_MONTH ORDER BY NAME];
            leadlist1=LeadL1;
            
        }
        else if (listViewName =='Last Quarter Lead'){
            system.debug('Last Quarter Lead===');
            List<Lead> LeadL1 = [SELECT LeadID__c,Lead_Number__c,Address,AnnualRevenue,City,Company,ConvertedAccountId,Country,CreatedDate,Description,Designation__c,Email,FirstName,Id,Industry,IsConverted,LastModifiedDate,LastName,LastViewedDate,LeadSource,Longitude,MasterRecordId,Name,Next_Follow_up_Date__c,NumberOfEmployees,OwnerId,Phone,Owner.Name,
                                 PhotoUrl,PostalCode,Rating,Remarks__c,Salutation,State,Status,Street,Title,Website ,LastActivityDate,Creted_Time__C 
                                 FROM Lead
                                 Where  Partner__c =: partnerId AND   CreatedDate = LAST_90_DAYS ORDER BY NAME];
            leadlist1=LeadL1;
            
        }
        system.debug('leadlist==='+leadlist1);
        
        return  leadlist1;
    }
    @AuraEnabled 
    public static List<Lead> getLeadRecordByDate(Date startdate,Date endDate ,Id partnerId) {
        system.debug('startdate==='+startdate);
        system.debug('endDate==='+endDate);
        list<Lead> leadlist1 = new list<Lead>();
        if(startdate != null && startdate != null && partnerId != null){
            List<Lead> LeadL1 = [SELECT LeadID__c,Lead_Number__c,Address,AnnualRevenue,City,Company,ConvertedAccountId,Country,CreatedDate,Description,Designation__c,Email,FirstName,Id,Industry,IsConverted,LastModifiedDate,LastName,LastViewedDate,LeadSource,Longitude,MasterRecordId,Name,Next_Follow_up_Date__c,NumberOfEmployees,OwnerId,Phone,Owner.Name,
                                 PhotoUrl,PostalCode,Rating,Remarks__c,Salutation,State,Status,Street,Title,Website ,LastActivityDate
                                 FROM Lead
                                 Where  Partner__c =: partnerId AND IsConverted = false AND CreatedDate >=: startdate AND  CreatedDate <=: endDate];
            leadlist1.addAll(LeadL1);
            system.debug('LeadL1==='+LeadL1);
        }
        return leadlist1; 
    }
    @AuraEnabled 
    public static Decimal churnRatioOfOpportunity(string partnerid){
        set<id> accIds = new  set<id>();
        Decimal churnRatio;
        List<Opportunity> oppList = [Select id ,Recurring__c from Opportunity where Recurring__c = true AND Partner__c =:partnerid AND  CreatedDate = LAST_MONTH  ];
        integer LastMonthOppCount = oppList.size();
        system.debug('LastMonthOppCount=====>>'+LastMonthOppCount);
        system.debug('oppListSize======>>'+oppList.size());
        if(oppList.size()>0){
            for(Opportunity opp :oppList){
                accIds.add(opp.AccountId);
            }
        }
        
        //   List<Account> acclist =   [Select id,(Select id ,Recurring__c from opportunities where Recurring__c = true AND  CreatedDate = THIS_MONTH)from Account where id IN:accIds AND  Partner__c =:partnerid ];
        if(!accIds.isEmpty()){
            List<Opportunity> ThisMonthoppList = [Select id ,Recurring__c from Opportunity where Recurring__c = true AND Partner__c =:partnerid AND  AccountID IN :accIds AND CreatedDate = THIS_MONTH  ];
            
            integer ThisMonthOppCount = ThisMonthoppList.size();
            churnRatio = (LastMonthOppCount - ThisMonthOppCount )/LastMonthOppCount * 100 ;
            system.debug('chrnRatio=====>>'+oppList.size());
        }
        return churnRatio;
        
    }
    @AuraEnabled
    public static dashboardWrapper getUserRecord(string currentuserid){
        try{
            dashboardWrapper wrapper = new dashboardWrapper();
            User_Portal__c userRec =[Select id,First_Name__c,Last_Name__c,Hash_Code__c,Role__c from User_Portal__c where id =: currentuserid];
            system.debug('userRec===>>'+userRec);
            wrapper.PortlUserRec = userRec;
            wrapper.roleName = userRec.Role__c;
            system.debug('wrapper===>>'+wrapper);
            return wrapper;
            
        }catch(Exception e){
            system.debug('Error Message==>'+e.getMessage()+ 'Erro in Line==>'+e.getLineNumber());
        }
        return null;
    }
    
     @AuraEnabled
    public static dashboardWrapper getUserRecord1(string currentuserid, String startDate, String endDate){
        try{
            List<String> startDateList = new List<String>();
        startDateList = StartDate.split('-');
        startDate = startDateList[1] + '/' + startDateList[2] + '/' + startDateList[0];
        date startingDate = date.parse(startDate);
        List<String> endDateList = new List<String>();
        endDateList = endDate.split('-');
        endDate = endDateList[1] + '/' + endDateList[2] + '/' + endDateList[0];
        date endingDate = date.parse(endDate);
            dashboardWrapper wrapper = new dashboardWrapper();
            User_Portal__c userRec =[Select id,First_Name__c,Last_Name__c,Hash_Code__c,Role__c from User_Portal__c where id =: currentuserid AND CreatedDate>=:startingDate AND CreatedDate<=:endingDate];
            system.debug('userRec===>>'+userRec);
            wrapper.PortlUserRec = userRec;
            wrapper.roleName = userRec.Role__c;
            system.debug('wrapper===>>'+wrapper);
            return wrapper;
            
        }catch(Exception e){
            system.debug('Error Message==>'+e.getMessage()+ 'Erro in Line==>'+e.getLineNumber());
        }
        return null;
    }
    public class dashboardWrapper{
        @AuraEnabled
        public User_Portal__c PortlUserRec {get;set;} 
        @AuraEnabled
        public String roleName {get;set;}
    }
    public static void SendFollowUpEmailtoPOrtalUser(List<Task> TaskList){
        set<id> leadIds = new set<id>();
        set<id> oppIds = new set<id>();
        if(!TaskList.isEmpty()){
            for(Task taskRec :TaskList){
                leadIds.add(taskRec.WhoId);
                oppIds.add(taskRec.WhatId);
            }   
        }
        system.debug('leadIds==>>'+leadIds);
        system.debug('oppIds==>>'+oppIds);
        if(!leadIds.isEmpty() || !oppIds.isEmpty()){
            list<User_Portal__c> userlist = [Select id,User_Name__c,First_Name__c,(Select id,Partner__c from Leads1__r where Id IN:leadIds),(Select id,Partner__c from Opportunities__r where Id IN:oppIds) From User_Portal__c];
            List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
            system.debug('userlist==>>'+userlist);            
            for(User_Portal__c userRec :userlist){
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                String[] toAddresses = new String[] {userRec.User_Name__c};
                    email.setToAddresses(toAddresses);
                email.setSubject('New Task Created: ' +userRec.First_Name__c);
                
                
                email.setPlainTextBody('Dear ' + userRec.First_Name__c + ',\n\nA follow-up task has been created on one of your Leads or Opportunities.\n\nPlease take appropriate action as needed.\n\nBest regards,\n\n[Your Name]');
                
                emails.add(email);
            }
            System.debug('Email==='+emails);
            if ( emails.size()>0) {
                Messaging.sendEmail(emails);
            }
        }
        
    }

    
    
    @AuraEnabled
    public static List<String> getPicklistValues(String objName, String fieldName){
        List<String> options = new List<String>();
        Map<String, String> mapPickListValues = new Map<String, String>();
        Schema.SObjectType objSobjectType = Schema.getGlobalDescribe().get(objName);
        Schema.DescribeSObjectResult objDescribeSobject = objSobjectType.getDescribe();
        Map<String, Schema.SObjectField> mapFields = objDescribeSobject.fields.getMap();
        List<Schema.PicklistEntry> lstPickListValues = mapFields.get(fieldName).getDescribe().getPickListValues();
        for (Schema.PicklistEntry objPickList : lstPickListValues) {
            options.add(objPickList.getValue());
        }
        return options;
    }
    
    @AuraEnabled
    public static Map<String, List<String>> getAllPickListVal(Map<String, String> ObjectByField){
        Map<String, List<String>> picklistValByField = new Map<String, List<String>>();
        for(String fields : ObjectByField.keySet()){
            picklistValByField.put(fields, getPicklistValues(ObjectByField.get(fields), fields));
        }
        return picklistValByField;
    }
    
    
    
}