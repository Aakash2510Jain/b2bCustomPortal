trigger trackStatus on Docusign_Status__c (before insert) {
   list<Docusign_Status__c> statusEnvelope = new list<Docusign_Status__c> ();
    for(Docusign_Status__c doc:trigger.new){
    	statusEnvelope = [Select  Envelope_Id__c,Opportunity__c From Docusign_Status__c where Envelope_Id__c=:doc.Envelope_Id__c];
    	if(statusEnvelope.size() >0){
    		system.debug('*****hhhhhh'+statusEnvelope.size());
    		if(doc.Opportunity__c==null  && doc.Envelope_Id__c!=null){
        	//statusEnvelope = [Select  Envelope_Id__c,Opportunity__c From Docusign_Status__c where Envelope_Id__c=:doc.Envelope_Id__c];
        	doc.Opportunity__c=statusEnvelope[0].Opportunity__c; 
       			system.debug('*****hhhhhh'+doc.Opportunity__c);  
    	}
       } 
    }
}