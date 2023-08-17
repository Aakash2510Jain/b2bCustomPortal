@isTest (seealldata=true)

  private class LeadoppcoloumpageTest{
    static testmethod void mytestLeadoppcoloumpage(){
    
         LeadFormUsers__c lef = new LeadFormUsers__c();      
    lef.UserName__c = 'bharath.t@istrategicloud.com';
    lef.Name = 'demo';
    lef.Division__c = 'Rainmakers';
    insert lef;
      system.debug('_______________'+lef.id);

    Session__c ss=new Session__c();
        ss.Session_For_LeadFormUsers__c=lef.id;
        ss.SessionId__c='15600084825717';  
        insert ss;  
       
       ApexPages.currentPage().getParameters().Put('Id',lef.id);
      ApexPages.currentPage().getParameters().Put('sessionId',ss.SessionId__c);
         
          Leadoppcoloumpage coltest = new Leadoppcoloumpage();
			    //coltest.LeadformUserID=lef.Id;
	    		coltest.SessionID=ss.SessionId__c;
            	coltest.doSearch();
          }
    }