public class Report_Lead_Deal {

    public String fromDate{get;set;}
    public String toDate{get;set;}
    public Report_Lead_Deal(){
    
    }
    
    /* LeadDealCount is a wrapper class which will help to bind different types of data userName, divisionName, leadCount, dealCount and initializing the values at the time of construction of LeadDealCount object.
    */
    
    public class LeadDealCount{
       public string userName{get; set;}
       public string divisionName{get; set;}
       public integer leadCount{get; set;}
       public integer dealCount{get; set;}
       public integer paidCount{get;set;}
       public Decimal leadDeal{get;set;}
       public Decimal bonusAmount{get;set;}
       
       public  LeadDealCount(){
         userName ='';
         divisionName = '';
         leadCount = 0;
         dealCount=0;
         paidCount=0;
         leadDeal=0;
         bonusAmount=0;  
                      
        }
    }
    
    public void doSearch(){
		mapLeadUserCount = new Map<string, integer>();
		mapDealUserCount = new Map<string, integer>();
		mapDivisionUser = new Map<string,string>();
		mapPaidCount = new Map<string,integer>();
		mapleadDeal = new Map<string,Decimal>();
		mapbonusAmount = new Map<string,integer>();
		tempPaidDeal = new Map<string,integer>();
		getPreviousMonthUserInfo();
    }
    
    
     public List<LeadDealCount> getPreviousMonthUserInfo(){
   	
 			if(fromDate==null&&toDate==null){
 			 date dt= date.today();  
             dt = dt-30;
             Date dt1 = dt.toStartOfMonth();
 			 fromdate=string.valueOf(dt1);
 			 todate=String.valueOf(System.today());
 			}
 			
 			String queryLead='select id,User_Name__c, Division_Name__c,LeadSource from Lead where'+
 			' CreatedDate >='+fromDate.split(' ')[0]+'T00:00:03Z and CreatedDate <='+toDate.split(' ')[0]+'T23:59:03Z and '+
 			'Division_Name__c!= null and User_Name__c!= null and Team_Identification__c!=\'Web team\' and'+
 			' Team_Identification__c!=\'Campaign\' and Team_Identification__c!=\'Content\' and Team_Identification__c!=\'LeadGen\' and '+
 			' Team_Identification__c!=\'Sam Green\' and Team_Identification__c!=NULL and LeadSource!=\'Blog Lead\' and '+
 			'LeadSource!=\'Campaign Website\' and LeadSource!=\'PPC Lead\' and LeadSource!=\'Prospecting Website\' and '+
 			'LeadSource!=\'SEO Leads\' and LeadSource!=\'Web Site Lead\' and LeadSource!=\'White Paper Lead\'  Order By Division_Name__c Desc';
 			
 			
 			String queryOpty='select id, Uploaded_By__c,Division__c, StageName,LeadSource from Opportunity where  CloseDate >= '+fromDate+'   and'+
 			' CloseDate <= '+toDate+' and StageName = \'Deal\' and Division__c != null and Uploaded_By__c!= null and'+
 			' Team_Uploaded_By__c!=\'Web team\' and Team_Uploaded_By__c!=\'Campaign\' and Team_Uploaded_By__c!=\'Content\' and'+
 			' Team_Uploaded_By__c!=\'LeadGen\' and Team_Uploaded_By__c!=\'Sam Green\' and Team_Uploaded_By__c!=NULL and LeadSource!=\'Blog Lead\' and'+
 			' LeadSource!=\'Campaign Website\' and LeadSource!=\'PPC Lead\' and LeadSource!=\'Prospecting Website\' and LeadSource!=\'SEO Leads\' and'+
 			' LeadSource!=\'Web Site Lead\' and LeadSource!=\'White Paper Lead\'';
 			
 			String queryPay='Select  o.Service_Type__c, o.Payment_Mode__c, o.Payment_Id__c, o.Payment_Date__c, o.Payment_Amount__c, o.Pay_Status__c, o.Opportunity__c, o.Name, o.Id, o.CreatedDate  From Opportunity_Payment__c o where  Payment_Date__c >= '+fromDate+' and  Payment_Date__c <='+toDate+'  and o.Pay_Status__c IN (\'paid\',\'part payment\')';
 			
 			
 			//system.debug('queryLead'+queryLead);
 			//system.debug('queryOpty'+queryOpty);
 			//system.debug('queryPay'+queryPay);
 			
   			previousMonthValues.clear();
            previousMonthTotalLeads = 0;
            previousMonthTotalDeals = 0;
            previousMonthPaidCount = 0;
            previousMonthleadDeal = 0.0;
            previousMonthbonusAmount = 0;
            monthleads = Database.query(queryLead);
 			monthOpty = Database.query(queryOpty);
 			payopty = Database.query(queryPay);
            
            monthLeads= [select id,User_Name__c, Division_Name__c,LeadSource from Lead where CreatedDate =LAST_MONTH  and Division_Name__c!= null and User_Name__c!= null and Team_Identification__c!='Web team' and Team_Identification__c!='Campaign' and Team_Identification__c!='Content' and Team_Identification__c!='LeadGen' and Team_Identification__c!='Sam Green' and Team_Identification__c!=NULL and LeadSource!='Blog Lead' and LeadSource!='Campaign Website' and LeadSource!='PPC Lead' and LeadSource!='Prospecting Website' and LeadSource!='SEO Leads' and LeadSource!='Web Site Lead' and LeadSource!='White Paper Lead' Order By Division_Name__c Desc];
            monthOpty = [select id, Uploaded_By__c,Division__c, StageName,LeadSource from Opportunity where CloseDate = LAST_MONTH and StageName = 'Deal' and Division__c != null and Uploaded_By__c!= null and Team_Uploaded_By__c!='Web team' and Team_Uploaded_By__c!='Campaign' and Team_Uploaded_By__c!='Content' and Team_Uploaded_By__c!='LeadGen' and Team_Uploaded_By__c!='Sam Green' and Team_Uploaded_By__c!=NULL and LeadSource!='Blog Lead' and LeadSource!='Campaign Website' and LeadSource!='PPC Lead' and LeadSource!='Prospecting Website' and LeadSource!='SEO Leads' and LeadSource!='Web Site Lead' and LeadSource!='White Paper Lead'];
            payopty=[Select  o.Service_Type__c, o.Payment_Mode__c, o.Payment_Id__c, o.Payment_Date__c, o.Payment_Amount__c, o.Pay_Status__c, o.Opportunity__c, o.Name, o.Id, o.CreatedDate  From Opportunity_Payment__c o where Payment_Date__c =LAST_MONTH and o.Pay_Status__c IN ('paid','part payment')];  
            
                
         /*   monthLeads= [select id,User_Name__c, Division_Name__c,LeadSource from Lead where CreatedDate =LAST_MONTH  and Division_Name__c!= null and User_Name__c!= null and Team_Identification__c!='Web team' and Team_Identification__c!='Campaign' and Team_Identification__c!='Content' and Team_Identification__c!='LeadGen' and Team_Identification__c!='Sam Green' and Team_Identification__c!=NULL and LeadSource!='Blog Lead' and LeadSource!='Campaign Website' and LeadSource!='PPC Lead' and LeadSource!='Prospecting Website' and LeadSource!='SEO Leads' and LeadSource!='Web Site Lead' and LeadSource!='White Paper Lead' Order By Division_Name__c Desc];
            monthOpty = [select id, Uploaded_By__c,Division__c, StageName,LeadSource from Opportunity where CloseDate = LAST_MONTH and StageName = 'Deal' and Division__c != null and Uploaded_By__c!= null and Team_Uploaded_By__c!='Web team' and Team_Uploaded_By__c!='Campaign' and Team_Uploaded_By__c!='Content' and Team_Uploaded_By__c!='LeadGen' and Team_Uploaded_By__c!='Sam Green' and Team_Uploaded_By__c!=NULL and LeadSource!='Blog Lead' and LeadSource!='Campaign Website' and LeadSource!='PPC Lead' and LeadSource!='Prospecting Website' and LeadSource!='SEO Leads' and LeadSource!='Web Site Lead' and LeadSource!='White Paper Lead'];
            payopty=[Select  o.Service_Type__c, o.Payment_Mode__c, o.Payment_Id__c, o.Payment_Date__c, o.Payment_Amount__c, o.Pay_Status__c, o.Opportunity__c, o.Name, o.Id, o.CreatedDate  From Opportunity_Payment__c o where Payment_Date__c =LAST_MONTH and o.Pay_Status__c IN ('paid','part payment')];
         */
           calculateLeadOpty();
           calculateLeadOpty2();
           previousMonthTotalLeads = tempMonthTotalLeads;
           previousMonthTotalDeals = tempMonthTotalDeals;
           previousMonthPaidCount  = tempMonthPaidCount;
           previousMonthleadDeal = tempMonthleadDeal;
           previousMonthbonusAmount = tempMonthbonusAmount;
          
           previousMonthValues.addAll(tempMonthValues);

         return previousMonthValues;
    }
    
    
    
