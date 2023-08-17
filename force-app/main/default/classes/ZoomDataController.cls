public with sharing class ZoomDataController {

	public string sessionID = '';
	public string LeadformUserId = '';
	public LeadFormUsers__c leadGen;
	public string username {get;set;}
	public string Url {get;set;}
	
	public ZoomDataController(){
		sessionID = system.currentPageReference().getParameters().get('sessionId');
		system.debug('session id of the logged in user'+sessionID);
		if(sessionID != null){
			Session__c ses = [Select Session_For__c, Session_For_LeadFormUsers__c, SessionId__c  From Session__c s where Sessionid__c=:sessionID];
			LeadformUserId = ses.Session_For_LeadFormUsers__c;
		}
		system.debug('LeadGen id '+LeadformUserId);
		leadGen = [SELECT EMail_ID__c,Floor__c,Id,IsDeleted,Manager__c,
              			  Name,OwnerId,Password__c,UserName__c FROM LeadFormUsers__c where ID = :LeadformUserId];
			if(leadGen!=null){
				username = leadGen.UserName__c;
				system.debug('user name of the logged in leadgen'+username);
			}		
			
	}

}