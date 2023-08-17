public class SalesReport
{/*
     public SalesReport() { }
    
        date dt= date.today();
    
            Integer mon=dt.month();
            Integer d=dt.day();
            Integer y=dt.year();
            Date dt1 = date.newInstance(y,mon-3,1);
            Date dt2 = date.newInstance(y,mon-1,30);
       //for thsi month     
     integer AssLC=0;  
     integer AssOC=0;
     integer AssDC=0;
     integer TotalL=0;
     integer TotalAssL=0;
     integer XfUpLead=0;
     integer XfUpOpp=0;
     integer TAssL=0; 
     integer TotalFUp=0;
     integer TSR=0;
     integer TSRC=0;
     integer STD=0;
     integer SelfLC=0;
     integer SelfOC=0;
     integer SelfDC=0;
     integer TotalD=0;
     integer TotalSelfL=0;
     //for lastv month
       integer AssLC1=0;  
     integer AssOC1=0;
     integer AssDC1=0;
     integer TotalL1=0;
     integer TotalAssL1=0;
     integer XfUpLead1=0;
     integer XfUpOpp1=0;
     integer TAssL1=0; 
     integer TotalFUp1=0;
     integer TSR1=0;
     integer TSRC1=0;
     integer STD1=0;
     integer SelfLC1=0;
     integer SelfOC1=0;
     integer SelfDC1=0;
     integer TotalD1=0;
     integer TotalSelfL1=0;
     //for last 3 months
       integer AssLC2=0;  
     integer AssOC2=0;
     integer AssDC2=0;
     integer TotalL2=0;
     integer TotalAssL2=0;
     integer XfUpLead2=0;
     integer XfUpOpp2=0;
     integer TAssL2=0; 
     integer TotalFUp2=0;
     integer TSR2=0;
     integer TSRC2=0;
     integer STD2=0;
     integer SelfLC2=0;
     integer SelfOC2=0;
     integer SelfDC2=0;
     integer TotalD2=0;
     integer TotalSelfL2=0;
     //for percentage calculation this month
     decimal AssignedDealConv=0;
     decimal SelfDealConv=0;
     decimal DealConv=0;
     decimal SampleDealConv=0;
      //for percentage calculation last month
     decimal AssignedDealConv1=0;
     decimal SelfDealConv1=0;
     decimal DealConv1=0;
     decimal SampleDealConv1=0;
      //for percentage calculation last 3 months month
     decimal AssignedDealConv2=0;
     decimal SelfDealConv2=0;
     decimal DealConv2=0;
     decimal SampleDealConv2=0;
     
     
     //This months sales report
 
    List<Sales_Report__c> SR=new list<Sales_Report__c>();
    public List<Sales_Report__c> getSalesItems()
    {
        SR=[Select  Assigned_Lead_Count__c,Date__c,Assigned_Opportunity_Count__c,Assigned_Deal_Count__c,Total_Leads__c,Deal_Conv__c,Total_Assigned_Leads__c,Assigned_Deal_Conv__c,X0_Follow_Up_Leads__c,X0_Follow_Up_Opportunities__c,Total_0_Follow_Up__c, Total_Sample_Request__c,Samples_To_Deal__c, Samples_Deal_Conv__c,SelfGen_Lead_Count__c,SelfGen_Opportunity_Count__c,SelfGen_Deal_Count__c,Total_Deals__c,Total_SelfGen_Leads__c,Division_Name__c, Total_Sample_Request_Count__c, SelfGen_Deal_Conv__c from Sales_Report__c where date__c=this_month and (Division_Name__c !='Indians') and (Division_Name__c!='Millionaires') and (Division_Name__c!='')  order by Total_Deals__c desc];
         //SR=[Select  Assigned_Lead_Count__c,Date__c,Assigned_Opportunity_Count__c,Assigned_Deal_Count__c,Total_Leads__c,Deal_Conv__c,Total_Assigned_Leads__c,Assigned_Deal_Conv__c,X0_Follow_Up_Leads__c,X0_Follow_Up_Opportunities__c,Total_0_Follow_Up__c, Total_Sample_Request__c,Samples_To_Deal__c, Samples_Deal_Conv__c,SelfGen_Lead_Count__c,SelfGen_Opportunity_Count__c,SelfGen_Deal_Count__c,Total_Deals__c,Total_SelfGen_Leads__c,Division_Name__c, Total_Sample_Request_Count__c, SelfGen_Deal_Conv__c from Sales_Report__c where date__c=this_month order by Total_Deals__c desc];
         return SR;
    }
 
    //Function to calculate the Precentage fields for this month
    //Two Associated Functions which is needed for funDealConv()
     public integer getfunTotalL()
    {
       list <Sales_Report__c> s1=new list<Sales_Report__c>();
      s1= [select Total_Leads__c from sales_report__c where date__c =THIS_MONTH AND (Division_Name__c !='Indians') and (Division_Name__c!='Millionaires') and (Division_Name__c!='')];
         //s1= [select Total_Leads__c from sales_report__c where date__c =THIS_MONTH ];
       for(integer i=0;i<s1.size();i++)
       {
           integer j=0;
            if(s1[i].Total_Leads__c!=null)
          {j= s1[i].Total_Leads__c.intValue();}
          TotalL = TotalL + j;
         
       }
       return TotalL;
    }
      public integer  getfunTotalD()
    {
       TotalD = 0;
       list <Sales_Report__c> s1=new list<Sales_Report__c>();
       s1= [select Total_Deals__c from sales_report__c where date__c =THIS_MONTH AND (Division_Name__c !='Indians') and (Division_Name__c!='Millionaires') and (Division_Name__c!='')];
       for(integer i=0;i<s1.size();i++)
       {
     integer j=0;
            if(s1[i].Total_Deals__c!=null)
          {j= s1[i].Total_Deals__c.intValue();}
        TotalD = TotalD + j;
       }
       return  TotalD;
    }
    //funDealConv()
    public decimal getfunDealConv()
    {
      
          if(TotalD != 0 && TotalL != 0)
          {
           DealConv=((decimal.valueof(TotalD)*100)/decimal.valueof(TotalL));
          }
       return DealConv;
    }
    //two related fields associated to the function SelfDealConv()
      public integer  getfunSelfDC()
    {
       list <Sales_Report__c> s1=new list<Sales_Report__c>();
       s1= [select SelfGen_Deal_Count__c from sales_report__c where date__c =THIS_MONTH AND (Division_Name__c !='Indians') and (Division_Name__c!='Millionaires') and (Division_Name__c!='')];
       for(integer i=0;i<s1.size();i++)
       {
     integer j=0;
            if(s1[i].SelfGen_Deal_Count__c!=null)
          {j= s1[i].SelfGen_Deal_Count__c.intValue();}
         SelfDC = SelfDC + j;
       }
       return  SelfDC;
    }
     public integer  getfunTotalSelfL()
    {
       list <Sales_Report__c> s1=new list<Sales_Report__c>();
       s1= [select Total_SelfGen_Leads__c from sales_report__c where date__c =THIS_MONTH AND (Division_Name__c !='Indians') and (Division_Name__c!='Millionaires') and (Division_Name__c!='')];
       for(integer i=0;i<s1.size();i++)
       {
        integer j=0;
            if(s1[i].Total_SelfGen_Leads__c!=null)
          {j= s1[i].Total_SelfGen_Leads__c.intValue();}
         TotalSelfL = TotalSelfL + j;
       }
       return TotalSelfL;
    } 
    //SelfDealConv()
    public decimal getfunSelfDealConv()
    {
         list <Sales_Report__c> s1=new list<Sales_Report__c>();
       s1= [select SelfGen_Deal_Count__c from sales_report__c where date__c =THIS_MONTH AND (Division_Name__c !='Indians') and (Division_Name__c!='Millionaires') and (Division_Name__c!='')];
       for(integer i=0;i<s1.size();i++)
       {
     integer j=0;
            if(s1[i].SelfGen_Deal_Count__c!=null)
          {j= s1[i].SelfGen_Deal_Count__c.intValue();}
         SelfDC = SelfDC + j;
       }
    
    
   /*  list <Sales_Report__c> s2=new list<Sales_Report__c>();
       s2= [select Total_SelfGen_Leads__c from sales_report__c where date__c =THIS_MONTH];
       for(integer i=0;i<s2.size();i++)
       {
     integer j=0;
            if(s2[i].Total_SelfGen_Leads__c!=null)
          {j= s2[i].Total_SelfGen_Leads__c.intValue();}
         TotalSelfL = TotalSelfL + j;
       }*//*
          if(TotalSelfL != 0 && SelfDC != 0)
          {
           SelfDealConv=((decimal.valueof(SelfDC)*100)/decimal.valueof(TotalSelfL));
          }
       return SelfDealConv;
    }
    
    public decimal getfunAssignedDealConv()
    {
      
      list <Sales_Report__c> s3=new list<Sales_Report__c>();
       s3= [select Assigned_Deal_Count__c from sales_report__c where date__c =THIS_MONTH AND (Division_Name__c !='Indians') and (Division_Name__c!='Millionaires') and (Division_Name__c!='')];
       for(integer i=0;i<s3.size();i++)
       {
        integer j=0;
            if(s3[i].Assigned_Deal_Count__c!=null)
          {j= s3[i].Assigned_Deal_Count__c.intValue();}
           AssDC = AssDC + j;
       }
       
     /*  
       list <Sales_Report__c> s1=new list<Sales_Report__c>();
       s1= [select Total_Assigned_Leads__c from sales_report__c where date__c =THIS_MONTH];
       for(integer i=0;i<s1.size();i++)
       {
       integer j=0;
            if(s1[i].Total_Assigned_Leads__c!=null)
          {j= s1[i].Total_Assigned_Leads__c.intValue();}
         TotalAssL = TotalAssL + j;
    
       }*//*
      
    if(AssDC != 0 && TotalAssL != 0)
          {
           AssignedDealConv=((decimal.valueof(AssDC)*100)/decimal.valueof(TotalAssL));
          }
       return AssignedDealConv;
    }
    
      public decimal getfunSampleDealConv()
    {
    
     list <Sales_Report__c> s1=new list<Sales_Report__c>();
       s1= [select Total_Sample_Request__c from sales_report__c where date__c =THIS_MONTH AND (Division_Name__c !='Indians') and (Division_Name__c!='Millionaires') and (Division_Name__c!='')];
       for(integer i=0;i<s1.size();i++)
       {
    
         integer j=0;
            if(s1[i].Total_Sample_Request__c!=null)
          {j= s1[i].Total_Sample_Request__c.intValue();}
         TSR =   TSR + j;
       }
      
          if(TSR != 0 && STD != 0)
          {
          SampleDealConv=((decimal.valueof(STD)*100)/decimal.valueof(TSR));
          }
       return SampleDealConv;
    }
    
    //Fuctions to get the total of each field to show in salesreportdetails(vfp)
    public integer getfunAssLC()
    {
       list <Sales_Report__c> s1=new list<Sales_Report__c>();
       s1= [select Assigned_Lead_Count__c from sales_report__c where date__c =THIS_MONTH AND (Division_Name__c !='Indians') and (Division_Name__c!='Millionaires') and (Division_Name__c!='')];
       for(integer i=0;i<s1.size();i++)
       {
           AssLC= AssLC + s1[i].Assigned_Lead_Count__c.intValue();
       }
       return AssLC;
    }
     public integer getfunAssOC()
    {
       list <Sales_Report__c> s2=new list<Sales_Report__c>();
       s2= [select Assigned_Opportunity_Count__c from sales_report__c where date__c =THIS_MONTH AND (Division_Name__c !='Indians') and (Division_Name__c!='Millionaires') and (Division_Name__c!='')];
       for(integer i=0;i<s2.size();i++)
       {
       integer j=0;
          if(s2[i].Assigned_Opportunity_Count__c!=null)
          {j= s2[i].Assigned_Opportunity_Count__c.intValue();}
          
          AssOC= AssOC + j;
       }
       return AssOC;
    }
     public integer getfunAssDC()
    {
       list <Sales_Report__c> s3=new list<Sales_Report__c>();
       s3= [select Assigned_Deal_Count__c from sales_report__c where date__c =THIS_MONTH AND (Division_Name__c !='Indians') and (Division_Name__c!='Millionaires') and (Division_Name__c!='')];
       for(integer i=0;i<s3.size();i++)
       {
        integer j=0;
            if(s3[i].Assigned_Deal_Count__c!=null)
          {j= s3[i].Assigned_Deal_Count__c.intValue();}
           AssDC = AssDC + j;
       }
       return AssDC;
    }
    
    
    public integer  getfunXfUpLead()
    {
       list <Sales_Report__c> s1=new list<Sales_Report__c>();
       s1= [select X0_Follow_Up_Leads__c from sales_report__c where date__c =THIS_MONTH AND (Division_Name__c !='Indians') and (Division_Name__c!='Millionaires') and (Division_Name__c!='')];
       for(integer i=0;i<s1.size();i++)
       {
           integer j=0;
            if(s1[i].X0_Follow_Up_Leads__c!=null)
          {j= s1[i].X0_Follow_Up_Leads__c.intValue();}
         XfUpLead = XfUpLead + j;
          
       }
       return XfUpLead;
    }
      public integer  getfunTotalAssL()
    {
       list <Sales_Report__c> s1=new list<Sales_Report__c>();
       s1= [select Total_Assigned_Leads__c from sales_report__c where date__c =THIS_MONTH AND (Division_Name__c !='Indians') and (Division_Name__c!='Millionaires') and (Division_Name__c!='')];
       for(integer i=0;i<s1.size();i++)
       {
       integer j=0;
            if(s1[i].Total_Assigned_Leads__c!=null)
          {j= s1[i].Total_Assigned_Leads__c.intValue();}
         TotalAssL = TotalAssL + j;
    
       }
       return TotalAssL;
    }
     public integer  getfunXfUpOpp()
    {
       list <Sales_Report__c> s1=new list<Sales_Report__c>();
       s1= [select X0_Follow_Up_Opportunities__c from sales_report__c where date__c =THIS_MONTH AND (Division_Name__c !='Indians') and (Division_Name__c!='Millionaires') and (Division_Name__c!='')];
       for(integer i=0;i<s1.size();i++)
       {
       integer j=0;
            if(s1[i].X0_Follow_Up_Opportunities__c!=null)
          {j= s1[i].X0_Follow_Up_Opportunities__c.intValue();}
          XfUpOpp =  XfUpOpp + j;
      
       }
       return XfUpOpp;
    }
   /* public integer  getfunTAssL()
    {
       list <Sales_Report__c> s1=new list<Sales_Report__c>();
       s1= [select X0_Follow_Up_Opportunities__c from sales_report__c where date__c =THIS_MONTH];
       for(integer i=0;i<s1.size();i++)
       {
         integer j=0;
            if(s1[i].X0_Follow_Up_Opportunities__c!=null)
          {j= s1[i].X0_Follow_Up_Opportunities__c.intValue();}
          TAssL =   TAssL + j;
      
     
       }
       return TAssL;
    }*//*
     public integer  getfunTotalFUp()
    {
       list <Sales_Report__c> s1=new list<Sales_Report__c>();
       s1= [select Total_0_Follow_Up__c from sales_report__c where date__c =THIS_MONTH AND (Division_Name__c !='Indians') and (Division_Name__c!='Millionaires') and (Division_Name__c!='')];
       for(integer i=0;i<s1.size();i++)
       {
       
       
         integer j=0;
            if(s1[i].Total_0_Follow_Up__c!=null)
          {j= s1[i].Total_0_Follow_Up__c.intValue();}
         TotalFUp =   TotalFUp + j;
       
       }
       return TotalFUp;
    }
     public integer  getfunTSR()
    {
       list <Sales_Report__c> s1=new list<Sales_Report__c>();
       s1= [select Total_Sample_Request_Count__c from sales_report__c where date__c =THIS_MONTH AND (Division_Name__c !='Indians') and (Division_Name__c!='Millionaires') and (Division_Name__c!='')];
       for(integer i=0;i<s1.size();i++)
       {
    
         integer j=0;
            if(s1[i].Total_Sample_Request_Count__c!=null)
          {j= s1[i].Total_Sample_Request_Count__c.intValue();}
         TSRC =   TSRC + j;
       }
       return TSRC;
    }
     public integer  getfunSTD()
    {
       list <Sales_Report__c> s1=new list<Sales_Report__c>();
       s1= [select Samples_To_Deal__c from sales_report__c where date__c =THIS_MONTH AND (Division_Name__c !='Indians') and (Division_Name__c!='Millionaires') and (Division_Name__c!='')];
       for(integer i=0;i<s1.size();i++)
       {
          integer j=0;
            if(s1[i].Samples_To_Deal__c!=null)
          {j= s1[i].Samples_To_Deal__c.intValue();}
        STD =   STD + j;
       }
       return STD;
    }
   public integer  getfunSelfLC()
    {
       list <Sales_Report__c> s1=new list<Sales_Report__c>();
       s1= [select SelfGen_Lead_Count__c from sales_report__c where date__c =THIS_MONTH AND (Division_Name__c !='Indians') and (Division_Name__c!='Millionaires') and (Division_Name__c!='')];
       for(integer i=0;i<s1.size();i++)
       {
       
          integer j=0;
            if(s1[i].SelfGen_Lead_Count__c!=null)
          {j= s1[i].SelfGen_Lead_Count__c.intValue();}
       SelfLC = SelfLC + j;
       }
       return SelfLC;
    }
    public integer  getfunSelfOC()
    {
       list <Sales_Report__c> s1=new list<Sales_Report__c>();
       s1= [select SelfGen_Opportunity_Count__c from sales_report__c where date__c =THIS_MONTH AND (Division_Name__c !='Indians') and (Division_Name__c!='Millionaires') and (Division_Name__c!='')];
       for(integer i=0;i<s1.size();i++)
       {
        integer j=0;
            if(s1[i].SelfGen_Opportunity_Count__c!=null)
          {j= s1[i].SelfGen_Opportunity_Count__c.intValue();}
      SelfOC = SelfOC + j;
       }
       return SelfOC;
    }
  
      
    //This Function Used for Last month sales Report
    
     List<Sales_Report__c> SR1=new list<Sales_Report__c>();
    public List<Sales_Report__c> getSalesItems1()
    {
        SR1=[Select  Assigned_Lead_Count__c,Date__c,Assigned_Opportunity_Count__c,Assigned_Deal_Count__c,Total_Leads__c,Deal_Conv__c,Total_Assigned_Leads__c,Assigned_Deal_Conv__c,X0_Follow_Up_Leads__c,X0_Follow_Up_Opportunities__c,Total_0_Follow_Up__c, Total_Sample_Request__c,Samples_To_Deal__c, Samples_Deal_Conv__c,SelfGen_Lead_Count__c,SelfGen_Opportunity_Count__c,SelfGen_Deal_Count__c,Total_Deals__c,Total_SelfGen_Leads__c,Division_Name__c,Total_Sample_Request_Count__c, SelfGen_Deal_Conv__c from Sales_Report__c where date__c=last_month and (Division_Name__c !='Indians') and (Division_Name__c!='Millionaires')  and (Division_Name__c!='') order by Total_Deals__c desc];
        return SR1;
    }
    
     //Function to calculate the Precentage fields for Last Month
     //Two Fields Associated with the percentage calculation of funDealConv1() 
     
      public integer getfunTotalL1()
    {
       list <Sales_Report__c> s1=new list<Sales_Report__c>();
       s1= [select Total_Leads__c from sales_report__c where date__c =LAST_MONTH AND (Division_Name__c !='Indians') and (Division_Name__c!='Millionaires') and (Division_Name__c!='')];
       for(integer i=0;i<s1.size();i++)
       {
           integer j=0;
            if(s1[i].Total_Leads__c!=null)
          {j= s1[i].Total_Leads__c.intValue();}
          TotalL1 = TotalL1 + j;
         
       }
       return TotalL1;
    }
     public integer  getfunTotalD1()
    {
       list <Sales_Report__c> s1=new list<Sales_Report__c>();
       s1= [select Total_Deals__c from sales_report__c where date__c =LAST_MONTH AND (Division_Name__c !='Indians') and (Division_Name__c!='Millionaires') and (Division_Name__c!='')];
       for(integer i=0;i<s1.size();i++)
       {
     integer j=0;
            if(s1[i].Total_Deals__c!=null)
          {j= s1[i].Total_Deals__c.intValue();}
        TotalD1 = TotalD1 + j;
       }
       return  TotalD1;
    }

       public decimal getfunDealConv1()
    {
      
          if(TotalD1 != 0 && TotalL1 != 0)
          {
           DealConv1=((decimal.valueof(TotalD1)*100)/decimal.valueof(TotalL1));
          }
       return DealConv1;
    }
    
     public integer  getfunSelfDC1()
    {
       list <Sales_Report__c> s1=new list<Sales_Report__c>();
       s1= [select SelfGen_Deal_Count__c from sales_report__c where date__c =LAST_MONTH AND (Division_Name__c !='Indians') and (Division_Name__c!='Millionaires') and (Division_Name__c!='')];
       for(integer i=0;i<s1.size();i++)
       {
     integer j=0;
            if(s1[i].SelfGen_Deal_Count__c!=null)
          {j= s1[i].SelfGen_Deal_Count__c.intValue();}
         SelfDC1 = SelfDC1 + j;
       }
       return  SelfDC1;
    }
     public integer  getfunTotalSelfL1()
    {
       list <Sales_Report__c> s1=new list<Sales_Report__c>();
       s1= [select Total_SelfGen_Leads__c from sales_report__c where date__c =LAST_MONTH AND (Division_Name__c !='Indians') and (Division_Name__c!='Millionaires') and (Division_Name__c!='')];
       for(integer i=0;i<s1.size();i++)
       {
     integer j=0;
            if(s1[i].Total_SelfGen_Leads__c!=null)
          {j= s1[i].Total_SelfGen_Leads__c.intValue();}
         TotalSelfL1 = TotalSelfL1 + j;
       }
       return TotalSelfL1;
    }
    public decimal getfunSelfDealConv1()
    {
          list <Sales_Report__c> s1=new list<Sales_Report__c>();
       s1= [select SelfGen_Deal_Count__c from sales_report__c where date__c =LAST_MONTH AND (Division_Name__c !='Indians') and (Division_Name__c!='Millionaires') and (Division_Name__c!='')];
       for(integer i=0;i<s1.size();i++)
       {
     integer j=0;
            if(s1[i].SelfGen_Deal_Count__c!=null)
          {j= s1[i].SelfGen_Deal_Count__c.intValue();}
         SelfDC1 = SelfDC1 + j;
       }
          
          if(TotalSelfL1 != 0 && SelfDC1 != 0)
          {
           SelfDealConv1=((decimal.valueof(SelfDC1)*100)/decimal.valueof(TotalSelfL1));
          }
       return SelfDealConv1;
    }
     public integer getfunAssDC1()
    {
       list <Sales_Report__c> s3=new list<Sales_Report__c>();
       s3= [select Assigned_Deal_Count__c from sales_report__c where date__c =LAST_MONTH AND (Division_Name__c !='Indians') and (Division_Name__c!='Millionaires') and (Division_Name__c!='')];
       for(integer i=0;i<s3.size();i++)
       {
        integer j=0;
            if(s3[i].Assigned_Deal_Count__c!=null)
          {j= s3[i].Assigned_Deal_Count__c.intValue();}
           AssDC1 = AssDC1 + j;
       }
       return AssDC1;
    }
     public integer  getfunTotalAssL1()
    {
       list <Sales_Report__c> s1=new list<Sales_Report__c>();
       s1= [select Total_Assigned_Leads__c from sales_report__c where date__c =LAST_MONTH AND (Division_Name__c !='Indians') and (Division_Name__c!='Millionaires') and (Division_Name__c!='')];
       for(integer i=0;i<s1.size();i++)
       {
       integer j=0;
            if(s1[i].Total_Assigned_Leads__c!=null)
          {j= s1[i].Total_Assigned_Leads__c.intValue();}
         TotalAssL1 = TotalAssL1 + j;
    
       }
       return TotalAssL1;
    }
    public decimal getfunAssignedDealConv1()
    {
      
          list <Sales_Report__c> s3=new list<Sales_Report__c>();
       s3= [select Assigned_Deal_Count__c from sales_report__c where date__c =LAST_MONTH AND (Division_Name__c !='Indians') and (Division_Name__c!='Millionaires') and (Division_Name__c!='')];
       for(integer i=0;i<s3.size();i++)
       {
        integer j=0;
            if(s3[i].Assigned_Deal_Count__c!=null)
          {j= s3[i].Assigned_Deal_Count__c.intValue();}
           AssDC1 = AssDC1 + j;
       }
          if(AssDC1 != 0 && TotalAssL1 != 0)
          {
           AssignedDealConv1=((decimal.valueof(AssDC1)*100)/decimal.valueof(TotalAssL1));
          }
       return AssignedDealConv1;
    }
    
      public decimal getfunSampleDealConv1()
    {
       list <Sales_Report__c> s1=new list<Sales_Report__c>();
       s1= [select Total_Sample_Request__c from sales_report__c where date__c =LAST_MONTH AND (Division_Name__c !='Indians') and (Division_Name__c!='Millionaires') and (Division_Name__c!='')];
       for(integer i=0;i<s1.size();i++)
       {
    
         integer j=0;
            if(s1[i].Total_Sample_Request__c!=null)
          {j= s1[i].Total_Sample_Request__c.intValue();}
         TSR1 =   TSR1 + j;
       }
       
          if(TSR1 != 0 && STD1 != 0)
          {
          SampleDealConv1=((decimal.valueof(STD1)*100)/decimal.valueof(TSR1));
          }
       return SampleDealConv1;
    }
      //Fuctions to get the total of each field to show in salesreportdetails(vfp)
    
    public integer getfunAssLC1()
    {
       list <Sales_Report__c> s1=new list<Sales_Report__c>();
       s1= [select Assigned_Lead_Count__c from sales_report__c where date__c =LAST_MONTH AND (Division_Name__c !='Indians') and (Division_Name__c!='Millionaires') and (Division_Name__c!='')];
       for(integer i=0;i<s1.size();i++)
       {
           AssLC1= AssLC1 + s1[i].Assigned_Lead_Count__c.intValue();
       }
       return AssLC1;
    }
     public integer getfunAssOC1()
    {
       list <Sales_Report__c> s2=new list<Sales_Report__c>();
       s2= [select Assigned_Opportunity_Count__c from sales_report__c where date__c =LAST_MONTH];
       for(integer i=0;i<s2.size();i++)
       {
       integer j=0;
          if(s2[i].Assigned_Opportunity_Count__c!=null)
          {j= s2[i].Assigned_Opportunity_Count__c.intValue();}
          
          AssOC1= AssOC1 + j;
       }
       return AssOC1;
    }
    
    
    
    public integer  getfunXfUpLead1()
    {
       list <Sales_Report__c> s1=new list<Sales_Report__c>();
       s1= [select X0_Follow_Up_Leads__c from sales_report__c where date__c =LAST_MONTH AND (Division_Name__c !='Indians') and (Division_Name__c!='Millionaires') and (Division_Name__c!='')];
       for(integer i=0;i<s1.size();i++)
       {
           integer j=0;
            if(s1[i].X0_Follow_Up_Leads__c!=null)
          {j= s1[i].X0_Follow_Up_Leads__c.intValue();}
         XfUpLead1 = XfUpLead1 + j;
          
       }
       return XfUpLead1;
    }
     
     public integer  getfunXfUpOpp1()
    {
       list <Sales_Report__c> s1=new list<Sales_Report__c>();
       s1= [select X0_Follow_Up_Opportunities__c from sales_report__c where date__c =LAST_MONTH AND (Division_Name__c !='Indians') and (Division_Name__c!='Millionaires') and (Division_Name__c!='')];
       for(integer i=0;i<s1.size();i++)
       {
       integer j=0;
            if(s1[i].X0_Follow_Up_Opportunities__c!=null)
          {j= s1[i].X0_Follow_Up_Opportunities__c.intValue();}
          XfUpOpp1 =  XfUpOpp1 + j;
      
       }
       return XfUpOpp1;
    }
   /*  public integer  getfunTAssL1()
    {
       list <Sales_Report__c> s1=new list<Sales_Report__c>();
       s1= [select X0_Follow_Up_Opportunities__c from sales_report__c where date__c =LAST_MONTH];
       for(integer i=0;i<s1.size();i++)
       {
         integer j=0;
            if(s1[i].X0_Follow_Up_Opportunities__c!=null)
          {j= s1[i].X0_Follow_Up_Opportunities__c.intValue();}
          TAssL1 =   TAssL1 + j;
      
     
       }
       return TAssL1;
    }*//*
     public integer  getfunTotalFUp1()
    {
       list <Sales_Report__c> s1=new list<Sales_Report__c>();
       s1= [select Total_0_Follow_Up__c from sales_report__c where date__c =LAST_MONTH AND (Division_Name__c !='Indians') and (Division_Name__c!='Millionaires') and (Division_Name__c!='')];
       for(integer i=0;i<s1.size();i++)
       {
       
       
         integer j=0;
            if(s1[i].Total_0_Follow_Up__c!=null)
          {j= s1[i].Total_0_Follow_Up__c.intValue();}
         TotalFUp1 =   TotalFUp1 + j;
       
       }
       return TotalFUp1;
    }
     public integer  getfunTSR1()
    {
       list <Sales_Report__c> s1=new list<Sales_Report__c>();
       s1= [select Total_Sample_Request_Count__c from sales_report__c where date__c =LAST_MONTH AND (Division_Name__c !='Indians') and (Division_Name__c!='Millionaires') and (Division_Name__c!='')];
       for(integer i=0;i<s1.size();i++)
       {
    
         integer j=0;
            if(s1[i].Total_Sample_Request_Count__c!=null)
          {j= s1[i].Total_Sample_Request_Count__c.intValue();}
         TSRC1 =   TSRC1 + j;
       }
       return TSRC1;
    }
     public integer  getfunSTD1()
    {
       list <Sales_Report__c> s1=new list<Sales_Report__c>();
       s1= [select Samples_To_Deal__c from sales_report__c where date__c =LAST_MONTH AND (Division_Name__c !='Indians') and (Division_Name__c!='Millionaires') and (Division_Name__c!='')];
       for(integer i=0;i<s1.size();i++)
       {
          integer j=0;
            if(s1[i].Samples_To_Deal__c!=null)
          {j= s1[i].Samples_To_Deal__c.intValue();}
        STD1 =   STD1 + j;
       }
       return STD1;
    }
   public integer  getfunSelfLC1()
    {
       list <Sales_Report__c> s1=new list<Sales_Report__c>();
       s1= [select SelfGen_Lead_Count__c from sales_report__c where date__c =LAST_MONTH AND (Division_Name__c !='Indians') and (Division_Name__c!='Millionaires') and (Division_Name__c!='')];
       for(integer i=0;i<s1.size();i++)
       {
       
          integer j=0;
            if(s1[i].SelfGen_Lead_Count__c!=null)
          {j= s1[i].SelfGen_Lead_Count__c.intValue();}
       SelfLC1 = SelfLC1 + j;
       }
       return SelfLC1;
    }
    public integer  getfunSelfOC1()
    {
       list <Sales_Report__c> s1=new list<Sales_Report__c>();
       s1= [select SelfGen_Opportunity_Count__c from sales_report__c where date__c =LAST_MONTH AND (Division_Name__c !='Indians') and (Division_Name__c!='Millionaires') and (Division_Name__c!='')];
       for(integer i=0;i<s1.size();i++)
       {
        integer j=0;
            if(s1[i].SelfGen_Opportunity_Count__c!=null)
          {j= s1[i].SelfGen_Opportunity_Count__c.intValue();}
      SelfOC1 = SelfOC1 + j;
       }
       return SelfOC1;
    }
   
   
   
    
    //This function used for last three months sales report
    
     List<Sales_Report__c> SR2=new list<Sales_Report__c>();
    public List<Sales_Report__c> getSalesItems2()
    {
        SR2=[Select  Assigned_Lead_Count__c,Date__c,Assigned_Opportunity_Count__c,Total_Sample_Request_Count__c, Assigned_Deal_Count__c,Total_Leads__c,Deal_Conv__c,Total_Assigned_Leads__c,Assigned_Deal_Conv__c,X0_Follow_Up_Leads__c,X0_Follow_Up_Opportunities__c,Total_0_Follow_Up__c, Total_Sample_Request__c,Samples_To_Deal__c, Samples_Deal_Conv__c,SelfGen_Lead_Count__c,SelfGen_Opportunity_Count__c,SelfGen_Deal_Count__c,Total_Deals__c,Total_SelfGen_Leads__c,Division_Name__c,SelfGen_Deal_Conv__c from Sales_Report__c where test__c = true and (Division_Name__c !='Indians') and (Division_Name__c!='Millionaires')  and (Division_Name__c!='')  order by Total_Deals__c desc];
        return SR2;
    }
    
      //Function to calculate the Precentage fields for Last Month
      //Two Field Calculations Associated with the function funDealConv2()
        public integer  getfunTotalD2()
    {
       list <Sales_Report__c> s1=new list<Sales_Report__c>();
       s1= [select Total_Deals__c from sales_report__c where Date__c>=:dt1 and date__c<=:dt2 AND (Division_Name__c !='Indians') and (Division_Name__c!='Millionaires') and (Division_Name__c!='')];
       for(integer i=0;i<s1.size();i++)
       {
     integer j=0;
            if(s1[i].Total_Deals__c!=null)
          {j= s1[i].Total_Deals__c.intValue();}
        TotalD2 = TotalD2 + j;
       }
       return  TotalD2;
    }
     public integer getfunTotalL2()
    {
       list <Sales_Report__c> s1=new list<Sales_Report__c>();
       s1= [select Total_Leads__c from sales_report__c where Date__c>=:dt1 and date__c<=:dt2 AND (Division_Name__c !='Indians') and (Division_Name__c!='Millionaires') and (Division_Name__c!='')];
       for(integer i=0;i<s1.size();i++)
       {
           integer j=0;
            if(s1[i].Total_Leads__c!=null)
          {j= s1[i].Total_Leads__c.intValue();}
          TotalL2 = TotalL2 + j;
         
       }
       return TotalL2;
    }
       public decimal getfunDealConv2()
    {
      
          if(TotalD2 != 0 && TotalL2 != 0)
          {
           DealConv2=((decimal.valueof(TotalD2)*100)/decimal.valueof(TotalL2));
          }
       return DealConv2;
    }
     public integer  getfunSelfDC2()
    {
       list <Sales_Report__c> s1=new list<Sales_Report__c>();
       s1= [select SelfGen_Deal_Count__c from sales_report__c where  Date__c>=:dt1 and date__c<=:dt2 AND (Division_Name__c !='Indians') and (Division_Name__c!='Millionaires') and (Division_Name__c!='')];
       for(integer i=0;i<s1.size();i++)
       {
     integer j=0;
            if(s1[i].SelfGen_Deal_Count__c!=null)
          {j= s1[i].SelfGen_Deal_Count__c.intValue();}
         SelfDC2 = SelfDC2 + j;
       }
       return  SelfDC2;
    }
     public integer  getfunTotalSelfL2()
    {
       list <Sales_Report__c> s1=new list<Sales_Report__c>();
       s1= [select Total_SelfGen_Leads__c from sales_report__c where  Date__c>=:dt1 and date__c<=:dt2 AND (Division_Name__c !='Indians') and (Division_Name__c!='Millionaires') and (Division_Name__c!='')];
       for(integer i=0;i<s1.size();i++)
       {
     integer j=0;
            if(s1[i].Total_SelfGen_Leads__c!=null)
          {j= s1[i].Total_SelfGen_Leads__c.intValue();}
         TotalSelfL2 = TotalSelfL2 + j;
       }
       return TotalSelfL2;
    }
    public decimal getfunSelfDealConv2()
    {
          list <Sales_Report__c> s1=new list<Sales_Report__c>();
       s1= [select SelfGen_Deal_Count__c from sales_report__c where  Date__c>=:dt1 and date__c<=:dt2 AND (Division_Name__c !='Indians') and (Division_Name__c!='Millionaires') and (Division_Name__c!='')];
       for(integer i=0;i<s1.size();i++)
       {
     integer j=0;
            if(s1[i].SelfGen_Deal_Count__c!=null)
          {j= s1[i].SelfGen_Deal_Count__c.intValue();}
         SelfDC2 = SelfDC2 + j;
       }
          if(TotalSelfL2 != 0 && SelfDC2 != 0)
          {
           SelfDealConv2=((decimal.valueof(SelfDC2)*100)/decimal.valueof(TotalSelfL2));
          }
       return SelfDealConv2;
    }
     public integer getfunAssDC2()
    {
       list <Sales_Report__c> s3=new list<Sales_Report__c>();
       s3= [select Assigned_Deal_Count__c from sales_report__c where  Date__c>=:dt1 and date__c<=:dt2 AND (Division_Name__c !='Indians') and (Division_Name__c!='Millionaires') and (Division_Name__c!='')];
       for(integer i=0;i<s3.size();i++)
       {
        integer j=0;
            if(s3[i].Assigned_Deal_Count__c!=null)
          {j= s3[i].Assigned_Deal_Count__c.intValue();}
           AssDC2 = AssDC2 + j;
       }
       return AssDC2;
    }
    
    public decimal getfunAssignedDealConv2()
    {
      
      list <Sales_Report__c> s3=new list<Sales_Report__c>();
       s3= [select Assigned_Deal_Count__c from sales_report__c where  Date__c>=:dt1 and date__c<=:dt2 AND (Division_Name__c !='Indians') and (Division_Name__c!='Millionaires') and (Division_Name__c!='')];
       for(integer i=0;i<s3.size();i++)
       {
        integer j=0;
            if(s3[i].Assigned_Deal_Count__c!=null)
          {j= s3[i].Assigned_Deal_Count__c.intValue();}
           AssDC2 = AssDC2 + j;
       }
       
          if(AssDC2 != 0 && TotalAssL2 != 0)
          {
           AssignedDealConv2=((decimal.valueof(AssDC2)*100)/decimal.valueof(TotalAssL2));
          }
       return AssignedDealConv2;
    }
    
    public integer  getfunTotalAssL2()
    {
       list <Sales_Report__c> s1=new list<Sales_Report__c>();
       s1= [select Total_Assigned_Leads__c from sales_report__c where  Date__c>=:dt1 and date__c<=:dt2 AND (Division_Name__c !='Indians') and (Division_Name__c!='Millionaires') and (Division_Name__c!='')];
       for(integer i=0;i<s1.size();i++)
       {
       integer j=0;
            if(s1[i].Total_Assigned_Leads__c!=null)
          {j= s1[i].Total_Assigned_Leads__c.intValue();}
         TotalAssL2 = TotalAssL2 + j;
    
       }
       return TotalAssL2;
    }
      public decimal getfunSampleDealConv2()
    {
    
      list <Sales_Report__c> s1=new list<Sales_Report__c>();
       s1= [select Total_Sample_Request__c from sales_report__c where  Date__c>=:dt1 and date__c<=:dt2 AND (Division_Name__c !='Indians') and (Division_Name__c!='Millionaires') and (Division_Name__c!='')];
       for(integer i=0;i<s1.size();i++)
       {
    
         integer j=0;
            if(s1[i].Total_Sample_Request__c!=null)
          {j= s1[i].Total_Sample_Request__c.intValue();}
         TSR2 =   TSR2 + j;
       }
      
          if(TSR2 != 0 && STD2 != 0)
          {
          SampleDealConv2=((decimal.valueof(STD2)*100)/decimal.valueof(TSR2));
          }
       return SampleDealConv2;
    }
      
      //Fuctions to get the total of each field to show in salesreportdetails(vfp)
    
    public integer getfunAssLC2()
    {
       list <Sales_Report__c> s1=new list<Sales_Report__c>();
       s1= [select Assigned_Lead_Count__c from sales_report__c where Date__c>=:dt1 and date__c<=:dt2 AND (Division_Name__c !='Indians') and (Division_Name__c!='Millionaires') and (Division_Name__c!='')];
       for(integer i=0;i<s1.size();i++)
       {
           AssLC2= AssLC2 + s1[i].Assigned_Lead_Count__c.intValue();
       }
       return AssLC2;
    }
     public integer getfunAssOC2()
    {
       list <Sales_Report__c> s2=new list<Sales_Report__c>();
       s2= [select Assigned_Opportunity_Count__c from sales_report__c where  Date__c>=:dt1 and date__c<=:dt2 AND (Division_Name__c !='Indians') and (Division_Name__c!='Millionaires') and (Division_Name__c!='')];
       for(integer i=0;i<s2.size();i++)
       {
       integer j=0;
          if(s2[i].Assigned_Opportunity_Count__c!=null)
          {j= s2[i].Assigned_Opportunity_Count__c.intValue();}
          
          AssOC2= AssOC2 + j;
       }
       return AssOC2;
    }
    
    
    public integer  getfunXfUpLead2()
    {
       list <Sales_Report__c> s1=new list<Sales_Report__c>();
       s1= [select X0_Follow_Up_Leads__c from sales_report__c where  Date__c>=:dt1 and date__c<=:dt2 AND (Division_Name__c !='Indians') and (Division_Name__c!='Millionaires') and (Division_Name__c!='')];
       for(integer i=0;i<s1.size();i++)
       {
           integer j=0;
            if(s1[i].X0_Follow_Up_Leads__c!=null)
          {j= s1[i].X0_Follow_Up_Leads__c.intValue();}
         XfUpLead2 = XfUpLead2 + j;
          
       }
       return XfUpLead2;
    }
      
     public integer  getfunXfUpOpp2()
    {
       list <Sales_Report__c> s1=new list<Sales_Report__c>();
       s1= [select X0_Follow_Up_Opportunities__c from sales_report__c where  Date__c>=:dt1 and date__c<=:dt2 AND (Division_Name__c !='Indians') and (Division_Name__c!='Millionaires') and (Division_Name__c!='')];
       for(integer i=0;i<s1.size();i++)
       {
       integer j=0;
            if(s1[i].X0_Follow_Up_Opportunities__c!=null)
          {j= s1[i].X0_Follow_Up_Opportunities__c.intValue();}
          XfUpOpp2 =  XfUpOpp2 + j;
      
       }
       return XfUpOpp2;
    }
    /*public integer  getfunTAssL2()
    {
       list <Sales_Report__c> s1=new list<Sales_Report__c>();
       s1= [select X0_Follow_Up_Opportunities__c from sales_report__c where  Date__c>=:dt1 and date__c<=:dt2 ];
       for(integer i=0;i<s1.size();i++)
       {
         integer j=0;
            if(s1[i].X0_Follow_Up_Opportunities__c!=null)
          {j= s1[i].X0_Follow_Up_Opportunities__c.intValue();}
          TAssL2 =   TAssL2 + j;
      
     
       }
       return TAssL2;
    }*//*
     public integer  getfunTotalFUp2()
    {
       list <Sales_Report__c> s1=new list<Sales_Report__c>();
       s1= [select Total_0_Follow_Up__c from sales_report__c where  Date__c>=:dt1 and date__c<=:dt2 AND (Division_Name__c !='Indians') and (Division_Name__c!='Millionaires') and (Division_Name__c!='')];
       for(integer i=0;i<s1.size();i++)
       {
       
       
         integer j=0;
            if(s1[i].Total_0_Follow_Up__c!=null)
          {j= s1[i].Total_0_Follow_Up__c.intValue();}
         TotalFUp2 =   TotalFUp2 + j;
       
       }
       return TotalFUp2;
    }
     public integer  getfunTSR2()
    {
       list <Sales_Report__c> s1=new list<Sales_Report__c>();
       s1= [select Total_Sample_Request_Count__c from sales_report__c where  Date__c>=:dt1 and date__c<=:dt2 AND (Division_Name__c !='Indians') and (Division_Name__c!='Millionaires') and (Division_Name__c!='')];
       for(integer i=0;i<s1.size();i++)
       {
    
         integer j=0;
            if(s1[i].Total_Sample_Request_Count__c!=null)
          {j= s1[i].Total_Sample_Request_Count__c.intValue();}
         TSRC2 =   TSRC2 + j;
       }
       return TSRC2;
    }
     public integer  getfunSTD2()
    {
       list <Sales_Report__c> s1=new list<Sales_Report__c>();
       s1= [select Samples_To_Deal__c from sales_report__c where  Date__c>=:dt1 and date__c<=:dt2 AND (Division_Name__c !='Indians') and (Division_Name__c!='Millionaires') and (Division_Name__c!='')];
       for(integer i=0;i<s1.size();i++)
       {
          integer j=0;
            if(s1[i].Samples_To_Deal__c!=null)
          {j= s1[i].Samples_To_Deal__c.intValue();}
        STD2 =   STD2 + j;
       }
       return STD2;
    }
   public integer  getfunSelfLC2()
    {
       list <Sales_Report__c> s1=new list<Sales_Report__c>();
       s1= [select SelfGen_Lead_Count__c from sales_report__c where  Date__c>=:dt1 and date__c<=:dt2 AND (Division_Name__c !='Indians') and (Division_Name__c!='Millionaires') and (Division_Name__c!='')];
       for(integer i=0;i<s1.size();i++)
       {
       
          integer j=0;
            if(s1[i].SelfGen_Lead_Count__c!=null)
          {j= s1[i].SelfGen_Lead_Count__c.intValue();}
       SelfLC2 = SelfLC2 + j;
       }
       return SelfLC2;
    }
    public integer  getfunSelfOC2()
    {
       list <Sales_Report__c> s1=new list<Sales_Report__c>();
       s1= [select SelfGen_Opportunity_Count__c from sales_report__c where  Date__c>=:dt1 and date__c<=:dt2 AND (Division_Name__c !='Indians') and (Division_Name__c!='Millionaires') and (Division_Name__c!='')];
       for(integer i=0;i<s1.size();i++)
       {
        integer j=0;
            if(s1[i].SelfGen_Opportunity_Count__c!=null)
          {j= s1[i].SelfGen_Opportunity_Count__c.intValue();}
      SelfOC2 = SelfOC2 + j;
       }
       return SelfOC2;
    }
   
   
  */

    
}