    /*Below varible names explains the use of them */
     public integer previousMonthTotalLeads {get; set;}
    public integer previousMonthTotalDeals {get; set;}
    public integer previousMonthPaidCount{get;set;}
    public Decimal previousMonthleadDeal{get;set;}    
    public Decimal previousMonthbonusAmount{get;set;}
    
    public integer tempMonthTotalLeads {get; set;}
    public integer tempMonthTotalDeals {get; set;}
    public integer tempMonthPaidCount {get; set;}
    public Decimal tempMonthleadDeal {get; set;}
    public Decimal tempMonthbonusAmount {get; set;}
    
    Map<string, integer> mapLeadUserCount = new Map<string, integer>();
    Map<string, integer> mapDealUserCount = new Map<string, integer>();
    Map<string, string> mapDivisionUser = new Map<string,string>();
    Map<string, integer> mapPaidCount = new Map<string,integer>();
    Map<string, Decimal> mapleadDeal = new Map<string,Decimal>();
    Map<string, Decimal> mapbonusAmount = new Map<string,integer>();
    Map<string,integer> tempPaidDeal = new Map<string,integer>();
    
    
    
    List<Lead> monthLeads = new List<Lead>();
    List<Opportunity> monthOpty = new List<Opportunity>();
    List<Opportunity_Payment__c> payOpty = new List<Opportunity_Payment__c>();
    
