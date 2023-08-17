trigger SendEmailToLeadGen on Lead (after update) {
	//SOS__c customSettings = SOS__c.getInstance();
	//String supportEmail = customSettings.Dev_Support_Email__c;
	List<String> updateLead = new List<String>();
     for(Lead l : trigger.new){ 
     	System.debug('LEAD RECORD : '+l);
          if(l.Id != null && l.User_EmailId__c !=null && !l.EmailConformanceToLeadGen__c){
                updateLead.add(l.Id); 
           }
    }
    if(updateLead.size() > 0){
    	SOS__c customSettings = SOS__c.getInstance();
        String supportEmail = customSettings.Dev_Support_Email__c;
        SendEmailLeadUser.sendEmail(updateLead, supportEmail); 
    }
}