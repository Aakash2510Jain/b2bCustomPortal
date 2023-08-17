public class MeetingScheduleController {
    public Id Id{get;set;}
    public list<Lead> l = new list<Lead>();
    public String eventLeadId {get;set;}
    public Event eventRecord {get;set;}
    public String uploadedBy {get;set;}
    public boolean showMeeting = false;
    public boolean ShowList = true;
    public MeetingScheduleController(ApexPages.StandardController controller) {
        uploadedBy = Apexpages.currentPage().getParameters().get('uploadedBy');
        System.debug('RRRRRRRRRRRRRRRRR'+uploadedBy);
            if(uploadedBy== null){
                ShowList = false;
                ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,'No LeadGen Name specified, try again or reach Salesforce Administrator.'));
            }
            System.debug('-------------------'+uploadedBy);
            eventRecord = new Event();
            loadLeads();
            showMeeting = false;
    }   
    public Map<Id,Lead> leadMap {get;set;}     
    
    public void loadLeads(){
        if(uploadedBy != null){
            leadMap = new Map<Id,Lead>([select Id,Name,Company,Email,OwnerId,Owner.Name,CreatedDate, 
                LastActivityDate from Lead where User_name__c =:uploadedBy and CreatedDate = THIS_WEEK and isConverted=false]);
        }else{
            leadMap = new Map<Id,Lead>();
        }
        System.debug('LOAD LEADS :'+leadMap);
    }   
    public List<Lead> getLeadsForUser(){
        if(leadMap.size() > 0){
            return leadMap.values();
        }
        return new List<Lead>();
    }
    public Lead eventLeadRecord {get;set;}
    public PageReference setEvent(){
        uploadedBy = apexpages.currentpage().getparameters().get('uploadedBy');
        eventLeadId= apexpages.currentpage().getparameters().get('eventLeadId');  
        System.debug('uploadedBy : '+uploadedBy);
        System.debug('eventLeadId: '+eventLeadId);
          
        System.debug('MAP LIST : '+leadMap);
        System.debug('PARAM : '+uploadedBy +'------------'+eventLeadId);    
        eventLeadRecord = new Lead();
        eventLeadRecord = leadMap.get(eventLeadId);
        System.debug('Selected Lead Record : '+eventLeadRecord+'---------------'+eventLeadId);
        eventRecord.WhoId = eventLeadId;
        eventRecord.Type = 'Meeting';
        eventRecord.Lead_Gen_Name__c = uploadedBy;
        eventRecord.OwnerId = eventLeadRecord.OwnerId;
        eventRecord.IsReminderSet = false;
        showMeeting = true;
        return null;
    }
    
    public PageReference saveEvent(){
        try{
            if(eventRecord.ReminderDateTime != null){
                eventRecord.IsReminderSet = true;
            }
            insert eventRecord;
            eventRecord = new Event();
            showMeeting = false;
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO,'Meeting Scheduled Successfully'));
        }catch(Exception er){
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,'Meeting was not scheduled. Please try again or reach out to Salesforce Administrator.'));
        }
        return null;
    }
    
    public boolean getShowMeetingStatus(){
        return showMeeting;
    }
    public boolean getShowList(){
        return ShowList;
    }
    
   public static testmethod void Test_MeetingScheduleController(){
   	
   	LeadFormUsers__c l1=new LeadFormUsers__c();
   	l1.EMail_ID__c='xyzas@gmail.com';
   	l1.Name='sraj';
   	insert l1;
   	
   LeadFormUsers__c	leadFormUser = [Select Id, Name, Email_Id__c from LeadFormUsers__c where Name ='sraj'];
	   	Lead leadRec = new Lead();
        leadRec.Company = 'Test';
        leadRec.Country = 'India';
        leadRec.Email='vinaypatel.hyd@gmail.com';
        leadRec.LastName='testing';
        leadRec.LeadSource='Other';
        leadRec.Lead_AssignedTo__c='Ben Adams (Rainmakers)';
        leadRec.Primary_Service_Name__c='InfocheckPoint';
        leadRec.Sub_Division_Name__c='Health Care Data Group';
        leadRec.Division_Name__c='Winners';
        leadRec.Status='Yet to Initiate';
        leadRec.LinkedIn_URL__c='srivarsha379/linkedin.com';
        leadRec.User_Name__c=leadFormUser.Name;
        leadRec.IgnoreTriggerCheck__c=true;
        insert leadRec;
        Event e1 =new Event();
        e1.DurationInMinutes=10;
        e1.ActivityDateTime=date.valueOf('2013-03-21T23:01:01Z'); 
        insert e1;
       
       
    
    
     Lead leadFor = new Lead();
     ApexPages.standardController stdcon = new ApexPages.standardController(leadFor);
     PageReference testpr = Page.LeadMeetingSchedule; 
   	 Test.setCurrentPage(testpr);
   	 ApexPages.CurrentPage().getparameters().put('uploadedBy',leadFormUser.Name);
   	 ApexPages.CurrentPage().getparameters().put('eventLeadId',leadRec.id);
     MeetingScheduleController Msc=new MeetingScheduleController(stdcon);
     Msc.eventRecord=e1;
   	 Msc.ShowList=true;
  	 Msc.showMeeting=false;
  	 Msc.getShowList();
  	 Msc.getShowMeetingStatus();
  	 Msc.loadLeads();
  	 Msc.getLeadsForUser();
  	 Msc.saveEvent();
  	 Msc.setEvent();
   }
}