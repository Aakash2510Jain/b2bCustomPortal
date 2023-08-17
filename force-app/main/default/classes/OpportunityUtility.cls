public without sharing class OpportunityUtility {
	public static void assignAccountToAM(String opportunityId){
		Opportunity oppRec = [Select Id, AccountId,OwnerId,Owner.Account_Manager__r.Id,
			Owner.Account_Manager__c,Account.OwnerId,Account.Owner.Is_Account_Manager__c from Opportunity where Id =: opportunityId];
			system.debug('oppRec.Account.Owner.Is_Account_Manager__c'+oppRec.Account.Owner.Is_Account_Manager__c);
			system.debug('oppRec.Owner.Account_Manager__c'+oppRec.Owner.Account_Manager__c);
			system.debug('oppRec.Owner.Account_Manager__r.Id'+oppRec.Owner.Account_Manager__r.Id+' oppRec.Account.OwnerId'+ oppRec.Account.OwnerId);			
		if(oppRec.Account.Owner.Is_Account_Manager__c == false && 
				oppRec.Owner.Account_Manager__c != null && 
						oppRec.Owner.Account_Manager__r.Id != oppRec.Account.OwnerId){
			Account accountRec = [Select Id,OwnerId from Account where Id=: oppRec.AccountId];
			accountRec.OwnerId =oppRec.Owner.Account_Manager__c;
			update accountRec; 
		}
	}
}