   // List<LeadDealCount> currentMonthValues = new List<LeadDealCount>();    
      List<LeadDealCount> previousMonthValues = new List<LeadDealCount>();    
   // List<LeadDealCount> beforePreviousMonthValues = new List<LeadDealCount>();    
      List<LeadDealCount> tempMonthValues = new List<LeadDealCount>();
   
    
    /*
    calculateLeadOpty() and calculateLeadOpty2() are data process logic methods which will based on variable monthLeads, monthOpty.
    
    calculateLeadOpty() will take monthLeads, monthOpty values and then  count number of Lead per user(mapLeadUserCount) as well as  count number of Deal per user(mapDealUserCount) and  hold the User name and division in mapDivisionUser
    
    */
    public void calculateLeadOpty(){
            
            mapLeadUserCount.clear();
            mapDealUserCount.clear();
            mapDivisionUser.clear();
            mapPaidCount.clear();
            mapleadDeal.clear();  
            mapbonusAmount.clear();  
        
            // The below for loop is counting number of leads against leads in current month.      
           for(Lead looplead : monthLeads ){
                if(mapLeadUserCount.containsKey(looplead.User_Name__c)){
                         mapLeadUserCount.put(looplead.User_Name__c,mapLeadUserCount.get(looplead.User_Name__c)+1);
                }            
                else {
                       mapLeadUserCount.put(looplead.User_Name__c,1);
                       mapDivisionUser.put(looplead.User_Name__c,looplead.Division_Name__c);           
                }
            }
           // The below for loop is counting number of Deals against Opty in current month.      
           for(Opportunity loopopty : monthOpty){
                 if(mapDealUserCount.containsKey(loopopty.Uploaded_By__c)){
                        mapDealUserCount.put(loopopty.Uploaded_By__c,mapDealUserCount.get(loopopty.Uploaded_By__c)+1);
                  }
                else{
                        mapDealUserCount.put(loopopty.Uploaded_By__c,1);
                        mapDivisionUser.put(loopopty.Uploaded_By__c,loopopty.Division__c); 
                }
                for(Opportunity_Payment__c looppay: payopty){
                if(loopopty.get('Id')== looppay.Opportunity__c){                    
                     if(mapPaidCount.containsKey(looppay.Opportunity__c)){
                               mapPaidCount.put(loopopty.Uploaded_By__c,mapPaidCount.get(looppay.Opportunity__c)+1);
                     }
                            else{
                                   mapPaidCount.put(loopopty.Uploaded_By__c,1);
                                   mapDivisionUser.put(loopopty.Uploaded_By__c,loopopty.Division__c);
                            } 
                     }
                }   
                
           }    
           for(string loopCurrentMonthUser : mapLeadUserCount.keySet()){
                  LeadDealCount temp = new LeadDealCount();
                  temp.leadCount = mapLeadUserCount.get(loopCurrentMonthUser);
                  for(string loopPaidCount : mapPaidCount.keySet()){
                  	Decimal tempValue;
             if(mapPaidCount.containsKey(loopCurrentMonthUser) && mapPaidCount.get(loopPaidCount) > 0  ){
                           tempValue = (((decimal.valueof(mapPaidCount.get(loopPaidCount)))*100)/(decimal.valueof(temp.leadCount)));
                            mapleadDeal.put(loopCurrentMonthUser ,tempValue);                           
                       } else{                       
                        mapleadDeal.put(loopCurrentMonthUser ,tempValue);
                       }     
                       if(mapPaidCount.containsKey(loopCurrentMonthUser )&& temp.leadCount > 0){
                           mapbonusAmount.put(loopCurrentMonthUser ,bounsAmount(temp.leadCount,mapPaidCount.get(loopPaidCount)));
                       }                
                  }
            }//end of for loop
           
    }
    
