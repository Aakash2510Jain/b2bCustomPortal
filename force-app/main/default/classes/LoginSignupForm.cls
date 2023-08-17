public without Sharing class LoginSignupForm {
    public static String generateRandomString(){
        Integer len = 10;
        final String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz';
        String randStr = '';
        while (randStr.length() < len) {
            Integer idx = Math.mod(Math.abs(Crypto.getRandomInteger()), chars.length());
            randStr += chars.substring(idx, idx+1);
        }
        return randStr+string.ValueOf(system.now().getTime()); 
    } 
    public static String generateRandomOTP(){
        Integer len = 0;
        final String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz';
        String randStr = '';
        while (randStr.length() < len) {
            Integer idx = Math.mod(Math.abs(Crypto.getRandomInteger()), chars.length());
            randStr += chars.substring(idx, idx+1);
        }
        return randStr+string.ValueOf(system.now().getTime()); 
    }
    
    // -------------Update Hash Code Field by passing UserName and Password-------------------
    @AuraEnabled
    public static PartnerLoginWarpper loginUser(string username,string password){
        PartnerLoginWarpper PartnerLoginWrap = new PartnerLoginWarpper();
        //list<User_Portal__c> updateUserRec = new List<User_Portal__c>();
        try{
            
            List<User_Portal__c> PortlUserRec = [Select id,User_Name__c,Password__c,Hash_Code__c,Role__c from User_Portal__c where User_Name__c =:username AND Password__c =:password limit 1 ];
            if(!PortlUserRec.isEmpty() && PortlUserRec.size() >0 ){
                string hashcode;
                hashcode = generateRandomString(); 
                PortlUserRec[0].Hash_Code__c = hashcode;
                system.debug('hashcode===>>'+hashcode);
                update PortlUserRec[0];
                PartnerLoginWrap.PortlUserRec = PortlUserRec[0];
                PartnerLoginWrap.roleName =PortlUserRec[0].Role__c;
                PartnerLoginWrap.Message = 'SUCCESS';
                //return hashcode;
            }else {
                PartnerLoginWrap.PortlUserRec =NULL;
                PartnerLoginWrap.Message = 'INCORRECT USERNAME OR PASSWORD';
            }
            system.debug('PortlUserRec===>'+PortlUserRec);
        }catch(Exception e){
            system.debug('Error Message==>'+e.getMessage()+ 'Erro in Line==>'+e.getLineNumber());
            PartnerLoginWrap.PortlUserRec =NULL;
            PartnerLoginWrap.Message = e.getMessage();
            
        }
        return PartnerLoginWrap;
    }
    
    // ======================================= Login Wrapper =========================================
    
    Public class PartnerLoginWarpper{
        @AuraEnabled
        public User_Portal__c PortlUserRec {get;set;} 
        @AuraEnabled
        public String Message {get;set;}
         @AuraEnabled
        public String roleName {get;set;}
    } 
    
    // -------------Sign Up User-------------------
    @AuraEnabled
    public static userSignupWrapper signUpUser(User_Portal__c userPortalRec){
        try{
            userSignupWrapper wrapper = new userSignupWrapper();
             system.debug('userPortalRec===>>'+userPortalRec);
            if(userPortalRec != null){
                insert  userPortalRec;
                wrapper.Message = 'Success';
            }else{
                 wrapper.Message = 'Error';
                
            }
         return wrapper;   
        }catch(Exception e){
            system.debug('Error Message==>'+e.getMessage()+ 'Erro in Line==>'+e.getLineNumber());
        }
        return null;
    }
     Public class userSignupWrapper{
         @AuraEnabled
        public String Message {get;set;}
     } 
    // -------------Show User Details on  Welcome page-------------------
    @AuraEnabled
    public static User_Portal__c getUserRecord(string currentuserid){
        try{
            User_Portal__c userRec =[Select id,First_Name__c,Last_Name__c,Hash_Code__c from User_Portal__c where id =: currentuserid];
            system.debug('userRec===>>'+userRec);
            return userRec;
        }catch(Exception e){
            system.debug('Error Message==>'+e.getMessage()+ 'Erro in Line==>'+e.getLineNumber());
        }
        return null;
    }
    // -------------Log Out user by pass the Current hashcode null-------------------
    @AuraEnabled
    public static void logOutUserByHashCode(string userid){
        try{
            User_Portal__c userRec =[Select id,First_Name__c,Last_Name__c,Hash_Code__c,OTP_Number__c from User_Portal__c where id =: userid];
            system.debug('userRec===>>'+userRec);
            if(userRec!= null){
                userRec.Hash_Code__c = null;
                update userRec;
            }
        }catch(Exception e){
            system.debug('Error Message==>'+e.getMessage()+ 'Erro in Line==>'+e.getLineNumber());
        }
        
    }
    // -------------Generate OTP by pass Username-------------------
    @AuraEnabled
    public static UserRecWrapper generateOTP(string username){
        System.debug('username ===> '+username);
        try{
            string otp =  generateRandomOTP();
            System.debug('otp' +otp);
            Integer len = 6;
            String str = string.valueof(otp);
            String randomNumber = str.substring(7, 13);
            System.debug('randomNumber' +randomNumber);
            UserRecWrapper wrapper = new UserRecWrapper();
            list<User_Portal__c> portaluserlist = new list<User_Portal__c>();
            User_Portal__c userRec =[Select id,First_Name__c,Last_Name__c,Hash_Code__c,OTP_Number__c,User_Name__c from User_Portal__c    where User_Name__c =: username ];
            system.debug('userRec===>>'+userRec);
            User_Portal__c userPortalRec = new User_Portal__c();
            userPortalRec.id = userRec.id;
            userPortalRec.OTP_Number__c = randomNumber;
            portaluserlist.add(userPortalRec);    
            update portaluserlist;
            system.debug('portaluserlist==='+portaluserlist);
            wrapper.recordId = userRec.id;
            if(!portaluserlist.isEmpty() &&  userRec.User_Name__c != null){
                User_Portal__c userRecord =[Select id,First_Name__c,Last_Name__c,Hash_Code__c,OTP_Number__c,User_Name__c from User_Portal__c where User_Name__c =:  userRec.User_Name__c ];
                system.debug('portaluserlist==='+userRecord);
                string otpno = userRecord.OTP_Number__c;
                string recid =  userRecord.id;
                string firstName =  userRecord.First_Name__c;
                if(otpno != null && recid != null && firstName != null && userRecord.User_Name__c != null ){
                    
                    EmailTemplate emailTemp = [SELECT Id, Name,DeveloperName, Subject, Body, HtmlValue FROM EmailTemplate Where Name ='Send an OTP'];
                    
                    String subject = emailTemp.Subject;
                    String hBody = emailTemp.Body;
                    string HtmlBody=emailTemp.HtmlValue;
                    htmlBody = htmlBody.replace('{User_Portal__c.Id}',recid);
                    htmlBody = htmlBody.replace('{User_Portal__c.First_Name__c}',firstName);
                    htmlBody = htmlBody.replace('{User_Portal__c.OTP_Number__c}',otpno);
                    System.debug('htmlBody == >'+htmlBody);
                    hBody = hBody.replace('{User_Portal__c.Id}',recid);
                    hBody = hBody.replace('{User_Portal__c.First_Name__c}',firstName);
                    hBody = hBody.replace('{User_Portal__c.OTP_Number__c}',otpno);
                    system.debug('hBody === >'+hBody);
                    List<String> recipients = new List<String>();
                   
                    recipients.add(userRecord.User_Name__c);                            
                     System.debug('recipients == >'+recipients);
                    List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
                    
                    Messaging.SingleEmailMessage email=new Messaging.SingleEmailMessage();
                    
                    email.setToAddresses(recipients);
                    email.setSubject(subject);
                    email.setHtmlBody(htmlBody);
                    email.setPlainTextBody(hBody);
                    //Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email })
                    mails.add(email);
                    system.debug('mails ====> ' + mails);
                    //Messaging.sendEmail(mails);
                    Messaging.SendEmailResult[] sendResults = Messaging.sendEmail(mails);
                    
                    // Check the send results
                    for (Messaging.SendEmailResult result : sendResults) {
                        if (result.isSuccess()) {
                            System.debug('Email sent successfully.');
                        } else {
                            System.debug('Email sending failed. Error: ' + result.getErrors()[0].getMessage());
                            for(Messaging.SendEmailError err : result.getErrors()) {
                                System.debug('The following error has occurred.');                    
                                System.debug(err.getStatusCode() + ': ' + err.getMessage());
                                System.debug('fields that affected this error: ' + err.getFields());
                            }
                        }
                    }
                  //  Messaging.sendEmail(mails);
                  wrapper.message = 'SUCCESS';
                   
                } 
                else{
                    wrapper.message = 'Username is not exist';
                }
                 return wrapper;
            }
            
            
        }catch(Exception e){
            system.debug('Error Message==>'+e.getMessage()+ 'Erro in Line==>'+e.getLineNumber());
        }
        return null;
    }
     Public class UserRecWrapper{
        @AuraEnabled
        public string message {get;set;} 
          @AuraEnabled
        public string recordId {get;set;} 
     }
    // ---------------------record fetched for otp validation in Component JS ---------------------
    @AuraEnabled
    public static User_Portal__c fetchUserRecordData(string URLrecordid){
        try{
            
            if(URLrecordid != null ){
                User_Portal__c userRec =[Select id, OTP_Number__c  from User_Portal__c where id =:URLrecordid];
                system.debug('userRec===>>'+userRec);
                return userRec;
            }
            
        }catch(Exception e){
            system.debug('Error Message==>'+e.getMessage()+ 'Erro in Line==>'+e.getLineNumber());
        }
        return null;
        
    }
   @AuraEnabled
    public static void removeOTP(string recId){
        System.debug('recId' +recId);
        try{
            if(recId != null ){
                User_Portal__c userRec =[Select id, OTP_Number__c  from User_Portal__c where id =:recId];
                userRec.OTP_Number__c = null;
                update userRec;
                system.debug('userRec===>>'+userRec);
             }
         }catch(Exception e){
            system.debug('Error Message==>'+e.getMessage()+ 'Erro in Line==>'+e.getLineNumber());
        }
     }
     // ---------------------change password by pass the userId,otp and new Password---------------------
    
    @AuraEnabled
    public static void resetPassword(string userid, string setnewpassword){
        try{
            if(userid != null &&  setnewpassword != null){
                User_Portal__c userRec =[Select id,First_Name__c,Last_Name__c,Hash_Code__c,OTP_Number__c,Password__c from User_Portal__c where id =:userid];
                userRec.Password__c =  setnewpassword;
                userRec.OTP_Number__c = null;
                update userRec;
                system.debug('userRec===>>'+userRec);
            }
            
        }catch(Exception e){
            system.debug('Error Message==>'+e.getMessage()+ 'Erro in Line==>'+e.getLineNumber());
        }
        
    }
    //------------------------------Fecth Lead Reccord by Passing the hascode-----------------------
    @AuraEnabled
    public static LeadRecTableWrapper fetchLeadRecordUnserPortalUser(string hashcode,integer pageNumber,integer pageSize) {
        try{
            integer offset = (pageNumber - 1) * pageSize;
            Integer totalRecords = [Select COUNT() from Account];
            Integer recordEnd = pageSize * pageNumber;
            LeadRecTableWrapper leadwrpper = new LeadRecTableWrapper(); 
            leadwrpper.pageSize = pageSize;
            leadwrpper.pageNumber = pageNumber;
            leadwrpper.recordStart = offset + 1 ;
            leadwrpper.recordEnd = totalRecords >= recordEnd ? recordEnd : totalRecords; 
            leadwrpper.totalRecords = totalRecords;
            leadwrpper.leadlist = [Select id,Name,Email,Lead_Number__c, Partner__r.Hash_Code__c,LeadSource,Phone,Status from Lead where Partner__r.Hash_Code__c =: hashcode ORDER BY Name LIMIT :pageSize OFFSET :offset];
            system.debug('leadwrpper==='+leadwrpper);
            return leadwrpper;
            
        }catch(Exception e){
            system.debug('Error Message==>'+e.getMessage()+ 'Erro in Line==>'+e.getLineNumber()); 
        }
        return null;
    }
    Public class LeadRecTableWrapper{
        @AuraEnabled
        public List<Lead> leadlist {get;set;} 
        @AuraEnabled   
        public Integer pageSize {get;set;}
        @AuraEnabled 
        public Integer pageNumber {get;set;}
        @AuraEnabled
        public Integer recordStart {get;set;}
        @AuraEnabled
        public Integer recordEnd {get;set;}
        @AuraEnabled
        public Integer totalRecords {get;set;} 
        
    } 
    // ---------------------fetch data and update  it by leadRecId------------------
    @AuraEnabled
    public static Lead updateLeadRec(string leadId){
        try{
            Lead leadRec =[Select id,FirstName,LastName,Email,Phone,Company,LeadSource from Lead where id =:leadId];
            system.debug('leadRec===>>'+leadRec);
            if(leadRec!= null){
                update leadRec;
                
            }
            return leadRec;
        }catch(Exception e){
            system.debug('Error Message==>'+e.getMessage()+ 'Erro in Line==>'+e.getLineNumber());
        }
        return null;
    }  
    @AuraEnabled
    public static User_Portal__c fetchUserProfileRecord(string userid){
        // User_Portal__c userrRec = new User_Portal__c();
        try{
            if(userid!= null){
                User_Portal__c   userrRec =[Select id,First_Name__c,Last_Name__c,User_Name__c,Email__c,Password__c,Phone__c from User_Portal__c where id =:userid ];
                system.debug('userrRec===>>'+userrRec);
                return userrRec;
            }
            
        }catch(Exception e){
            system.debug('Error Message==>'+e.getMessage()+ 'Erro in Line==>'+e.getLineNumber());
        }
        return null;
    }  
    @AuraEnabled
    public static void UpdateUserProfile(User_Portal__c useRec){
        try{
            update useRec;
        }catch(Exception e){
            system.debug('Error Message==>'+e.getMessage()+ 'Erro in Line==>'+e.getLineNumber());
        }
        
    }  
    @AuraEnabled
    public static wrapperDashboard getUserDashboardData(string userPortalid){
        try{
            Date lastMonthStartDate = Date.today().addMonths(-1).toStartOfMonth();
            Date lastMonthEndDate = lastMonthStartDate.addMonths(1).addDays(-1);
            wrapperDashboard wrapper = new wrapperDashboard();
            List<AggregateResult>    opportunities = [SELECT Partner__c, SUM(AMOUNT) total FROM Opportunity WHERE StageName = 'Closed Won' AND Partner__c =:userPortalid  GROUP BY Partner__c]; 
            Decimal decimalRevenue = 0; 
            Decimal decimalLastMonth = 0; 
            if(opportunities.size()>0){
                String str = '' + opportunities[0].get('total') ;
                decimalRevenue = Decimal.ValueOf(str) ;
                System.debug('decimalRevenue ::::: ' + decimalRevenue) ; 
            }
            wrapper.AnnualReturnRevenue = decimalRevenue;
            AggregateResult result = [SELECT SUM(Amount) totalRevenue,Partner__c
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
            return wrapper;
        }catch(Exception e){
            system.debug('Error Message==>'+e.getMessage()+ 'Erro in Line==>'+e.getLineNumber());
        }
        return null;
    }
    public class wrapperDashboard {
        @AuraEnabled 
        public Decimal AnnualReturnRevenue {get;set;}
        @AuraEnabled
        public Decimal lastMonthReturnRevenue {get;set;}
        @AuraEnabled
        public Decimal ConvertedLeadRatio   {get;set;}
        
    }
   /* @AuraEnabled
    public static TodaysTaskWarpper getTodaysTaskForUserPortal(string userPortalid){
       TodaysTaskWarpper wrapper = new TodaysTaskWarpper(); 
       set<id> leadID = new set<id>();
        
        List<Lead> listlead =[Select id ,FirstName,LastName,Partner__c From Lead where Partner__c =: userPortalid];
        system.debug('listlead===='+listlead);
        for(Lead lead :listlead){
            leadID.add(lead.id);
        }
         system.debug('leadID====='+leadID);
        
        list<Task> listOfTodaysTask = [SELECT Id, Subject, ActivityDate, Status,Who.Name 
                               FROM Task  
                               WHERE Whoid IN: leadID AND ActivityDate = TODAY ];
        system.debug('listOfTodaysTask===='+listOfTodaysTask);
        if(!listOfTodaysTask.isEmpty()){
           wrapper.tasklist = listOfTodaysTask; 
            wrapper.Message ='SUCCESS';
        }else if(listOfTodaysTask.isEmpty()){
             wrapper.Message ='ERROR';
        }
        return wrapper;
    }
    Public class TodaysTaskWarpper{
        @AuraEnabled
        public LIst<Task> tasklist {get;set;} 
        @AuraEnabled
        public String Message {get;set;}
    } */
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
    public static WrapperChart dashboardChartsData(string userPortalid){
        system.debug('userPortalid =====> ' + userPortalid);
        WrapperChart wrapper = new WrapperChart();
        Date today = Date.today();
        Date lastWeekStart = today.addDays(-7);
        Date lastWeekEnd = today.addDays(-1);
        List<AggregateResult> leadResults = [SELECT COUNT(Id) leadCount, Status FROM Lead WHERE  Partner__c =:userPortalid AND CreatedDate >= :lastWeekStart AND CreatedDate <= :lastWeekEnd  GROUP BY Status];
        Map<String, Integer> leadCountMap = new Map<String, Integer>();
        for (AggregateResult result : leadResults) {
            String status = (String)result.get('Status');
            Integer leadCount = (Integer)result.get('leadCount');
            leadCountMap.put(status, leadCount);
        }
        system.debug('leadCountMap=='+leadCountMap);
        wrapper.LastweekLeadMap = leadCountMap;
         
        List<AggregateResult> oppnegotiationlist = [SELECT COUNT(ID) countOpportunity ,StageName FROM Opportunity WHERE   Partner__c =:userPortalid GROUP BY StageName];
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
         List<AggregateResult> lastweekOpportunity = [SELECT COUNT(ID) countOpportunity,Created_Date__c  FROM Opportunity WHERE Partner__c =:userPortalid AND Created_Date__c >= :lastWeekStart AND Created_Date__c <:tomorrow  GROUP BY Created_Date__c];
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
         List<AggregateResult> leadproposalCount = [SELECT  Created_Date__c, COUNT(Id) leadCount  FROM Lead WHERE  Status = 'Proposal' AND  Partner__c =:userPortalid  AND Created_Date__c >= :lastWeekStart AND Created_Date__c <:tomorrow  GROUP BY Created_Date__c];
         for(AggregateResult result : leadproposalCount) {
            Date crtdate = (Date)result.get('Created_Date__c');
            Integer leadCount = (Integer)result.get('leadCount');
            LeadProposalMap.put(crtdate, leadCount);
         }
         system.debug('LeadProposalMap===='+LeadProposalMap);
        wrapper.LeadProposalCount = LeadProposalMap;
        
        Map<String, Integer> leadsCreatedByCountryMap = new Map<String, Integer>();
         List<AggregateResult> leadscountbyCountry = [Select Country,COUNT(Id) leadCount from Lead where Partner__c =:userPortalid AND Country != null GROUP BY Country ];
         for(AggregateResult result : leadscountbyCountry) {
            String country = (String)result.get('Country');
            Integer leadCount = (Integer)result.get('leadCount');
            leadsCreatedByCountryMap.put(country, leadCount);
         }
        wrapper.leadsCountByCountry = leadsCreatedByCountryMap;
         system.debug('leadsCreatedByCountryMap===='+leadsCreatedByCountryMap);
        
        
        Map<String, Integer> accountConvertedBystate = new Map<String, Integer>();
         List<AggregateResult> accountBystate = [SELECT BillingState, COUNT(Id) accCount FROM Account GROUP BY BillingState]; 
          for(AggregateResult result : accountBystate) {
            String State = (String)result.get('BillingState');
            Integer acccount = (Integer)result.get('accCount');
            accountConvertedBystate.put(State, acccount);
         } 
        system.debug('accountConvertedBystate===='+accountConvertedBystate);
        
        wrapper.accountConvertedbyState = accountConvertedBystate;
        return wrapper;  
    }
    public class WrapperChart{
        
        public Map<String,Integer> LastweekLeadMap  {get;set;} 
        @AuraEnabled
        public Map<String,Integer> opportunityNegotiation {get;set;} 
        @AuraEnabled
        public Map<Date, Integer> LastweekOpportunity {get;set;} 
          @AuraEnabled
        public Map<Date,Integer> LeadProposalCount {get;set;}
        @AuraEnabled
        public Map<String,Integer> leadsCountByCountry {get;set;} 
        @AuraEnabled
        public Map<String,Integer> accountConvertedbyState {get;set;} 
    }
     @AuraEnabled(cacheable=true)
    public static List<List<sObject>> getSearchRecords(String searchKey){      
        List<List<sObject>> searchResult = [FIND :searchKey IN ALL FIELDS RETURNING
                                            Account (Id, Name, AccountNumber, Website),
                                            Contact(Id, Name, Email, MobilePhone),
                                            Opportunity(Id, Name, StageName, CloseDate),
                                            Lead(Id, Name, Email, Company)];
        return searchResult;
      
    }
    @AuraEnabled
    public static List<Task>  getLeadTask(String userPortalid){
        try{
       // DateTime currentDateTime = DateTime.now();
            //System.debug('currentDateTime==='+currentDateTime);
        // DateTime reminderDateTime = currentDateTime.addHours(-2);  WHERE ReminderDateTime < :DateTime.now().addHours(-2)
       /* set<id> leadID = new set<id>();
        
        List<Lead> listlead =[Select id ,FirstName,LastName,Partner__c From Lead where Partner__c =: userPortalid];
        system.debug('listlead===='+listlead);
        for(Lead lead :listlead){
            leadID.add(lead.id);
        }
         
        system.debug('leadID====='+leadID);
       DateTime ttime = DateTime.now().addHours(-2).addminutes(330);
            system.debug('now==='+system.Now().addminutes(330));
        System.debug('ttime==='+ttime);*/
         List<Task> tasks = [SELECT Id, Subject, ActivityDate, What.Type
                    FROM Task
                    WHERE Partner__c =: userPortalid  AND ReminderDateTime >= :DateTime.now()
                        AND ReminderDateTime <= :DateTime.now().addHours(2)  
                           ];
        System.debug('Lead task Lest======'+tasks);
        return tasks;
    }Catch(Exception e){
            system.debug('Error Message==>'+e.getMessage()+ 'Erro in Line==>'+e.getLineNumber());
        
        }  
    return null;
    }
}