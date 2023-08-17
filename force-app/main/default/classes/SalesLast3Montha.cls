Public class SalesLast3Montha{
/*This class is not using currently

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
     
    public SalesLast3Montha() { }
     
        //------------------------------******************WINNERS***********----------------------------------------------------------
         date dt= date.today();
    
            Integer mon=dt.month();
            Integer d=dt.day();
            Integer y=dt.year();
            Date dt1 = date.newInstance(y,mon-3,1);
            Date dt2 = date.newInstance(y,mon-1,30);
            
          
             
             public double getWinnerAssignConv(){
             
             wDealAssigned=[select count() from Opportunity where  Division__c='Winners' and CloseDate>=:dt1 and Closedate<=:dt2 and StageName='Deal' and (LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead') Limit 50000];
              wLeads1=[select count() from Lead where  Division_name__c='Winners' and  CreatedDate>=:dt1 and CreatedDate<=:dt2 and isConverted=false and (Team_Identification__c='LeadGen' OR Team_Identification__c='Campaign') and (LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead') Limit 50000];
                wopps1=[select count() from Opportunity where  Division__c='Winners' and  CreatedDate>=:dt1 and CreatedDate<=:dt2 and (LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead') Limit 50000];
                WAssignLeads=wLeads1+wOpps1;
                if(wDealAssigned== 0 || WAssignLeads== 0)
              return 0;
              else
             return (((decimal.valueof(wDealAssigned))*100)/(decimal.valueof(WAssignLeads)));   
             }
             
              public decimal getWinnerSelfGenConv(){
              wDealSelf= wDealAssigned=[select count() from Opportunity where  Division__c='Winners' and CloseDate>=:dt1 and Closedate<=:dt2 and StageName='Deal' and (NOT(LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead')) Limit 50000];
                 Wopps2=[select count() from Opportunity where Division__c='Winners' and  CreatedDate>=:dt1 and CreatedDate<=:dt2 Limit 50000];  
               WLeads2=[select count() from Lead where  Division_name__c='Winners' and  CreatedDate>=:dt1 and CreatedDate<=:dt2 and isConverted=false Limit 50000];
              WSelfGenLeads=  Wopps2+Wleads2-WAssignLeads;
              
                if(wDealSelf== 0 || WSelfGenLeads== 0)
                {return 0;}
              else
                {
                return (((decimal.valueof(wDealSelf))*100)/(decimal.valueof(WSelfGenLeads)));   
                }
             }
             
             public integer getWinnerFollowups(){
               List<Lead> L= new List<Lead>();
                List<Lead> L1= new List<Lead>();
                List<Lead> L2= new List<Lead>();
                List<Opportunity> O= new List<Opportunity>();
                List<Opportunity> O1= new List<Opportunity>();
                 List<Opportunity> O2= new List<Opportunity>();
               List<Task> taskIds = new List<Task>();
               List<Event> EventIds= new List<Event>();
                 Set<id> whoids = new set<id>(); 
                 Set<id> whatids = new set<id>();   
                  Set<id> whoidsE = new set<id>(); 
                 Set<id> whatidsE = new set<id>();    
                  Set<id> Leads= new set<id>();    
                   Set<id> Opps= new set<id>();            
                 
               taskIds =[select whoid, whatid from task where  ActivityDate>=:dt1 and ActivityDate<=:dt2 Limit 50000];
               for(integer j=0;j<taskIds.size();j++)
               {
               whoids.add(taskIds[j].whoid);
               }
               
               for(integer k=0;k<taskIds.size();k++)
               {
               whatids.add(taskIds[k].whatid);
               }
               L=[select id from Lead where  CreatedDate>=:dt1 and CreatedDate<=:dt2 and Division_name__c='Winners' and isConverted=false and id NOT IN :whoids Limit 50000];
               O=[select id from Opportunity where  CreatedDate>=:dt1 and CreatedDate<=:dt2 and Division__c='Winners' and id NOT IN :whatIds Limit 50000];
              //--------------------------------- 
                EventIds =[select whoid, whatid from Event where  ActivityDate>=:dt1 and ActivityDate<=:dt2 Limit 50000];
               for(integer r=0;r<EventIds.size();r++)
               {
               whoidsE.add(EventIds[r].whoid);
               }
               
               for(integer m=0;m<EventIds.size();m++)
               {
               whatidsE.add(EventIds[m].whatid);
               }
               L1=[select id from Lead where  CreatedDate>=:dt1 and CreatedDate<=:dt2 and Division_name__c='Winners' and isConverted=false and id NOT IN :whoidsE Limit 50000];
               O1=[select id from Opportunity where  CreatedDate>=:dt1 and CreatedDate<=:dt2 and Division__c='Winners' and id NOT IN :whatIdsE Limit 50000];
              
              if(L.size()<L1.size())
              L2.addAll(L);
              else
              L2.addAll(L1);
              
              if(O.size()<O1.size())
              O2.addAll(O);
              else
              O2.addAll(O1);
                 
                 for(integer p =0; p<L2.size();p++)
                 {
                 Leads.add(L2[p].id);
                 }
                 for(integer q =0; q<O2.size();q++)
                 {
                 Opps.add(O2[q].id);
                 }
              
               WFollowups=Leads.size()+ Opps.size();
                return WFollowups;
             }
             
             
              public integer getWinnerSampleReq(){
              
              /*List<Lead> SIds = new List<Lead>();
              Sids=[select id from Lead where  Division_name__c='Winners' and isConverted=false Limit 50000];
               
               List<Opportunity> OIds = new List<Opportunity>();
              Oids=[select id from Opportunity where  Division__c='Winners' Limit 50000];  *//*
               
               WSampleReq=[select count() from Sample_request__c where  CreatedDate>=:dt1 and CreatedDate<=:dt2 and (Lead_Divison__c='Winners' OR Opportunity_Division__c='Winners') Limit 50000];
              
                return WSampleReq;
             }
             
             
             public integer getWinnerSampleDeal(){
                           
               set<Id> SIds = new set<Id>();
               Sample_request__c[]  s=[select id,Opportunity__c,Lead__r.ConvertedOpportunityId from Sample_request__c where Opportunity_Division__c='Winners' and Opportunity__c!=null  Limit 50000];
               for(integer i=0;i<s.size();i++)
               {
               Sids.add(s[i].Opportunity__C);
               }
               
             /*  for(integer j=0;j<s.size();j++)
               {
               Sids.add(s[j].Lead__r.ConvertedOpportunityId);
               }
               *//*
               
              WSampleDeal =[select count() from Opportunity where StageName='Deal' and CloseDate>=:dt1 and Closedate<=:dt2 and Division__c='Winners' and ID IN:SIds Limit 50000];  
              
                return WSampleDeal;
             }
             
              public double getWinnerSampleConv(){
                if(WSampleDeal== 0 || WSampleReq== 0)
              return 0;
              else
              return  (((decimal.valueof(WSampleDeal))*100)/(decimal.valueof(WSampleReq)));       
             }
             
             
             //------------------------------------------------------*******************INDIANS********----------------------------------------------------
             
             
             public double getIndiansAssignConv(){
             
              ILeads1=[select count() from Lead where  Division_name__c='Indians' and  CreatedDate>=:dt1 and CreatedDate<=:dt2 and isConverted=false and (Team_Identification__c='LeadGen' OR Team_Identification__c='Campaign') and (LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead') Limit 50000];
                Iopps1=[select count() from Opportunity where  Division__c='Indians' and  CreatedDate>=:dt1 and CreatedDate<=:dt2 and (LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead') Limit 50000];
                IAssignLeads=wLeads1+wOpps1;
             IDealAssigned=[select count() from Opportunity where  Division__c='Indians' and CloseDate>=:dt1 and Closedate<=:dt2 and StageName='Deal' and (LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead') Limit 50000];
                if(IDealAssigned== 0 || IAssignLeads== 0)
              return 0;
              else
             return (((decimal.valueof(IDealAssigned))*100)/(decimal.valueof(IAssignLeads)));   
             }
             
              public decimal getIndiansSelfGenConv(){
               Iopps2=[select count() from Opportunity where Division__c='Indians' and  CreatedDate>=:dt1 and CreatedDate<=:dt2 Limit 50000];  
               ILeads2=[select count() from Lead where  Division_name__c='Indians' and  CreatedDate>=:dt1 and CreatedDate<=:dt2 and isConverted=false Limit 50000];
              ISelfGenLeads=  Iopps2+Ileads2-IAssignLeads;
              
              IDealSelf= IDealAssigned=[select count() from Opportunity where  Division__c='Indians' and CloseDate>=:dt1 and Closedate<=:dt2 and StageName='Deal' and (NOT(LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead')) Limit 50000];
                if(IDealSelf== 0 || WSelfGenLeads== 0)
                {return 0;}
              else
                {
                return (((decimal.valueof(IDealSelf))*100)/(decimal.valueof(ISelfGenLeads)));   
                }
             }
             
             public integer getIndiansFollowups(){
               List<Lead> L= new List<Lead>();
                List<Lead> L1= new List<Lead>();
                List<Lead> L2= new List<Lead>();
                List<Opportunity> O= new List<Opportunity>();
                List<Opportunity> O1= new List<Opportunity>();
                 List<Opportunity> O2= new List<Opportunity>();
               List<Task> taskIds = new List<Task>();
               List<Event> EventIds= new List<Event>();
                 Set<id> whoids = new set<id>(); 
                 Set<id> whatids = new set<id>();   
                  Set<id> whoidsE = new set<id>(); 
                 Set<id> whatidsE = new set<id>();    
                  Set<id> Leads= new set<id>();    
                   Set<id> Opps= new set<id>();            
                 
               taskIds =[select whoid, whatid from task where  ActivityDate>=:dt1 and ActivityDate<=:dt2 Limit 50000];
               for(integer j=0;j<taskIds.size();j++)
               {
               whoids.add(taskIds[j].whoid);
               }
               
               for(integer k=0;k<taskIds.size();k++)
               {
               whatids.add(taskIds[k].whatid);
               }
               L=[select id from Lead where  CreatedDate>=:dt1 and CreatedDate<=:dt2 and Division_name__c='Indians' and isConverted=false and id NOT IN :whoids Limit 50000];
               O=[select id from Opportunity where  CreatedDate>=:dt1 and CreatedDate<=:dt2 and Division__c='Indians' and id NOT IN :whatIds Limit 50000];
              //--------------------------------- 
                EventIds =[select whoid, whatid from Event where  ActivityDate>=:dt1 and ActivityDate<=:dt2 Limit 50000];
               for(integer r=0;r<EventIds.size();r++)
               {
               whoidsE.add(EventIds[r].whoid);
               }
               
               for(integer m=0;m<EventIds.size();m++)
               {
               whatidsE.add(EventIds[m].whatid);
               }
               L1=[select id from Lead where  CreatedDate>=:dt1 and CreatedDate<=:dt2 and Division_name__c='Indians' and isConverted=false and id NOT IN :whoidsE Limit 50000];
               O1=[select id from Opportunity where  CreatedDate>=:dt1 and CreatedDate<=:dt2 and Division__c='Indians' and id NOT IN :whatIdsE Limit 50000];
              
              if(L.size()<L1.size())
              L2.addAll(L);
              else
              L2.addAll(L1);
              
              if(O.size()<O1.size())
              O2.addAll(O);
              else
              O2.addAll(O1);
                 
                 for(integer p =0; p<L2.size();p++)
                 {
                 Leads.add(L2[p].id);
                 }
                 for(integer q =0; q<O2.size();q++)
                 {
                 Opps.add(O2[q].id);
                 }
              
               IFollowups=Leads.size()+ Opps.size();
                return IFollowups;
             }
             
             
              public integer getIndiansSampleReq(){
             /* List<Lead> SIds = new List<Lead>();
              Sids=[select id from Lead where  Division_name__c='Indians' and isConverted=false Limit 50000];
               
               List<Opportunity> OIds = new List<Opportunity>();
              Oids=[select id from Opportunity where  Division__c='Indians' Limit 50000];  *//*
               
               ISampleReq=[select count() from Sample_request__c where  CreatedDate>=:dt1 and CreatedDate<=:dt2 and (Lead_Divison__c='Indians' OR Opportunity_Division__c='Indians') Limit 50000];
              
                return ISampleReq;
             }
             
             
             public integer getIndiansSampleDeal(){
                           
               set<Id> SIds = new set<Id>();
               Sample_request__c[]  s=[select id,Opportunity__c,Lead__r.ConvertedOpportunityId from Sample_request__c where Opportunity_Division__c='Indians' and Opportunity__c!=null Limit 50000];
               for(integer i=0;i<s.size();i++)
               {
               Sids.add(s[i].Opportunity__C);
               }
               
              /* for(integer j=0;j<s.size();j++)
               {
               Sids.add(s[j].Lead__r.ConvertedOpportunityId);
               }
               *//*
               
              ISampleDeal =[select count() from Opportunity where StageName='Deal' and CloseDate>=:dt1 and Closedate<=:dt2 and Division__c='Indians' and ID IN:SIds Limit 50000];  
              
                return ISampleDeal;
             }
             
              public double getIndiansSampleConv(){
                if(ISampleDeal== 0 || ISampleReq== 0)
              return 0;
              else
              return  (((decimal.valueof(ISampleDeal))*100)/(decimal.valueof(ISampleReq)));       
             }
              
        //------------------------------------------------------*******************MAURYAS********----------------------------------------------------
        
             
             public double getMauryasAssignConv(){
              MLeads1=[select count() from Lead where  Division_name__c='Mauryas' and  CreatedDate>=:dt1 and CreatedDate<=:dt2 and isConverted=false and (Team_Identification__c='LeadGen' OR Team_Identification__c='Campaign') and (LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead') Limit 50000];
                Mopps1=[select count() from Opportunity where  Division__c='Mauryas' and  CreatedDate>=:dt1 and CreatedDate<=:dt2 and (LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead') Limit 50000];
                MAssignLeads=MLeads1+MOpps1;
             MDealAssigned=[select count() from Opportunity where  Division__c='Mauryas' and CloseDate>=:dt1 and Closedate<=:dt2 and StageName='Deal' and (LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead') Limit 50000];
                if(MDealAssigned== 0 || MAssignLeads== 0)
              return 0;
              else
             return (((decimal.valueof(MDealAssigned))*100)/(decimal.valueof(MAssignLeads)));   
             }
             
              
              public decimal getMauryasSelfGenConv(){
               Mopps2=[select count() from Opportunity where Division__c='Mauryas' and  CreatedDate>=:dt1 and CreatedDate<=:dt2 Limit 50000];  
               MLeads2=[select count() from Lead where  Division_name__c='Mauryas' and  CreatedDate>=:dt1 and CreatedDate<=:dt2 and isConverted=false Limit 50000];
              MSelfGenLeads=  Mopps2+Mleads2-MAssignLeads;
              MDealSelf= MDealAssigned=[select count() from Opportunity where  Division__c='Mauryas' and CloseDate>=:dt1 and Closedate<=:dt2 and StageName='Deal' and (NOT(LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead')) Limit 50000];
                if(MDealSelf== 0 || MSelfGenLeads== 0)
                {return 0;}
              else
                {
                return (((decimal.valueof(MDealSelf))*100)/(decimal.valueof(MSelfGenLeads)));   
                }
             }
             
             public integer getMauryasFollowups(){
               List<Lead> L= new List<Lead>();
                List<Lead> L1= new List<Lead>();
                List<Lead> L2= new List<Lead>();
                List<Opportunity> O= new List<Opportunity>();
                List<Opportunity> O1= new List<Opportunity>();
                 List<Opportunity> O2= new List<Opportunity>();
               List<Task> taskIds = new List<Task>();
               List<Event> EventIds= new List<Event>();
                 Set<id> whoids = new set<id>(); 
                 Set<id> whatids = new set<id>();   
                  Set<id> whoidsE = new set<id>(); 
                 Set<id> whatidsE = new set<id>();    
                  Set<id> Leads= new set<id>();    
                   Set<id> Opps= new set<id>();            
                 
               taskIds =[select whoid, whatid from task where  ActivityDate>=:dt1 and ActivityDate<=:dt2 Limit 50000];
               for(integer j=0;j<taskIds.size();j++)
               {
               whoids.add(taskIds[j].whoid);
               }
               
               for(integer k=0;k<taskIds.size();k++)
               {
               whatids.add(taskIds[k].whatid);
               }
               L=[select id from Lead where  CreatedDate>=:dt1 and CreatedDate<=:dt2 and Division_name__c='Mauryas' and isConverted=false and id NOT IN :whoids Limit 50000];
               O=[select id from Opportunity where  CreatedDate>=:dt1 and CreatedDate<=:dt2 and Division__c='Mauryas' and id NOT IN :whatIds Limit 50000];
              //--------------------------------- 
                EventIds =[select whoid, whatid from Event where  ActivityDate>=:dt1 and ActivityDate<=:dt2 Limit 50000];
               for(integer r=0;r<EventIds.size();r++)
               {
               whoidsE.add(EventIds[r].whoid);
               }
               
               for(integer m=0;m<EventIds.size();m++)
               {
               whatidsE.add(EventIds[m].whatid);
               }
               L1=[select id from Lead where  CreatedDate>=:dt1 and CreatedDate<=:dt2 and Division_name__c='Mauryas' and isConverted=false and id NOT IN :whoidsE Limit 50000];
               O1=[select id from Opportunity where  CreatedDate>=:dt1 and CreatedDate<=:dt2 and Division__c='Mauryas' and id NOT IN :whatIdsE Limit 50000];
              
              if(L.size()<L1.size())
              L2.addAll(L);
              else
              L2.addAll(L1);
              
              if(O.size()<O1.size())
              O2.addAll(O);
              else
              O2.addAll(O1);
                 
                 for(integer p =0; p<L2.size();p++)
                 {
                 Leads.add(L2[p].id);
                 }
                 for(integer q =0; q<O2.size();q++)
                 {
                 Opps.add(O2[q].id);
                 }
              
               MFollowups=Leads.size()+ Opps.size();
                return MFollowups;
             }
             
             
              public integer getMauryasSampleReq(){
              /*List<Lead> SIds = new List<Lead>();
              Sids=[select id from Lead where  Division_name__c='Mauryas' and isCOnverted=false Limit 50000];
               
               List<Opportunity> OIds = new List<Opportunity>();
              Oids=[select id from Opportunity where  Division__c='Mauryas' Limit 50000]; *//* 
               
               MSampleReq=[select count() from Sample_request__c where  CreatedDate>=:dt1 and CreatedDate<=:dt2 and (Lead_Divison__c='Mauryas' OR Opportunity_Division__c='Mauryas') Limit 50000];
              
                return MSampleReq;
             }
             
             
             public integer getMauryasSampleDeal(){
                           
               set<Id> SIds = new set<Id>();
               Sample_request__c[]  s=[select id,Opportunity__c,Lead__r.ConvertedOpportunityId from Sample_request__c where Opportunity_Division__c='Mauryas' and Opportunity__c!=null Limit 50000];
               for(integer i=0;i<s.size();i++)
               {
               Sids.add(s[i].Opportunity__C);
               }
               
              /* for(integer j=0;j<s.size();j++)
               {
               Sids.add(s[j].Lead__r.ConvertedOpportunityId);
               }*//*
               
                MSampleDeal =[select count() from Opportunity where StageName='Deal' and CloseDate>=:dt1 and Closedate<=:dt2 and Division__c='Mauryas' and ID IN:SIds Limit 50000];  
              
                return WSampleDeal;
             }
             
              public double getMauryasSampleConv(){
                if(MSampleDeal== 0 || MSampleReq== 0)
              return 0;
              else
              return  (((decimal.valueof(MSampleDeal))*100)/(decimal.valueof(MSampleReq)));       
             }
             
     //------------------------------------------------------*******************TITANS********----------------------------------------------------         
        
             
             public double getTitansAssignConv(){
             
              TLeads1=[select count() from Lead where  Division_name__c='Titans' and  CreatedDate>=:dt1 and CreatedDate<=:dt2 and isConverted=false and (Team_Identification__c='LeadGen' OR Team_Identification__c='Campaign') and (LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead') Limit 50000];
                Topps1=[select count() from Opportunity where  Division__c='Titans' and  CreatedDate>=:dt1 and CreatedDate<=:dt2 and (LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead') Limit 50000];
                TAssignLeads=TLeads1+TOpps1;
             TDealAssigned=[select count() from Opportunity where  Division__c='Titans' and CloseDate>=:dt1 and Closedate<=:dt2 and StageName='Deal' and (LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead') Limit 50000];
                if(TDealAssigned== 0 || TAssignLeads== 0)
              return 0;
              else
             return (((decimal.valueof(TDealAssigned))*100)/(decimal.valueof(TAssignLeads)));   
             }
             
              public decimal getTitanselfGenConv(){
               Topps2=[select count() from Opportunity where Division__c='Titans' and  CreatedDate>=:dt1 and CreatedDate<=:dt2 Limit 50000];  
               TLeads2=[select count() from Lead where  Division_name__c='Titans' and  CreatedDate>=:dt1 and CreatedDate<=:dt2 and isConverted=false Limit 50000];
              TSelfGenLeads=  Topps2+Tleads2-TAssignLeads;
              TDealSelf= TDealAssigned=[select count() from Opportunity where  Division__c='Titans' and CloseDate>=:dt1 and Closedate<=:dt2 and StageName='Deal' and (NOT(LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead')) Limit 50000];
                if(TDealSelf== 0 || TSelfGenLeads== 0)
                {return 0;}
              else
                {
                return (((decimal.valueof(TDealSelf))*100)/(decimal.valueof(TSelfGenLeads)));   
                }
             }
             
             public integer getTitansFollowups(){
               List<Lead> L= new List<Lead>();
                List<Lead> L1= new List<Lead>();
                List<Lead> L2= new List<Lead>();
                List<Opportunity> O= new List<Opportunity>();
                List<Opportunity> O1= new List<Opportunity>();
                 List<Opportunity> O2= new List<Opportunity>();
               List<Task> taskIds = new List<Task>();
               List<Event> EventIds= new List<Event>();
                 Set<id> whoids = new set<id>(); 
                 Set<id> whatids = new set<id>();   
                  Set<id> whoidsE = new set<id>(); 
                 Set<id> whatidsE = new set<id>();    
                  Set<id> Leads= new set<id>();    
                   Set<id> Opps= new set<id>();            
                 
               taskIds =[select whoid, whatid from task where  ActivityDate>=:dt1 and ActivityDate<=:dt2 Limit 50000];
               for(integer j=0;j<taskIds.size();j++)
               {
               whoids.add(taskIds[j].whoid);
               }
               
               for(integer k=0;k<taskIds.size();k++)
               {
               whatids.add(taskIds[k].whatid);
               }
               L=[select id from Lead where  CreatedDate>=:dt1 and CreatedDate<=:dt2 and Division_name__c='Titans' and isConverted=false and id NOT IN :whoids Limit 50000];
               O=[select id from Opportunity where  CreatedDate>=:dt1 and CreatedDate<=:dt2 and Division__c='Titans' and id NOT IN :whatIds Limit 50000];
              //--------------------------------- 
                EventIds =[select whoid, whatid from Event where  ActivityDate>=:dt1 and ActivityDate<=:dt2 Limit 50000];
               for(integer r=0;r<EventIds.size();r++)
               {
               whoidsE.add(EventIds[r].whoid);
               }
               
               for(integer m=0;m<EventIds.size();m++)
               {
               whatidsE.add(EventIds[m].whatid);
               }
               L1=[select id from Lead where  CreatedDate>=:dt1 and CreatedDate<=:dt2 and Division_name__c='Titans' and isConverted=false and id NOT IN :whoidsE Limit 50000];
               O1=[select id from Opportunity where  CreatedDate>=:dt1 and CreatedDate<=:dt2 and Division__c='Titans' and id NOT IN :whatIdsE Limit 50000];
              
              if(L.size()<L1.size())
              L2.addAll(L);
              else
              L2.addAll(L1);
              
              if(O.size()<O1.size())
              O2.addAll(O);
              else
              O2.addAll(O1);
                 
                 for(integer p =0; p<L2.size();p++)
                 {
                 Leads.add(L2[p].id);
                 }
                 for(integer q =0; q<O2.size();q++)
                 {
                 Opps.add(O2[q].id);
                 }
              
               TFollowups=Leads.size()+ Opps.size();
                return TFollowups;
             }
             
             
              public integer getTitansampleReq(){
             /* List<Lead> SIds = new List<Lead>();
              Sids=[select id from Lead where  Division_name__c='Titans' and isCOnverted=false Limit 50000];
               
               List<Opportunity> OIds = new List<Opportunity>();
              Oids=[select id from Opportunity where  Division__c='Titans' Limit 50000];  *//*
               
               TSampleReq=[select count() from Sample_request__c where  CreatedDate>=:dt1 and CreatedDate<=:dt2 and (Lead_Divison__c='Mauryas' OR Opportunity_Division__c='Mauryas') Limit 50000];
              
                return TSampleReq;
             }
             
             
             public integer getTitansampleDeal(){
                           
               set<Id> SIds = new set<Id>();
               Sample_request__c[]  s=[select id,Opportunity__c,Lead__r.ConvertedOpportunityId from Sample_request__c where Opportunity_Division__c='Mauryas' and Opportunity__c!=null Limit 50000];
               for(integer i=0;i<s.size();i++)
               {
               Sids.add(s[i].Opportunity__C);
               }
               
             /*  for(integer j=0;j<s.size();j++)
               {
               Sids.add(s[j].Lead__r.ConvertedOpportunityId);
               }
               *//*
               
              TSampleDeal =[select count() from Opportunity where StageName='Deal' and CloseDate>=:dt1 and Closedate<=:dt2 and Division__c='Titans' and ID IN:SIds Limit 50000];  
              
                return TSampleDeal;
             }
             
              public double getTitansampleConv(){
                if(TSampleDeal== 0 || TSampleReq== 0)
              return 0;
              else
              return  (((decimal.valueof(TSampleDeal))*100)/(decimal.valueof(TSampleReq)));       
             }
             

             
             //------------------------------------------------------*******************RAINMAKERS********----------------------------------------------------         
             
          
             
             public double getRainmakersAssignConv(){
              RLeads1=[select count() from Lead where  Division_name__c='Rainmakers' and  CreatedDate>=:dt1 and CreatedDate<=:dt2 and isConverted=false and (Team_Identification__c='LeadGen' OR Team_Identification__c='Campaign') and (LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead') Limit 50000];
                Ropps1=[select count() from Opportunity where  Division__c='Rainmakers' and  CreatedDate>=:dt1 and CreatedDate<=:dt2 and (LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead') Limit 50000];
                RAssignLeads=RLeads1+ROpps1;
             
             RDealAssigned=[select count() from Opportunity where  Division__c='Rainmakers' and CloseDate>=:dt1 and Closedate<=:dt2 and StageName='Deal' and (LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead') Limit 50000];
                if(RDealAssigned== 0 || RAssignLeads== 0)
              return 0;
              else
             return (((decimal.valueof(RDealAssigned))*100)/(decimal.valueof(RAssignLeads)));   
             }
             
              public decimal getRainmakerselfGenConv(){
              
               Ropps2=[select count() from Opportunity where Division__c='Rainmakers' and  CreatedDate>=:dt1 and CreatedDate<=:dt2 Limit 50000];  
               RLeads2=[select count() from Lead where  Division_name__c='Rainmakers' and  CreatedDate>=:dt1 and CreatedDate<=:dt2 and isConverted=false Limit 50000];
              RSelfGenLeads=  Ropps2+Rleads2-RAssignLeads;
              RDealSelf= [select count() from Opportunity where  Division__c='Rainmakers' and CloseDate>=:dt1 and Closedate<=:dt2 and StageName='Deal' and (NOT(LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead')) Limit 50000];
                if(RDealSelf== 0 || RSelfGenLeads== 0)
                {return 0;}
              else
                {
                return (((decimal.valueof(RDealSelf))*100)/(decimal.valueof(RSelfGenLeads)));   
                }
             }
             
             public integer getRainmakersFollowups(){
               List<Lead> L= new List<Lead>();
                List<Lead> L1= new List<Lead>();
                List<Lead> L2= new List<Lead>();
                List<Opportunity> O= new List<Opportunity>();
                List<Opportunity> O1= new List<Opportunity>();
                 List<Opportunity> O2= new List<Opportunity>();
               List<Task> taskIds = new List<Task>();
               List<Event> EventIds= new List<Event>();
                 Set<id> whoids = new set<id>(); 
                 Set<id> whatids = new set<id>();   
                  Set<id> whoidsE = new set<id>(); 
                 Set<id> whatidsE = new set<id>();    
                  Set<id> Leads= new set<id>();    
                   Set<id> Opps= new set<id>();            
                 
               taskIds =[select whoid, whatid from task where  ActivityDate>=:dt1 and ActivityDate<=:dt2 Limit 50000];
               for(integer j=0;j<taskIds.size();j++)
               {
               whoids.add(taskIds[j].whoid);
               }
               
               for(integer k=0;k<taskIds.size();k++)
               {
               whatids.add(taskIds[k].whatid);
               }
               L=[select id from Lead where  CreatedDate>=:dt1 and CreatedDate<=:dt2 and Division_name__c='Rainmakers' and isConverted=false and id NOT IN :whoids Limit 50000];
               O=[select id from Opportunity where  CreatedDate>=:dt1 and CreatedDate<=:dt2 and Division__c='Rainmakers' and id NOT IN :whatIds Limit 50000];
              //--------------------------------- 
                EventIds =[select whoid, whatid from Event where  CreatedDate>=:dt1 and CreatedDate<=:dt2 Limit 50000];
               for(integer r=0;r<EventIds.size();r++)
               {
               whoidsE.add(EventIds[r].whoid);
               }
               
               for(integer m=0;m<EventIds.size();m++)
               {
               whatidsE.add(EventIds[m].whatid);
               }
               L1=[select id from Lead where  CreatedDate>=:dt1 and CreatedDate<=:dt2 and Division_name__c='Rainmakers' and isConverted=false and id NOT IN :whoidsE Limit 50000];
               O1=[select id from Opportunity where  CreatedDate>=:dt1 and CreatedDate<=:dt2 and Division__c='Rainmakers' and id NOT IN :whatIdsE Limit 50000];
              
              if(L.size()<L1.size())
              L2.addAll(L);
              else
              L2.addAll(L1);
              
              if(O.size()<O1.size())
              O2.addAll(O);
              else
              O2.addAll(O1);
                 
                 for(integer p =0; p<L2.size();p++)
                 {
                 Leads.add(L2[p].id);
                 }
                 for(integer q =0; q<O2.size();q++)
                 {
                 Opps.add(O2[q].id);
                 }
              
               RFollowups=Leads.size()+ Opps.size();
                return RFollowups;
             }
             
             
              public integer getRainmakersampleReq(){
             /* List<Lead> SIds = new List<Lead>();
              Sids=[select id from Lead where  Division_name__c='Rainmakers' and isCOnverted=false Limit 50000];
               
               List<Opportunity> OIds = new List<Opportunity>();
              Oids=[select id from Opportunity where  Division__c='Rainmakers' Limit 50000];  *//*
               
               RSampleReq=[select count() from Sample_request__c where  CreatedDate>=:dt1 and CreatedDate<=:dt2 and (Lead_Divison__c='Rainmakers' OR Opportunity_Division__c='Rainmakers') Limit 50000];
              
                return RSampleReq;
             }
             
             
             public integer getRainmakersampleDeal(){
                           
               set<Id> SIds = new set<Id>();
               Sample_request__c[]  s=[select id,Opportunity__c,Lead__r.ConvertedOpportunityId from Sample_request__c where Opportunity_Division__c='Rainmakers' and Opportunity__c!=null Limit 50000];
               for(integer i=0;i<s.size();i++)
               {
               Sids.add(s[i].Opportunity__C);
               }
               
            /*   for(integer j=0;j<s.size();j++)
               {
               Sids.add(s[j].Lead__r.ConvertedOpportunityId);
               }*//*
               
              RSampleDeal =[select count() from Opportunity where StageName='Deal' and CloseDate>=:dt1 and Closedate<=:dt2 and Division__c='Rainmakers' and ID IN:SIds Limit 50000];  
              
                return RSampleDeal;
             }
             
              public double getRainmakersampleConv(){
                if(RSampleDeal== 0 || RSampleReq== 0)
              return 0;
              else
              return  (((decimal.valueof(RSampleDeal))*100)/(decimal.valueof(RSampleReq)));       
             }
            //-----------------------------------------------------------------------------------------------------------------------------------
                         
*/
}