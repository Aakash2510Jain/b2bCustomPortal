@isTest (seealldata=true)

	private class LeadColumnPageTest {
		static testmethod void mytestLeadColumnPage(){
			   
			   		LeadFormUsers__c lef = new LeadFormUsers__c();			
		lef.UserName__c = 'demo@scs.com';
		lef.Name = 'demo';
		lef.Division__c = 'Rainmakers';
		insert lef;
			system.debug('_______________'+lef.id);

		Session__c ss=new Session__c();
        ss.Session_For_LeadFormUsers__c=lef.id;
        ss.SessionId__c='38856717452355';   
        insert ss;  
   		
   		ApexPages.currentPage().getParameters().Put('Id',lef.id);
	    ApexPages.currentPage().getParameters().Put('sessionId',ss.SessionId__c);
			   
			    LeadColumnPage coltest = new LeadColumnPage();
			    //coltest.LeadformUserID=lef.Id;
	    		coltest.SessionID=ss.SessionId__c;
            	coltest.doSearch();
    			}
		}