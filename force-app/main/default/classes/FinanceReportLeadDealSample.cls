public class FinanceReportLeadDealSample {
    public FinanceReportLeadDealSample(){}
    public class LeadDealSample{
       public string divisionName{get; set;}
       public string subTeamName{get; set;}
       public Decimal divDealCount{get; set;}
       public Decimal divLeadCount{get; set;}
       public Decimal divDealconvPer {get; set;}
       public Decimal divAssignedLeadCount{get; set;}
       public Decimal divSelfGenLeadCount{get; set;}
       public Decimal divAssignedLeadconvPer {get; set;}
       public Decimal divSelfGenLeadconvPer {get; set;}
       public Decimal divFollowUpCount {get; set;}
       public Decimal divSampleRequestCount {get; set;}
       public Decimal divSamplesToDealCount {get; set;}
       public Decimal divSamplesToDealconvPer {get; set;}
       public Decimal divAssignedDealCount{get; set;}
       public Decimal divSelfGenDealCount{get; set;}
       
       
       public  LeadDealSample(){
         divisionName = '';
         subTeamName='';
         divDealCount = 0;
         divLeadCount = 0;
         divDealconvPer  = 0;
         divAssignedLeadCount = 0;
         divSelfGenLeadCount = 0;
         divAssignedLeadconvPer  = 0;
         divSelfGenLeadconvPer  = 0;
         divFollowUpCount  = 0;
         divSampleRequestCount  = 0;
         divSamplesToDealCount  = 0;
         divSamplesToDealconvPer  = 0;
         divAssignedDealCount = 0;
         divSelfGenDealCount = 0;        
        }
    }
        public LeadDealSample currentMonthData { get; set; }
        public LeadDealSample lastMonthData { get; set; }
        public LeadDealSample lastBeforeMonthData { get; set; }
        public LeadDealSample tempDataTotal { get; set; }
    
        Map<string, integer> mapTempDivAssignedDeal = new Map<string, integer>();
        Map<string, integer> mapTempDivSelfGenDeal = new Map<string, integer>();
        Map<string, integer> mapTempDivAssignedLead = new Map<string, integer>();
        Map<string, integer> mapTempDivSelfGenLead = new Map<string, integer>();
        Map<string, integer> mapTempDivFollowup = new Map<string, integer>();
        Map<string, integer> mapTempDivSampleReq = new Map<string, integer>();
        Map<string, integer> mapTempDivSampleReqToDeal = new Map<string, integer>();
        set<string> setDivisions = new set<string>();
        List<string> listDivisions = new List<string>();
    
        List<Lead> monthLeads = new List<Lead>();
        List<Opportunity> monthLeadOpty = new List<Opportunity>();
        List<Opportunity> monthOpty = new List<Opportunity>();
        List<Sample_Request__c> monthSampleReq = new List<Sample_Request__c>();
        List<Sample_Request__c> monthSampleReqToDeal = new List<Sample_Request__c>();
        List<Opportunity> monthSampleOpty = new List<Opportunity>();
    
        public List<LeadDealSample> currentMonthValues = new List<LeadDealSample>();
        public List<LeadDealSample> lastMonthValues = new List<LeadDealSample>();
        public List<LeadDealSample> lastBeforeMonthValues = new List<LeadDealSample>(); 
        public List<LeadDealSample> tempMonthValues = new List<LeadDealSample>();
    
           void calculate(){   

                  mapTempDivAssignedDeal.clear();
                  mapTempDivSelfGenDeal.clear();
                  mapTempDivAssignedLead.clear();
                  mapTempDivSelfGenLead.clear();
                  mapTempDivFollowup.clear();
                  mapTempDivSampleReq.clear();
                  mapTempDivSampleReqToDeal.clear();
                  setDivisions.clear();

                 for(Lead looplead : monthLeads ){
                      integer assignedL = 0;
                      integer selfGenL = 0;
                      if((looplead.Team_Identification__c=='LeadGen') || (looplead.Team_Identification__c=='Campaign') ||(looplead.Team_Identification__c=='Content') || (looplead.Team_Identification__c=='Web team') || (looplead.LeadSource=='Web Site Lead') || (looplead.LeadSource=='Campaign Website') || (looplead.LeadSource=='PPC Lead') || (looplead.LeadSource=='Prospecting Website') || (looplead.LeadSource=='SEO Leads') || (looplead.LeadSource=='Blog Lead') || (looplead.LeadSource=='White Paper Lead'))
                             assignedL = 1;
                       else  selfGenL = 1;

                      if(mapTempDivAssignedLead.containsKey(looplead.Division_Name__c)){
                         mapTempDivAssignedLead.put(looplead.Division_Name__c, mapTempDivAssignedLead.get(looplead.Division_Name__c)+assignedL);
                         mapTempDivSelfGenLead.put(looplead.Division_Name__c, mapTempDivSelfGenLead.get(looplead.Division_Name__c)+selfGenL);
                         }
                      else {
                        mapTempDivAssignedLead.put(looplead.Division_Name__c,assignedL);
                        mapTempDivSelfGenLead.put(looplead.Division_Name__c,selfGenL);
                        setDivisions.add(looplead.Division_Name__c);
                        }
                        
                      if( looplead.isFollowUp__c == false && looplead.IsConverted == false && mapTempDivFollowup.containsKey(looplead.Division_Name__c)){
                        mapTempDivFollowup.put(looplead.Division_Name__c, mapTempDivFollowup.get(looplead.Division_Name__c)+1);  
                      }
                      else if( looplead.isFollowUp__c == false && looplead.IsConverted == false ){
                         mapTempDivFollowup.put(looplead.Division_Name__c,1);  
                      }
                }
                for(Opportunity looplead : monthLeadOpty){
                if(mapTempDivSelfGenLead.containsKey(looplead.Division__c)){
                         mapTempDivSelfGenLead.put(looplead.Division__c, mapTempDivSelfGenLead.get(looplead.Division__c)+1);
                         }
                      else {
                        mapTempDivSelfGenLead.put(looplead.Division__c,1);
                        setDivisions.add(looplead.Division__c);
                        }
                if( looplead.isFollowUp__c == false && mapTempDivFollowup.containsKey(looplead.Division__c)){
                        mapTempDivFollowup.put(looplead.Division__c, mapTempDivFollowup.get(looplead.Division__c)+1);  
                      }
                      else if( looplead.isFollowUp__c == false){
                         mapTempDivFollowup.put(looplead.Division__c,1);  
                      }
                
                }
                for(Opportunity loopopty : monthOpty){
                    integer assignedD = 0;
                    integer selfGenD = 0;
                     if((loopopty.Team_Uploaded_By__c=='LeadGen') || (loopopty.Team_Uploaded_By__c=='Campaign') ||(loopopty.Team_Uploaded_By__c=='Content') || (loopopty.Team_Uploaded_By__c=='Web team') || (loopopty.LeadSource=='Web Site Lead') || (loopopty.LeadSource=='Campaign Website') || (loopopty.LeadSource=='PPC Lead') || (loopopty.LeadSource=='Prospecting Website') || (loopopty.LeadSource=='SEO Leads') || (loopopty.LeadSource=='Blog Lead') || (loopopty.LeadSource=='White Paper Lead') && loopopty.Lead_ID__c !=NULL)
                             assignedD = 1;
                       else  selfGenD = 1;
                     
                     if(mapTempDivAssignedDeal.containsKey(loopopty.Division__c)){
                         mapTempDivAssignedDeal.put(loopopty.Division__c, mapTempDivAssignedDeal.get(loopopty.Division__c)+assignedD);
                         mapTempDivSelfGenDeal.put(loopopty.Division__c, mapTempDivSelfGenDeal.get(loopopty.Division__c)+selfGenD);
                         }
                      else {
                        mapTempDivAssignedDeal.put(loopopty.Division__c,assignedD);
                        mapTempDivSelfGenDeal.put(loopopty.Division__c,selfGenD);
                        setDivisions.add(loopopty.Division__c);
                        }
                
                }
                
                for( Sample_Request__c loopSampleReq : monthSampleReq){
                     if(mapTempDivSampleReq.containsKey(loopSampleReq.Division__c)){
                         mapTempDivSampleReq.put(loopSampleReq.Division__c, mapTempDivSampleReq.get(loopSampleReq.Division__c)+1);
                        }
                     else{
                     mapTempDivSampleReq.put(loopSampleReq.Division__c,1);
                     setDivisions.add(loopSampleReq.Division__c); 
                     }
                }
                
                for(Opportunity loopSampleReqToDeal : monthSampleOpty){
                if(mapTempDivSampleReqToDeal.containsKey(loopSampleReqToDeal.Division__c)){
                         mapTempDivSampleReqToDeal.put(loopSampleReqToDeal.Division__c, mapTempDivSampleReqToDeal.get(loopSampleReqToDeal.Division__c)+1);
                         }
                      else {
                        mapTempDivSampleReqToDeal.put(loopSampleReqToDeal.Division__c,1);
                        setDivisions.add(loopSampleReqToDeal.Division__c);
                        }
                }
          }
          
          
         void calculate2(){
                  tempMonthValues.clear();
                  tempDataTotal = new LeadDealSample();
                  integer tempAssinedLeadTotal = 0;
                  integer tempSelfGenTotal = 0;
                  listDivisions.clear();
                  listDivisions.addAll(setDivisions);
                  listDivisions.sort();
                                   
             for(integer i = listDivisions.size(); i >= 1; i--){
                string div = listDivisions.get(i-1);
                LeadDealSample temp = new LeadDealSample();
                temp.divisionName = div;
                temp.divSelfGenDealCount = (mapTempDivSelfGenDeal.get(div) == null ? 0 : mapTempDivSelfGenDeal.get(div) );
                temp.divAssignedDealCount = (mapTempDivAssignedDeal.get(div) == null ? 0 : mapTempDivAssignedDeal.get(div));
                temp.divDealCount = (mapTempDivAssignedDeal.get(div) == null ? 0 : mapTempDivAssignedDeal.get(div)) + (mapTempDivSelfGenDeal.get(div) == null ? 0 : mapTempDivSelfGenDeal.get(div) );
                temp.divAssignedLeadCount =  (mapTempDivAssignedLead.get(div) == null ? 0 : mapTempDivAssignedLead.get(div));
                temp.divSelfGenLeadCount = (mapTempDivSelfGenLead.get(div) == null ? 0 : mapTempDivSelfGenLead.get(div));
                temp.divLeadCount = temp.divAssignedLeadCount + temp.divSelfGenLeadCount;
                temp.divDealconvPer = (temp.divLeadCount == 0 ? 0 : ((temp.divDealCount / temp.divLeadCount) *100));
                //system.debug('Deal:'+temp.divDealCount+':Lead Count:'+temp.divLeadCount+':%:'+temp.divDealconvPer+':');
                temp.divAssignedLeadconvPer = ( temp.divAssignedLeadCount == 0 ? 0 : (mapTempDivAssignedDeal.get(div) == null ? 0 : (mapTempDivAssignedDeal.get(div) /temp.divAssignedLeadCount *100 )));
                //system.debug('Assigned Deal:'+(mapTempDivAssignedDeal.get(div) == null ? 0 : mapTempDivAssignedDeal.get(div))+':Lead Count:'+temp.divSelfGenLeadCount+':%:'+temp.divAssignedLeadconvPer +':');
                temp.divSelfGenLeadconvPer = (temp.divSelfGenLeadCount == 0 ? 0 : (mapTempDivSelfGenDeal.get(div) == null ? 0 : ( mapTempDivSelfGenDeal.get(div) /temp.divSelfGenLeadCount *100)));
                //system.debug('Self Deal:'+(mapTempDivSelfGenDeal.get(div) == null ? 0 : mapTempDivSelfGenDeal.get(div) )+':Lead Count:'+temp.divSelfGenLeadCount+':%:'+temp.divSelfGenLeadconvPer +':');
                temp.divFollowUpCount = (mapTempDivFollowup.get(div) == null ? 0 : mapTempDivFollowup.get(div)) ;
                temp.divSampleRequestCount = (mapTempDivSampleReq.get(div) == null ? 0 : mapTempDivSampleReq.get(div));
                temp.divSamplesToDealCount=(mapTempDivSampleReqToDeal.get(div) == null ? 0 : mapTempDivSampleReqToDeal.get(div));
                temp.divSamplesToDealconvPer= ( temp.divSampleRequestCount == 0 ? 0 : (temp.divSamplesToDealCount/temp.divSampleRequestCount * 100));

                tempMonthValues.add(temp);
                tempAssinedLeadTotal = tempAssinedLeadTotal + ( mapTempDivAssignedDeal.get(div) == null ? 0 : mapTempDivAssignedDeal.get(div));
                tempSelfGenTotal = tempSelfGenTotal + ( mapTempDivSelfGenDeal.get(div) == null ? 0 : mapTempDivSelfGenDeal.get(div));
                tempDataTotal.divAssignedLeadCount = tempDataTotal.divAssignedLeadCount + temp.divAssignedLeadCount;
                tempDataTotal.divSelfGenLeadCount = tempDataTotal.divSelfGenLeadCount + temp.divSelfGenLeadCount;
                tempDataTotal.divFollowUpCount = tempDataTotal.divFollowUpCount + temp.divFollowUpCount;
                tempDataTotal.divSampleRequestCount = tempDataTotal.divSampleRequestCount + temp.divSampleRequestCount;
                tempDataTotal.divSamplesToDealCount = tempDataTotal.divSamplesToDealCount + temp.divSamplesToDealCount;
                tempDataTotal.divSelfGenDealCount = tempDataTotal.divSelfGenDealCount + temp.divSelfGenDealCount;
                tempDataTotal.divAssignedDealCount = tempDataTotal.divAssignedDealCount + temp.divAssignedDealCount;
                
                
           }
                tempDataTotal.divDealCount =  tempAssinedLeadTotal + tempSelfGenTotal;
                tempDataTotal.divLeadCount = tempDataTotal.divAssignedLeadCount + tempDataTotal.divSelfGenLeadCount;
                tempDataTotal.divDealconvPer = (tempDataTotal.divLeadCount == 0 ? 0 : (tempDataTotal.divDealCount / tempDataTotal.divLeadCount *100)) ;
                tempDataTotal.divAssignedLeadconvPer = (tempDataTotal.divAssignedLeadCount == 0 ? 0  : (tempAssinedLeadTotal / tempDataTotal.divAssignedLeadCount *100));
                tempDataTotal.divSelfGenLeadconvPer = ( tempDataTotal.divSelfGenLeadCount == 0 ? 0 : (tempSelfGenTotal / tempDataTotal.divSelfGenLeadCount * 100));
                tempDataTotal.divSamplesToDealconvPer = (tempDataTotal.divSampleRequestCount == 0 ? 0 : (tempDataTotal.divSamplesToDealCount / tempDataTotal.divSampleRequestCount *100));
    }
    
      public List<LeadDealSample> getCurrentMonthInfo(){

            monthLeads = [select id,User_Name__c, Division_Name__c, Sub_Team__c, isFollowUp__c, Team_Identification__c, LeadSource, IsConverted from Lead where CREATEDDATE = this_month and Division_Name__c!= null and Sub_Team__c!=null ];
            monthLeadOpty = [ select id, Uploaded_By__c,Division__c,Sub_Team__c, StageName, isFollowUp__c, LeadSource,Team_Uploaded_By__c,Lead_ID__c from Opportunity where CREATEDDATE=this_month and Lead_ID__c =''];
            monthOpty = [ select id, Uploaded_By__c,Division__c,Sub_Team__c, StageName, LeadSource,Team_Uploaded_By__c,Lead_ID__c from Opportunity where CloseDate=this_month and StageName = 'Deal' and Division__c != null];
            //monthSampleReq = [ select ID, Division__c, Lead__c, Opportunity__c, Send_Request__c from Sample_Request__c where CREATEDDATE = this_month and Send_Request__c = true and Division__c != null];
        monthSampleReq = [ select ID, Division__c, Lead__c, Opportunity__c, Send_Request__c from Sample_Request__c where CREATEDDATE = this_month and Division__c != null];
            set<ID> sampleOptyIDs = new set<ID>();
            for(Opportunity loopOpty :  monthOpty){
            sampleOptyIDs.add(loopOpty.ID);
            }
            monthSampleReqToDeal = [ select ID, Division__c, Lead__c, Opportunity__c, Send_Request__c from Sample_Request__c where Opportunity__c IN :sampleOptyIDs];
            sampleOptyIDs.clear();
            for(Sample_Request__c loopSample : monthSampleReqToDeal){
            sampleOptyIDs.add(loopSample.Opportunity__c);
            }
            monthSampleOpty = [ select id, Uploaded_By__c,Division__c, StageName, LeadSource from Opportunity where ID IN : sampleOptyIDs];
            
            currentMonthValues.clear();
            calculate();
            calculate2();
            currentMonthValues.addAll(tempMonthValues);
            currentMonthData = tempDataTotal;
       
          return currentMonthValues;
    }

      public List<LeadDealSample> getLastMonthInfo(){
            
            monthLeads = [select id,User_Name__c, Division_Name__c, Sub_Team__c, isFollowUp__c, Team_Identification__c, LeadSource, IsConverted from Lead where CREATEDDATE = LAST_MONTH  and Division_Name__c!= null and  Sub_Team__c!=null];
            monthLeadOpty = [ select id, Uploaded_By__c,Division__c,Sub_Team__c,isFollowUp__c, StageName, LeadSource,Team_Uploaded_By__c from Opportunity where CREATEDDATE=LAST_MONTH and Lead_ID__c =''];
            monthOpty = [ select id, Uploaded_By__c,Division__c,Sub_Team__c,StageName, LeadSource,Team_Uploaded_By__c,Lead_ID__c from Opportunity where CloseDate=LAST_MONTH  and StageName = 'Deal' and Division__c != null and Sub_Team__c!= null];
            monthSampleReq = [ select ID, Division__c, Lead__c, Opportunity__c, Send_Request__c from Sample_Request__c where CREATEDDATE = LAST_MONTH and Division__c != null ];
            set<ID> sampleOptyIDs = new set<ID>();
            for(Opportunity loopOpty :  monthOpty){
            sampleOptyIDs.add(loopOpty.ID);
            }
            monthSampleReqToDeal = [ select ID, Division__c, Lead__c, Opportunity__c, Send_Request__c from Sample_Request__c where Opportunity__c IN :sampleOptyIDs];
            sampleOptyIDs.clear();
            for(Sample_Request__c loopSample : monthSampleReqToDeal){
            sampleOptyIDs.add(loopSample.Opportunity__c);
            }
            monthSampleOpty = [ select id, Uploaded_By__c,Division__c, StageName, LeadSource,Team_Uploaded_By__c,Lead_ID__c from Opportunity where ID IN : sampleOptyIDs];
            
            lastMonthValues.clear();
            calculate();
            calculate2();
            lastMonthValues.addAll(tempMonthValues);
            lastMonthData = tempDataTotal;
            
          return lastMonthValues;
    }
    
      public List<LeadDealSample> getLastBeforeMonthInfo(){
           /*
            date dt= date.today();  
            dt = dt-60;
            Date dt1 = dt.toStartOfMonth();
            integer noOfDays = date.daysInMonth(dt1.year(),dt1.month());
            Date dt2 = date.newInstance(dt1.year(),dt1.month(),noOfDays); 
            */
             date dt= date.today();  
             //dt = dt-90;
             Date dt1 = dt.toStartOfMonth(); 
             dt1 = dt1-1;
             dt1 = dt1.toStartOfMonth();
             dt1 = dt1-1;
             dt1 = dt1.toStartOfMonth();
             dt1 = dt1-1;
             dt1 = dt1.toStartOfMonth();                          
             Date dt2 = date.today().toStartOfMonth();
            system.debug('The date Dt1:'+dt1);
            system.debug('The date Dt2:'+dt2);
            monthLeads= [select id,User_Name__c, Division_Name__c,Sub_Team__c, isFollowUp__c, Team_Identification__c, LeadSource, IsConverted from Lead where Lead_Created_Date__c >= :dt1 and Lead_Created_Date__c < :dt2 and Division_Name__c!= null and Division_Name__c!='#N/A' and Division_Name__c!='0' and Sub_Team__c!='#N/A'and Sub_Team__c!='0'];
            monthLeadOpty = [ select id, Uploaded_By__c,Division__c,Sub_Team__c, StageName, LeadSource, isFollowUp__c,Team_Uploaded_By__c from Opportunity where CREATEDDATE >= :dt1 and CREATEDDATE < :dt2 and Lead_ID__c ='' and Division__c!='#N/A' and Division__c!='0'and Sub_Team__c!='#N/A'and Sub_Team__c!='0'];
            monthOpty = [ select id, Uploaded_By__c,Division__c,Sub_Team__c, StageName, LeadSource,Team_Uploaded_By__c,Lead_ID__c from Opportunity where CloseDate >= :dt1 and CloseDate < :dt2 and StageName = 'Deal' and Division__c != null and Division__c!='#N/A' and Division__c!='0'and Sub_Team__c!='#N/A'and Sub_Team__c!='0'];
            monthSampleReq = [ select ID, Division__c, Lead__c, Opportunity__c, Send_Request__c from Sample_Request__c where CREATEDDATE >=: dt1 and CREATEDDATE <=: dt2 and Division__c != null and Division__c!='#N/A' and Division__c!='0'];
            set<ID> sampleOptyIDs = new set<ID>();
            for(Opportunity loopOpty :  monthOpty){
            sampleOptyIDs.add(loopOpty.ID);
            }
            monthSampleReqToDeal = [ select ID, Division__c, Lead__c, Opportunity__c, Send_Request__c from Sample_Request__c where Opportunity__c IN :sampleOptyIDs];
            sampleOptyIDs.clear();
            for(Sample_Request__c loopSample : monthSampleReqToDeal){
            sampleOptyIDs.add(loopSample.Opportunity__c);
            }
            monthSampleOpty = [ select id, Uploaded_By__c,Division__c, StageName, LeadSource,Team_Uploaded_By__c,Lead_ID__c from Opportunity where ID IN : sampleOptyIDs];
            
            lastBeforeMonthValues.clear();
            calculate();
            calculate2();
            lastBeforeMonthValues.addAll(tempMonthValues);
            lastBeforeMonthData = tempDataTotal;
       
          return lastBeforeMonthValues;
    }
}