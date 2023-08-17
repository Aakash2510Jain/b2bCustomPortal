@istest (seealldata=true)
	public with sharing class PieChartController2Test {
		static testmethod void mytestPiechartController(){
			LeadFormUsers__c FormUsers = new LeadFormUsers__c();			
		FormUsers.UserName__c = 'demo@scs.com';
		FormUsers.Name = 'demo';
		FormUsers.Division__c = 'Rainmakers';
		insert FormUsers;
			
		Session__c ss=new Session__c();
        ss.Session_For_LeadFormUsers__c=FormUsers.id;
        ss.SessionId__c='38856717452355';   
        insert ss;  
		

			ApexPages.currentPage().getParameters().Put('Id',FormUsers.id);
	    ApexPages.currentPage().getParameters().Put('sessionId',ss.SessionId__c);
	    
	    PieChartController2 pie=new PieChartController2();
	    pie.getPieData3();
		
		}
}