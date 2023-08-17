/**
*	This class acts as a controller for providing the salesreport of ICP and other sales across the
* 	organization. The report format would be as below for a specific date duration/interval
* 	#leads - is a combination of Leads and Opportunity
*	#demos	- Total Demos provided this month Pick It up from Lead field
*	demos% - % od leads and demos
* 	#sales% - Closed Won Opportunities
*	close % - based onLeads and Closed Won Opportunties
* 	$ rev	- From Project Central from Opportunity Payments ---where type = InfoCheckPoint
*	avg $ sale	-Total Closed Won Opportunities Vs Total Revenue of those Opportunities
*	Amount	- This is salesforce value from Opportunity Closed Amount
*	Amount Paid $	- From Project Central from Opportunity Payments 
*  	Report 1 : Rep Wise
*	Report 2 : Team Wise
*/
public class ConsolidatedSalesReport {
		public string fromDate{get;set;}
		public string toDate{get;set;}
		public String fromNewDate{get;set;}
		public String toNewDate{get;set;}
		
		
		// now it is performed for ICP Team and Other Teams/Divisions Summarized
		// Only ICP Users Team
		public Map<String,SalesTeamReport> salesTeamReportMap = new Map<String,SalesTeamReport>();
		public ConsolidatedSalesReport(){
			try{
			System.debug('constuctor');
			fromDate='2012-08-02';			
			toDate = String.valueOf(System.today());
			fromNewDate  = fromDate;
			toNewDate = toDate;
			divisionName='';
			getAllTeamReps('');
			getTotalLeadsAndDemos();
			getTotalOpportunityAndDemos();
			calculateSalesTeamAggregate();
			}catch(Exception e){
				system.debug(e);
				throw e;
			}
		}
		public ConsolidatedSalesReport(ApexPages.StandardController controller){
			try{
			//fromDate='2012-08-27';
			//toDate = String.valueOf(System.today());
			//fromDate = fromDate.split('.')[2]+'-'+fromDate.split('.')[0]+'-'+fromDate.split('.')[1];
			//toDate = toDate.split('.')[2]+'-'+toDate.split('.')[0]+'-'+toDate.split('.')[1];
			divisionName='';
			getAllTeamReps('');
			getTotalLeadsAndDemos();
			getTotalOpportunityAndDemos();
			calculateSalesTeamAggregate();
			}catch(Exception e){
				system.debug('*****************************'+e);
				throw e;
			}
		}
		/**
		*	Search based on the date and division to return the result
		*/
		public pagereference search(){
			
			//fromDate = fromNewDate.split('.').get(2)+'-'+fromNewDate.split('.').get(0)+'-'+fromNewDate.split('.').get(1);
			//toDate = toNewDate.split('.').get(2)+'-'+toNewDate.split('.').get(0)+'-'+toNewDate.split('.').get(1);
			if(fromNewDate.length() > 0 && toNewDate.length() > 0){
				try{
				System.debug('DATE FIELDS :'+fromNewDate +';;;;;;;;;;;;;;;;'+toNewDate);
				fromDate=fromNewDate;
				toDate = toNewDate;
				getAllTeamReps(divisionName);
				getTotalLeadsAndDemos();
				getTotalOpportunityAndDemos();
				calculateSalesTeamAggregate();
				}catch(Exception e){
					system.debug('*****************************'+e);
					throw e;
				}
			}else{
				ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,'Date fields cannot be empty'));
			}
			return null;
		}
		/**
		* return salesTeamReportMap
		*/
		public List<SalesTeamReport> getSalesTeamList(){
			return salesTeamReportMap.values();
		}
		/**
		*	returns ICP Team
		*/
		public SalesTeamReport getICPTeam(){
			return icpTeamReport;
		}
		/**
		* return overallTeamReport
		*/
		public SalesTeamReport getOverAllTeamList(){
			return overallTeamReport;
		}
		/**
		*	Calculates the details for all sales team and rep average
		*/
		//variable for overall ICP Team Report
		public SalesTeamReport icpTeamReport = new SalesTeamReport();
		public SalesTeamReport overallTeamReport = new SalesTeamReport();
		public void calculateSalesTeamAggregate(){
			icpTeamReport = new SalesTeamReport();
			overallTeamReport = new SalesTeamReport();
			overallTeamReport.teamName='Total Stats';
			icpTeamReport.teamName = 'ICP Team';
			for(String divTeam : divisions.values()){ // for every division
				SalesTeamReport salesTeam = salesTeamReportMap.get(divTeam); // get salesteamreport
				System.debug('SALES TEAM :'+salesTeam);
				SalesTeamReport onlyICPSalesTeam = new SalesTeamReport();
				//onlyICPSalesTeam = salesTeam;
				
				for(SalesRepReport repReport : salesTeam.salesRepMap.values()){// for every sales rep
					System.debug('REP IS :'+repReport.repName);
					if(repReport.icpEnabled){
						System.debug('ONLY ICP SALES TEAM :'+onlyICPSalesTeam);
					// perform avg calculations for sales rep		
					 onlyICPSalesTeam.teamTotalLeads = onlyICPSalesTeam.teamTotalLeads + repReport.totalLeads;
					 onlyICPSalesTeam.teamTotalDemos = onlyICPSalesTeam.teamTotalDemos + repReport.totalDemos;
					 onlyICPSalesTeam.teamTotalSalesAmount = onlyICPSalesTeam.teamTotalSalesAmount + repReport.totalSalesAmount;
					 onlyICPSalesTeam.teamTotalRevenue = onlyICPSalesTeam.teamTotalRevenue + repReport.totalRevenue;
					 onlyICPSalesTeam.teamTotalDeals = onlyICPSalesTeam.teamTotalDeals + repReport.totalDeals;
					}else{
					// perform avg calculations for sales rep		
					 salesTeam.teamTotalLeads = salesTeam.teamTotalLeads + repReport.totalLeads;
					 salesTeam.teamTotalDemos = salesTeam.teamTotalDemos + repReport.totalDemos;
					 salesTeam.teamTotalSalesAmount = salesTeam.teamTotalSalesAmount + repReport.totalSalesAmount;
					 salesTeam.teamTotalRevenue = salesTeam.teamTotalRevenue + repReport.totalRevenue;
					 salesTeam.teamTotalDeals = salesTeam.teamTotalDeals + repReport.totalDeals;
					  System.debug('NON ICP SALES TEAM :'+salesTeam);
					}
					 
					 if(repReport.totalLeads > 0){
					 //% of Leads Vs Demos
					 repReport.percentDemos = String.valueOf((100 * repReport.totalDemos)/repReport.totalLeads) + ' %';
					 
					 //% of based on TotalLeads and TotalDeals (Closed Won Opportunties)
					 repReport.percentClose = String.valueOf((100 * repReport.totalDeals)/repReport.totalLeads)+' %';
					 }else{
					 	repReport.percentDemos = '0 %';
					 	repReport.percentClose = '0 %';
					 }
					 //Avg Sales based on TotalDeals Vs TotalAmount
					 if(repReport.totalDeals > 0){
					 	repReport.avgSales = repReport.totalSalesAmount / repReport.totalDeals;
					 }
					
					salesTeam.salesRepMap.put(repReport.repID,repReport);
					//for overallteamstats
					overallTeamReport.teamTotalLeads = overallTeamReport.teamTotalLeads + repReport.totalLeads;
					 overallTeamReport.teamTotalDemos = overallTeamReport.teamTotalDemos + repReport.totalDemos;
					 overallTeamReport.teamTotalSalesAmount = overallTeamReport.teamTotalSalesAmount + repReport.totalSalesAmount;
					 overallTeamReport.teamTotalRevenue = overallTeamReport.teamTotalRevenue + repReport.totalRevenue;
					 overallTeamReport.teamTotalDeals = overallTeamReport.teamTotalDeals + repReport.totalDeals;
				}
				System.debug('ONLY ICP IS : '+onlyICPSalesTeam);
				System.debug('ICP TEAM IS : '+icpTeamReport);
				icpTeamReport.teamTotalDeals = icpTeamReport.teamTotalDeals + onlyICPSalesTeam.teamTotalDeals;
				icpTeamReport.teamTotalDemos = icpTeamReport.teamTotalDemos + onlyICPSalesTeam.teamTotalDemos;
				icpTeamReport.teamTotalLeads = icpTeamReport.teamTotalLeads + onlyICPSalesTeam.teamTotalLeads;
				icpTeamReport.teamTotalRevenue  = icpTeamReport.teamTotalRevenue + onlyICPSalesTeam.teamTotalRevenue;
				icpTeamReport.teamTotalSalesAmount = icpTeamReport.teamTotalSalesAmount + onlyICPSalesTeam.teamTotalSalesAmount;
				//% of Leads Vs Demos for TEAM
				if(salesTeam.teamTotalLeads > 0){
					salesTeam.teamPercentDemos = String.valueOf(( 100 * salesTeam.teamTotalDemos)/salesTeam.teamTotalLeads) + ' %';
				}else{
					salesTeam.teamPercentDemos ='0 %';
				}
				//% of based on TotalLeads and TotalDeals (Closed Won Opportunties) for TEAM
				if(salesTeam.teamTotalLeads > 0){
					salesTeam.teamPercentClose = String.valueOf((100 * salesTeam.teamTotalDeals)/salesTeam.teamTotalLeads )+' %';
				}else{
					salesTeam.teamPercentClose ='0 %';
				}
				//Avg Sales based on TotalDeals Vs TotalAmount for TEAM
				if(salesTeam.teamTotalDeals > 0){
					salesTeam.teamAvgSales = salesTeam.teamTotalSalesAmount / salesTeam.teamTotalDeals;
				}
				salesTeamReportMap.put(divTeam,salesTeam);
			}
			// calculating percent and avg for sales team and overall icp team
				if(icpTeamReport.teamTotalLeads > 0){
				//% of Leads Vs Demos for ICP TEAM
				icpTeamReport.teamPercentDemos = String.valueOf((100 * icpTeamReport.teamTotalDemos)/icpTeamReport.teamTotalLeads) + ' %';
				//% of based on TotalLeads and TotalDeals (Closed Won Opportunties) for ICP TEAM
				icpTeamReport.teamPercentClose = String.valueOf((100 * icpTeamReport.teamTotalDeals)/icpTeamReport.teamTotalLeads)+' %';
				}else{
					icpTeamReport.teamPercentClose = '0'+' %';
					icpTeamReport.teamPercentDemos = '0'+' %';
				}
				//Avg Sales based on TotalDeals Vs TotalAmount for ICP TEAM
				if(icpTeamReport.teamTotalDeals > 0){
					icpTeamReport.teamAvgSales = icpTeamReport.teamTotalSalesAmount / icpTeamReport.teamTotalDeals;
				}
				
				//for overall Team Stats
				if(overallTeamReport.teamTotalLeads > 0){
					overallTeamReport.teamPercentDemos = String.valueOf((100 * overallTeamReport.teamTotalDemos)/overallTeamReport.teamTotalLeads) + ' %';
					overallTeamReport.teamPercentClose = String.valueOf((100 * overallTeamReport.teamTotalDeals)/overallTeamReport.teamTotalLeads)+' %';
				}else{
					overallTeamReport.teamPercentClose = '0'+' %';
					overallTeamReport.teamPercentDemos = '0'+' %';
				}
				if(overallTeamReport.teamTotalDeals > 0){
					overallTeamReport.teamAvgSales = overallTeamReport.teamTotalSalesAmount / overallTeamReport.teamTotalDeals;
				}
				
				
		}
		/**
		*	Get the list of divisions available for ICP
		*/
		// variable for division
		public String divisionName {get;set;}
	
		public List<selectOption> getDivisionList(){
			List<selectOption> options = new List<selectOption>(); //new list for holding all of the picklist options
			options.add(new selectOption('', '- None -')); //add the first option of '- None -' in case the user doesn't want to select a value or in case no values are returned from query below
			for(String divName : divisionsMain.values()){
				options.add(new selectOption(divName, divName));
			   }
			return options;
		}	
		/**
		* Get all users with division not empty . Will be executed only once at the initial page loading
		*/
		// need to run this for every team and ICP Team
		// -- variables for Sales Reps
		Map<String,User> userRepsMap = new Map<String, User>();
		//Varibale for all divisions and ICP
		//public Map<String,User> icpUsers = new Map<String,User>();
		public Map<String,String> divisions = new Map<String,String>();
		public Map<String,String> divisionsMain = new Map<String,String>();
		public void getAllTeamReps(String teamName){
			System.debug('into the getallteamreps');
			//if(divisions.size() < 1){
			
			divisions = new Map<String,String>();
			salesTeamReportMap = new Map<String,SalesTeamReport>();
			//icpUsers = new Map<String,User>();
			userRepsMap = new Map<String,User>();
			String queryString = 'Select Id, Name, Division,Products__c,ManagerId from User '+
					' where Division !=\'\' and isActive=true ';//and Products__c includes (\'ICP\')
			
			
			List<User> userList1 = Database.query(queryString);
			for(User userRec : userList1){
				divisionsMain.put(userRec.Division,userRec.Division);
			}
			
			if(divisionName== null){
				divisionName='';
			}
			if(divisionName==''){
				queryString = queryString	+ ' ALL Rows';
			}else{
				queryString = queryString+' and Division =\''+divisionName+'\' All Rows';
			}
			System.debug('user query----'+queryString);
			List<User> userList = Database.query(queryString);
			for(User userRec : userList){
				userRepsMap.put(userRec.Id,userRec);
				if(!divisions.containsKey(userRec.Division)){
					//creating divisions and salesteamreport object for each division
					divisions.put(userRec.Division,userRec.Division);
					SalesTeamReport teamReport = new SalesTeamReport();
					teamReport.teamName = userRec.Division;
					salesTeamReportMap.put(teamReport.teamName,teamReport);
				}
				//segregating the ICP Sales Reps
				//if(userRec.Products__c.contains('ICP%')){
				//	icpUsers.put(userRec.Id,userRec);
				//}
			}
			//adding reps to respective division of salesteam
			for(User userRec : userList){
				SalesTeamReport teamReport = salesTeamReportMap.get(userRec.Division);
				SalesRepReport repReport = new SalesRepReport();
				repReport.repID = userRec.Id;
				repReport.repName = userRec.Name;
				repReport.repTeam = userRec.Division;
				if(userRec.Products__c != null && userRec.Products__c.contains('ICP')){
					repReport.icpEnabled = true;
				}
				teamReport.salesRepMap.put(userRec.Id,repReport);
			}
			System.debug('DIVISIONS :'+divisions);
			System.debug('salesTeamReportMap------'+salesTeamReportMap);
			//}
		}
		/**
		* Considering only by CreatedDate of a Lead, which are not converted
		*	Will run everytime the search is been made
		*/
		// -- variables of Total Leads and Total Lead Demos
		public Map<Id,Lead> leadsMap = new Map<Id,Lead>();
		//public Map<Id,Lead> leadDemosMap = new Map<Id,Lead>();
		public void getTotalLeadsAndDemos(){
			leadsMap = new Map<Id,Lead>();
			// not considering the records with Division_Name__c empty
		/*	List<Lead>	leadsList = [Select Id, Name, Website, ICP_Demo__c, OwnerId from Lead where CreatedDate > :fromDate 
				and CreatedDate <= :toDate and isConverted=false and Division_Name__c!='' 
				and (website like '%infocheckpoint%' or Primary_Service_Name__c like '%infocheckpoint%') All Rows];*/
						
			String queryString = 'Select Id, Name, Division_Name__c ,Website, CreatedDate,Demo_Given_On__c, OwnerId from Lead where ((CreatedDate >= '+fromDate.split(' ')[0]+
			'T00:00:03Z and CreatedDate <= ' +toDate.split(' ')[0]+'T23:59:03Z) OR (Demo_Given_On__c >= '+fromDate+
			' and Demo_Given_On__c <= ' +toDate+')) and  Division_Name__c !=\'\''+
			' and (website like \'%infocheckpoint%\' or Primary_Service_Name__c like \'%infocheckpoint%\') ';
			////////////isConverted=false and
			/*String queryString = 'Select Id, Name, Division_Name__c ,Website, Demo_Given_On__c, OwnerId from Lead where ((CreatedDate >= '+fromDate.split(' ')[0]+
			'T00:00:03Z and CreatedDate <= ' +toDate.split(' ')[0]+'T00:00:03Z) OR (Demo_Given_On__c >= '+fromDate+
			' and Demo_Given_On__c <= ' +toDate+')) and isConverted=false and Division_Name__c !=\'\''+
			' and (website like \'%infocheckpoint%\' or Primary_Service_Name__c like \'%infocheckpoint%\') ';*/
			
					system.debug('queryString'+queryString);
			if(divisionName==''){
				queryString = queryString	+ ' ALL Rows';
			}else{
				queryString = queryString+' and Division_Name__c =\''+divisionName+'\' All Rows';
			}
			System.debug('lead query----'+queryString);
			List<Lead> leadsList = Database.query(queryString);
			for(Lead leadRec : leadsList){
				leadsMap.put(leadRec.Id,leadRec);
			}
			System.debug('leads got -------'+leadsMap);
			if(leadsMap.size() > 0){
				assignLeadToSalesTeamAndRep(leadsMap.values());
			}
		}
		/**
		*	Assign the lead information to SalesRep of respective sales teams
		*/
		public void assignLeadToSalesTeamAndRep(List<Lead> leadRecordList){
			//get division from lead and get the SalesTeamReport object
			for(Lead leadRec : leadRecordList){
				System.debug('lead is --'+leadRec);
				SalesTeamReport leadTeam = salesTeamReportMap.get(leadRec.Division_Name__c);
				System.debug('leads team -------'+leadTeam);
				if(leadTeam != null){
					SalesRepReport repReport = leadTeam.salesRepMap.get(leadRec.OwnerId);
					System.debug('rep Report -----'+repReport);
					if(repReport != null){
						if(leadRec.CreatedDate >= Datetime.valueOf(fromDate+' 00:00:00') && leadRec.CreatedDate <= Datetime.valueOf(toDate+' 23:59:00')){
							repReport.totalLeads = repReport.totalLeads+1;
						}
						if(leadRec.Demo_Given_On__c != null){
							if(leadRec.Demo_Given_On__c >= Date.valueOf(fromDate) && leadRec.Demo_Given_On__c <= Date.valueOf(toDate)){
								repReport.totalDemos = repReport.totalDemos+1;
							}
						}
						leadTeam.salesRepMap.put(leadRec.OwnerId,repReport);
					}
				}				
			}
			System.debug('leads team out -------');
		}
		
		/**
		* Considering only by CreatedDate of a Opportunity
		*	Will run everytime the search is been made
		*/
		// -- variables of Total Opportunity and Total Opportunity Demos and Opportunity Payments
		public Map<Id,Opportunity> opportunityMap = new Map<Id,Opportunity>();
		//public Map<Id,Opportunity> opportunityDemosMap = new Map<Id,Opportunity>();
		// -- variables of Payments Received
		public Map<String,Map<String,Opportunity_Payment__c>> paymentOpportunityMap = new Map<String,Map<String,Opportunity_Payment__c>>();
		public void getTotalOpportunityAndDemos(){
			opportunityMap = new Map<Id,Opportunity>();
			paymentOpportunityMap = new Map<String,Map<String,Opportunity_Payment__c>>();
			/*List<Opportunity>	opportunityList = [Select Id, Name,Division__c, ICP_Demo__c, StageName,Amount,OwnerId 
				from Opportunity where CreatedDate > :fromDate 
				and CreatedDate <= :toDate and (Website__c like '%infocheckpoint%' or  
				Primary_Service_Name__c like '%infocheckpoint%') All Rows];
			*/
			
			String queryString = 'Select Id, Name,Division__c, ICP_Demo__c, StageName,Amount,OwnerId'+
			' from Opportunity where CloseDate >= '+fromDate.split(' ')[0] +
			' and CloseDate <= '+toDate.split(' ')[0]+' and (Website__c like \'%infocheckpoint%\' or'+
			' Primary_Service_Name__c like \'%infocheckpoint%\')';
			
			/*String queryString = 'Select Id, Name,Division__c, ICP_Demo__c, StageName,Amount,OwnerId'+
			' from Opportunity where CloseDate > '+fromDate.split(' ')[0] +
			' and CloseDate <= '+toDate.split(' ')[0]+' and (Website__c like \'%infocheckpoint%\' or'+
			' Primary_Service_Name__c like \'%infocheckpoint%\') ';*/
			
			system.debug('queryString'+queryString);		
			if(divisionName==''){
				queryString = queryString	+ ' ALL Rows';
			}else{
				queryString = queryString+' and Division__c =\''+divisionName+'\' All Rows';
			}
			System.debug('opportunity query----'+queryString);
			List<Opportunity>	opportunityList = Database.query(queryString);
			for(Opportunity opportunityRec : opportunityList){
				opportunityMap.put(opportunityRec.Id,opportunityRec);
				//if(opportunityRec.ICP_Demo__c){
				//	opportunityDemosMap.put(opportunityRec.Id,opportunityRec);
				//}
			}
			if(opportunityMap.size() > 0){
				getTotalPayments();
				assignSalesToSalesTeamAndRep();
				
			}
		}
		/**
		*	Assign opportunity values to sales team and sales rep
		*/
		public void assignSalesToSalesTeamAndRep(){
			List<Opportunity> oppList = opportunityMap.values();
			for(Opportunity oppRecord : oppList){
				SalesTeamReport salesTeam = salesTeamReportMap.get(oppRecord.Division__c);
				if(salesTeam != null){
					SalesRepReport repReport = salesTeam.salesRepMap.get(oppRecord.OwnerId);
					if(repReport != null){ //added newly
						if(oppRecord.StageName == 'Deal'){
							repReport.totalDeals = repReport.totalDeals+1;
							repReport.totalSalesAmount = repReport.totalSalesAmount+oppRecord.Amount;
						}
						////////if(oppRecord.ICP_Demo__c){
						///////	repReport.totalDemos = repReport.totalDemos+1;
						///////}
						///////repReport.totalLeads = repReport.totalLeads+1; //[Total Leads = Lead and Opportunities (converted leads)]
						Map<String,Opportunity_Payment__c> payments = paymentOpportunityMap.get(oppRecord.Id);
						if(payments != null && payments.size() > 0){
							for(Opportunity_Payment__c payRecord : payments.values()){
								repReport.totalRevenue = repReport.totalRevenue+payRecord.Payment_Amount__c;
							}
						}
						salesTeam.salesRepMap.put(oppRecord.OwnerId,repReport);
					}
				}
			}
		}
		/**
		* Considering only payments Opportunity from date wise
		*	Will run everytime the search is been made
		*/
		private void getTotalPayments(){
			List<Opportunity_Payment__c> paymentList = [Select Id,Opportunity__c,Payment_Amount__c,Payment_Date__c,Pay_Status__c, 
					Service_Type__c, Payment_Id__c from Opportunity_Payment__c 
					where Opportunity__c in :opportunityMap.keySet()  and Pay_Status__c != '%not%'  
					 ALL Rows];
			/*String ids = '';
			Integer county = 0;
			System.debug('Opportunity Key Set----'+opportunityMap.keySet());
			for(String id : opportunityMap.keySet()){
				if(id.length() > 0){
					if(county == 0){
						ids = '\''+id+'\'';					
					}else{
						ids = ids+','+'\''+id+'\'';
					}
					county=county+1;
					System.debug('COUNTRY ----'+county);
				}
			}
			String queryString = 'Select Id,Opportunity__c,Payment_Amount__c,Payment_Date__c,Pay_Status__c,'+
			' Service_Type__c, Payment_Id__c from Opportunity_Payment__c '+
			' where Pay_Status__c != \'%not%\' and '+
			' Payment_Date__c >= '+fromDate+' and Payment_Date__c <= '+toDate +' ALL Rows';
			System.debug('PAYMENT QUERY :'+queryString); //Opportunity__c in ('+ids+')  and 
			List<Opportunity_Payment__c> paymentList = Database.query(queryString);
			*/
			for(Opportunity_Payment__c paymentRec : paymentList){
				Map<String,Opportunity_Payment__c> oppPayList = null;
				if(paymentOpportunityMap.get(paymentRec.Opportunity__c)!= null){
					oppPayList = paymentOpportunityMap.get(paymentRec.Opportunity__c);
				}else{
					oppPayList = new Map<String,Opportunity_Payment__c>();
				}
				oppPayList.put(paymentRec.Id,paymentRec);
				paymentOpportunityMap.put(paymentRec.Opportunity__c,oppPayList);
			}
		}
		
		public class SalesTeamReport{
			public String teamName {get;set;}
			public String teamLead {get;set;}
			public Integer teamTotalLeads {get;set;}
			public Integer teamTotalDemos {get;set;}	
			public Integer teamTotalDeals {get;set;}
			public String teamPercentDemos {get;set;}
			public Double teamTotalSalesAmount {get;set;}
			public String teamPercentClose {get;set;}
			public Double teamTotalRevenue {get;set;}
			//public Double teamTotalSalesTurnover {get;set;}
			public Double teamAvgSales {get;set;}
			public Map<String,SalesRepReport> salesRepMap = new Map<String,SalesRepReport>();
			
			public SalesTeamReport(){
				teamName='';
				teamLead='';
				teamTotalLeads=0;
				teamTotalDemos=0;
				teamTotalDeals=0;
				teamTotalSalesAmount=0.00;
				teamTotalRevenue = 0.00;
				teamPercentDemos='';
				teamAvgSales=0.00;
				teamPercentClose='';
			}
			/**
			*	returns the salesreplist
			*/
			public List<SalesRepReport> getSalesRepList(){
				system.debug('salesRepMap***'+salesRepMap.values());
				return salesRepMap.values();
			}
			
		}
		public class SalesRepReport{
			public String repID {get;set;}
			public String repName {get;set;}
			public String repTeam {get;set;}
			public boolean icpEnabled {get;set;} // todo will be used for team wise reporting, icp enabled reps would not come under teamwise report
			
			public Integer totalLeads {get;set;}
			public Integer totalDemos {get;set;}	
			
			public Integer totalDeals {get;set;}
			public Double totalSalesAmount {get;set;}
			public Double totalRevenue {get;set;}
			
			public String percentDemos {get;set;}
			public String percentClose {get;set;}			
			//public Double totalSalesTurnover {get;set;}
			public Double avgSales {get;set;}
			public SalesRepReport(){
				repId='';
				repName='';
				repTeam='';
				icpEnabled = false;
				totalLeads=0;
				totalDemos=0;
				totalDeals=0;
				totalSalesAmount=0.00;
				totalRevenue = 0.00;
				percentDemos='';
				avgSales=0.00;
				percentClose='';
			}
		}
 public static testmethod void ConsolidatedSalesReport() {
 	ConsolidatedSalesReport salesReport = new ConsolidatedSalesReport();
 	salesReport.assignSalesToSalesTeamAndRep();
 	salesReport.calculateSalesTeamAggregate();
 	
 }
}