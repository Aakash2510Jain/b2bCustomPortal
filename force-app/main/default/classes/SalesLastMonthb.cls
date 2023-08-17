Public class SalesLastMonthb{
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
     
    public SalesLastMonthb() { }
     
        
            //------------------------------******************MAVERICKS***********---------------------------------------------------------- 
                public integer getMavericksDeal(){
               mvDeal=[select count() from Opportunity where Division__c='Mavericks' and StageName='Deal' and CloseDate=THIS_MONTH];  
               return mvDeal;   
            }
           
             public integer getMavericksLeads(){
              mvopps=[select count() from Opportunity where Division__c='Mavericks' and CreatedDate=THIS_MONTH];  
               mvLeads=[select count() from Lead where  Division_name__c='Mavericks' and CreatedDate=THIS_MONTH and isConverted=false];
              mvTotalLeads=mvopps+mvleads;
                return mvTotalLeads;   
            }
            
             public double getMavericksDealConv(){
                         
              if(mvDeal == 0 || mvTotalLeads == 0)
              return 0;
              else
              return  (((decimal.valueof(mvDeal))*100)/(decimal.valueof(mvTotalLeads)));     
             }
             
             public integer getMavericksAssignLeads(){
              //  Wopps1=[select count() from Opportunity where Division__c='Indians' and CreatedDate=THIS_MONTH];  
               mvLeads1=[select count() from Lead where  Division_name__c='Mavericks' and CreatedDate=THIS_MONTH and isConverted=false and (Team_Identification__c='LeadGen' OR Team_Identification__c='Campaign') and (LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead')];
                mvopps1=[select count() from Opportunity where  Division__c='Mavericks' and CreatedDate=THIS_MONTH and (LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead')];
                mvAssignLeads=mvLeads1+mvOpps1;
                return mvAssignLeads;
             }
             
             
              public integer getMavericksSelfGenLeads(){
              mvopps2=[select count() from Opportunity where Division__c='Mavericks' and CreatedDate=THIS_MONTH];  
               mvLeads2=[select count() from Lead where  Division_name__c='Mavericks' and CreatedDate=THIS_MONTH and isConverted=false];
              mvSelfGenLeads=  mvopps2+mvleads2-mvAssignLeads;
                return mvSelfGenLeads;
             }
             
           
             
      //------------------------------******************JAguars***********----------------------------------------------------------        
             
            public integer getJaguarsDeal(){
               jDeal=[select count() from Opportunity where Division__c='Jaguars' and StageName='Deal' and CloseDate=THIS_MONTH];  
               return jDeal;   
            }
           
             public integer getJaguarsLeads(){
              jopps=[select count() from Opportunity where Division__c='Jaguars' and CreatedDate=THIS_MONTH];  
               jLeads=[select count() from Lead where  Division_name__c='Jaguars' and CreatedDate=THIS_MONTH and isConverted=false];
              jTotalLeads=jopps+jleads;
                return jTotalLeads;   
            }
            
             public double getJaguarsDealConv(){
                         
              if(jDeal == 0 || jTotalLeads == 0)
              return 0;
              else
              return  (((decimal.valueof(jDeal))*100)/(decimal.valueof(jTotalLeads)));     
             }
             
             public integer getJaguarsAssignLeads(){
              //  Wopps1=[select count() from Opportunity where Division__c='Indians' and CreatedDate=THIS_MONTH];  
               jLeads1=[select count() from Lead where  Division_name__c='Jaguars' and CreatedDate=THIS_MONTH and isConverted=false and (Team_Identification__c='LeadGen' OR Team_Identification__c='Campaign') and (LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead')];
                jopps1=[select count() from Opportunity where  Division__c='Jaguars' and CreatedDate=THIS_MONTH and (LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead')];
                jAssignLeads=jLeads1+jOpps1;
                return jAssignLeads;
             }
             
             
              public integer getJaguarsSelfGenLeads(){
              jopps2=[select count() from Opportunity where Division__c='Jaguars' and CreatedDate=THIS_MONTH];  
               jLeads2=[select count() from Lead where  Division_name__c='Jaguars' and CreatedDate=THIS_MONTH and isConverted=false];
              jSelfGenLeads=  jopps2+jleads2-jAssignLeads;
                return jSelfGenLeads;
             }
             
           
           //  --------------------------------------------------------------------------SPARTANS------------------------------------------------
             
             
             
              public integer getSpartansDeal(){
               SDeal=[select count() from Opportunity where Division__c='Spartans' and StageName='Deal' and CloseDate=THIS_MONTH];  
               return SDeal;   
            }
           
             public integer getSpartansLeads(){
              Sopps=[select count() from Opportunity where Division__c='Spartans' and CreatedDate=THIS_MONTH];  
               SLeads=[select count() from Lead where  Division_name__c='Spartans' and CreatedDate=THIS_MONTH and isConverted=false];
              STotalLeads=Sopps+Sleads;
                return STotalLeads;   
            }
            
             public double getSpartansDealConv(){
                         
              if(SDeal == 0 || STotalLeads == 0)
              return 0;
              else
              return  (((decimal.valueof(SDeal))*100)/(decimal.valueof(STotalLeads)));     
             }
             
             public integer getSpartansAssignLeads(){
              //  Sopps1=[select count() from Opportunity where Division__c='Spartans' and CreatedDate=THIS_MONTH];  
               SLeads1=[select count() from Lead where  Division_name__c='Spartans' and CreatedDate=THIS_MONTH and isConverted=false and (Team_Identification__c='LeadGen' OR Team_Identification__c='Campaign') and (LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead')];
                Sopps1=[select count() from Opportunity where  Division__c='Spartans' and CreatedDate=THIS_MONTH and (LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead')];
                SAssignLeads=SLeads1+SOpps1;
                return SAssignLeads;
             }
             
             
              public integer getSpartanselfGenLeads(){
              Sopps2=[select count() from Opportunity where Division__c='Spartans' and CreatedDate=THIS_MONTH];  
               SLeads2=[select count() from Lead where  Division_name__c='Spartans' and CreatedDate=THIS_MONTH and isConverted=false];
              SSelfGenLeads=  Sopps2+Sleads2-SAssignLeads;
                return SSelfGenLeads;
             }
             
            
           //  ----------------------------------------------------------Gladiators---------------------------------------------------------------------
             
              public integer getGladiatorsDeal(){
               GDeal=[select count() from Opportunity where Division__c='Gladiators (SB)' and StageName='Deal' and CloseDate=THIS_MONTH];  
               return GDeal;   
            }
           
             public integer getGladiatorsLeads(){
              Gopps=[select count() from Opportunity where Division__c='Gladiators (SB)' and CreatedDate=THIS_MONTH];  
               GLeads=[select count() from Lead where  Division_name__c='Gladiators (SB)' and CreatedDate=THIS_MONTH and isConverted=false];
              GTotalLeads=Gopps+Gleads;
                return GTotalLeads;   
            }
            
             public double getGladiatorsDealConv(){
                         
              if(GDeal == 0 || GTotalLeads == 0)
              return 0;
              else
              return  (((decimal.valueof(GDeal))*100)/(decimal.valueof(GTotalLeads)));     
             }
             
             public integer getGladiatorsAssignLeads(){
              //  Gopps1=[select count() from Opportunity where Division__c='Gladiators' and CreatedDate=THIS_MONTH];  
               GLeads1=[select count() from Lead where  Division_name__c='Gladiators (SB)' and CreatedDate=THIS_MONTH and isConverted=false and (Team_Identification__c='LeadGen' OR Team_Identification__c='Campaign') and (LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead')];
                Gopps1=[select count() from Opportunity where  Division__c='Gladiators (SB)' and CreatedDate=THIS_MONTH and (LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead')];
                GAssignLeads=GLeads1+GOpps1;
                return GAssignLeads;
             }
             
             
              public integer getGladiatorselfGenLeads(){
              Gopps2=[select count() from Opportunity where Division__c='Gladiators (SB)' and CreatedDate=THIS_MONTH];  
               GLeads2=[select count() from Lead where  Division_name__c='Gladiators (SB)' and CreatedDate=THIS_MONTH and isConverted=false];
              GSelfGenLeads=  Gopps2+Gleads2-GAssignLeads;
                return GSelfGenLeads;
             }
             
           
             
       //-------------------------------------------------------------millionaries----------------------------------
             
             public integer getMillionairesDeal(){
               MIDeal=[select count() from Opportunity where Division__c='Millionaires' and StageName='Deal' and CloseDate=THIS_MONTH];  
               return MIDeal;   
            }
           
             public integer getMillionairesLeads(){
              MIopps=[select count() from Opportunity where Division__c='Millionaires' and CreatedDate=THIS_MONTH];  
               MILeads=[select count() from Lead where  Division_name__c='Millionaires' and CreatedDate=THIS_MONTH and isConverted=false];
              MITotalLeads=MIopps+MIleads;
                return MITotalLeads;   
            }
            
             public double getMillionairesDealConv(){
                         
              if(MIDeal == 0 || MITotalLeads == 0)
              return 0;
              else
              return  (((decimal.valueof(MIDeal))*100)/(decimal.valueof(MITotalLeads)));     
             }
             
             public integer getMillionairesAssignLeads(){
              //  Topps1=[select count() from Opportunity where Division__c='Millionaires' and CreatedDate=THIS_MONTH];  
               MILeads1=[select count() from Lead where  Division_name__c='Millionaires' and CreatedDate=THIS_MONTH and isConverted=false and (Team_Identification__c='LeadGen' OR Team_Identification__c='Campaign') and (LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead')];
                MIopps1=[select count() from Opportunity where  Division__c='Millionaires' and CreatedDate=THIS_MONTH and (LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead')];
                MIAssignLeads=MILeads1+MIOpps1;
                return MIAssignLeads;
             }
             
             
              public integer getMillionaireselfGenLeads(){
              MIopps2=[select count() from Opportunity where Division__c='Millionaires' and CreatedDate=THIS_MONTH];  
               MILeads2=[select count() from Lead where  Division_name__c='Millionaires' and CreatedDate=THIS_MONTH and isConverted=false];
              MISelfGenLeads=  MIopps2+MIleads2-MIAssignLeads;
                return MISelfGenLeads;
             }
             
           
            //--------------------------totals-----------------------------------------------------------------------------------------
             public integer getTotalsDeal(){
               ToDeal=[select count() from Opportunity where StageName='Deal' and CloseDate=THIS_MONTH];  
               return TODeal;   
            }
           
             public integer getTotalsLeads(){
              TOopps=[select count() from Opportunity where  CreatedDate=THIS_MONTH];  
               TOLeads=[select count() from Lead where CreatedDate=THIS_MONTH and isConverted=false];
              TOTotalLeads=Toopps+Toleads;
                return TOTotalLeads;   
            }
            
             public double getTotalsDealConv(){
                         
              if(TODeal == 0 || TOTotalLeads == 0)
              return 0;
              else
              return  (((decimal.valueof(TODeal))*100)/(decimal.valueof(TOTotalLeads)));     
             }
             
             public integer getTotalsAssignLeads(){
              //  Topps1=[select count() from Opportunity where CreatedDate=THIS_MONTH];  
               TOLeads1=[select count() from Lead where CreatedDate=THIS_MONTH and isConverted=false and (Team_Identification__c='LeadGen' OR Team_Identification__c='Campaign') and (LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead')];
                TOopps1=[select count() from Opportunity where CreatedDate=THIS_MONTH and (LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead')];
                TOAssignLeads=TOLeads1+TOOpps1;
                return TOAssignLeads;
             }
             
             
              public integer getTotalselfGenLeads(){
              TOopps2=[select count() from Opportunity where CreatedDate=THIS_MONTH];  
               TOLeads2=[select count() from Lead where CreatedDate=THIS_MONTH and isConverted=false];
              TOSelfGenLeads=  TOopps2+TOleads2-TOAssignLeads;
                return TOSelfGenLeads;
             }
             
            
            //-----------------------------------------------------------------------------------------------------------------------------------
  */}