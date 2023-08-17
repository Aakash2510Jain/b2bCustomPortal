public without sharing class LogUtility {
		public String recordID {get;set;}
		public String objectName {get;set;}
		public LogUtility(ApexPages.StandardController controller){
			recordID = controller.getRecord().Id;
			controller.getRecord().getSObjectType();
			objectName = controller.getRecord().getSObjectType().getDescribe().getName();
			System.debug('RECORDID :'+recordID +'-----------------OBJECTNAME :'+controller.getRecord().getSObjectType());
		}
		
		public void LogRecord(){
			RecordViewLogs__c viewLog = new RecordViewLogs__c();
			viewLog.Object__c = objectName;
			viewLog.Record_ID__c = recordID;
			viewLog.User_Viewed__c = Userinfo.getUserId();
			viewLog.Viewed_On__c = System.now();
			viewLog.User_Viewed_Link__c = Userinfo.getUserId();
			System.debug('---------------------'+viewLog);
			insert viewLog;
		}
		
   public static testmethod void testLogUtility(){
   				 lead lea=new lead();
                 lea.LastName='name';
                 lea.Email='sample@sap.com';
                 lea.Company='SOS'; 
                 lea.Division_Name__c='Winners';
                 lea.Primary_Service_Name__c='Email Appending';
                 lea.LeadSource='Customer Service';
                 lea.Status='Yet to Initiate';    
                 lea.Lead_AssignedTo__c ='Andy Rodgers (Winners)';
                 insert lea;
   	
   	ApexPages.StandardController sc = new ApexPages.standardController(lea);
		LogUtility lUtility = new LogUtility(sc);
		lUtility.objectName='lead';
		lUtility.LogRecord();
   }		
}