    public Integer bounsAmount(Integer totalLead, Integer PaidLead){
             Integer tempMinAtm = 2500;
             Integer tempMaxAtm = 5000;
    if(totalLead!= 0){
         if(totalLead <= 49 && PaidLead <= 2){
             tempMinAtm =  tempMinAtm * PaidLead;
             System.debug('below 50:'+tempMinAtm);
             return tempMinAtm;
             }        
         else if(totalLead <= 49 && PaidLead >= 3 ){
             tempMaxAtm  = tempMinAtm  * 2 + (PaidLead-2)* tempMaxAtm;
          //   System.debug('below2 50 :'+tempMaxAtm);
             return tempMaxAtm;
             }   
        else if(totalLead >= 50 && paidLead <= 2){
         
             tempMinAtm = totalLead * 50 + tempMinAtm * PaidLead;
            // System.debug('below 100:'+tempMinAtm);
             return tempMinAtm;
         }
         else if(totalLead >= 50 && paidLead >= 3 ){
             tempMaxAtm = totalLead * 50 + tempMaxAtm * (PaidLead-2) + tempMinAtm * 2;
            // System.debug('below2 100 :'+tempMaxAtm);
             return tempMaxAtm;
         }            
        }
      return 0;
    }
  /*
    calculateLeadOpty2() will process the data based on divisions(from mapDivisionUser) and find user, number of Leads and Deals from mapLeadUserCount, mapDealUserCount. By using tempMonthTotalLeads,tempMonthTotalDeals we are calculating totalLeads and TotalDeals count for all Divisions to display in the last line of the VF per Month.
    
    */
    public void calculateLeadOpty2(){
        tempMonthTotalLeads = 0;
        tempMonthTotalDeals = 0;
        tempMonthPaidCount = 0;
        tempMonthleadDeal  = 0.0; 
        tempMonthbonusAmount = 0;        
        tempMonthValues.clear();
        
        List<string> listDivision =  new List<string>();
        listDivision = mapDivisionUser.values();
        listDivision.sort();
        string loopCurrentMonthUser = '';
          for(integer i = listDivision.size(); i >= 1; i--){
           string loopD = listDivision.get(i-1);
              for(string s : mapDivisionUser.keySet()){
                if(loopD == mapDivisionUser.get(s)){
                    loopCurrentMonthUser = s;
                    //system.debug('The division name:'+loopD+':');
                    break;
                    }
                }
              
              LeadDealCount temp = new LeadDealCount();
               temp.leadCount = (mapLeadUserCount.get(loopCurrentMonthUser) == null ? 0 : mapLeadUserCount.get(loopCurrentMonthUser));
               temp.dealCount = (mapDealUserCount.get(loopCurrentMonthUser) == null ? 0 : mapDealUserCount.get(loopCurrentMonthUser));
               temp.paidCount = (mapPaidCount.get(loopCurrentMonthUser) == null ? 0 : mapPaidCount.get(loopCurrentMonthUser));
               temp.divisionName = mapDivisionUser.get(loopCurrentMonthUser);
               temp.leadDeal =(mapleadDeal.get(loopCurrentMonthUser) == null ? 0 : mapleadDeal.get(loopCurrentMonthUser));
               temp.bonusAmount =(mapbonusAmount.get(loopCurrentMonthUser)== null ? 0 : mapbonusAmount.get(loopCurrentMonthUser));
               
               temp.userName= loopCurrentMonthUser;
               tempMonthValues.add(temp);
               tempMonthTotalLeads += temp.leadCount;
               tempMonthTotalDeals += temp.dealCount;
               tempMonthPaidCount += temp.paidCount;
               tempMonthleadDeal  +=temp.leadDeal; 
               tempMonthbonusAmount  +=temp.bonusAmount;
               //system.debug('The division name:'+loopCurrentMonthUser+':'+loopD+':');
               //system.debug('The divisionUser Map size:'+mapDivisionUser.size()+':');
               //system.debug('The divisionUser Map values:'+mapDivisionUser+':');   
               mapDivisionUser.remove(loopCurrentMonthUser);

              
            }

        }
    /* 
    getCurrentMonthUserInfo(), getPreviousMonthUserInfo(), getBeforePreviousMonthUserInfo() are calling from VF page. When these methods are calling from VF, these methods call the SOQL statements with necessary filter conditions.
    
    monthLeads,monthOpty have the required records.
    
    calculateLeadOpty(), calculateLeadOpty2() will process the data calculation logic.
    
    tempMonthTotalLeads,tempMonthTotalDeals will have the totalLeads and TotalDeals count for all Divisions.
    
    tempMonthValues contains the data of division wize and user wize.
    
    */
    
  

}