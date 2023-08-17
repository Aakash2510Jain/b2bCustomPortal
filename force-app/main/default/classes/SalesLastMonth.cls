Public class SalesLastMonth{
/*
     integer WDeal, WTotalLeads,wDealAssigned, wDealSelf, Wleads, Wopps, Wleads1, Wopps1,Wleads2, Wopps2,WAssignLeads,WSelfGenLeads, WFollowups,Wtask, WEvent,Wtask1, WEvent1, WSampleReq, WSampleDeal;
     integer IDeal, ITotalLeads,IDealAssigned, IDealSelf, Ileads, Iopps, Ileads1, Iopps1,Ileads2, Iopps2,IAssignLeads,ISelfGenLeads, IFollowups,Itask, IEvent,Itask1, IEvent1, ISampleReq, ISampleDeal;
     integer MDeal, MTotalLeads,MDealAssigned, MDealSelf, Mleads, Mopps, Mleads1, Mopps1,Mleads2, Mopps2,MAssignLeads,MSelfGenLeads, MFollowups,Mtask, MEvent,Mtask1, MEvent1, MSampleReq, mSampleDeal;
     integer TDeal, TTotalLeads,TDealAssigned, TDealSelf, Tleads, Topps, Tleads1, Topps1,Tleads2, Topps2,TAssignLeads,TSelfGenLeads, TFollowups,Ttask, TEvent,Ttask1, TEvent1, TSampleReq, TSampleDeal;
     integer RDeal, RTotalLeads,RDealAssigned, RDealSelf, Rleads, Ropps, Rleads1, Ropps1,Rleads2, Ropps2,RAssignLeads,RSelfGenLeads, RFollowups,Rtask, REvent,Rtask1, REvent1, RSampleReq, RSampleDeal;
     integer mvDeal, mvTotalLeads,mvDealAssigned, mvDealSelf, mvleads, mvopps, mvleads1, mvopps1,mvleads2, mvopps2,mvAssignLeads,mvSelfGenLeads, mvFollowups,mvtask, mvEvent,mvtask1, mvEvent1, mvSampleReq, mvSampleDeal;
     integer jDeal, jTotalLeads,jDealAssigned, jDealSelf, jleads, jopps, jleads1, jopps1,jleads2, jopps2,jAssignLeads,jSelfGenLeads, jFollowups,jtask, jEvent,jtask1, jEvent1, jSampleReq, jSampleDeal;
     integer SDeal, STotalLeads,SDealAssigned, SDealSelf, Sleads, Sopps, Sleads1, Sopps1,Sleads2, Sopps2,SAssignLeads,SSelfGenLeads, SFollowups,Stask, SEvent,Stask1, SEvent1, SSampleReq, SSampleDeal;
     integer GDeal, GTotalLeads,GDealAssigned, GDealSelf, Gleads, Gopps, Gleads1, Gopps1,Gleads2, Gopps2,GAssignLeads,GSelfGenLeads, GFollowups,Gtask, GEvent,Gtask1, GEvent1, GSampleReq, GSampleDeal;
     integer MIDeal, MITotalLeads,MIDealAssigned, MIDealSelf, MIleads, MIopps, MIleads1, MIopps1,MIleads2, MIopps2,MIAssignLeads,MISelfGenLeads, MIFollowups,MItask, MIEvent,MItask1, MIEvent1, MISampleReq, MISampleDeal;
      integer ToDeal, TOTotalLeads,ToDealAssigned, TODealSelf, TOleads, TOopps, TOleads1, TOopps1,TOleads2, Toopps2,TOAssignLeads,TOSelfGenLeads, TOFollowups,TOtask, TOEvent,TOtask1, TOEvent1, TOSampleReq, TOSampleDeal;
     
    public SalesLastMonth() { }
     
        //------------------------------******************WINNERS***********----------------------------------------------------------
         
          public integer getWinnersDeal(){
               WDeal=[select count() from Opportunity where Division__c='Winners' and StageName='Deal' and CloseDate=THIS_MONTH];  
               return WDeal;   
            }
           
             public integer getWinnersLeads(){
              Wopps=[select count() from Opportunity where Division__c='Winners' and CreatedDate=THIS_MONTH];  
               WLeads=[select count() from Lead where  Division_name__c='Winners' and CreatedDate=THIS_MONTH and isConverted=false];
              WTotalLeads=Wopps+Wleads;
                return WTotalLeads;   
            }
            
             public double getWinnerDealConv(){
                         
              if(WDeal == 0 || WTotalLeads == 0)
              return 0;
              else
              return  (((decimal.valueof(WDeal))*100)/(decimal.valueof(WTotalLeads)));     
             }
             
             public integer getWinnerAssignLeads(){
              //  Wopps1=[select count() from Opportunity where Division__c='Winners' and CreatedDate=THIS_MONTH];  
               wLeads1=[select count() from Lead where  Division_name__c='Winners' and CreatedDate=THIS_MONTH and isConverted=false and (Team_Identification__c='LeadGen' OR Team_Identification__c='Campaign') and (LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead')];
                wopps1=[select count() from Opportunity where  Division__c='Winners' and CreatedDate=THIS_MONTH and (LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead')];
                WAssignLeads=wLeads1+wOpps1;
                return WAssignLeads;
             }
             
             
              public integer getWinnerSelfGenLeads(){
              Wopps2=[select count() from Opportunity where Division__c='Winners' and CreatedDate=THIS_MONTH];  
               WLeads2=[select count() from Lead where  Division_name__c='Winners' and CreatedDate=THIS_MONTH and isConverted=false];
              WSelfGenLeads=  Wopps2+Wleads2-WAssignLeads;
                return WSelfGenLeads;
             }
             
            
             
             
             //------------------------------------------------------*******************INDIANS********----------------------------------------------------
             
             public integer getIndiansDeal(){
               iDeal=[select count() from Opportunity where Division__c='Indians' and StageName='Deal' and CloseDate=THIS_MONTH];  
               return iDeal;   
            }
           
             public integer getIndiansLeads(){
              Iopps=[select count() from Opportunity where Division__c='Indians' and CreatedDate=THIS_MONTH];  
               ILeads=[select count() from Lead where  Division_name__c='Indians' and CreatedDate=THIS_MONTH and isConverted=false];
              ITotalLeads=Iopps+Ileads;
                return ITotalLeads;   
            }
            
             public double getIndiansDealConv(){
                         
              if(IDeal == 0 || ITotalLeads == 0)
              return 0;
              else
              return  (((decimal.valueof(IDeal))*100)/(decimal.valueof(ITotalLeads)));     
             }
             
             public integer getIndiansAssignLeads(){
              //  Wopps1=[select count() from Opportunity where Division__c='Indians' and CreatedDate=THIS_MONTH];  
               ILeads1=[select count() from Lead where  Division_name__c='Indians' and CreatedDate=THIS_MONTH and isConverted=false and (Team_Identification__c='LeadGen' OR Team_Identification__c='Campaign') and (LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead')];
                Iopps1=[select count() from Opportunity where  Division__c='Indians' and CreatedDate=THIS_MONTH and (LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead')];
                IAssignLeads=ILeads1+IOpps1;
                return IAssignLeads;
             }
             
             
              public integer getIndiansSelfGenLeads(){
              Iopps2=[select count() from Opportunity where Division__c='Indians' and CreatedDate=THIS_MONTH];  
               ILeads2=[select count() from Lead where  Division_name__c='Indians' and CreatedDate=THIS_MONTH and isConverted=false];
               
               ILeads1=[select count() from Lead where  Division_name__c='Indians' and CreatedDate=THIS_MONTH and isConverted=false and (Team_Identification__c='LeadGen' OR Team_Identification__c='Campaign') and (LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead')];
                Iopps1=[select count() from Opportunity where  Division__c='Indians' and CreatedDate=THIS_MONTH and (LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead')];
                IAssignLeads=ILeads1+IOpps1;
               
              ISelfGenLeads=  Iopps2+Ileads2-IAssignLeads;
                return ISelfGenLeads;
             }
             
           
              
        //------------------------------------------------------*******************MAURYAS********----------------------------------------------------
               public integer getMauryasDeal(){
               MDeal=[select count() from Opportunity where Division__c='Mauryas' and StageName='Deal' and CloseDate=THIS_MONTH];  
               return MDeal;   
            }
           
             public integer getMauryasLeads(){
              Mopps=[select count() from Opportunity where Division__c='Mauryas' and CreatedDate=THIS_MONTH];  
               MLeads=[select count() from Lead where  Division_name__c='Mauryas' and CreatedDate=THIS_MONTH and isConverted=false];
              MTotalLeads=Mopps+Mleads;
                return MTotalLeads;   
            }
            
             public double getMauryasDealConv(){
                         
              if(MDeal == 0 || MTotalLeads == 0)
              return 0;
              else
              return  (((decimal.valueof(MDeal))*100)/(decimal.valueof(MTotalLeads)));     
             }
             
             public integer getMauryasAssignLeads(){
              //  Wopps1=[select count() from Opportunity where Division__c='Winners' and CreatedDate=THIS_MONTH];  
               MLeads1=[select count() from Lead where  Division_name__c='Mauryas' and CreatedDate=THIS_MONTH and isConverted=false and (Team_Identification__c='LeadGen' OR Team_Identification__c='Campaign') and (LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead')];
                Mopps1=[select count() from Opportunity where  Division__c='Mauryas' and CreatedDate=THIS_MONTH and (LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead')];
                MAssignLeads=MLeads1+MOpps1;
                return MAssignLeads;
             }
             
             
              public integer getMauryasSelfGenLeads(){
              Mopps2=[select count() from Opportunity where Division__c='Mauryas' and CreatedDate=THIS_MONTH];  
               MLeads2=[select count() from Lead where  Division_name__c='Mauryas' and CreatedDate=THIS_MONTH and isConverted=false];
              MSelfGenLeads=  Mopps2+Mleads2-MAssignLeads;
                return MSelfGenLeads;
             }
             
           
             
     //------------------------------------------------------*******************TITANS********----------------------------------------------------         
                
          public integer getTitansDeal(){
               TDeal=[select count() from Opportunity where Division__c='Titans' and StageName='Deal' and CloseDate=THIS_MONTH];  
               return TDeal;   
            }
           
             public integer getTitansLeads(){
              Topps=[select count() from Opportunity where Division__c='Titans' and CreatedDate=THIS_MONTH];  
               TLeads=[select count() from Lead where  Division_name__c='Titans' and CreatedDate=THIS_MONTH and isConverted=false];
              TTotalLeads=Topps+Tleads;
                return TTotalLeads;   
            }
            
             public double getTitansDealConv(){
                         
              if(TDeal == 0 || TTotalLeads == 0)
              return 0;
              else
              return  (((decimal.valueof(TDeal))*100)/(decimal.valueof(TTotalLeads)));     
             }
             
             public integer getTitansAssignLeads(){
              //  Topps1=[select count() from Opportunity where Division__c='Titans' and CreatedDate=THIS_MONTH];  
               TLeads1=[select count() from Lead where  Division_name__c='Titans' and CreatedDate=THIS_MONTH and isConverted=false and (Team_Identification__c='LeadGen' OR Team_Identification__c='Campaign') and (LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead')];
                Topps1=[select count() from Opportunity where  Division__c='Titans' and CreatedDate=THIS_MONTH and (LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead')];
                TAssignLeads=TLeads1+TOpps1;
                return TAssignLeads;
             }
             
             
              public integer getTitanselfGenLeads(){
              Topps2=[select count() from Opportunity where Division__c='Titans' and CreatedDate=THIS_MONTH];  
               TLeads2=[select count() from Lead where  Division_name__c='Titans' and CreatedDate=THIS_MONTH and isConverted=false];
              TSelfGenLeads=  Topps2+Tleads2-TAssignLeads;
                return TSelfGenLeads;
             }
             
           

             
             //------------------------------------------------------*******************RAINMAKERS********----------------------------------------------------         
             
             
               public integer getRainmakersDeal(){
               RDeal=[select count() from Opportunity where Division__c='Rainmakers' and StageName='Deal' and CloseDate=THIS_MONTH];  
               return RDeal;   
            }
           
             public integer getRainmakersLeads(){
              Ropps=[select count() from Opportunity where Division__c='Rainmakers' and CreatedDate=THIS_MONTH];  
               RLeads=[select count() from Lead where  Division_name__c='Rainmakers' and CreatedDate=THIS_MONTH and isConverted=false];
              RTotalLeads=Ropps+Rleads;
                return RTotalLeads;   
            }
            
             public double getRainmakersDealConv(){
                         
              if(RDeal == 0 || RTotalLeads == 0)
              return 0;
              else
              return  (((decimal.valueof(RDeal))*100)/(decimal.valueof(RTotalLeads)));     
             }
             
             public integer getRainmakersAssignLeads(){
              //  Ropps1=[select count() from Opportunity where Division__c='Rainmakers' and CreatedDate=THIS_MONTH];  
               RLeads1=[select count() from Lead where  Division_name__c='Rainmakers' and CreatedDate=THIS_MONTH and isConverted=false and (Team_Identification__c='LeadGen' OR Team_Identification__c='Campaign') and (LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead')];
                Ropps1=[select count() from Opportunity where  Division__c='Rainmakers' and CreatedDate=THIS_MONTH and (LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead')];
                RAssignLeads=RLeads1+ROpps1;
                return RAssignLeads;
             }
             
             
              public integer getRainmakerselfGenLeads(){
              Ropps2=[select count() from Opportunity where Division__c='Rainmakers' and CreatedDate=THIS_MONTH];  
               RLeads2=[select count() from Lead where  Division_name__c='Rainmakers' and CreatedDate=THIS_MONTH and isConverted=false];
              RSelfGenLeads=  Ropps2+Rleads2-RAssignLeads;
                return RSelfGenLeads;
             }
             
            
            //-----------------------------------------------------------------------------------------------------------------------------------
                         
*/
}