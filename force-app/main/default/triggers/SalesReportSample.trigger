trigger SalesReportSample on Sample_Request__c (after insert) {
if(trigger.isinsert)
{
For(Sample_Request__c S: Trigger.New)
    {
        If(S.Lead__c!=null)
        {
         date dt= S.createdDate.date();
         integer month =dt.month();
         integer year = dt.year();
         integer sampleR=0;
          
           integer sample = [select count() from sample_request__c where lead__c=:s.lead__c];
           if(sample<=1)
                sampleR=1;
          sales_report__c[] sr = [select id, Total_Sample_Request__c,Total_Sample_Request_Count__c, division_name__C, date__c from sales_report__c where division_name__c=:s.Lead_Divison__c and Calendar_Month(date__C)= :month and CALENDAR_YEAR(date__c)= :year];     
           
            if(sr.size()==0)
            {
            Sales_report__c s1 = new sales_report__c();
            s1.date__c= S.createdDate.date();
            s1.Division_Name__c = S.Lead_Divison__c ;
            s1.Total_Sample_Request__c=sampleR;
            s1.Total_Sample_Request_Count__c=1;
            insert s1;
            }
            
           else 
           {
           sr[0].Total_Sample_Request__c= sr[0].Total_Sample_Request__c+sampleR;
           sr[0].Total_Sample_Request_Count__c=sr[0].Total_Sample_Request_Count__c+1;
         
           update sr;
           
           }        
        } // End of (Lead != null)

       else if(S.Opportunity__c!=null)
        {
         date dt= S.createdDate.date();
         integer month =dt.month();
         integer year = dt.year();
         integer sampleR=0;
          
           integer sample = [select count() from sample_request__c where Opportunity__c=:s.Opportunity__c and Lead__C=null];
           if(sample<=1)
                   sampleR=1;
          sales_report__c[] sr = [select id, Total_Sample_Request__c,Total_Sample_Request_Count__c, division_name__C, date__c from sales_report__c where division_name__c=:s.Opportunity_Division__c and Calendar_Month(date__C)= :month and CALENDAR_YEAR(date__c)= :year];     
           
            if(sr.size()==0)
            {
            Sales_report__c s1 = new sales_report__c();
            s1.date__c= S.createdDate.date();
            s1.Division_Name__c = S.Opportunity_Division__c ;
            s1.Total_Sample_Request__c=sampleR;
            s1.Total_Sample_Request_Count__c=1;
            insert s1;
            }
            
           else 
           {
             sr[0].Total_Sample_Request__c= sr[0].Total_Sample_Request__c+sampleR;
             sr[0].Total_Sample_Request_Count__c=sr[0].Total_Sample_Request_Count__c+1;
         
           update sr;
           
           }
           
        }// End of (opty != null)


    } // for loop

  } // end of isInsert task
   
  
}