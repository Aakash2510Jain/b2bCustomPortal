public class Samples_SearchController {
        public String sampleType {get;set;}
        public String sampleKeyword {get;set;}
        public String fromDate {get;set;} 
        public String toDate {get;set;}
        public String searchDateFormat {get;set;}  
        public String user_Name;
        public String user_Ip{get;set;} 
        public Boolean flag=false;  
        public String dateCaption {get;set;}
        public String SampleRecord='https://btobglobal--sos.cs5.my.salesforce.com/servlet/servlet.FileDownload?file=00PO0000000unSQMAY';
        private ApexPages.StandardController controller;    
        public Samples_SearchController (ApexPages.StandardController controller) {
            this.controller = controller;
            flag=true;
            user_Ip = ApexPages.currentPage().getHeaders().get('X-Salesforce-SIP');
           system.debug('^^^^SELECTEDUSERIP^^^^^'+user_Ip);
           system.debug('######IIIIPPPP######'+ApexPages.currentPage().getHeaders().get('True-Client-IP'));
           // Search();
      }
      // selvi //
  // @RemoteAction
  //  public static string SampleRecord(string str){
  //      System.debug('INTO THE SAMPLERECORD FUNCTION---'+UserInfo.getUserId());
  //      SampleRequestDownload__c Samples = new SampleRequestDownload__c(Downloaded_User__c = '005900000018B9q');
  //      insert Samples;
   //     return Samples.Name;
 //   }
// selvi //


    public Sample_Request__c searchRecordForm = new Sample_Request__c();
    public Sample_Request__c getSampleRecord(){
        return searchRecordForm;
    }
    
    public List<Sample_Request__c> searchRecords;
    
    public String sortDir {get;set;}
    public String soqlSearch ='';
    public boolean showResults {get;set;}
    public Map<String, SampleResultRecord> searchResult  = new Map<String,SampleResultRecord>();
    public ResultSorter[] sortedResult = new List<ResultSorter>();
    
    public ResultSorter[] getSearchResults(){
//      System.debug('************'+searchResult.size());
        System.debug('************'+searchResult);
        //return searchResult.values();
        sortedResult.sort();
        return sortedResult;
    }
    public String errMsg='';
    public String geterrMsg(){
        return errMsg;
    }
    public String requestIds = '';
    public void DoSearch(){
	    sortedResult.clear();
	        showResults = true;     
	        searchResult = new Map<String,SampleResultRecord>();
	        System.debug('**************************'+fromDate);
	        if(fromDate != null && fromDate.length() > 0){
	            if(Date.valueOf(fromDate.split(' ')[0].trim()) > (System.today()-30)){
	                System.debug((Date.valueOf(fromDate.split(' ')[0].trim()) > (System.today()-30))+'---------------'+Date.valueOf(fromDate.split(' ')[0].trim()) +'--------------'+(System.today()-30));
	                //Apexpages.currentPage()addMessage(new ApexPages.message(ApexPages.Severity.ERROR,'Please select the Dates more than 30 days from today.'));
	                errMsg='Please select the From Date less than 30 days from today.';
	                return;
	            }
	        }
	        if(toDate != null && toDate.length() > 0){
	            if(Date.valueOf(toDate.split(' ')[0].trim()) > (System.today()-30)){
	                System.debug((Date.valueOf(toDate.split(' ')[0].trim()) > (System.today()-30))+'---------------'+Date.valueOf(toDate.split(' ')[0].trim()) +'--------------'+(System.today()-30));
	                //Apexpages.currentPage()addMessage(new ApexPages.message(ApexPages.Severity.ERROR,'Please select the Dates more than 30 days from today.'));
	                errMsg='Please select the To Date less than 30 days from today.';
	                return;
	            }
	        }
	        errMsg='';
	        sampleType = searchRecordForm.Sample_Type__c;       
	        sortDir = 'desc';
	        System.debug('---------------------------'+sampleKeyword);
	        if(sampleKeyword != null&& sampleKeyword.length() > 1  ){
	            List<Sample_Request__c> findResults = new List<Sample_Request__c>(); 
	            List<List<Sample_Request__c>>  findResultsAll = new List<List<Sample_Request__c>> ();
	                
	            if(sampleType!=null){
	             findResultsAll = search.query('FIND \''+sampleKeyword+'\' in ALL fields returning Sample_Request__c (Id,Name where Sample_Type__c=\''+sampleType+'\'    order by CreatedDate desc)');
	            }else{
	             findResultsAll = search.query('FIND \''+sampleKeyword+'\' in ALL fields returning Sample_Request__c (Id,Name order by CreatedDate desc)');
	            }
	            findResults = findResultsAll[0];
	            System.debug('FIND \''+sampleKeyword+'\' in ALL fields returning Sample_Request__c (Id,Name where Sample_Type__c=\''+sampleType+'\'  order by CreatedDate desc)');
	            System.debug('FIND RESULT ALL ::::::::::'+findResultsAll);
	            
	            System.debug('FIND RESULTS:::::::::::::'+findResults);
	            //Map<String,Sample_Request__c> requestMap = new Map<String,Sample_Request__c>();
	            
	            for(Sample_Request__c findRec : findResults){
	                if(requestIds==''){
	                    requestIds=requestIds+'\''+findRec.Id+'\'';
	                }else{
	                    requestIds=requestIds+','+'\''+findRec.Id+'\'';
	                }
	            }
	            system.debug('*****requestid*****'+requestIds);
	            if(requestIds.length() > 0 ){
	                flag=false;
	                String sampleTypeText = '';
	                if(sampleType != null){//Sample_Type__c=\''+sampleType+
	                    sampleTypeText = 'Sample_Type__c=\''+sampleType+'\' and ';
	                }                   
	                if(searchDateFormat== NULL || searchDateFormat.equalsIgnoreCase('')){
	                    dateCaption = fromDate+' to '+toDate;
	                    if(fromDate!=null && fromDate !='' && toDate!=null && toDate!='' ){
	                    soqlSearch = 'select Id, Name, CreatedDate,Sample_Type__c,Sample_Type_Description__c from Sample_Request__c'+
	                    ' where '+sampleTypeText+
	                    ' Id in ('+requestIds+') and CreatedDate > '+fromDate.split(' ')[0]+'T00:00:03Z and CreatedDate < '+toDate.split(' ')[0]+'T23:59:03Z order by CreatedDate '+ sortDir;
	                    }else{
	                    soqlSearch = 'select Id, Name, CreatedDate,Sample_Type__c,Sample_Type_Description__c from Sample_Request__c'+
	                    ' where '+sampleTypeText+
	                    ' Id in ('+requestIds+') and CreatedDate > today and CreatedDate < today order by CreatedDate '+ sortDir;
	                    
	                    }
	                }else{
	                    dateCaption = searchDateFormat;
	                 soqlSearch = 'select Id, Name, CreatedDate,Sample_Type__c,Sample_Type_Description__c from '+
	                 'Sample_Request__c where '+sampleTypeText+'  Id in ('+requestIds+')  and CreatedDate = '+searchDateFormat+' order by CreatedDate '+sortDir;
	                }
	            }
	        }   //Sample_Type_Description__c like \'%:sampleKeyword%\'  
	            //and Sample_Type_Description__c '+ 'like \'%:sampleKeyword%\' 
	            /*if(searchDateFormat== NULL || searchDateFormat.equalsIgnoreCase('')){
	                searchRecords = [select Id, Name, CreatedDate,Sample_Type_Description__c from 
	                    Sample_Request__c where Id in :requestMap.keySet() and 
	                            CreatedDate > :fromDate and CreatedDate < :toDate];
	            }else{
	                searchRecords = [select Id, Name, CreatedDate,Sample_Type_Description__c from 
	                    Sample_Request__c where Id in :requestMap.keySet() and CreatedDate = :searchDateFormat];
	            }*/
	            System.debug('SARCH-----'+searchDateFormat);
	            System.debug(soqlSearch);
	            
	            String soqlAll='Select Sample_Type_Description__c,Name,Id,Sample_Type__c ,CreatedDate From Sample_Request__c where CreatedDate = ToDay  order by CreatedDate '+sortDir+' Limit 50';
	            try{
	                if(flag==false){
	                    searchRecords = Database.query(soqlSearch);
	                }else{
	                    searchDateFormat = 'TODAY';
	                    dateCaption = searchDateFormat;
	                    searchRecords = Database.query(soqlAll);
	                    sampleKeyword='';
	                }
	            }catch(DMLException e){
	            
	            }
	        //  System.debug('SEARCH RESULTS:::::::::::::'+searchRecords);
	        
	    
	            Set<String> attParentIds = new Set<String>();
	            for(Sample_Request__c searchRecord : searchRecords){            
	                if(searchRecord.Sample_Type_Description__c != ''){
	                    IF(!flag){
	                        if(searchRecord.Sample_Type_Description__c.containsIgnoreCase(sampleKeyword)){ 
	                            SampleResultRecord sRecord= new SampleResultRecord();
	                            sRecord.sampleId = searchRecord.Id;
	                            if(sampleKeyword!=''){
	                            String ste2=searchRecord.Sample_Type_Description__c.toLowerCase(); 
	                            sRecord.sampleDesc=ste2.replaceAll(sampleKeyword.toLowerCase(),'<font size="3" color="red">'+sampleKeyword.toLowerCase()+'</font>');
	                            }else{
	                            sRecord.sampleDesc=searchRecord.Sample_Type_Description__c;
	                            }
	                            sRecord.sampleType = searchRecord.Sample_Type__c;
	                            sRecord.sampleName = searchRecord.Name;
	                            sRecord.sampleReqDate = searchRecord.CreatedDate;
	                            system.debug('SortDate:'+sRecord.sampleReqDate+'&&&'+searchRecord.CreatedDate );
	                            searchResult.put(sRecord.sampleId,sRecord);
	                            attParentIds.add(sRecord.sampleId);
	                            sortedResult.add(new ResultSorter(sRecord));        
	                        }
	                    }else{
	                            SampleResultRecord sRecord= new SampleResultRecord();
	                            sRecord.sampleId = searchRecord.Id;
	                            if(sampleKeyword!=''){
	                            String ste2=searchRecord.Sample_Type_Description__c.toLowerCase(); 
	                            sRecord.sampleDesc=ste2.replaceAll(sampleKeyword.toLowerCase(),'<font size="3" color="red">'+sampleKeyword.toLowerCase()+'</font>');
	                            }else{
	                            sRecord.sampleDesc=searchRecord.Sample_Type_Description__c;
	                            }
	                            sRecord.sampleType = searchRecord.Sample_Type__c;
	                            sRecord.sampleName = searchRecord.Name;
	                            sRecord.sampleReqDate = searchRecord.CreatedDate;
	                            system.debug('SortDate:'+sRecord.sampleReqDate+'&&&'+searchRecord.CreatedDate );
	                            searchResult.put(sRecord.sampleId,sRecord);
	                            attParentIds.add(sRecord.sampleId);
	                            sortedResult.add(new ResultSorter(sRecord));        
	                        
	                    }
	                }
	            }
	            //attachments of sample requests
	            //https://c.cs5.content.force.com/servlet/servlet.FileDownload?file=00PO0000000TPNh
	            Map<String,List<String>> attachmentResultList = new Map<String,List<String>>();
	            List<Attachment> attachList = [select id,name,parentid from Attachment where parentid in :attParentIds];
	            for(Attachment attRec : attachList){    
	                if(searchResult.containsKey(attRec.ParentId)){
	                    if(searchResult.get(attRec.ParentId).att1Link == null){
	                        searchResult.get(attRec.ParentId).att1Link = attRec;
	                        searchResult.get(attRec.ParentId).att1Name = attRec.Name;                       
	                    }else{
	                        searchResult.get(attRec.ParentId).att2Link = attRec;
	                        searchResult.get(attRec.ParentId).att2Name = attRec.Name;                       
	                    }
	                }
	            }
	            system.debug('@@SAMPLETYPE@@'+sampleType);
	            system.debug('**sampleKeyword**'+sampleKeyword);
	            system.debug('##fromDate##'+fromDate);
	            system.debug('##fromDate##'+toDate);
	            system.debug('&&searchDateFormat&&'+searchDateFormat);
	            system.debug('!!!sortedResult!!!'+sortedResult.size());
	            
	            User u=[Select Name,Id From User where id=:UserInfo.getUserId()];
	            system.debug('^^^^***************^^^^^'+u.Name);
	            //user_Name = u.Name;
	            List<LoginIp> l_ip= new List<LoginIp>(); 
	             l_ip=[Select UsersId, SourceIp From LoginIp where UsersId=:u.id];
				//user_Ip = l_ip.SourceIp;
				system.debug('^^^^USERIP^^^^^'+l_ip);
				system.debug('^^^^SELECTEDUSERIP^^^^^'+user_Ip);
				if(user_Ip!=null){
				if(sortedResult.size()>0){
				SamplesSearchCriteria__c ssc= new SamplesSearchCriteria__c();
				if((fromDate!= '' && fromDate!= null)  || (toDate!= ''& toDate!= null)){
				ssc.From_Date__c=date.valueOf(fromDate);
				ssc.To_Date__c=date.valueOf(toDate);
				}
				ssc.User_Ip__c=user_Ip;
				ssc.User_name__c= u.Name;
				ssc.Search_Keyword__c=sampleKeyword;
				ssc.Sample_Type__c=sampleType;
				ssc.Samples_Downloaded__c=sortedResult.size();
				if(searchDateFormat!= null|| searchDateFormat!='- None -')
				ssc.Date_Criteria__c = searchDateFormat;
				insert ssc;
				system.debug('%%%%INSERTED SAMPLE%%%%'+ssc.id);  
				}  
				}
	            //for(SampleResultRecord recordS : searchResult.values()){
	        //  //  System.debug('2-------------'+recordS.sampleReqDate);
	            //}
	        //}
	    //}
    }
    
    public class SampleResultRecord{
        public String sampleId {get;set;}
        public String sampleName {get;set;}
        public String sampleType {get;set;}
        public String sampleDesc {get;set;}
        public Datetime sampleReqDate {get;set;}
        public Attachment att1Link {get;set;}
        public Attachment att2Link {get;set;}
        public String att1Name {get;set;}
        public String att2Name {get;set;}
    }
    public List<selectOption> getDateC(){
        List<selectOption> options = new List<selectOption>(); //new list for holding all of the picklist options
        options.add(new selectOption('', '- None -')); //add the first option of '- None -' in case the user doesn't want to select a value or in case no values are returned from query below
        //options.add(new selectOption('TODAY', 'TODAY'));
        //options.add(new selectOption('YESTERDAY', 'YESTERDAY'));
        //options.add(new selectOption('LAST_WEEK', 'LAST WEEK'));
        //options.add(new selectOption('THIS_WEEK', 'THIS WEEK'));
        //options.add(new selectOption('LAST_MONTH', 'LAST MONTH'));
        //options.add(new selectOption('THIS_MONTH', 'THIS MONTH'));
        //options.add(new selectOption('LAST_90_DAYS', 'LAST 90 DAYS'));
        //options.add(new selectOption('THIS_QUARTER', 'THIS QUARTER'));
        options.add(new selectOption('LAST_QUARTER', 'LAST QUARTER'));
        //options.add(new selectOption('THIS_YEAR', 'THIS YEAR'));
        options.add(new selectOption('LAST_YEAR', 'LAST YEAR'));
        return options;
    }
    class ResultSorter implements Comparable {
        public SampleResultRecord ssrRec {get;set;}
       
        // Constructor 
        public ResultSorter(SampleResultRecord ssr) {
            
            ssrRec = ssr;
        }
        // Compare opportunities based on the opportunity amount. 
        public Integer compareTo(Object compareTo) {
            // Cast argument to OpportunityWrapper 
            ResultSorter compareToOppy = (ResultSorter)compareTo;
            // The return value of 0 indicates that both elements are equal. 
            Integer returnValue = 0;
            if (ssrRec.sampleReqDate > compareToOppy.ssrRec.sampleReqDate) {
                // Set return value to a positive value. 
                returnValue = -1;
            } else if (ssrRec.sampleReqDate < compareToOppy.ssrRec.sampleReqDate) {
                // Set return value to a negative value. 
                returnValue = 1;
            }
            return returnValue;       
        }
    }
    
      
   /* static testMethod void myUnitTest_SampleSearchController(){
            /*   Config__c cf=new Config__c();
                cf.NumberOfDays__c=5;
                cf.NoLeadActivity__c=3;
                cf.Division__c='Alex; Blake Cooper; Campaign; Content; Jeff Anderson; LeadGen; Manager_Robin Smith';
                cf.BrandWise__c='B2B Contacts; B2B Data Partners In';
                cf.Value__c='dell.com,span.com';
                cf.Key__c='sample';
                insert cf;
                 
                 lead le=new lead();
                 le.LastName='name';
                 le.Email='sample@sos.com';
                 le.Company='SOS'; 
                 le.Division_Name__c='Spartans';
                 le.Primary_Service_Name__c='Email Appending';
                 le.LeadSource='Customer Service';
                 le.Status='Yet to Initiate';    
                 le.Lead_AssignedTo__c ='Adam Joseph (Spartans)';
                 insert le;
                 
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
                  insert opp;
        
        Sample_Request__c rec = new Sample_Request__c();
        rec.Lead__c=le.id;
        rec.Name='leadsample';
        rec.Sample_Type__c='SEO';
        rec.Status__c='New';
        rec.Sample_Type_Description__c='Test sample';
        insert rec;
        list<sample_Request__c> samplelist = new list<sample_Request__c>(); 
        samplelist.add(rec);
        
                 lead lea=new lead();
                 lea.LastName='name';
                 lea.Email='sample@sap.com';
                 lea.Company='SOS'; 
                 lea.Division_Name__c='Winners';
                 lea.Primary_Service_Name__c='Email Appending';
                 lea.LeadSource='Customer Service';
                 lea.Status='Yet to Initiate';    
                 lea.Lead_AssignedTo__c ='Andy Rodgers (Winners)';
                 insert lea;
                 
                  Account acct=new Account();
                  acct.Name='SOS';
                  acct.Email__c='sample@in.com';
                  acct.Phone='(954) 344-9254';
                  acct.Type='Customer';
                  insert acct;
                  
                  Opportunity oppt=new Opportunity();
                  oppt.Name='sample';
                  oppt.AccountId=acc.id;
                  oppt.Lead_Source__c='Approved Index';
                  oppt.Primary_Service_Name__c='Technology List';
                  oppt.Division__c='Gladiators';
                  oppt.StageName='Deal';
                  oppt.Sample_To_Deal__c='other';
                  oppt.Uploaded_By__c='test';
                  oppt.ForecastCategoryName='pipeline';
                  oppt.Amount=5000;
                  oppt.CloseDate=date.parse('1/13/2013');
                  oppt.Team_Uploaded_By__c='Winners'; 
                  insert oppt;
        
        Sample_Request__c rec1 = new Sample_Request__c();
        rec1.Lead__c=lea.id;
        rec1.Name='leadsample';
        rec1.Sample_Type__c='Business Email Appending';
        rec1.Status__c='New';
        rec1.Sample_Type_Description__c='sample';
        insert rec1;
        list<sample_Request__c> samplelist1 = new list<sample_Request__c>(); 
        samplelist1.add(rec);
        
        lead l=new lead();
                 l.LastName='name';
                 l.Email='sample@sample.com';
                 l.Company='SOS'; 
                 l.Division_Name__c='Titans';
                 l.Primary_Service_Name__c='Email Appending';
                 l.LeadSource='Customer Service';
                 l.Status='Yet to Initiate';    
                 l.Lead_AssignedTo__c ='Chad Hall (Titans)';
                 insert l;
                 
                  Account ac=new Account();
                  ac.Name='SOS';
                  ac.Email__c='sample@in.com';
                  ac.Phone='(954) 344-9254';
                  ac.Type='Customer';
                  insert ac;
                  
                  Opportunity op=new Opportunity();
                  op.Name='sample';
                  op.AccountId=acc.id;
                  op.Lead_Source__c='Approved Index';
                  op.Primary_Service_Name__c='Technology List';
                  op.Division__c='Gladiators';
                  op.StageName='Deal';
                  op.Sample_To_Deal__c='other';
                  op.Uploaded_By__c='test';
                  op.ForecastCategoryName='pipeline';
                  op.Amount=5000;
                  op.CloseDate=date.parse('1/13/2013');
                  op.Team_Uploaded_By__c='Winners'; 
                  insert op;
        
        Sample_Request__c rec2 = new Sample_Request__c();
        rec2.Lead__c=l.id;
        rec2.Name='leadsample';
        rec2.Sample_Type__c='Custom Business List Sample';
        rec2.Status__c='New';
        rec2.Sample_Type_Description__c='Testing sample';
        insert rec2;
        list<sample_Request__c> samplelist2 = new list<sample_Request__c>(); 
        samplelist2.add(rec);
        
        Blob b = Blob.valueOf('Test Data');
        Attachment att=new Attachment();
        att.ParentId=le.id;
        att.Body=b;
        att.name='testattachment';
        att.Description='sample';
        insert att;
        
        
        ApexPages.StandardController sc = new ApexPages.standardController(rec);
        
        Samples_SearchController controller = new Samples_SearchController(sc);
        controller.fromDate='2012-02-01';//(System.today()-20).toString();
        controller.toDate='2013-02-13';
        controller.searchDateFormat='THIS_YEAR';
        controller.sampleKeyword='Test sample';
        controller.sampleType='SEO';
        controller.dateCaption='THIS_YEAR';
        controller.flag=true;
        controller.errMsg='this is error message';
        controller.searchRecords=samplelist;
        controller.showResults=true;
        controller.searchRecordForm=rec;
        controller.sortDir='desc';
        controller.soqlSearch='Select Sample_Type_Description__c,Name,Id,Sample_Type__c ,CreatedDate From Sample_Request__c where CreatedDate = ToDay  order by CreatedDate desc Limit 50';
        controller.DoSearch();
        controller.getSampleRecord();
        controller.getSearchResults();
        controller.getDateC();
        controller.geterrMsg();
        controller.requestIds='';
        
        
        SampleResultRecord samplerec = new SampleResultRecord();
        samplerec.sampleId=rec.id;
        samplerec.sampleType='SEO';
        samplerec.sampleName='testsample';
        samplerec.sampleDesc='this is a test sample';
        samplerec.att1Name=att.name;
        
    /*  Samples_SearchController.ResultSorter results=new Samples_SearchController.ResultSorter();
        results.ResultSorter(rec.id);
        results.compareTo(opp.id);  
    
        
        ApexPages.StandardController sc1 = new ApexPages.standardController(rec1);
        Samples_SearchController controller1 = new Samples_SearchController(sc1);
        controller1.searchDateFormat='THIS_YEAR';
        //controller1.fromDate='2013-03-03';//(System.today()-20).toString();
        //controller1.toDate='2013-03-08';
        controller1.sampleKeyword='sample';     
        controller1.dateCaption='THIS_YEAR';
        controller1.flag=false;
        controller1.errMsg='this is error message';
        controller1.searchRecords=samplelist1;
        controller1.showResults=false;
        controller1.searchRecordForm=rec1;
        controller1.sortDir='desc';
        controller1.soqlSearch='Select Sample_Type_Description__c,Name,Id,Sample_Type__c ,CreatedDate From Sample_Request__c where CreatedDate = ToDay  order by CreatedDate desc Limit 50';
        //controller1.sampleType='Custom Business List Sample';
        controller1.getSampleRecord();
        controller1.getSearchResults();
        controller1.getDateC();
        controller1.geterrMsg();
        controller1.DoSearch();
           
         ApexPages.StandardController sc3 = new ApexPages.standardController(rec2);
        Samples_SearchController controller3 = new Samples_SearchController(sc3);
        controller3.searchDateFormat='THIS_YEAR';
        //controller1.fromDate='2013-03-03';//(System.today()-20).toString();
        //controller1.toDate='2013-03-08';
        
        controller3.sampleKeyword='Test sample';        
        controller3.dateCaption='THIS_YEAR';
        controller3.flag=false;
        controller3.errMsg='this is error message';
        controller3.searchRecords=samplelist2;
        controller3.showResults=false;
        controller3.searchRecordForm=rec1;
        controller3.sortDir='desc';
        controller3.soqlSearch='Select Sample_Type_Description__c,Name,Id,Sample_Type__c ,CreatedDate From Sample_Request__c where CreatedDate = ToDay  order by CreatedDate desc Limit 50';
        controller1.sampleType='Custom Business List Sample';
        controller3.getSampleRecord();
        controller3.getSearchResults();
        controller3.getDateC();
        controller3.geterrMsg();
        controller3.DoSearch();   
    
    }*/
    
    
}