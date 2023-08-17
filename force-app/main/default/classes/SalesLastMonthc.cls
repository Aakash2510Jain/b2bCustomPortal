Public class SalesLastMonthc{
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
     
    public SalesLastMonthc() { }
     
      
         
         
            //------------------------------******************MAVERICKS***********---------------------------------------------------------- 
             
             
             public double getMavericksAssignConv(){
             
              mvLeads1=[select count() from Lead where  Division_name__c='Mavericks' and CreatedDate=THIS_MONTH and isConverted=false and (Team_Identification__c='LeadGen' OR Team_Identification__c='Campaign') and (LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead')];
                mvopps1=[select count() from Opportunity where  Division__c='Mavericks' and CreatedDate=THIS_MONTH and (LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead')];
                mvAssignLeads=mvLeads1+mvOpps1;
                
             mvDealAssigned=[select count() from Opportunity where  Division__c='Mavericks' and CloseDate=THIS_MONTH and StageName='Deal' and (LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead')];
                if(mvDealAssigned== 0 || mvAssignLeads== 0)
              return 0;
              else
             return (((decimal.valueof(mvDealAssigned))*100)/(decimal.valueof(mvAssignLeads)));   
             }
             
              public decimal getMavericksSelfGenConv(){
              
                mvopps2=[select count() from Opportunity where Division__c='Mavericks' and CreatedDate=THIS_MONTH];  
               mvLeads2=[select count() from Lead where  Division_name__c='Mavericks' and CreatedDate=THIS_MONTH and isConverted=false];
              mvSelfGenLeads=  mvopps2+mvleads2-mvAssignLeads;
              mvDealSelf= IDealAssigned=[select count() from Opportunity where  Division__c='Mavericks' and CloseDate=THIS_MONTH and StageName='Deal' and (NOT(LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead'))];
                if(mvDealSelf== 0 || mvSelfGenLeads== 0)
                {return 0;}
              else
                {
                return (((decimal.valueof(mvDealSelf))*100)/(decimal.valueof(mvSelfGenLeads)));   
                }
             }
             
             public integer getMavericksFollowups(){
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
                 
               taskIds =[select whoid, whatid from task where createdDate=THIS_MONTH];
               for(integer j=0;j<taskIds.size();j++)
               {
               whoids.add(taskIds[j].whoid);
               }
               
               for(integer k=0;k<taskIds.size();k++)
               {
               whatids.add(taskIds[k].whatid);
               }
               L=[select id from Lead where createdDate=THIS_MONTH and Division_name__c='Mavericks' and isConverted=false and id NOT IN :whoids];
               O=[select id from Opportunity where createdDate=THIS_MONTH and Division__c='Mavericks' and id NOT IN :whatIds];
              //--------------------------------- 
                EventIds =[select whoid, whatid from Event where createdDate=THIS_MONTH];
               for(integer r=0;r<EventIds.size();r++)
               {
               whoidsE.add(EventIds[r].whoid);
               }
               
               for(integer m=0;m<EventIds.size();m++)
               {
               whatidsE.add(EventIds[m].whatid);
               }
               L1=[select id from Lead where createdDate=THIS_MONTH and Division_name__c='Mavericks' and isConverted=false and id NOT IN :whoidsE];
               O1=[select id from Opportunity where createdDate=THIS_MONTH and Division__c='Mavericks' and id NOT IN :whatIdsE];
              
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
              
               mvFollowups=Leads.size()+ Opps.size();
                return mvFollowups;
             }
             
             
              public integer getMavericksSampleReq(){
             /* List<Lead> SIds = new List<Lead>();
              Sids=[select id from Lead where  Division_name__c='Mavericks' and isConverted=false];
               
               List<Opportunity> OIds = new List<Opportunity>();
              Oids=[select id from Opportunity where  Division__c='Mavericks'];  *//*
               
               mvSampleReq=[select count() from Sample_request__c where CreatedDate=THIS_MONTH and (Lead_Divison__c='Mavericks' OR Opportunity_Division__c='Mavericks')];
              
                return mvSampleReq;
             }
             
             
             public integer getMavericksSampleDeal(){
                           
               set<Id> SIds = new set<Id>();
               Sample_request__c[]  s=[select id,Opportunity__c,Lead__r.ConvertedOpportunityId from Sample_request__c where Opportunity_Division__c='Mavericks' and Opportunity__c!=null];
               for(integer i=0;i<s.size();i++)
               {
               Sids.add(s[i].Opportunity__C);
               }
               
             /*  for(integer j=0;j<s.size();j++)
               {
               Sids.add(s[j].Lead__r.ConvertedOpportunityId);
               }
               *//*
              mvSampleDeal =[select count() from Opportunity where StageName='Deal' and CloseDate=THIS_MONTH and Division__c='Mavericks' and ID IN:SIds];  
              
                return mvSampleDeal;
             }
             
              public double getMavericksSampleConv(){
                if(mvSampleDeal== 0 || mvSampleReq== 0)
              return 0;
              else
              return  (((decimal.valueof(mvSampleDeal))*100)/(decimal.valueof(mvSampleReq)));       
             }
             
      //------------------------------******************JAguars***********----------------------------------------------------------        
             
        
             
             public double getJaguarsAssignConv(){
             
              jLeads1=[select count() from Lead where  Division_name__c='Jaguars' and CreatedDate=THIS_MONTH and isConverted=false and (Team_Identification__c='LeadGen' OR Team_Identification__c='Campaign') and (LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead')];
                jopps1=[select count() from Opportunity where  Division__c='Jaguars' and CreatedDate=THIS_MONTH and (LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead')];
                jAssignLeads=jLeads1+jOpps1;
             jDealAssigned=[select count() from Opportunity where  Division__c='Jaguars' and CloseDate=THIS_MONTH and StageName='Deal' and (LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead')];
                if(jDealAssigned== 0 || jAssignLeads== 0)
              return 0;
              else
             return (((decimal.valueof(jDealAssigned))*100)/(decimal.valueof(jAssignLeads)));   
             }
             
              public decimal getJaguarsSelfGenConv(){
              
               jopps2=[select count() from Opportunity where Division__c='Jaguars' and CreatedDate=THIS_MONTH];  
               jLeads2=[select count() from Lead where  Division_name__c='Jaguars' and CreatedDate=THIS_MONTH and isConverted=false];
              jSelfGenLeads=  jopps2+jleads2-jAssignLeads;
              jDealSelf= IDealAssigned=[select count() from Opportunity where  Division__c='Jaguars' and CloseDate=THIS_MONTH and StageName='Deal' and (NOT(LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead'))];
                if(jDealSelf== 0 || jSelfGenLeads== 0)
                {return 0;}
              else
                {
                return (((decimal.valueof(jDealSelf))*100)/(decimal.valueof(jSelfGenLeads)));   
                }
             }
             
             public integer getJaguarsFollowups(){
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
                 
               taskIds =[select whoid, whatid from task where createdDate=THIS_MONTH];
               for(integer j=0;j<taskIds.size();j++)
               {
               whoids.add(taskIds[j].whoid);
               }
               
               for(integer k=0;k<taskIds.size();k++)
               {
               whatids.add(taskIds[k].whatid);
               }
               L=[select id from Lead where createdDate=THIS_MONTH and Division_name__c='Jaguars' and isConverted=false and id NOT IN :whoids];
               O=[select id from Opportunity where createdDate=THIS_MONTH and Division__c='Jaguars' and id NOT IN :whatIds];
              //--------------------------------- 
                EventIds =[select whoid, whatid from Event where createdDate=THIS_MONTH];
               for(integer r=0;r<EventIds.size();r++)
               {
               whoidsE.add(EventIds[r].whoid);
               }
               
               for(integer m=0;m<EventIds.size();m++)
               {
               whatidsE.add(EventIds[m].whatid);
               }
               L1=[select id from Lead where createdDate=THIS_MONTH and Division_name__c='Jaguars' and isConverted=false and id NOT IN :whoidsE];
               O1=[select id from Opportunity where createdDate=THIS_MONTH and Division__c='Jaguars' and id NOT IN :whatIdsE];
              
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
              
               jFollowups=Leads.size()+ Opps.size();
                return jFollowups;
             }
             
             
              public integer getJaguarsSampleReq(){
            /*  List<Lead> SIds = new List<Lead>();
              Sids=[select id from Lead where  Division_name__c='Jaguars' and isConverted=false];
               
               List<Opportunity> OIds = new List<Opportunity>();
              Oids=[select id from Opportunity where  Division__c='Jaguars'];  *//*
               
               jSampleReq=[select count() from Sample_request__c where CreatedDate=THIS_MONTH and (Lead_Divison__c='Jaguars' OR Opportunity_Division__c='Jaguars')];
              
                return jSampleReq;
             }
             
             
             public integer getJaguarsSampleDeal(){
                           
               set<Id> SIds = new set<Id>();
               Sample_request__c[]  s=[select id,Opportunity__c,Lead__r.ConvertedOpportunityId from Sample_request__c where Opportunity_Division__c='Jaguars' and Opportunity__c!=null];
               for(integer i=0;i<s.size();i++)
               {
               Sids.add(s[i].Opportunity__C);
               }
            /*   
               for(integer j=0;j<s.size();j++)
               {
               Sids.add(s[j].Lead__r.ConvertedOpportunityId);
               } *//*
               
              jSampleDeal =[select count() from Opportunity where StageName='Deal' and CloseDate=THIS_MONTH and Division__c='Jaguars' and ID IN:SIds];  
              
                return jSampleDeal;
             }
             
              public double getJaguarsSampleConv(){
                if(jSampleDeal== 0 || jSampleReq== 0)
              return 0;
              else
              return  (((decimal.valueof(jSampleDeal))*100)/(decimal.valueof(jSampleReq)));       
             }
           //  --------------------------------------------------------------------------SPARTANS------------------------------------------------
             
           
             
             public double getSpartansAssignConv(){
             
              SLeads1=[select count() from Lead where  Division_name__c='Spartans' and CreatedDate=THIS_MONTH and isConverted=false and (Team_Identification__c='LeadGen' OR Team_Identification__c='Campaign') and (LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead')];
                Sopps1=[select count() from Opportunity where  Division__c='Spartans' and CreatedDate=THIS_MONTH and (LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead')];
                SAssignLeads=SLeads1+SOpps1;
             SDealAssigned=[select count() from Opportunity where  Division__c='Spartans' and CloseDate=THIS_MONTH and StageName='Deal' and (LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead')];
                if(SDealAssigned== 0 || SAssignLeads== 0)
              return 0;
              else
             return (((decimal.valueof(SDealAssigned))*100)/(decimal.valueof(SAssignLeads)));   
             }
             
              public decimal getSpartanselfGenConv(){
              
               Sopps2=[select count() from Opportunity where Division__c='Spartans' and CreatedDate=THIS_MONTH];  
               SLeads2=[select count() from Lead where  Division_name__c='Spartans' and CreatedDate=THIS_MONTH and isConverted=false];
              SSelfGenLeads=  Sopps2+Sleads2-SAssignLeads;
              SDealSelf= SDealAssigned=[select count() from Opportunity where  Division__c='Spartans' and CloseDate=THIS_MONTH and StageName='Deal' and (NOT(LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead'))];
                if(SDealSelf== 0 || SSelfGenLeads== 0)
                {return 0;}
              else
                {
                return (((decimal.valueof(SDealSelf))*100)/(decimal.valueof(SSelfGenLeads)));   
                }
             }
             
             public integer getSpartansFollowups(){
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
                 
               taskIds =[select whoid, whatid from task where createdDate=THIS_MONTH];
               for(integer j=0;j<taskIds.size();j++)
               {
               whoids.add(taskIds[j].whoid);
               }
               
               for(integer k=0;k<taskIds.size();k++)
               {
               whatids.add(taskIds[k].whatid);
               }
               L=[select id from Lead where createdDate=THIS_MONTH and Division_name__c='Spartans' and isConverted=false and id NOT IN :whoids];
               O=[select id from Opportunity where createdDate=THIS_MONTH and Division__c='Spartans' and id NOT IN :whatIds];
              //--------------------------------- 
                EventIds =[select whoid, whatid from Event where createdDate=THIS_MONTH];
               for(integer r=0;r<EventIds.size();r++)
               {
               whoidsE.add(EventIds[r].whoid);
               }
               
               for(integer m=0;m<EventIds.size();m++)
               {
               whatidsE.add(EventIds[m].whatid);
               }
               L1=[select id from Lead where createdDate=THIS_MONTH and Division_name__c='Spartans' and isConverted=false and id NOT IN :whoidsE];
               O1=[select id from Opportunity where createdDate=THIS_MONTH and Division__c='Spartans' and id NOT IN :whatIdsE];
              
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
              
               SFollowups=Leads.size()+ Opps.size();
                return SFollowups;
             }
             
             
              public integer getSpartansampleReq(){
            /*  List<Lead> SIds = new List<Lead>();
              Sids=[select id from Lead where  Division_name__c='Spartans' and isCOnverted=false];
               
               List<Opportunity> OIds = new List<Opportunity>();
              Oids=[select id from Opportunity where  Division__c='Spartans'];  *//*
               
               SSampleReq=[select count() from Sample_request__c where CreatedDate=THIS_MONTH and (Lead_Divison__c='Spartans' OR Opportunity_Division__c='Spartans')];
              
                return SSampleReq;
             }
             
             
             public integer getSpartansampleDeal(){
                           
               set<Id> SIds = new set<Id>();
               Sample_request__c[]  s=[select id,Opportunity__c,Lead__r.ConvertedOpportunityId from Sample_request__c where Opportunity_Division__c='Spartans' and Opportunity__c!=null];
               for(integer i=0;i<s.size();i++)
               {
               Sids.add(s[i].Opportunity__C);
               }
               
             /*  for(integer j=0;j<s.size();j++)
               {
               Sids.add(s[j].Lead__r.ConvertedOpportunityId);
               }*//*
               
              SSampleDeal =[select count() from Opportunity where StageName='Deal' and CloseDate=THIS_MONTH and Division__c='Spartans' and ID IN:SIds];  
              
                return SSampleDeal;
             }
             
              public double getSpartansampleConv(){
                if(SSampleDeal== 0 || SSampleReq== 0)
              return 0;
              else
              return  (((decimal.valueof(SSampleDeal))*100)/(decimal.valueof(SSampleReq)));       
             }
           //  ----------------------------------------------------------Gladiators---------------------------------------------------------------------
             
           
             public double getGladiatorsAssignConv(){
             
             GLeads1=[select count() from Lead where  Division_name__c='Gladiators (SB)' and CreatedDate=THIS_MONTH and isConverted=false and (Team_Identification__c='LeadGen' OR Team_Identification__c='Campaign') and (LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead')];
                Gopps1=[select count() from Opportunity where  Division__c='Gladiators (SB)' and CreatedDate=THIS_MONTH and (LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead')];
                GAssignLeads=GLeads1+GOpps1;
             GDealAssigned=[select count() from Opportunity where  Division__c='Gladiators (SB)' and CloseDate=THIS_MONTH and StageName='Deal' and (LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead')];
                if(GDealAssigned== 0 || GAssignLeads== 0)
              return 0;
              else
             return (((decimal.valueof(GDealAssigned))*100)/(decimal.valueof(GAssignLeads)));   
             }
             
              public decimal getGladiatorselfGenConv(){
              
               Gopps2=[select count() from Opportunity where Division__c='Gladiators (SB)' and CreatedDate=THIS_MONTH];  
               GLeads2=[select count() from Lead where  Division_name__c='Gladiators (SB)' and CreatedDate=THIS_MONTH and isConverted=false];
              GSelfGenLeads=  Gopps2+Gleads2-GAssignLeads;
              GDealSelf= GDealAssigned=[select count() from Opportunity where  Division__c='Gladiators (SB)' and CloseDate=THIS_MONTH and StageName='Deal' and (NOT(LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead'))];
                if(GDealSelf== 0 || GSelfGenLeads== 0)
                {return 0;}
              else
                {
                return (((decimal.valueof(GDealSelf))*100)/(decimal.valueof(GSelfGenLeads)));   
                }
             }
             
             public integer getGladiatorsFollowups(){
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
                 
               taskIds =[select whoid, whatid from task where createdDate=THIS_MONTH];
               for(integer j=0;j<taskIds.size();j++)
               {
               whoids.add(taskIds[j].whoid);
               }
               
               for(integer k=0;k<taskIds.size();k++)
               {
               whatids.add(taskIds[k].whatid);
               }
               L=[select id from Lead where createdDate=THIS_MONTH and Division_name__c='Gladiators (SB)' and isConverted=false and id NOT IN :whoids];
               O=[select id from Opportunity where createdDate=THIS_MONTH and Division__c='Gladiators (SB)' and id NOT IN :whatIds];
              //--------------------------------- 
                EventIds =[select whoid, whatid from Event where createdDate=THIS_MONTH];
               for(integer r=0;r<EventIds.size();r++)
               {
               whoidsE.add(EventIds[r].whoid);
               }
               
               for(integer m=0;m<EventIds.size();m++)
               {
               whatidsE.add(EventIds[m].whatid);
               }
               L1=[select id from Lead where createdDate=THIS_MONTH and Division_name__c='Gladiators (SB)' and isConverted=false and id NOT IN :whoidsE];
               O1=[select id from Opportunity where createdDate=THIS_MONTH and Division__c='Gladiators (SB)' and id NOT IN :whatIdsE];
              
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
              
               GFollowups=Leads.size()+ Opps.size();
                return GFollowups;
             }
             
             
              public integer getGladiatorsampleReq(){
            /*  List<Lead> SIds = new List<Lead>();
              Sids=[select id from Lead where  Division_name__c='Gladiators' and isCOnverted=false];
               
               List<Opportunity> OIds = new List<Opportunity>();
              Oids=[select id from Opportunity where  Division__c='Gladiators'];  *//*
               
               GSampleReq=[select count() from Sample_request__c where CreatedDate=THIS_MONTH and (Lead_Divison__c='Gladiators (SB)' OR Opportunity_Division__c='Gladiators (SB)')];
              
                return GSampleReq;
             }
             
             
             public integer getGladiatorsampleDeal(){
                           
               set<Id> SIds = new set<Id>();
               Sample_request__c[]  s=[select id,Opportunity__c,Lead__r.ConvertedOpportunityId from Sample_request__c where Opportunity_Division__c='Gladiators (SB)' and Opportunity__c!=null];
               for(integer i=0;i<s.size();i++)
               {
               Sids.add(s[i].Opportunity__C);
               }
               
              /* for(integer j=0;j<s.size();j++)
               {
               Sids.add(s[j].Lead__r.ConvertedOpportunityId);
               }
               *//*
               
              GSampleDeal =[select count() from Opportunity where StageName='Deal' and CloseDate=THIS_MONTH and Division__c='Gladiators (SB)' and ID IN:SIds];  
              
                return GSampleDeal;
             }
             
              public double getGladiatorsampleConv(){
                if(GSampleDeal== 0 || GSampleReq== 0)
              return 0;
              else
              return  (((decimal.valueof(GSampleDeal))*100)/(decimal.valueof(GSampleReq)));       
             }
             
       //-------------------------------------------------------------millionaries----------------------------------
            
             public double getMillionairesAssignConv(){
             
              MILeads1=[select count() from Lead where  Division_name__c='Millionaires' and CreatedDate=THIS_MONTH and isConverted=false and (Team_Identification__c='LeadGen' OR Team_Identification__c='Campaign') and (LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead')];
                MIopps1=[select count() from Opportunity where  Division__c='Millionaires' and CreatedDate=THIS_MONTH and (LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead')];
                MIAssignLeads=MILeads1+MIOpps1;
             MIDealAssigned=[select count() from Opportunity where  Division__c='Millionaires' and CloseDate=THIS_MONTH and StageName='Deal' and (LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead')];
                if(MIDealAssigned== 0 || MIAssignLeads== 0)
              return 0;
              else
             return (((decimal.valueof(MIDealAssigned))*100)/(decimal.valueof(MIAssignLeads)));   
             }
             
              public decimal getMillionaireselfGenConv(){
              
                MIopps2=[select count() from Opportunity where Division__c='Millionaires' and CreatedDate=THIS_MONTH];  
               MILeads2=[select count() from Lead where  Division_name__c='Millionaires' and CreatedDate=THIS_MONTH and isConverted=false];
              MISelfGenLeads=  MIopps2+MIleads2-MIAssignLeads;
              MIDealSelf=[select count() from Opportunity where  Division__c='Millionaires' and CloseDate=THIS_MONTH and StageName='Deal' and (NOT(LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead'))];
                if(MIDealSelf== 0 || MISelfGenLeads== 0)
                {return 0;}
              else
                {
                return (((decimal.valueof(MIDealSelf))*100)/(decimal.valueof(MISelfGenLeads)));   
                }
             }
             
             public integer getMillionairesFollowups(){
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
                 
               taskIds =[select whoid, whatid from task where createdDate=THIS_MONTH];
               for(integer j=0;j<taskIds.size();j++)
               {
               whoids.add(taskIds[j].whoid);
               }
               
               for(integer k=0;k<taskIds.size();k++)
               {
               whatids.add(taskIds[k].whatid);
               }
               L=[select id from Lead where createdDate=THIS_MONTH and Division_name__c='Millionaires' and isConverted=false and id NOT IN :whoids];
               O=[select id from Opportunity where createdDate=THIS_MONTH and Division__c='Millionaires' and id NOT IN :whatIds];
              //--------------------------------- 
                EventIds =[select whoid, whatid from Event where createdDate=THIS_MONTH];
               for(integer r=0;r<EventIds.size();r++)
               {
               whoidsE.add(EventIds[r].whoid);
               }
               
               for(integer m=0;m<EventIds.size();m++)
               {
               whatidsE.add(EventIds[m].whatid);
               }
               L1=[select id from Lead where createdDate=THIS_MONTH and Division_name__c='Millionaires' and isConverted=false and id NOT IN :whoidsE];
               O1=[select id from Opportunity where createdDate=THIS_MONTH and Division__c='Millionaires' and id NOT IN :whatIdsE];
              
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
              
               MIFollowups=Leads.size()+ Opps.size();
                return MIFollowups;
             }
             
             
              public integer getMillionairesampleReq(){
            /*  List<Lead> SIds = new List<Lead>();
              Sids=[select id from Lead where  Division_name__c='Millionaires' and isCOnverted=false];
               
               List<Opportunity> OIds = new List<Opportunity>();
              Oids=[select id from Opportunity where  Division__c='Millionaires'];  *//*
               
               MISampleReq=[select count() from Sample_request__c where CreatedDate=THIS_MONTH and (Lead_Divison__c='Millionaires' OR Opportunity_Division__c='Millionaires')];
              
                return MISampleReq;
             }
             
             
             public integer getMillionairesampleDeal(){
                           
               set<Id> SIds = new set<Id>();
               Sample_request__c[]  s=[select id,Opportunity__c,Lead__r.ConvertedOpportunityId from Sample_request__c where Opportunity_Division__c='Millionaires' and Opportunity__c!=null];
               for(integer i=0;i<s.size();i++)
               {
               Sids.add(s[i].Opportunity__C);
               }
               
             /*  for(integer j=0;j<s.size();j++)
               {
               Sids.add(s[j].Lead__r.ConvertedOpportunityId);
               }
               *//*
              MISampleDeal =[select count() from Opportunity where StageName='Deal' and CloseDate=THIS_MONTH and Division__c='Millionaires' and ID IN:SIds];  
              
                return MISampleDeal;
             }
             
              public double getMillionairesampleConv(){
                if(MISampleDeal== 0 || MISampleReq== 0)
              return 0;
              else
              return  (((decimal.valueof(MISampleDeal))*100)/(decimal.valueof(MISampleReq)));       
             }

            //--------------------------totals-----------------------------------------------------------------------------------------
           
             
             public double getTotalsAssignConv(){
             
             
              TOLeads1=[select count() from Lead where CreatedDate=THIS_MONTH and isConverted=false and (Team_Identification__c='LeadGen' OR Team_Identification__c='Campaign') and (LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead')];
                TOopps1=[select count() from Opportunity where CreatedDate=THIS_MONTH and (LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead')];
                TOAssignLeads=TOLeads1+TOOpps1;
             TODealAssigned=[select count() from Opportunity where CloseDate=THIS_MONTH and StageName='Deal' and (LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead')];
                if(TODealAssigned== 0 || TOAssignLeads== 0)
              return 0;
              else
             return (((decimal.valueof(TODealAssigned))*100)/(decimal.valueof(TOAssignLeads)));   
             }
             
              public decimal getTotalselfGenConv(){
              
               TOopps2=[select count() from Opportunity where CreatedDate=THIS_MONTH];  
               TOLeads2=[select count() from Lead where CreatedDate=THIS_MONTH and isConverted=false];
              TOSelfGenLeads=  TOopps2+TOleads2-TOAssignLeads;
              TODealSelf=[select count() from Opportunity where CloseDate=THIS_MONTH and StageName='Deal' and (NOT(LeadSource='Web Site Lead' OR LeadSource='Campaign Website' OR LeadSource='PPC Lead' OR LeadSource='Prospecting Website' OR LeadSource='SEO Leads' OR LeadSource='Blog Lead' OR LeadSource='White Paper Lead'))];
                if(TODealSelf== 0 || TOSelfGenLeads== 0)
                {return 0;}
              else
                {
                return (((decimal.valueof(TODealSelf))*100)/(decimal.valueof(TOSelfGenLeads)));   
                }
             }
             
             public integer getTotalsFollowups(){
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
                 
               taskIds =[select whoid, whatid from task where createdDate=THIS_MONTH];
               for(integer j=0;j<taskIds.size();j++)
               {
               whoids.add(taskIds[j].whoid);
               }
               
               for(integer k=0;k<taskIds.size();k++)
               {
               whatids.add(taskIds[k].whatid);
               }
               L=[select id from Lead where createdDate=THIS_MONTH and isConverted=false and id NOT IN :whoids];
               O=[select id from Opportunity where createdDate=THIS_MONTH and id NOT IN :whatIds];
              //--------------------------------- 
                EventIds =[select whoid, whatid from Event where createdDate=THIS_MONTH];
               for(integer r=0;r<EventIds.size();r++)
               {
               whoidsE.add(EventIds[r].whoid);
               }
               
               for(integer m=0;m<EventIds.size();m++)
               {
               whatidsE.add(EventIds[m].whatid);
               }
               L1=[select id from Lead where createdDate=THIS_MONTH and isConverted=false and id NOT IN :whoidsE];
               O1=[select id from Opportunity where createdDate=THIS_MONTH and id NOT IN :whatIdsE];
              
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
              
               TOFollowups=Leads.size()+ Opps.size();
                return TOFollowups;
             }
             
             
              public integer getTotalsampleReq(){
            /*  List<Lead> SIds = new List<Lead>();
              Sids=[select id from Lead where isCOnverted=false];
               
               List<Opportunity> OIds = new List<Opportunity>();
              Oids=[select id from Opportunity];  *//*
               
               TOSampleReq=[select count() from Sample_request__c where CreatedDate=THIS_MONTH];
              
                return TOSampleReq;
             }
             
             
             public integer getTotalsampleDeal(){
                           
               set<Id> SIds = new set<Id>();
               Sample_request__c[]  s=[select id,Opportunity__c,Lead__r.ConvertedOpportunityId from Sample_request__c where Opportunity__r.StageName='Deal'];
               for(integer i=0;i<s.size();i++)
               {
               Sids.add(s[i].Opportunity__C);
               }
               
             /*  for(integer j=0;j<s.size();j++)
               {
               Sids.add(s[j].Lead__r.ConvertedOpportunityId);
               }*//*
               
              TOSampleDeal =[select count() from Opportunity where StageName='Deal' and CloseDate=THIS_MONTH and ID IN:SIds];  
              
                return TOSampleDeal;
             }
             
              public double getTotalsampleConv(){
                if(TOSampleDeal== 0 || TOSampleReq== 0)
              return 0;
              else
              return  (((decimal.valueof(TOSampleDeal))*100)/(decimal.valueof(TOSampleReq)));       
             }
            //-----------------------------------------------------------------------------------------------------------------------------------
 */
 }