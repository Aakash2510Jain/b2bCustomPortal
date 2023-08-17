Public Class Download_Attachments_Paging
{  
    public class wrapclassdemo
    {
        public Sample_Request__c mem {get; set; }
        public List<Attachment> at {get; set; }
    }
    public List<wrapclassdemo> wcc
    { 
        get {
           return nextwc;
         }
        set; 
    }
    public List<wrapclassdemo> wc  = new List<wrapclassdemo> ();
    public List<wrapclassdemo> nextwc  = new List<wrapclassdemo> ();
    Public Sample_Request__c WO{get;set;}
    public list<Sample_Request__c> WOlist1{get;set;}
    public List<Attachment> attr = new List<Attachment> ();
    Public Boolean shownext;
    Public Integer Countnum=0;
    Public Boolean showprev;
    private Integer next = 30, count = 30;
    public integer i1=0; 
    public integer co;
    public integer val{get; set;}
    public integer val2{get; set;}
    Public boolean getshownext(){return shownext;}
    Public boolean getshowprev(){return showprev;}
    public List<Attachment> attachment
    {
        get {
            return attr;
         }
        set;
    }
    public Download_Attachments_Paging()
    {
        User U=[select Id,Alias,Name,ProfileId,Profile.Name from User where Id =: UserInfo.getUserId() limit 1];
        if(U.Profile.Name !='System Administrator')
        {
              system.debug('*******Other User*******'+U.Profile.Name);
              WOlist1=[select id,Name,LeadID__c,Lead__r.id,Ownerid,Opportunity_Number__c,Opportunity__r.id, Status_Flag__c,CreatedById,Sample_ID__c,Sample_Type__c,Due_Date__c,CreatedDate from Sample_Request__c where CreatedById =: UserInfo.getUserId() Order By CreatedDate Desc limit 300];
        }
        else if(U.Profile.Name =='System Administrator')
        {
              system.debug('#######SysAdmin######'+U.Profile.Name);
              WOlist1=[select id,Name,LeadID__c,Lead__r.id,Ownerid,Opportunity_Number__c,Opportunity__r.id, Status_Flag__c,CreatedById,Sample_ID__c,Sample_Type__c,Due_Date__c,CreatedDate from Sample_Request__c Order By CreatedDate Desc limit 300];
        }
        List<id> attids = new List<id>();
        for(Sample_Request__c m : WOlist1)
        { 
            attids.add(m.id);
        }
        attr = [select id, name, parentid from Attachment where parentid =: attids ];
        for(Sample_Request__c m : WOlist1)
        { 
              wrapclassdemo w = new wrapclassdemo();
              w.mem = m;
              if(w.at == null)
              w.at = new List<Attachment> ();
              for (Attachment a :attr )
              if(a.parentid == m.id)
              w.at.add(a);
              wc.add(w); 
        }
        if(wc.size()>0)
        {
            if(wc.size() > count)   
            {    
                val=0;
                val2=30;
                for(Integer i=0; i<count; i++)                         
                    nextwc.add(wc[i]);                                            
                shownext = true;                                 
            }
            else                      
                nextwc = wc;     
        }
    }
    Public void Next()
     {
         Countnum = 0;
         showprev = true;
         nextwc .clear();
         Integer limit1 = 0;
         if(next+count < wc .size())
         {
              limit1 = next+count;
         }
         else
         {
              limit1 = wc .size();
              shownext= false;
         }
         co=0; 
         for(Integer i=next; i<limit1; i++)
         {
            nextwc.add(wc [i]);
            co+=1;
         }
         val=next+1;
         val2=next+co;    
         Next+=count;      
   }
   public void prev()
   {
       Countnum = 0;
       shownext=true;
       nextwc.clear();
       Integer limit1 = 0; 
       if(next-(count+count) > 0)
       {
            limit1 = next-count;
       }
       else
       {
            limit1 = next-count;
            showprev = false;
       }
       for(Integer i=next-(count+count); i<limit1; i++)
       {
           nextwc.add(wc [i]);
       }
       val2=next-count;
       val=next-(count+count)+1;
       Next-=count;
   }
       
          static testMethod void myUnitTest(){
               Opportunity opp=new Opportunity();
              opp.Name='sample1';
              // opp.AccountId=acc.id;
              opp.Lead_Source__c='Approved Index';
              opp.Primary_Service_Name__c='Technology List';
              opp.Division__c='Winners';
              opp.StageName='new';
              opp.Sample_To_Deal__c='other';
              opp.Uploaded_By__c='test';
              opp.ForecastCategoryName='pipeline';
              opp.Amount=500;
              opp.CloseDate=date.parse('1/13/2013');
              opp.Team_Uploaded_By__c='Winners';
              opp.Emt__c='idh';
              insert opp;
              lead objLead = new Lead (LastName = 'Test data', Email = 'test@gmail.com', mobilephone = '+1234567890', Company = 'Test company');
              insert objLead;
              Sample_Request__c SR=new Sample_Request__c();
              SR.Name='Test';
              SR.Opportunity__c=opp.Id;
              sr.lead__c=objLead.id;
              sr.Special_Instructions__c='testingdata';
              insert SR;
              update sr;
  
              Attachment Att=new Attachment();
              Att.Name='TestAtt';
              string str='testtesttest';
              Blob blbVal = Blob.valueof(str);
              Att.Body=blbVal ;
              Att.ParentId=SR.Id;
              insert Att;
  
              Download_Attachments_Paging.wrapclassdemo wrp= new Download_Attachments_Paging.wrapclassdemo();
              Download_Attachments_Paging DA=new Download_Attachments_Paging(); 
              DA.count=0;
              DA.next=0;
              DA.Next();
              DA.prev();
              DA.getshownext();
              DA.getshowprev();
             
              
              
              
      }
       
}