Public Class Download_Attachments
{
public class wrapclassdemo{
  public Sample_Request__c mem {get; set; }
  public List<Attachment> at {get; set; }
  }
  public List<wrapclassdemo> wcc { 
  get {
   return wc;
  }
    set; }

  public List<wrapclassdemo> wc  = new List<wrapclassdemo> ();
  Public Sample_Request__c WO{get;set;}
  public list<Sample_Request__c> WOlist1{get;set;}
  public List<Attachment> attr = new List<Attachment> ();
  public List<Attachment> attachment {
        get {
            return attr;
        }
 
        set;
    }
  public Download_Attachments(){
  //User U=[select Id,Name,ProfileId from User limit 1];
  //if(U.ProfileId!='System Administrator'){
  WOlist1=[select id,Name,LeadID__c,Lead__r.id,Opportunity_Number__c,Opportunity__r.id, Sample_Replied_Date__c,CreatedById,Sample_ID__c,Sample_Type__c,Due_Date__c,CreatedDate from Sample_Request__c where CreatedById =: UserInfo.getUserId()Order By CreatedDate Desc limit 500];
  
  List<id> attids = new List<id>();
  for(Sample_Request__c m : WOlist1){ 
  attids.add(m.id);
  }
  attr = [select id, name, parentid from Attachment where parentid =: attids ];
  
  for(Sample_Request__c m : WOlist1){ 
  wrapclassdemo w = new wrapclassdemo();
  w.mem = m;
  if(w.at == null)
  w.at = new List<Attachment> ();
  for (Attachment a :attr )
  if(a.parentid == m.id)
  w.at.add(a);
 
  wc.add(w); 
  }
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
  
  Download_Attachments.wrapclassdemo wrp= new Download_Attachments.wrapclassdemo();
  Download_Attachments DA=new Download_Attachments();
  
  }
       
}