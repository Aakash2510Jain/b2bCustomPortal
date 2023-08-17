public without sharing class B2BPartnerPortal_Helper {

public static List<Lead> GetPartnerLeads(String partnerId){
    system.debug('partnerId===='+partnerId);
    
    list<Lead> leadlist = [SELECT Lead_Number__c,LeadID__c,Address,AnnualRevenue,City,Company,ConvertedAccountId,Country,CreatedDate,LastActivityDate,Description,Designation__c,Email,FirstName,Id,Industry,IsConverted,LastModifiedDate,LastName,LastViewedDate,LeadSource,Longitude,MasterRecordId,Name,Next_Follow_up_Date__c,NumberOfEmployees,OwnerId,Phone,Owner.Name,
                            PhotoUrl,PostalCode,Rating, Salutation,State,Status,Street,Title,Website,Client_Name__c,Company_Recent_Blogs__c,Webinar_Links__c,Client_Time_Zone__c ,Partner__r.Name,Partner__r.First_Name__c,Partner__r.Last_Name__c
                            FROM Lead
                            Where  Partner__c =: partnerId AND IsConverted = false];
    system.debug('leadlist===='+leadlist);
    system.debug('leadlist===='+leadlist.Size());
    return leadlist;
}

public static List<Account> GetPartnerAccounts(String partnerId){
    system.debug('partnerId===='+partnerId);
    list<Account> acclist = [SELECT AccountNumber,AccountSource,Partner__r.Name,AnnualRevenue,BillingAddress,BillingCity,BillingCountry,BillingLongitude,BillingPostalCode,BillingState,BillingStreet
                                ,CreatedById,CreatedDate,Description,Email__c,Fax
                                ,Id,Industry,IsDeleted,LastActivityDate,LastModifiedDate,
                                LastViewedDate,Last_Name__c,Name,NumberOfEmployees,Opportunity__c,OwnerId,Ownership,ParentId,Phone,PhotoUrl,Rating,ShippingCity,
                                Shipping_Address__c,Site,Stage__c,Type,Website
                                FROM Account
                                Where  Partner__c =: partnerId];
    system.debug('acclist===='+acclist);
    system.debug('acclist===='+acclist.Size());
    return acclist;
    
}

public static List<Opportunity> GetPartnerOpportunity(String partnerId){
    List<Opportunity> opplist = [SELECT AccountId,Amount,Partner__c,Partner__r.Name,CampaignId,CloseDate,ContactId,CreatedDate,Description,ForecastCategory,ForecastCategoryName,Id,IsClosed,LeadSource,Name,NextStep,OwnerId,Pricebook2Id,Probability,PushCount,StageName,Account.Name,CreatedBy.Name,SystemModstamp,Type FROM Opportunity
                                    Where  Partner__c =: partnerId];
    system.debug('opplist===='+opplist);
    system.debug('opplist===='+opplist.Size());
    return opplist;
}

public static  followupwrapper GetPartnerFollowUpActivities1(String partnerId){
    system.debug('partnerId===='+partnerId);
    List<task> LeadTasks = new List<task>();
    
    List<task> OpportunityTasks = new List<task>();
    followupwrapper FollowupWrap = new followupwrapper();
    try {
        list<Task> CompleteTaskList =  [SELECT WhoId,Who.Name,AccountId,ActivityDate,CompletedDateTime,CreatedDate,Description,Id,IsReminderSet,ReminderDateTime,Status,Subject,SystemModstamp,TaskSubtype,Type,WhatId, What.Name FROM Task
                                        Where  Partner__c =: partnerId];
        system.debug('CompleteTaskList===='+CompleteTaskList);
        
        if (!CompleteTaskList.isEmpty()) {
            for (task tas : CompleteTaskList) {
                system.debug('tas.whoId ===='+tas.whoId );
                if (tas.whoId != null )  {                //&& tas.whoId != ''
                    LeadTasks.add(tas);
                }
                
                if (tas.whatId != null ) {                 //&& tas.whatId != ''
                    system.debug('tas.whatId  ===='+tas.whatId  );
                    OpportunityTasks.add(tas);
                }
            }
            system.debug('LeadTasks====='+LeadTasks);
            system.debug('OpportunityTasks====='+OpportunityTasks);
            system.debug('OpportunityTasks size ====='+OpportunityTasks.size());
            if (!LeadTasks.isEmpty() && LeadTasks.size() >0) {
                FollowupWrap.LeadTaskList = LeadTasks;
            }
            else {
                FollowupWrap.LeadTaskList = null;
            }
            if (!OpportunityTasks.isEmpty() && OpportunityTasks.size() >0) {
                FollowupWrap.OpptaskList = OpportunityTasks;
            }
            else {
                FollowupWrap.OpptaskList = null;
            }
            
        }
    } catch (Exception e) {
        System.debug('The error has occured due to =====> ' + e.getMessage());
        System.debug('The error has occured due to =====> ' + e.getLineNumber());
        FollowupWrap.LeadTaskList = null;
        FollowupWrap.OpptaskList = null;
        
    }
    return FollowupWrap;
    
}


public static  followupwrapper GetFilteredPartnerLeadFollowUpActivities(String partnerId, String StartDate, String endDate, String leadStatus){
    system.debug('partnerId===='+partnerId);
    system.debug('StartDate===='+StartDate);
    system.debug('endDate===='+endDate);
    system.debug('leadStatus===='+leadStatus);
    List<task> LeadTasks = new List<task>();
    
    List<task> OpportunityTasks = new List<task>();
    followupwrapper FollowupWrap = new followupwrapper();
    
    /*List<String> startDateList = new List<String>();
    startDateList = StartDate.split('-');
    startDate = startDateList[1] + '/' + startDateList[2] + '/' + startDateList[0];
    date startingDate = date.parse(startDate);
    List<String> endDateList = new List<String>();
    endDateList = endDate.split('-');
    endDate = endDateList[1] + '/' + endDateList[2] + '/' + endDateList[0];
    date endingDate = date.parse(endDate);*/
    DateTime StartDateTime;
    DateTime EndDateTime;
    if(StartDate!=null && EndDate!=null){
        StartDateTime=Date.valueOf(StartDate);
        EndDateTime=Date.valueOf(endDate);
    } 
    String FollowUpTask;
    
    try {
        if(StartDate==null && EndDate==null && leadStatus != null){
            FollowUpTask='SELECT AccountId,ActivityDate,CompletedDateTime,CreatedDate,Description,Id,IsReminderSet,ReminderDateTime,Status,Subject,SystemModstamp,TaskSubtype,Type, TYPEOF who WHEN Lead THEN Id, Name, Status,IsConverted END WHEN Lead THEN Id, Name, Status,IsConverted END FROM Task Where   Partner__c =: partnerId AND createdDate=TODAY';  
           
            system.debug('FollowUpTask===='+FollowUpTask);

        }else{
            system.debug('StartDate===='+StartDate);
            system.debug('StartDate===='+EndDate);
            FollowUpTask='SELECT AccountId,ActivityDate,CompletedDateTime,CreatedDate,Description,Id,IsReminderSet,ReminderDateTime,Status,Subject,SystemModstamp,TaskSubtype,Type,  TYPEOF who WHEN Lead THEN Id, Name, Status,IsConverted END  FROM Task Where  Partner__c =: partnerId AND createdDate>=:StartDateTime  AND createdDate<=:EndDateTime'; 
            system.debug('FollowUpTask===='+FollowUpTask);
        }
        
        List<Task>CompleteTaskList=DataBase.query(FollowUpTask);
        system.debug('CompleteTaskList===='+CompleteTaskList+'Size--'+CompleteTaskList.size()); 
        if (!CompleteTaskList.isEmpty()) {
                                
            for (task tas : CompleteTaskList) {  
                            
                if (!String.isBlank(tas.whoId)) {
                    // get related leads
                        system.debug('leadStatus===='+leadStatus); 
                        string keyPrefix = string.valueOf(tas.whoId).substring(0,3);  

                        if(keyPrefix == '00Q') {
                            if(leadStatus != null ){
                                if(tas.who instanceOf Lead){
                                    Lead ld = tas.who;
                                    if(ld.Status == leadStatus){
                                        LeadTasks.add(tas);
                                    }
                                }
                            }else{
                                LeadTasks.add(tas);
                            }
                        }                     
                }
               /* else if(leadStatus != null && leadStatus != 'All'){
                    if(tas.who instanceOf Lead){
                        Lead ld = tas.who;
                       ld.Status = leadStatus;
                       system.debug(' ld.Status====='+ ld.Status);

                        string ldid1 = ld.id;
                        string keyPrefix1 =  ldid1.substring(0,3);  

                        if(keyPrefix1 == '00Q' && ld.Status!= null &&  ld.Status!= 'All' ){
                            LeadTasks.add(tas);
                            if(leadStatus == ld.Status){
                               
                            }

                        }
                        
                    }
                }*/
            }
            system.debug('LeadTasks====='+LeadTasks);
            system.debug('LeadTasks size ====='+LeadTasks.size());
            if (!LeadTasks.isEmpty() && LeadTasks.size() >0 ) {
                FollowupWrap.LeadTaskList = LeadTasks;
            }
            else {
                FollowupWrap.LeadTaskList = null;
            } 
        }
        
        /*list<Task> CompleteTaskList =  [SELECT AccountId,ActivityDate,CompletedDateTime,CreatedDate,Description,Id,IsReminderSet,ReminderDateTime,Status,Subject,SystemModstamp,TaskSubtype,Type, TYPEOF who WHEN Lead THEN Id, Name, Status END, TYPEOF what WHEN Opportunity THEN Id, Name, StageName END FROM Task
                                        Where  Partner__c =: partnerId AND createdDate>=: startingDate AND createdDate<=: endingDate];
        system.debug('CompleteTaskList===='+CompleteTaskList);
        
        if (!CompleteTaskList.isEmpty()) {
            for (task tas : CompleteTaskList) {
                system.debug('tas.whoId ===='+tas.whoId );
                if (tas.whoId != null )  {                //&& tas.whoId != ''
                    if(leadStatus == 'All'){
                        LeadTasks.add(tas); 
                    }
                    else{
                        if(tas.who instanceOf Lead){
                            Lead ld = tas.who;
                            if(leadStatus == ld.Status){
                                LeadTasks.add(tas);
                            }
                        }
                    }
                }
            }
            system.debug('LeadTasks====='+LeadTasks);
            if (!LeadTasks.isEmpty() && LeadTasks.size() >0) {
                FollowupWrap.LeadTaskList = LeadTasks;
            }
            else {
                FollowupWrap.LeadTaskList = null;
            }
            
        }*/
    } catch (Exception e) {
        System.debug('The error has occured due to =====> ' + e.getMessage());
        System.debug('The error has occured due to =====> ' + e.getLineNumber());
        FollowupWrap.LeadTaskList = null;
        FollowupWrap.OpptaskList = null;
        
    }
    return FollowupWrap;
    
}

//Opportunity FollowUp Activity
public static  followupwrapper GetFilteredPartnerOppFollowUpActivities(String partnerId, String StartDate, String endDate, String oppStage){
        system.debug('partnerId===='+partnerId);
        system.debug('StartDate===='+StartDate);
        system.debug('endDate===='+endDate);
        system.debug('oppStage===='+oppStage);
    
    List<task> LeadTasks = new List<task>();
    List<task> OpportunityTasks = new List<task>();
    followupwrapper FollowupWrap = new followupwrapper();
    
    /*List<String> startDateList = new List<String>();
    startDateList = StartDate.split('-');
    startDate = startDateList[1] + '/' + startDateList[2] + '/' + startDateList[0];
    date startingDate = date.parse(startDate);
    List<String> endDateList = new List<String>();
    endDateList = endDate.split('-');
    endDate = endDateList[1] + '/' + endDateList[2] + '/' + endDateList[0];
    date endingDate = date.parse(endDate);*/
    DateTime StartDateTime;
    DateTime EndDateTime;
    if(StartDate!=null && EndDate!=null){
        StartDateTime=Date.valueOf(StartDate);
        EndDateTime=Date.valueOf(endDate);
    }
    String FollowUpTask;
    try {
        if(StartDate==null && EndDate==null){
            FollowUpTask='SELECT AccountId,ActivityDate,CompletedDateTime,CreatedDate,Description,Id,IsReminderSet,ReminderDateTime,Status,Subject,SystemModstamp,TaskSubtype,Type,   TYPEOF what WHEN Opportunity THEN Id, Name, StageName END FROM Task Where  Partner__c =: partnerId AND createdDate=TODAY';  
        }else{
            FollowUpTask='SELECT AccountId,ActivityDate,CompletedDateTime,CreatedDate,Description,Id,IsReminderSet,ReminderDateTime,Status,Subject,SystemModstamp,TaskSubtype,Type,   TYPEOF what WHEN Opportunity THEN Id, Name, StageName END FROM Task Where  Partner__c =: partnerId AND createdDate>=:StartDateTime  AND createdDate<=:EndDateTime'; 
        }
                    
        List<Task>CompleteTaskList=DataBase.query(FollowUpTask);
        if (!CompleteTaskList.isEmpty()) {
                system.debug('CompleteTaskList===='+CompleteTaskList+'Size--'+CompleteTaskList.size());                    
            for (task tas : CompleteTaskList) {                    
                    if (!String.isBlank(tas.whatId)) {         
                          /*  if(oppStage == 'All'){
                                OpportunityTasks.add(tas);
                            }*/
 

                            if(oppStage != null ){
                                if(tas.what instanceOf Opportunity){
                                    Opportunity opp = tas.what;
                                    if(opp.StageName == oppStage){
                                        OpportunityTasks.add(tas);
                                    }
                                }
                            }else{
                                OpportunityTasks.add(tas);
                            }
 
                          /*  else{
                                if(tas.what instanceOf Opportunity){
                                    Opportunity opp = tas.what;
                                    if(oppStage == opp.StageName){
                                        OpportunityTasks.add(tas);
                                    }
                                }
                            }*/
                    }
            }
            system.debug('OpportunityTasks====='+OpportunityTasks);
            system.debug('OpportunityTasks size ====='+OpportunityTasks.size());
            if (!OpportunityTasks.isEmpty() && OpportunityTasks.size() >0) {
                FollowupWrap.OpptaskList = OpportunityTasks;
            }
            else {
                FollowupWrap.OpptaskList = null;
            }
            
        }
        
        /*list<Task> CompleteTaskList =  [SELECT AccountId,ActivityDate,CompletedDateTime,CreatedDate,Description,Id,IsReminderSet,ReminderDateTime,Status,Subject,SystemModstamp,TaskSubtype,Type, TYPEOF who WHEN Lead THEN Id, Name, Status END, TYPEOF what WHEN Opportunity THEN Id, Name, StageName END FROM Task
                                        Where  Partner__c =: partnerId AND createdDate>=:StartDateTime  AND createdDate<=:EndDateTime];
        system.debug('CompleteTaskList===='+CompleteTaskList);
        
        if (!CompleteTaskList.isEmpty()) {
            for (task tas : CompleteTaskList) {                    
                if (tas.whatId != null ) {                 //&& tas.whatId != ''
                    system.debug('tas.whatId  ===='+tas.whatId  );
                    if(oppStage == 'All'){
                        OpportunityTasks.add(tas);
                    }
                    else{
                        if(tas.what instanceOf Opportunity){
                            Opportunity opp = tas.what;
                            if(oppStage == opp.StageName){
                                OpportunityTasks.add(tas);
                            }
                        }
                    }
                }
            }
            //system.debug('LeadTasks====='+LeadTasks);
            system.debug('OpportunityTasks====='+OpportunityTasks);
            system.debug('OpportunityTasks size ====='+OpportunityTasks.size());
            if (!OpportunityTasks.isEmpty() && OpportunityTasks.size() >0) {
                FollowupWrap.OpptaskList = OpportunityTasks;
            }
            else {
                FollowupWrap.OpptaskList = null;
            }
            
        }*/
    } catch (Exception e) {
        System.debug('The error has occured due to =====> ' + e.getMessage());
        System.debug('The error has occured due to =====> ' + e.getLineNumber());
        FollowupWrap.LeadTaskList = null;
        FollowupWrap.OpptaskList = null;
        
    }
    return FollowupWrap;
    
}

public static Map<String,List<String>> GetPartnerLeadStatus(){
    Map<String,List<String>> pickValByField = new Map<String,List<String>>();
    pickValByField.put('Lead_Status', Utility.getPicklistValues('Lead','Status'));
    pickValByField.put('Lead_Source', Utility.getPicklistValues('Lead','LeadSource'));
    pickValByField.put('Lead_Salutation', Utility.getPicklistValues('Lead','Salutation')); //
    pickValByField.put('Lead_Industry', Utility.getPicklistValues('Lead','Industry'));
    return pickValByField;
}
public static Map<String,List<String>> GetOpprtunityStagePicklist(){
    Map<String,List<String>> pickValByField = new Map<String,List<String>>(); 
    pickValByField.put('Lead_Status', Utility.getPicklistValues('Opportunity','StageName'));
    return pickValByField;
}

    public static Map<String,List<String>> GetTaskPicklists(){
    Map<String,List<String>> pickValByField = new Map<String,List<String>>(); 
    pickValByField.put('Task_Status', Utility.getPicklistValues('Task','Status'));
    pickValByField.put('Task_Subject', Utility.getPicklistValues('Task','Subject'));
    pickValByField.put('Task_Priority', Utility.getPicklistValues('Task','Priority'));    
    return pickValByField;
}

public class followupwrapper{
    @AuraEnabled //Annotation when using for lightning component
    public List<task> LeadTaskList{get;set;}
    @AuraEnabled 
    public List<Task> OpptaskList{get;set;}
}

public static List<Group> GetGroupList(){
    list<Group> QueueList = [SELECT CreatedDate,DeveloperName,Email,Id,Name,OwnerId,RelatedId,Type FROM Group];
    system.debug('QueueList===='+QueueList);
    system.debug('QueueList===='+QueueList.Size());
    return QueueList;
}

//Show This Dashboard Data On PageLoad

public static WrapperChart PartnerdashboardChartsData(string userPortalid, date startDate, date endDate){
    system.debug('userPortalid =====> ' + userPortalid);
    WrapperChart wrapper = new WrapperChart();
    Date today = Date.today();
    Date lastWeekStart = today.addDays(-7);   
    Date lastWeekEnd = today.addDays(-1);
    Date tomorrow = Date.today().addDays(1);

    Set<id> userIds = new Set<id>();
    String createdDate = System.Label.Created_Date;
    
    User_Portal__c activeUser = [SELECT Id, Manager__c, Role__c, Team_Lead__c, User_Name__c, Name, First_Name__c FROM User_Portal__c WHERE Id =: userPortalid LIMIT 1];
    if(activeUser.Role__c == 'Team Member'){
        userIds.add(activeUser.id);
    }
    if(activeUser.Role__c == 'Team Lead'){
        userIds.add(activeUser.id);
        List<User_Portal__c> relUsers = [SELECT Id, Manager__c, Role__c, Team_Lead__c, User_Name__c, Name, First_Name__c FROM User_Portal__c WHERE Team_Lead__c =: activeUser.id];
        for(User_Portal__c userRec : relUsers){
            userIds.add(userRec.id);   
        }
    }
    if(activeUser.Role__c == 'Manager'){
        userIds.add(activeUser.id);
        List<User_Portal__c> relUsers = [SELECT Id, Manager__c, Role__c, Team_Lead__c, User_Name__c, Name, First_Name__c FROM User_Portal__c WHERE Team_Lead__r.Manager__c =: activeUser.id];
        for(User_Portal__c userRec : relUsers){
            userIds.add(userRec.id);  
            userIds.add(userRec.Team_Lead__c);
        }
    }
     
    if(startdate == null && endDate == null && userPortalid != null){
            List<AggregateResult> leadResults = [SELECT COUNT(Id) leadCount, Status FROM Lead WHERE  Partner__c IN: userIds AND CreatedDate = Today GROUP BY Status];
    Map<String, Integer> leadCountMap = new Map<String, Integer>();
    for (AggregateResult result : leadResults) {
        String status = (String)result.get('Status');
        Integer leadCount = (Integer)result.get('leadCount');
        leadCountMap.put(status, leadCount);
    }
    system.debug('leadCountMap=='+leadCountMap);
    wrapper.LastweekLeadMap = leadCountMap;

    }else if(startdate != null && endDate == null && userPortalid != null){
        List<AggregateResult> leadResults = [SELECT COUNT(Id) leadCount, Status FROM Lead WHERE  Partner__c IN: userIds AND CreatedDate >=: startdate AND CreatedDate <= Today GROUP BY Status];
        Map<String, Integer> leadCountMap = new Map<String, Integer>();
        for (AggregateResult result : leadResults) {
            String status = (String)result.get('Status');
            Integer leadCount = (Integer)result.get('leadCount');
            leadCountMap.put(status, leadCount);
        }
        system.debug('leadCountMap=='+leadCountMap);
        wrapper.LastweekLeadMap = leadCountMap;

    }else if(startdate != null && endDate != null && userPortalid != null){
        List<AggregateResult> leadResults = [SELECT COUNT(Id) leadCount, Status FROM Lead WHERE Partner__c IN: userIds AND CreatedDate >=: startdate AND CreatedDate <=: endDate GROUP BY Status];
        Map<String, Integer> leadCountMap = new Map<String, Integer>();
        for (AggregateResult result : leadResults) {
            String status = (String)result.get('Status');
            Integer leadCount = (Integer)result.get('leadCount');
            leadCountMap.put(status, leadCount);
        }
        system.debug('leadCountMap=='+leadCountMap);
        wrapper.LastweekLeadMap = leadCountMap;

    }
    
    if(startdate == null && endDate == null && userPortalid != null){
        List<AggregateResult> oppnegotiationlist = [SELECT COUNT(ID) countOpportunity ,StageName FROM Opportunity WHERE   Partner__c IN: userIds AND CreatedDate = Today GROUP BY StageName];
        Map<String, Integer> MapOppNegotiation = new Map<String, Integer>();
        for (AggregateResult result1 : oppnegotiationlist) {
            String StageName = (String)result1.get('StageName');
            Integer countOpportunity = (Integer)result1.get('countOpportunity');
            MapOppNegotiation.put(StageName, countOpportunity);
        }
        system.debug('MapOppNegotiation===='+MapOppNegotiation);
        wrapper.opportunityNegotiation = MapOppNegotiation;

    }else if(startdate != null && endDate == null && userPortalid != null){
        List<AggregateResult> oppnegotiationlist = [SELECT COUNT(ID) countOpportunity ,StageName FROM Opportunity WHERE    Partner__c IN: userIds AND CreatedDate >=: startdate AND CreatedDate <= Today GROUP BY StageName];
        Map<String, Integer> MapOppNegotiation = new Map<String, Integer>();
        for (AggregateResult result1 : oppnegotiationlist) {
            String StageName = (String)result1.get('StageName');
            Integer countOpportunity = (Integer)result1.get('countOpportunity');
            MapOppNegotiation.put(StageName, countOpportunity);
        }
        system.debug('MapOppNegotiation===='+MapOppNegotiation);
        wrapper.opportunityNegotiation = MapOppNegotiation;


    }else if(startdate != null && endDate != null && userPortalid != null){
        List<AggregateResult> oppnegotiationlist = [SELECT COUNT(ID) countOpportunity ,StageName FROM Opportunity WHERE  Partner__c IN: userIds AND CreatedDate >=: startdate AND CreatedDate <=: endDate GROUP BY StageName];
        Map<String, Integer> MapOppNegotiation = new Map<String, Integer>();
        for (AggregateResult result1 : oppnegotiationlist) {
            String StageName = (String)result1.get('StageName');
            Integer countOpportunity = (Integer)result1.get('countOpportunity');
            MapOppNegotiation.put(StageName, countOpportunity);
        }
        system.debug('MapOppNegotiation===='+MapOppNegotiation);
        wrapper.opportunityNegotiation = MapOppNegotiation;

    }
    
    
    if(startdate == null && endDate == null && userPortalid != null){
        List<AggregateResult> leadResults = [SELECT COUNT(Id) leadCount, Industry FROM Lead WHERE  Partner__c IN: userIds AND CreatedDate = Today AND Industry != null  GROUP BY Industry];
    Map<String, Integer> leadCountIndustryMap = new Map<String, Integer>();
    for (AggregateResult result : leadResults) {
        String industry = (String)result.get('Industry');
        Integer leadCount = (Integer)result.get('leadCount');
        leadCountIndustryMap.put(industry, leadCount);
    }
    system.debug('leadCountIndustryMap=='+leadCountIndustryMap);
    wrapper.LastweekLeadIndustryMap = leadCountIndustryMap;

    }else if(startdate != null && endDate == null && userPortalid != null){
        List<AggregateResult> leadResults = [SELECT COUNT(Id) leadCount, Industry FROM Lead WHERE  Partner__c IN: userIds AND CreatedDate >=: startdate AND CreatedDate <= Today AND Industry != null GROUP BY Industry];
        Map<String, Integer> leadCountIndustryMap = new Map<String, Integer>();
        for (AggregateResult result : leadResults) {
        String industry = (String)result.get('Industry');
        Integer leadCount = (Integer)result.get('leadCount');
        leadCountIndustryMap.put(industry, leadCount);
        }
        system.debug('leadCountIndustryMap=='+leadCountIndustryMap);
        wrapper.LastweekLeadIndustryMap = leadCountIndustryMap;

    }else if(startdate != null && endDate != null && userPortalid != null){
        List<AggregateResult> leadResults = [SELECT COUNT(Id) leadCount, Industry FROM Lead WHERE Partner__c IN: userIds AND CreatedDate >=: startdate AND CreatedDate <=: endDate AND Industry != null GROUP BY Industry];
        Map<String, Integer> leadCountIndustryMap = new Map<String, Integer>();
        for (AggregateResult result : leadResults) {
        String industry = (String)result.get('Industry');
        Integer leadCount = (Integer)result.get('leadCount');
        leadCountIndustryMap.put(industry, leadCount);
        }
        system.debug('leadCountIndustryMap=='+leadCountIndustryMap);
        wrapper.LastweekLeadIndustryMap = leadCountIndustryMap;

    }


if(startdate == null && endDate == null && userPortalid != null){
List<AggregateResult> leadResults = [SELECT COUNT(Id) leadCount, Title FROM Lead WHERE  Partner__c IN: userIds AND CreatedDate = Today AND Title != null  GROUP BY Title];
Map<String, Integer> leadTitleCountMap = new Map<String, Integer>();
for (AggregateResult result : leadResults) {
String industry = (String)result.get('Title');
Integer leadCount = (Integer)result.get('leadCount');
leadTitleCountMap.put(industry, leadCount);
}
system.debug('leadTitleCountMap=='+leadTitleCountMap);
wrapper.LeadTitlelistMap = leadTitleCountMap;

}else if(startdate != null && endDate == null && userPortalid != null){
    List<AggregateResult> leadResults = [SELECT COUNT(Id) leadCount, Title FROM Lead WHERE  Partner__c IN: userIds AND CreatedDate >=: startdate AND CreatedDate <= Today AND Title != null GROUP BY Title];
    Map<String, Integer> leadTitleCountMap = new Map<String, Integer>();
    for (AggregateResult result : leadResults) {
    String industry = (String)result.get('Title');
    Integer leadCount = (Integer)result.get('leadCount');
    leadTitleCountMap.put(industry, leadCount);
    }
    system.debug('leadTitleCountMap=='+leadTitleCountMap);
    wrapper.LeadTitlelistMap = leadTitleCountMap;

}else if(startdate != null && endDate != null && userPortalid != null){
    List<AggregateResult> leadResults = [SELECT COUNT(Id) leadCount, Title FROM Lead WHERE Partner__c IN: userIds AND CreatedDate >=: startdate AND CreatedDate <=: endDate AND Title != null GROUP BY Title];
    Map<String, Integer> leadTitleCountMap = new Map<String, Integer>();
    for (AggregateResult result : leadResults) {
    String industry = (String)result.get('Title');
    Integer leadCount = (Integer)result.get('leadCount');
    leadTitleCountMap.put(industry, leadCount);
    }
    system.debug('leadTitleCountMap=='+leadTitleCountMap);
    wrapper.LeadTitlelistMap= leadTitleCountMap;

}


if(startdate == null && endDate == null && userPortalid != null){
List<AggregateResult> leadResults = [SELECT COUNT(Id) leadCount, NumberOfEmployees FROM Lead WHERE  Partner__c IN: userIds AND CreatedDate = Today AND NumberOfEmployees != null  GROUP BY NumberOfEmployees];
Map<Integer, Integer> leadEmployeeCountMap = new Map<Integer, Integer>();
for (AggregateResult result : leadResults) {
Integer industry = (Integer)result.get('NumberOfEmployees');
Integer leadCount = (Integer)result.get('leadCount');
leadEmployeeCountMap.put(industry, leadCount);
}
system.debug('leadEmployeeCountMap=='+leadEmployeeCountMap);
wrapper.LeadEmployeetMap = leadEmployeeCountMap;

}else if(startdate != null && endDate == null && userPortalid != null){
List<AggregateResult> leadResults = [SELECT COUNT(Id) leadCount, NumberOfEmployees FROM Lead WHERE  Partner__c IN: userIds AND CreatedDate >=: startdate AND CreatedDate <= Today AND NumberOfEmployees != null GROUP BY NumberOfEmployees];
Map<Integer, Integer> leadEmployeeCountMap = new Map<Integer, Integer>();
for (AggregateResult result : leadResults) {
Integer industry = (Integer)result.get('NumberOfEmployees');
Integer leadCount = (Integer)result.get('leadCount');
leadEmployeeCountMap.put(industry, leadCount);
}
system.debug('leadEmployeeCountMap=='+leadEmployeeCountMap);
wrapper.LeadEmployeetMap = leadEmployeeCountMap;

}else if(startdate != null && endDate != null && userPortalid != null){
List<AggregateResult> leadResults = [SELECT COUNT(Id) leadCount, NumberOfEmployees FROM Lead WHERE Partner__c IN: userIds AND CreatedDate >=: startdate AND CreatedDate <=: endDate AND NumberOfEmployees != null GROUP BY NumberOfEmployees];
Map<Integer, Integer> leadEmployeeCountMap = new Map<Integer, Integer>();
for (AggregateResult result : leadResults) {
Integer industry = (Integer)result.get('NumberOfEmployees');
Integer leadCount = (Integer)result.get('leadCount');
leadEmployeeCountMap.put(industry, leadCount);
}
system.debug('leadTitleCountMap=='+leadEmployeeCountMap);
wrapper.LeadEmployeetMap= leadEmployeeCountMap;

}

if(startdate == null && endDate == null && userPortalid != null){
List<AggregateResult> leadResults = [SELECT COUNT(Id) leadCount, Country FROM Lead WHERE  Partner__c IN: userIds AND CreatedDate = Today AND Country != null  GROUP BY Country];
Map<string, Integer> leadCountryCountMap = new Map<string, Integer>();
for (AggregateResult result : leadResults) {
string industry = (string)result.get('Country');
Integer leadCount = (Integer)result.get('leadCount');
leadCountryCountMap.put(industry, leadCount);
}
system.debug('leadCountryCountMap =='+leadCountryCountMap);
wrapper.LeadCountryMap = leadCountryCountMap;

}else if(startdate != null && endDate == null && userPortalid != null){
List<AggregateResult> leadResults = [SELECT COUNT(Id) leadCount, Country FROM Lead WHERE  Partner__c IN: userIds AND CreatedDate >=: startdate AND CreatedDate <= Today AND Country != null GROUP BY Country];
Map<string, Integer> leadCountryCountMap = new Map<string, Integer>();
for (AggregateResult result : leadResults) {
string industry = (string)result.get('Country');
Integer leadCount = (Integer)result.get('leadCount');
leadCountryCountMap.put(industry, leadCount);
}
system.debug('leadCountryCountMap=='+leadCountryCountMap);
wrapper.LeadCountryMap = leadCountryCountMap;

}else if(startdate != null && endDate != null && userPortalid != null){
List<AggregateResult> leadResults = [SELECT COUNT(Id) leadCount, Country FROM Lead WHERE Partner__c IN: userIds AND CreatedDate >=: startdate AND CreatedDate <=: endDate AND Country != null GROUP BY Country];
Map<string, Integer> leadCountryCountMap = new Map<string, Integer>();
for (AggregateResult result : leadResults) {
string industry = (string)result.get('Country');
Integer leadCount = (Integer)result.get('leadCount');
leadCountryCountMap.put(industry, leadCount);
}
system.debug('leadTitleCountMap=='+leadCountryCountMap);
wrapper.LeadCountryMap= leadCountryCountMap;

}


if(startdate == null && endDate == null && userPortalid != null){
List<AggregateResult> leadResults = [SELECT COUNT(Id) leadCount, Rating FROM Lead WHERE  Partner__c IN: userIds AND CreatedDate = Today AND Rating != null  GROUP BY Rating];
Map<string, Integer> leadRatingCountMap = new Map<string, Integer>();
for (AggregateResult result : leadResults) {
string industry = (string)result.get('Rating');
Integer leadCount = (Integer)result.get('leadCount');
leadRatingCountMap.put(industry, leadCount);
}
system.debug('leadRatingCountMap=='+leadRatingCountMap);
wrapper.LeadRatingMap = leadRatingCountMap;

}else if(startdate != null && endDate == null && userPortalid != null){
List<AggregateResult> leadResults = [SELECT COUNT(Id) leadCount, Rating FROM Lead WHERE  Partner__c IN: userIds AND CreatedDate >=: startdate AND CreatedDate <= Today AND Rating != null GROUP BY Rating];
Map<string, Integer> leadRatingCountMap = new Map<string, Integer>();
for (AggregateResult result : leadResults) {
string industry = (string)result.get('Rating');
Integer leadCount = (Integer)result.get('leadCount');
leadRatingCountMap.put(industry, leadCount);
}
system.debug('leadRatingCountMap=='+leadRatingCountMap);
wrapper.LeadRatingMap = leadRatingCountMap;

}else if(startdate != null && endDate != null && userPortalid != null){
List<AggregateResult> leadResults = [SELECT COUNT(Id) leadCount, Rating FROM Lead WHERE Partner__c IN: userIds AND CreatedDate >=: startdate AND CreatedDate <=: endDate AND Rating != null GROUP BY Rating];
Map<string, Integer> leadRatingCountMap = new Map<string, Integer>();
for (AggregateResult result : leadResults) {
string industry = (string)result.get('Rating');
Integer leadCount = (Integer)result.get('leadCount');
leadRatingCountMap.put(industry, leadCount);
}
system.debug('leadTitleCountMap=='+leadRatingCountMap);
wrapper.LeadRatingMap= leadRatingCountMap;

}


if(startdate == null && endDate == null && userPortalid != null){
 List<AggregateResult> leadResults = [SELECT COUNT(Id) leadCount, Status FROM Lead WHERE Status ='Unqualified' AND Partner__c IN: userIds AND CreatedDate = Today GROUP BY Status];
Map<String, Integer> leadStatusUnqualifiedMap = new Map<String, Integer>();
for (AggregateResult result : leadResults) {
String status = (String)result.get('Status');
Integer leadCount = (Integer)result.get('leadCount');
leadStatusUnqualifiedMap.put(status, leadCount);
}
system.debug('leadStatusUnqualifiedMap=='+leadStatusUnqualifiedMap);
wrapper.LeadUnquailifiedMap = leadStatusUnqualifiedMap;

}else if(startdate != null && endDate == null && userPortalid != null){
List<AggregateResult> leadResults = [SELECT COUNT(Id) leadCount, Status FROM Lead WHERE Status ='Unqualified' AND  Partner__c IN: userIds AND CreatedDate >=: startdate AND CreatedDate <= Today GROUP BY Status];
Map<String, Integer> leadStatusUnqualifiedMap = new Map<String, Integer>();
for (AggregateResult result : leadResults) {
    String status = (String)result.get('Status');
    Integer leadCount = (Integer)result.get('leadCount');
    leadStatusUnqualifiedMap.put(status, leadCount);
}
system.debug('leadStatusUnqualifiedMap=='+leadStatusUnqualifiedMap);
wrapper.LeadUnquailifiedMap = leadStatusUnqualifiedMap;

}else if(startdate != null && endDate != null && userPortalid != null){
List<AggregateResult> leadResults = [SELECT COUNT(Id) leadCount, Status FROM Lead WHERE Status ='Unqualified' AND    Partner__c IN: userIds AND CreatedDate >=: startdate AND CreatedDate <=: endDate GROUP BY Status];
Map<String, Integer> leadStatusUnqualifiedMap = new Map<String, Integer>();
for (AggregateResult result : leadResults) {
    String status = (String)result.get('Status');
    Integer leadCount = (Integer)result.get('leadCount');

    leadStatusUnqualifiedMap.put(status, leadCount);
}
system.debug('leadStatusUnqualifiedMap=='+leadStatusUnqualifiedMap);
wrapper.LeadUnquailifiedMap = leadStatusUnqualifiedMap;

}

if(startdate == null && endDate == null && userPortalid != null){
    List<AggregateResult> leadResults = [SELECT COUNT(Id) leadCount, Industry FROM Lead WHERE IsConverted = True AND Partner__c IN: userIds AND CreatedDate = Today GROUP BY Industry];
   Map<String, Integer> leadindustryconvertMap = new Map<String, Integer>();
   for (AggregateResult result : leadResults) {
   String status = (String)result.get('Industry');
   Integer leadCount = (Integer)result.get('leadCount');
   if(status != null){
    leadindustryconvertMap.put(status, leadCount);
   }
   
   }
   system.debug('leadindustryconvertMap=='+leadindustryconvertMap);
   wrapper.LeadindustryConverteddMap = leadindustryconvertMap;
   
   }else if(startdate != null && endDate == null && userPortalid != null){
   List<AggregateResult> leadResults = [SELECT COUNT(Id) leadCount,Industry FROM Lead WHERE IsConverted = True AND  Partner__c IN: userIds AND CreatedDate >=: startdate AND CreatedDate <= Today GROUP BY Industry];
   Map<String, Integer> leadindustryconvertMap = new Map<String, Integer>();
   for (AggregateResult result : leadResults) {
       String status = (String)result.get('Industry');
       Integer leadCount = (Integer)result.get('leadCount');
       if(status != null){
        leadindustryconvertMap.put(status, leadCount);
       }
   }
   system.debug('leadindustryconvertMap=='+leadindustryconvertMap);
   wrapper.LeadindustryConverteddMap = leadindustryconvertMap;
   
   }else if(startdate != null && endDate != null && userPortalid != null){
   List<AggregateResult> leadResults = [SELECT COUNT(Id) leadCount, Industry FROM Lead WHERE IsConverted = True AND    Partner__c IN: userIds AND CreatedDate >=: startdate AND CreatedDate <=: endDate GROUP BY Industry];
   Map<String, Integer> leadindustryconvertMap = new Map<String, Integer>();
   for (AggregateResult result : leadResults) {
       String status = (String)result.get('Industry');
       Integer leadCount = (Integer)result.get('leadCount');
       if(status != null){
        leadindustryconvertMap.put(status, leadCount);
       }
       
   }
   system.debug('leadindustryconvertMap=='+leadindustryconvertMap);
   wrapper.LeadindustryConverteddMap = leadindustryconvertMap;
   
   }

 
  /*  Map<Date, Integer> MapLastWeekOppp = new Map<Date, Integer>();
    List<AggregateResult> lastweekOpportunity = [SELECT COUNT(ID) countOpportunity,Created_Date__c  FROM Opportunity WHERE Partner__c IN: userIds AND Created_Date__c >= :lastWeekStart AND Created_Date__c <:tomorrow  GROUP BY Created_Date__c];
    for (AggregateResult result2 : lastweekOpportunity) {
        Date cretdt = (Date)result2.get('Created_Date__c');
        system.debug('cretdt===='+cretdt);
        // Date dt = cretdt.date();
        Date d = Date.newInstance(cretdt.year(), cretdt.month(), cretdt.day());
        system.debug('d===='+d);
        // Date date12 = CloseDate.toLocaleDateString();;
        system.debug('cretdt===='+cretdt);
        Integer countOpportunity = (Integer)result2.get('countOpportunity');
        MapLastWeekOppp.put(cretdt, countOpportunity);
    }
    system.debug('MapLastWeekOppp===='+MapLastWeekOppp);
    wrapper.LastweekOpportunity = MapLastWeekOppp;
    
    Map<Date, Integer> LeadProposalMap = new  Map<Date, Integer>();
    List<AggregateResult> leadproposalCount = [SELECT  Created_Date__c, COUNT(Id) leadCount  FROM Lead WHERE  Status = 'Proposal' AND  Partner__c IN: userIds  AND Created_Date__c >= :lastWeekStart AND Created_Date__c <:tomorrow  GROUP BY Created_Date__c];
    for(AggregateResult result : leadproposalCount) {
        Date crtdate = (Date)result.get('Created_Date__c');
        Integer leadCount = (Integer)result.get('leadCount');
        LeadProposalMap.put(crtdate, leadCount);
    }
    system.debug('LeadProposalMap===='+LeadProposalMap);
    wrapper.LeadProposalCount = LeadProposalMap;
    
    Map<String, Integer> leadsCreatedByCountryMap = new Map<String, Integer>();
    List<AggregateResult> leadscountbyCountry = [Select Country,COUNT(Id) leadCount from Lead where Partner__c IN: userIds AND Country != null GROUP BY Country ];
    for(AggregateResult result : leadscountbyCountry) {
        String country = (String)result.get('Country');
        Integer leadCount = (Integer)result.get('leadCount');
        leadsCreatedByCountryMap.put(country, leadCount);
    }
    wrapper.leadsCountByCountry = leadsCreatedByCountryMap;
    system.debug('leadsCreatedByCountryMap===='+leadsCreatedByCountryMap);
    
    
    Map<String, Integer> accountConvertedBystate = new Map<String, Integer>();
    List<AggregateResult> accountBystate = [SELECT BillingState, COUNT(Id) accCount FROM Account where Partner__c IN: userIds GROUP BY BillingState]; 
    for(AggregateResult result : accountBystate) {
        String State = (String)result.get('BillingState');
        Integer acccount = (Integer)result.get('accCount');
        if(State == null){
            accountConvertedBystate.put('NA', acccount);
        }
        else{
            accountConvertedBystate.put(State, acccount);
        }
        
    } */
  //  system.debug('accountConvertedBystate===='+accountConvertedBystate);
    
   // wrapper.accountConvertedbyState = accountConvertedBystate;
    return wrapper;  
}
public class WrapperChart{
    
    public Map<String,Integer> LastweekLeadMap  {get;set;} 
     
    public Map<String,Integer> opportunityNegotiation {get;set;} 
     
    public Map<String,Integer> LastweekLeadIndustryMap {get;set;}
    
    public Map<String,Integer> LeadTitlelistMap {get;set;}  
   
    public Map<Integer,Integer> LeadEmployeetMap {get;set;}   
    
    public Map<String,Integer> LeadCountryMap {get;set;}     
     
    public Map<string,Integer> LeadRatingMap {get;set;} 
    
    public Map<string,Integer> LeadUnquailifiedMap {get;set;}  
  
    public Map<string,Integer> LeadindustryConverteddMap {get;set;} 
    
   // public Map<Date, Integer> LastweekOpportunity {get;set;} 
  
   /* public Map<Date,Integer> LeadProposalCount {get;set;}
   
    public Map<String,Integer> leadsCountByCountry {get;set;} 
    
    public Map<String,Integer> accountConvertedbyState {get;set;} */
 /*  @AuraEnabled
    public List<Task> taskList {get;set;} 
    @AuraEnabled
    public List<Task> overdueTaskList {get;set;} 
    @AuraEnabled
    public List<Lead> inactiveLeads {get;set;} */
}

@AuraEnabled
Public Static transferdatawrapper getUserbyGroup(){
    
    map<string,list<User>> usersByGroupsid = new map<string,list<User>>();
    
    List<Group> Groups=[SELECT DeveloperName,DoesIncludeBosses,DoesSendEmailToMembers,Email,Id,Name FROM Group WHERE NAME !=NULL ];
    List<GroupMember> GroupMembers=[SELECT GroupId,Id,UserOrGroupId FROM GroupMember];
    List<User> Users=[SELECT AccountId,Alias,Email,FirstName,Id,Name FROM User];
    
    for(GroupMember gmbr:GroupMembers){
        if(usersByGroupsid.containsKey(gmbr.GroupId)){
            
        }
        
    }
    
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
    Public List<User> Users {get; set;}
}

public static String convertLead(Lead LeadRecToConvert){
    String message = '';
    AccountAndOppwrapper accOppWrap = new AccountAndOppwrapper();
    try{
        Database.LeadConvert lc = new Database.LeadConvert();
        lc.setLeadId(LeadRecToConvert.Id);
        lc.setDoNotCreateOpportunity(false);
        LeadStatus convertStatus = [SELECT Id, MasterLabel, IsConverted
                                    FROM LeadStatus
                                    WHERE IsConverted = true
                                    limit 1];
        lc.setConvertedStatus(convertStatus.MasterLabel);
        Database.LeadConvertResult lcResults = Database.convertLead(lc);
        if (lcResults.isSuccess()){
            string accId = lcResults.getAccountId();
            System.debug('Converted accId =====> ' + accId);
            
            string oppId = lcResults.getOpportunityId();
            System.debug('Converted oppId =====> ' + oppId);
            if(accId != null){
                message = 'Lead Converted Successfully';
            }
        }
        
    }
    catch(Exception e){
        System.debug('the error has occured due to ====> ' + e.getMessage());
        System.debug('the error has occured at ====> ' + e.getLineNumber());
        System.debug('the error stack trace string ====> ' + e.getStackTraceString()); //DUPLICATES_DETECTED
        System.debug('the error  cause ====> ' + e.getCause());
        System.debug('the error get type Name ====> ' + e.getTypeName());
        message = e.getMessage();
        
    }
    return message;
    
}    

public class AccountAndOppwrapper{
    //public List<Account> convertedAcclist{ get; set; }
    
    //public List<Opportunity> ConvertedoppList{ get; set; }
    
    public String message{ get; set; }
    
}


public static void PartnerTeamLeadDashBoard(String partnerId){
    
    try {
        
        if (!String.isBlank(partnerId)) {
            
        }
        
    } catch (Exception e) {
        
    }
}

//Show This Dashboard Data On Applying Filter
/*@auraEnabled
public static WrapperChart PartnerdashboardChartsData1(string userPortalid, string startDate, string endDate){
    system.debug('startDate =====> ' + startDate);
    system.debug('endDate =====> ' + endDate);
    Set<id> userIds = new Set<id>();
    String createdDate = System.Label.Created_Date;
    
    User_Portal__c activeUser = [SELECT Id, Manager__c, Role__c, Team_Lead__c, User_Name__c, Name, First_Name__c FROM User_Portal__c WHERE Id =: userPortalid LIMIT 1];
    if(activeUser.Role__c == 'Team Member'){
        userIds.add(activeUser.id);
    }
    if(activeUser.Role__c == 'Team Lead'){
        userIds.add(activeUser.id);
        List<User_Portal__c> relUsers = [SELECT Id, Manager__c, Role__c, Team_Lead__c, User_Name__c, Name, First_Name__c FROM User_Portal__c WHERE Team_Lead__c =: activeUser.id];
        for(User_Portal__c userRec : relUsers){
            userIds.add(userRec.id);   
        }
    }
    if(activeUser.Role__c == 'Manager'){
        userIds.add(activeUser.id);
        List<User_Portal__c> relUsers = [SELECT Id, Manager__c, Role__c, Team_Lead__c, User_Name__c, Name, First_Name__c FROM User_Portal__c WHERE Team_Lead__r.Manager__c =: activeUser.id];
        for(User_Portal__c userRec : relUsers){
            userIds.add(userRec.id);  
            userIds.add(userRec.Team_Lead__c);
        }
    }
    
    
    system.debug('userPortalid =====> ' + userPortalid);
    WrapperChart wrapper = new WrapperChart();
    Date today = Date.today();
    Date lastWeekStart = today.addDays(-7);
    Date lastWeekEnd = today.addDays(-1);
    Date startingDate;
    Date endingDate;
    if(startDate != null || startDate != ''){
        List<String> startDateList = new List<String>();
        startDateList = startDate.split('-');
        startDate = startDateList[1] + '/' + startDateList[2] + '/' + startDateList[0];
        startingDate = date.parse(startDate);  
    }
    if(endDate != null || endDate != ''){
        List<String> endDateList = new List<String>();
        endDateList = endDate.split('-');
        endDate = endDateList[1] + '/' + endDateList[2] + '/' + endDateList[0];
        endingDate = date.parse(endDate); 
    }
    date moreThanFortyFiveDays = today.addDays(-45);
    
    String query1= 'SELECT COUNT(Id) leadCount, Status FROM Lead WHERE  Partner__c IN: userIds';
    String query2= 'SELECT COUNT(ID) countOpportunity ,StageName FROM Opportunity WHERE   Partner__c IN: userIds GROUP BY StageName';
    String query3= 'SELECT COUNT(ID) countOpportunity,Created_Date__c  FROM Opportunity WHERE Partner__c IN: userIds AND StageName=ClosedWon';
    String query4= 'SELECT  Created_Date__c, COUNT(Id) leadCount  FROM Lead WHERE  Status = \'Proposal\'' + ' AND  Partner__c IN: userIds ';
    String query5= 'Select Country,COUNT(Id) leadCount from Lead where Partner__c IN: userIds AND Country != null GROUP BY Country';
    String query6= 'SELECT BillingState, COUNT(Id) accCount FROM Account where Partner__c IN: userIds GROUP BY BillingState';
    
    String query7= 'SELECT Id, Subject, ActivityDate, Priority, Status FROM Task where Partner__c IN: userIds';
    String query8= 'SELECT Id, Subject, ActivityDate, Priority, Status FROM Task where Partner__c IN: userIds AND activityDate < today';
    String query9= 'SELECT Id, Name, Partner__c, Status FROM Lead WHERE Partner__c IN: userIds AND LastActivityDate < moreThanFortyFiveDays';
    
    if(startingDate == null && endingDate == null){
        query1 = query1 + ' AND createdDate =:today GROUP BY Status';
        query3 = query3 + ' AND createdDate =:today GROUP BY createdDate';
        query4 = query4 + ' AND createdDate =:today  GROUP BY createdDate';
        query7 = query7 + ' AND createdDate =:today';
    }
    if(startingDate != null && endingDate == null){
        query1 = query1 + ' AND createdDate =:startingDate GROUP BY Status';
        query3 = query3 + ' AND createdDate =:startingDate GROUP BY createdDate';
        query4 = query4 + ' AND createdDate =:startingDate  GROUP BY createdDate';
        query7 = query7 + ' AND createdDate =:startingDate';
    }
    if(startingDate != null && endingDate != null){
        query1 = query1 + ' AND createdDate >=:startingDate AND createdDate <=: endingDate GROUP BY Status';
        query3 = query3 + ' AND createdDate >=:startingDate AND createdDate <: endingDate GROUP BY createdDate';
        query4 = query4 + ' AND createdDate >=:startingDate AND createdDate <=: endingDate GROUP BY createdDate';
        query7 = query7 + ' AND createdDate =:startingDate AND createdDate <=: endingDate';
    }
    
    List<Task> taskList = Database.query(query7);
    List<Task> overdueTaskList = Database.query(query8);
    List<Lead> inactiveLeadList = Database.query(query9);
    wrapper.taskList = taskList;
    wrapper.overdueTaskList = overdueTaskList;
    wrapper.inactiveLeads = inactiveLeadList;

    
    List<AggregateResult> leadResults = Database.query(query1);
    Map<String, Integer> leadCountMap = new Map<String, Integer>();
    for (AggregateResult result : leadResults) {
        String status = (String)result.get('Status');
        Integer leadCount = (Integer)result.get('leadCount');
        leadCountMap.put(status, leadCount);
    }
    system.debug('leadCountMap=='+leadCountMap);
    wrapper.LastweekLeadMap = leadCountMap;
    
    List<AggregateResult> oppnegotiationlist = Database.query(query2);
    Map<String, Integer> MapOppNegotiation = new Map<String, Integer>();
    for (AggregateResult result1 : oppnegotiationlist) {
        String StageName = (String)result1.get('StageName');
        Integer countOpportunity = (Integer)result1.get('countOpportunity');
        MapOppNegotiation.put(StageName, countOpportunity);
    }
    system.debug('MapOppNegotiation===='+MapOppNegotiation);
    wrapper.opportunityNegotiation = MapOppNegotiation;
    
    Date tomorrow = Date.today().addDays(1);
    Map<Date, Integer> MapLastWeekOppp = new Map<Date, Integer>();
    List<AggregateResult> lastweekOpportunity = Database.query(query3);
    for (AggregateResult result2 : lastweekOpportunity) {
        Date cretdt = (Date)result2.get('Created_Date__c');
        system.debug('cretdt===='+cretdt);
        // Date dt = cretdt.date();
        Date d = Date.newInstance(cretdt.year(), cretdt.month(), cretdt.day());
        system.debug('d===='+d);
        // Date date12 = CloseDate.toLocaleDateString();;
        system.debug('cretdt===='+cretdt);
        Integer countOpportunity = (Integer)result2.get('countOpportunity');
        MapLastWeekOppp.put(cretdt, countOpportunity);
    }
    system.debug('MapLastWeekOppp===='+MapLastWeekOppp);
    wrapper.LastweekOpportunity = MapLastWeekOppp;
    
    Map<Date, Integer> LeadProposalMap = new  Map<Date, Integer>();
    List<AggregateResult> leadproposalCount = Database.query(query4);
    for(AggregateResult result : leadproposalCount) {
        Date crtdate = (Date)result.get('Created_Date__c');
        Integer leadCount = (Integer)result.get('leadCount');
        LeadProposalMap.put(crtdate, leadCount);
    }
    system.debug('LeadProposalMap===='+LeadProposalMap);
    wrapper.LeadProposalCount = LeadProposalMap;
    
    Map<String, Integer> leadsCreatedByCountryMap = new Map<String, Integer>();
    List<AggregateResult> leadscountbyCountry = Database.query(query5);
    for(AggregateResult result : leadscountbyCountry) {
        String country = (String)result.get('Country');
        Integer leadCount = (Integer)result.get('leadCount');
        leadsCreatedByCountryMap.put(country, leadCount);
    }
    wrapper.leadsCountByCountry = leadsCreatedByCountryMap;
    system.debug('leadsCreatedByCountryMap===='+leadsCreatedByCountryMap);
    
    Map<String, Integer> accountConvertedBystate = new Map<String, Integer>();
    List<AggregateResult> accountBystate = Database.query(query6);
    for(AggregateResult result : accountBystate) {
        String State = (String)result.get('BillingState');
        Integer acccount = (Integer)result.get('accCount');
        if(State == null){
            accountConvertedBystate.put('NA', acccount);
        }
        else{
            accountConvertedBystate.put(State, acccount);
        }
        
    } 
    system.debug('accountConvertedBystate===='+accountConvertedBystate);
    wrapper.accountConvertedbyState = accountConvertedBystate; 
    
    return wrapper;  
    
}*/
}