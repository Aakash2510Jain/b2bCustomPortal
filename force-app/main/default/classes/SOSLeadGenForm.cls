public without sharing class SOSLeadGenForm {	
	public Lead leadRecord{get;set;}
	public Attachment Att1{get;set;}   
	public Attachment Att2{get;set;}
	public Attachment Att3{get;set;}
	public Attachment Att4{get;set;}
	public Attachment Att5{get;set;}
	public Boolean theHiddenInput{get;set;}
	public Boolean theHiddenOut{get;set;}
	//public Map<String,List<String>> formFloorMap = new Map<string,List<String>>();
	public Map<String,String> formFloorMap = new Map<string,String>();
	public Map<String,String> selfGenLeadFloorMap = new Map<string,String>();
	public Map<String,String> divisionFormMap = new Map<string,String>();
	public Boolean flag=false;
	
	Lead listLead=new Lead();
	List<String> parts= new List<String>();
	LeadFormUsers__c leadFormUser = new LeadFormUsers__c();
	public boolean displayPopup {get; set;} 
	
	public String strUse{get;set;}
	
	//============New Enhancement===============//
	public list<string> divlist;
	List<String> FinalDivision = new List<String>();
	List<string> FinalTeam = new List<string>();
	public String FinalEmail;
	public String FinaldivisionUser;
	public String FinalUName1{get;set;}
	public String FinalsessionId;
	public 	string domainname{get;set;}
	public  String divisionUser{get;set;} 
	public  String UName1{get;set;}
	public  String sessionId{get;set;}
	public  String Emailid{get;set;}
	//============New Enhancement===============//
	
	String splitStr = '';
	public  Date lastDate;
	public Map<String,String> queueMap = new Map<String,String>();
	WebFormLeadController__c customsetting = [select NoLoginTime__c,NoActivityLeads__c,Lead_Validity__c,Account_Validity__c from WebFormLeadController__c];
		decimal daysofLead = customSetting.Lead_Validity__c;
	    decimal daysofAccount = customSetting.Account_Validity__c;
	    decimal noActivityLeads = customSetting.NoActivityLeads__c;
	    decimal nologintime = customSetting.NoLoginTime__c;
    public SOSLeadGenForm(ApexPages.StandardController controller){
    	
    }
    /*Code enhancement by vinay*/
    		public string domain;
			public string msgValid{get;set;}
			public string emailToValidate{get;set;}
															
			public boolean validateAllEmails(string emailToValidate){
				if(emailToValidate!=null&&emailToValidate!=''){
					List<Config__c> cmail = new List<Config__c>();
					 cmail=[select name,Blacklisted_Domains__c from Config__c where Key__c='Blacklisted'];
					if(cmail.size()>0){
					List<String> parts= new List<String>();
					if(cmail[0].Blacklisted_Domains__c!=null){
				    		   string emailDomain=cmail[0].Blacklisted_Domains__c;
				   			   list<string> mailDomain=emailDomain.split(',');
						 	   parts = emailToValidate.split('@',2);
						 	   domain=parts[1];
						 	   system.debug('$$$$$$$domain'+domain);
				         	   //msgValid='Valid Email';
				               for(string m:mailDomain){
				               	system.debug('$$$$$$$mmmmmmmmmmm'+m);
					          		if(domain==m)
					              		//msgValid='Not Valid domain';
					              		return false;
					         	}
				        	 }
					}
				}
			return true;  
			}
		/*Code enhancement by vinay*/	    
		  
	public SOSLeadGenForm()
	{
		//============New Enhancement===============//
		divisionUser = ApexPages.currentPage().getParameters().get('div');
		UName1 = ApexPages.currentPage().getParameters().get('UName');
		Emailid = Apexpages.currentPage().getParameters().get('Emailid');
		sessionId = Apexpages.currentPage().getParameters().get('sessionId');
					
		if (Emailid != null)
			FinalEmail =Emailid;
		if (divisionUser != null)
			FinaldivisionUser =divisionUser;
		if (UName1 != null)
			FinalUName1 =UName1;
		if (sessionId != null)
			FinalsessionId =sessionId;
		
		//============New Enhancement===============//	
		
		//theHiddenOut=false;
		System.debug(nologintime+'------------'+daysofAccount+'----------'+daysofLead+'---------'+noActivityLeads);
		System.debug('LeadFrom SFDC:'+theHiddenInput+'------------'+strUse);
			if(strUse==null ||strUse==''){
				System.debug('inside strUse showpopup');
				showPopup();
			}
			Att1=new Attachment();
			Att2=new Attachment();
			Att3=new Attachment();
			Att4=new Attachment();
			Att5=new Attachment();
			leadRecord=new Lead (); 
			
			/*sathya if(strUse!=null){
			system.debug('@@@@@@@@@@@@@@@'+strUse);
					leadRecord.Team_Identification__c=strUse;
			}    */
			system.debug  ('#####domainName####'+domainname);
			queueMap.put('Alex','00G900000010Lqz');
			queueMap.put('Michelle','00G900000010Lr4');
			queueMap.put('Raymond Phillips','00G900000010neN');
			queueMap.put('Marshal Sequira','00G900000010pWU');
			queueMap.put('Max Tyler','00G900000010pXG');
			queueMap.put('Sam Green','00G900000012qt2');
			queueMap.put('Sean Fischer','00G900000013cVo');
			queueMap.put('MPO','00G90000001Ahl1');
			queueMap.put('Web team','00G9000000109Vj');
			queueMap.put('Campaign','00G9000000109Vt');
			queueMap.put('Content','00G9000000109Vy');
			queueMap.put('LeadGen','00G9000000109W8');
			queueMap.put('Sales Manager Gary Mayers','00G9000000109ZY');
			queueMap.put('Jeff Anderson','00G9000000109WD');
			queueMap.put('Blake Cooper','00G9000000109WS');
			queueMap.put('Manager Robin Smith','00G9000000109Wm');
			queueMap.put('Manager Steve Sujith','00G9000000109Vk');
			queueMap.put('Manager Roger Smith','00G9000000109Yr');
			queueMap.put('Team WML','00G90000001OuUr');
			
			List<String> thirdFloor = new List<String>();
			thirdFloor.add('Rainmakers');
			thirdFloor.add('Titans');
			thirdFloor.add('Team WML');
			String thirdFloorStr = '(\'Rainmakers\',\'Titans\',\'Team WML\')';
			
			List<String> secondFloor = new List<String>();
			secondFloor.add('Spartans');
			secondFloor.add('Mauryas');
			secondFloor.add('Mavericks');
			secondFloor.add('Stallions');
			String secondFloorStr = '(\'Spartans\',\'Mauryas\',\'Mavericks\',\'Stallions\')';
			  
			system.debug('this is the first initiation');
			
			List<String> firstFloor = new List<String>();
			firstFloor.add('Winners');
			firstFloor.add('Jaguars');
			String firstFloorStr = '(\'Winners\',\'Jaguars\')';
			
			List<String> groundFloor = new List<String>();
			groundFloor.add('Gladiators');
			String groundFloorStr = '(\'Gladiators\')';
			
			//============New Enhancement===============//
			List<String> AllFloor = new List<String>();
			AllFloor.add('Gladiators');
			AllFloor.add('Jaguars');
			AllFloor.add('Winners');
			AllFloor.add('Stallions');
			AllFloor.add('Rainmakers');
			AllFloor.add('Mavericks');
			AllFloor.add('Mauryas');
			AllFloor.add('Spartans');
			AllFloor.add('Team WML');
			AllFloor.add('Titans');
			AllFloor.add('Content Team');
			AllFloor.add('Web Team');
			AllFloor.add('Social Media');
			AllFloor.add('Campaign Team');
			//============New Enhancement===============//
			
			
			selfGenLeadFloorMap.put('Rainmakers',thirdFloorStr);
			selfGenLeadFloorMap.put('Titans',thirdFloorStr);
			selfGenLeadFloorMap.put('Team WML',thirdFloorStr);
			selfGenLeadFloorMap.put('Spartans',secondFloorStr);
			selfGenLeadFloorMap.put('Mauryas',secondFloorStr);
			selfGenLeadFloorMap.put('Mavericks',secondFloorStr);
			selfGenLeadFloorMap.put('Stallions',secondFloorStr);
			selfGenLeadFloorMap.put('Winners',firstFloorStr);
			selfGenLeadFloorMap.put('Jaguars',firstFloorStr);
			selfGenLeadFloorMap.put('Gladiators',groundFloorStr);
			
			//selfGenLeadFloorMap.put('Gladiators',firstFloor);
			//selfGenLeadFloorMap.put('Jaguars',firstFloor);
			//selfGenLeadFloorMap.put('Mavericks',firstFloor);
			//selfGenLeadFloorMap.put('Mauryas',firstFloor);
			//selfGenLeadFloorMap.put('Cuesent',firstFloor);
			//selfGenLeadFloorMap.put('Stallions',firstFloor);
			//selfGenLeadFloorMap.put('Marketing outsourcing',firstFloor);
			//selfGenLeadFloorMap.put('MPO',firstFloor);
			//selfGenLeadFloorMap.put('Social Media',firstFloor);
			//selfGenLeadFloorMap.put('Content Team',firstFloor);
			
			formFloorMap.put('Alex',thirdFloorStr);
			formFloorMap.put('Manager Roger Smith',thirdFloorStr);
			formFloorMap.put('Sales Manager Gary Mayers',thirdFloorStr);
			formFloorMap.put('Team WML',thirdFloorStr);
			formFloorMap.put('Manager Robin Smith',secondFloorStr);
			formFloorMap.put('Marshal Sequira',secondFloorStr);
			formFloorMap.put('Max Tyler',secondFloorStr);
			formFloorMap.put('Raymond Phillips',secondFloorStr);
			formFloorMap.put('Jeff Anderson',firstFloorStr);
			formFloorMap.put('Michelle',firstFloorStr);
			formFloorMap.put('Manager Steve Sujith',firstFloorStr);
			
			//formFloorMap.put('Web team','\'Web team\'');
			//formFloorMap.put('Campaign','\'Campaign\'');
			//formFloorMap.put('Content','\'Content\'');
			//formFloorMap.put('MPO','\'MPO\'');
			
			//formFloorMap.put('LeadGen','\'LeadGen\'');
			//formFloorMap.put('Sam Green','\'Sam Green\'');
			//formFloorMap.put('Sean Fischer','\'Sean Fischer\'');
			
			
			
			
			//============New Enhancement===============//
			List<string>TeamFirstFloor =new List<string>();
			TeamFirstFloor.add('Manager Steve Sujith');
			TeamFirstFloor.add('Michelle');
			TeamFirstFloor.add('Jeff Anderson');
			
			List<String> TeamSecondFloor = new List<string>();
			TeamSecondFloor.add('Raymond Phillips');
			TeamSecondFloor.add('Max Tyler');
			TeamSecondFloor.add('Marshal Sequira');
			TeamSecondFloor.add('Manager Robin Smith');
			
			List<string>TeamThirdFloor =new List<string>();
			TeamThirdFloor.add('Team WML');
			TeamThirdFloor.add('Sales Manager Gary Mayers');
			TeamThirdFloor.add('Manager Roger Smith');
			TeamThirdFloor.add('Alex');
			
			List<string>TeamAllFloor =new List<string>();
			TeamAllFloor.add('Manager Steve Sujith');
			TeamAllFloor.add('Michelle');
			TeamAllFloor.add('Jeff Anderson');
			TeamAllFloor.add('Raymond Phillips');
			TeamAllFloor.add('Max Tyler');
			TeamAllFloor.add('Marshal Sequira');
			TeamAllFloor.add('Manager Robin Smith');
			TeamAllFloor.add('Team WML');
			TeamAllFloor.add('Sales Manager Gary Mayers');
			TeamAllFloor.add('Manager Roger Smith');
			TeamAllFloor.add('Alex');
			TeamAllFloor.add('Web team');
			TeamAllFloor.add('Campaign');
			TeamAllFloor.add('Content');
			TeamAllFloor.add('Harsha Chandrasekhar(Social Media)');
			TeamAllFloor.add('MPO');
			//TeamAllFloor.add('LeadGen');
			//TeamAllFloor.add('Sam Green');
			//TeamAllFloor.add('Sean Fischer');
			
		  
			if (FinaldivisionUser != null){
				string div=selfGenLeadFloorMap.get(FinaldivisionUser);
				if(div != null){
					divlist=div.split(',');
				 	string trackdiv=divlist[0].SubString(2,6);
		        	boolean groundDiv=groundFloorStr.contains(trackdiv);
		        	boolean firstDiv=firstFloorStr.contains(trackdiv);
		        	boolean secondDiv=secondFloorStr.contains(trackdiv);
		        	boolean thirdDiv=thirdFloorStr.contains(trackdiv);
		        	if(groundDiv==true){
				 		FinalDivision=groundFloor;
				 		FinalTeam = TeamAllFloor;
				 	}else if(firstDiv==true){
				 		FinalDivision=firstFloor;
				 		FinalTeam = TeamFirstFloor;
				 	}else if(secondDiv==true){
				 		FinalDivision=secondFloor;
				 		FinalTeam = TeamSecondFloor;
				 	}else if(thirdDiv==true){
				 		FinalDivision=thirdFloor;
				 		FinalTeam = TeamThirdFloor;
				 	}
				}else {
					 FinalDivision = AllFloor;
					 FinalTeam = TeamAllFloor;
			 		system.debug('&&&&&&&&&'+FinalDivision);
			 	 }
			}
			else {
				 FinalDivision = AllFloor;
				 FinalTeam = TeamAllFloor;
		 	system.debug('&&&&&&&&&'+FinalDivision);
		 	 }
			//============New Enhancement===============//
			/*
			Not used, this was created to validate the user selecting the form can provide leads to specified divisions only.
			//divisionFormMap.put('','Gladiators');
			//divisionFormMap.put('','Jauguars');
			//divisionFormMap.put('','Mavericks');
			//divisionFormMap.put('','Mauryas');
			//divisionFormMap.put('','Cuesent');
			//divisionFormMap.put('','Stallions');
			//divisionFormMap.put('','Marketing outsourcing');
			//divisionFormMap.put('','Social Media');
			//divisionFormMap.put('','Content Team');
			divisionFormMap.put('Alex','Rainmakers');
			divisionFormMap.put('Manager Roger Smith','Rainmakers');
			divisionFormMap.put('Sales Manager Gary Mayers','Titans');
			divisionFormMap.put('Team WML','Team WML');
			divisionFormMap.put('Manager Robin Smith','Spartans');
			divisionFormMap.put('Marshal Sequira','Spartans');
			divisionFormMap.put('Max Tyler','Spartans');
			divisionFormMap.put('Raymond Phillips','Spartans');
			divisionFormMap.put('Jeff Anderson','Winners');
			divisionFormMap.put('Michelle','Winners');
			divisionFormMap.put('Manager Steve Sujith','Winners');
			//divisionFormMap.put('Web team','Web team');
			//divisionFormMap.put('Campaign','');
			//divisionFormMap.put('Content','Content');
			divisionFormMap.put('MPO','MPO');
			//divisionFormMap.put('LeadGen','LeadGen');
			//divisionFormMap.put('Sam Green','Sam Green');
			//divisionFormMap.put('Sean Fischer','Sean Fischer');
			*/
	}
	//============New Enhancement===============//
	public List<SelectOption> getDomainlist(){
     	List<selectoption> options=new List<selectoption>();
        options.clear();
        options.add(new SelectOption('','--None--'));
        if(FinalDivision != null){
        	
        for(string s:FinalDivision){
        	options.add(new SelectOption(s,s));
        } 
        return options;
        }
        else {        	
          	return options;
        }
        
     }
    public List<SelectOption> getTeamList(){
    	List<selectoption> options=new List<selectoption>();
        options.clear();
        options.add(new SelectOption('','--None--'));
        if(FinalTeam != null){
        	
        	for(string s:FinalTeam){
        	options.add(new SelectOption(s,s));
        } 
        return options;
        }
        else {
        	return options;
        }
    }
    
  
      public void setdomainname(String s){
      	System.debug('SETTINGDOMAINNAME:'+s);
      	domainname = s;
      }
      public String getdomainname(){
      	return domainname;
      }
      public PageReference ValidDomain(){
         leadRecord.Division_Name__c = domainname;	 
         return null; 
      }
         
	
	public ApexPages.pagereference init(){
		if (FinalsessionId == null || FinalsessionId == ''){
			PageReference TalentRef = new PageReference('/apex/LeadGenLogin');
               			 TalentRef.setRedirect(true);
             return   TalentRef; 		
		}
		return null;
	}
	
	//============New Enhancement===============//
	public void closePopup() {   
			displayPopup = false; 
	}     

	public void showPopup() {        
			displayPopup = 	true;    
	}
	public pagereference cancelRecord(){
		return null;
	}
	
	public pagereference saveRecord(){
		return save();
	}
	
	
	public pagereference save(){ 
		
		
		System.debug('LEAD RECORD IS :'+leadRecord);
		System.debug('LeadFrom SFDC***:'+theHiddenInput);
		Lead newLeadRecord =  leadRecord;
		/*Code enhancement by vinay*/
		if(leadRecord.Email!=null){
			boolean Validflag = validateAllEmails(leadRecord.Email);
			if(!Validflag){
				ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,'Leads with entered Email id are of Blacklisted Email'));
				return  null;
			}
		}
		/*Code enhancement by vinay*/
		system.debug('@@@@FinalUName1@@@'+FinalUName1);
		system.debug('@@@@leadRecord.User_Name__c@@@'+leadRecord.User_Name__c);
			leadRecord.User_Name__c = FinalUName1;
			leadRecord.Users__c =FinalUName1;
			leadRecord.User_EmailId__c = FinalEmail;
			StrUse = leadRecord.Team_Identification__c;
			
			
			//System.debug('Lead User is :'+leadRecord.User_Name__c);
			/* sathya 
			
			try{
				if(leadRecord.Users__c != null){
					leadFormUser = [Select Id, Name, Email_Id__c from LeadFormUsers__c where Name =: leadRecord.Users__c];
						leadRecord.User_EmailId__c = leadFormUser.Email_Id__c ;
				}
			}catch(Exception e){
				System.debug('ERROR ON USERNMAE: '+e);
				ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO,'Lead was unsuccessfully, specified User Name does not exists'));
				return null;
			}
			
			sathya */
					
		boolean isUserAssigned = false;
		System.debug('LEAD RECORD IS :'+leadRecord);
		User u = null;
		try{
			pagereference pr;
				if (leadRecord.Lead_AssignedTo__c != NULL){
					try{
						u = [Select Id, Mapped_UserID_Name__c,Division,Email,LastLoginDate from User where Mapped_UserID_Name__c =: leadRecord.Lead_AssignedTo__c and isActive=true Limit 1];
					}catch(Exception e){
							ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO,'Lead AssignedTo User does not exists.'));
							return null;
					}
					leadRecord.OwnerId = u.Id;
					//leadRecord.User_EmailId__c = u.Email;
					isUserAssigned = true;
				}else if (leadRecord.Lead_AssignedTo__c == NULL){ // || queueMap.get(leadRecord.Lead_AssignedTo__c) != null){
					if(strUse!=null){
						leadRecord.OwnerId = queueMap.get(strUse);
				//NOT REQUIRED by Praveen Ramachandra 18th May 2013, rather we are using leadRecord.Division_name__c 
					}else{
						leadRecord.OwnerId = System.Userinfo.getUserId();
						u = [Select Id, Division,Mapped_UserID_Name__c,Email,LastLoginDate from User where id =: leadRecord.OwnerId and isActive=true Limit 1];
					}
				}
				if(strUse == 'None'){
					leadRecord.Team_Identification__c='';
				}
				leadRecord.User_Name__c = leadRecord.Users__c;
				leadRecord.IgnoreTriggerCheck__c=TRUE;
			System.debug('LEAD RECORD IS :'+leadRecord);
			
			// Code to validate the LeadClash Process by Praveen Ramachandra
			String emailSplit='';
			List<Spam_Email__c> spamemaillist = new List<Spam_Email__c>();
			List<Spam_Domain__c> spamdomainlist = new List<Spam_Domain__c>();
			List<String> parts= new List<String>();
			     emailSplit=leadRecord.Email;
			     parts = emailSplit.split('@',2);
			     spamemaillist = [select Name from Spam_Email__c where Name=: leadRecord.Email.TRIM()] ;
				 spamdomainlist = [select Name from Spam_Domain__c where Name=:parts ] ;
			
			boolean isSpamEmail = false;
			boolean isSpamList = false;
			boolean invalidCompany = false;
			boolean invalidWebsite = false;
			boolean invalidName = false;
			boolean invalidTitle = false;
			String errMsg = '';
			system.debug('leadRecord.Company'+leadRecord.Company);
			if(!Pattern.matches('^[a-z A-Z 0-9.,]*$',leadRecord.Company)){
				errMsg = 'Please correct the Company Name. No Special Character allowed except dot(.).';
				invalidCompany = true;
			}
			if(leadRecord.Website != null && !Pattern.matches('^[a-z A-Z 0-9.,\\-]*$',leadRecord.Website)){
				errMsg = 'Please correct the Company Website. No Special Character allowed except dot(.).';
				invalidWebsite = true;
			}
			if((leadRecord.FirstName != null && !Pattern.matches('^[a-z A-Z.,]*$',leadRecord.FirstName)) || !Pattern.matches('^[a-z A-Z.,]*$',leadRecord.LastName)){
				errMsg = 'Please correct the LeadName. No Special Character / Number allowed.';
				invalidName = true;
			}
			if(leadRecord.Title != null && !Pattern.matches('^[a-z A-Z.,]*$',leadRecord.Title)){
				errMsg = 'Please correct the Title. No Special Character / Number allowed.';
				invalidTitle = true;
			}
			boolean isNoActivityLeads = false;
			boolean isNoLoginTime = false;
			if(isUserAssigned && getNoActivityLeads(leadRecord.OwnerId) > Integer.valueOf(noActivityLeads)){
				errMsg = 'Selected BD have reached the limit of Leads with No Activity. Assign the lead to other BD.';
				isNoActivityLeads = true;
			}
			System.debug('AFTER NOACTIVITY ON LEADS - NOLOGINTIME:'+nologintime);
			System.debug('USER SELECTED IS :'+u);
			if(u != null && (u.LastLoginDate == null || 
				(isUserAssigned && getDifferenceInMinutes(System.now(),u.LastLoginDate) > nologintime))){
				errMsg = 'Selected BD has not LoggedIn recently as per to lead assignment policy. Please select other BD.';
				isNoLoginTime = true;	
			}
			System.debug('AFTER NOLOGIN ON SFDC');
			if(spamemaillist.size() > 0){
				 errMsg = 'The lead entered is part of the spam list';
				 isSpamEmail = true;
			}
			if(spamdomainlist.size() > 0){
				errMsg = 'The lead entered is part of the spam domain';
				isSpamList = true;
			}
			if(isSpamEmail || isSpamList || invalidCompany || invalidName || invalidTitle || invalidWebsite 
						|| isNoActivityLeads || isNoLoginTime){
				ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,errMsg));
				return  null;
			}
					
			try{
				// New FineTuned Code for Lead Clash - 03 May 2013 - Praveen Ramachandra
				//STEP 1
				// Check for existing contacts / leads in the system based on email id
				string leadEmailAddress;
				leadEmailAddress = leadRecord.Email;
				List<Contact> existingContactsList = new List<Contact>();
				system.debug('STRUSE****'+strUse);
				if(strUse != null){
					
					String queryIs = 'Select Id, FirstName, LastName, OwnerId, Owner.Email, Account.Division__c,'+
								'Owner.Name,Owner.GM__c, Owner.IsGM__c, AccountId, LastModifiedDate,Account.OwnerId,'+
								'Account.Owner.Account_Manager__c,Account.owner.Is_Account_Manager__c,Account.Owner.Name,'+
								'(Select Id, ActivityDate, Status  From ActivityHistories), (Select Id, ActivityDate, Status  From OpenActivities) '+   
								'from Contact where '+
								'email =\''+leadEmailAddress.trim()+'\'';
								System.debug('FormFloorMap : '+formFloorMap  +'--------strUse: '+strUse);
								if(formFloorMap.get(strUse) != null){
									queryIs = queryIs + ' and Account.Division__c IN '+formFloorMap.get(strUse);
								} 
								
								
								//************sathya***********
								else if(selfGenLeadFloorMap.get(leadRecord.Division_Name__c) != null){
									queryIs = queryIs + ' and Account.Division__c IN '+selfGenLeadFloorMap.get(leadRecord.Division_Name__c);
								}
								//************sathya***********
								
								
								
								queryIs = queryIs +' order by LastModifiedDate desc ';
					System.debug('CONTACT QUERY WITH STRUSE : '+queryIs);
					existingContactsList = Database.query(queryIs);			
				/*	existingContactsList = [Select Id, FirstName, LastName, OwnerId, Owner.Email, Account.Division__c,
								Owner.Name,Owner.GM__c, Owner.IsGM__c, AccountId, LastModifiedDate,Account.OwnerId,
								Account.Owner.Account_Manager__c,Account.owner.Is_Account_Manager__c,Account.Owner.Name,
								(Select Id, ActivityDate, Status  From ActivityHistories), (Select Id, ActivityDate, Status  From OpenActivities)   
								from Contact where 
								email =: leadRecord.Email and 
								Account.Division__c IN :formFloorMap.get(strUse)
								order by LastModifiedDate desc]; */
				}else{
					//NEED TO GET THE USER DIVISION AND CHECK OVER THE FLOOR MAP
					String queryIs = 'Select Id, FirstName, LastName, OwnerId, Owner.Email, Account.Division__c,'+
								'Owner.Name,Owner.GM__c, Owner.IsGM__c, AccountId, LastModifiedDate,Account.OwnerId,'+
								'Account.Owner.Account_Manager__c,Account.owner.Is_Account_Manager__c,Account.Owner.Name,'+
								'(Select Id, ActivityDate, Status  From ActivityHistories), (Select Id, ActivityDate, Status  From OpenActivities) '+   
								'from Contact where '+
								'email =\''+leadEmailAddress.trim()+'\'';//'email =: leadRecord.Email ';
								System.debug('FormFloorMap : '+selfGenLeadFloorMap  +'--------strUse: '+leadRecord.Division_Name__c);
								
								// sathya***** 
								//if(formFloorMap.get(strUse) != null){
								
								if(selfGenLeadFloorMap.get(leadRecord.Division_Name__c) != null){	
									queryIs = queryIs + ' and Account.Division__c IN '+selfGenLeadFloorMap.get(leadRecord.Division_Name__c);
								} 
								
								queryIs = queryIs +' order by LastModifiedDate desc ';
					System.debug('CONTACT QUERY WITHOUT STRUSE : '+queryIs);
					existingContactsList = Database.query(queryIs);	
					/*existingContactsList = [Select Id, FirstName, LastName, OwnerId, Owner.Email, Account.Division__c,
								Owner.Name,Owner.GM__c, Owner.IsGM__c, AccountId, LastModifiedDate,Account.OwnerId,
								Account.Owner.Account_Manager__c,Account.owner.Is_Account_Manager__c,Account.Owner.Name,
								(Select Id, ActivityDate, Status  From ActivityHistories), (Select Id, ActivityDate, Status  From OpenActivities)   
								from Contact where 
								email =: leadRecord.Email and 
								Account.Division__c IN :selfGenLeadFloorMap.get(leadRecord.Division_Name__c)
								order by LastModifiedDate desc];*/					
				}
				System.debug('CONTACTS :'+existingContactsList+'-----------------'+leadRecord.Email);
				List<Lead> duplicateLeadsList = new List<Lead>();
				if(strUse != null){
					String queryIs = 'Select Id, LeadID__c,Relevant_Partners1__c,Relevant_Partners2__c, '+
						'Top_Customers1__c,Top_Customers2__c,CreatedDate,LastModifiedDate,FirstName,LastName,Company, '+
						'LinkedIn_URL__c,User_Name__c,Twitter_URL__c,Division_Name__c,LinkedIn_Photo_URL__c,Customer_Products_and_Services__c, '+
						'Other_Locations_Branches__c,LastActivityDate,Owner.Name,Owner.Email, '+
						'(Select Id, ActivityDate,LastModifiedDate, Status  From ActivityHistories), (Select Id, ActivityDate,LastModifiedDate, Status  From OpenActivities), '+
						' CRM_Used__c,OwnerId from Lead where email =\''+leadEmailAddress.trim()+'\''+//email=:leadRecord.Email '+
						 ' and Owner.IsActive=true and isConverted=false and Status != \'Unqualified\' and Status != \'Lost\' and isDeleted=false ';
						System.debug('FormFloorMap : '+formFloorMap  +'--------strUse: '+strUse);
						if(formFloorMap.get(strUse) != null){
							queryIs = queryIs + ' and Division_Name__c  IN '+formFloorMap.get(strUse);
						}
						
				    	//************sathya***********
						else if(selfGenLeadFloorMap.get(leadRecord.Division_Name__c) != null){
							queryIs = queryIs + ' and Division_Name__c IN '+selfGenLeadFloorMap.get(leadRecord.Division_Name__c);
						}
						//************sathya***********
						
								
						queryIs = queryIs + ' Order by LastActivityDate desc';
						System.debug('QUERY IS :'+queryIs);
						duplicateLeadsList = Database.query(queryIs);	
					/*duplicateLeadsList = [Select Id, LeadID__c,Relevant_Partners1__c,Relevant_Partners2__c,
						Top_Customers1__c,Top_Customers2__c,CreatedDate,LastModifiedDate,FirstName,LastName,Company,
						LinkedIn_URL__c,User_Name__c,Twitter_URL__c,Division_Name__c,LinkedIn_Photo_URL__c,Customer_Products_and_Services__c,
						Other_Locations_Branches__c,LastActivityDate,Owner.Name,Owner.Email,
						(Select Id, ActivityDate,LastModifiedDate, Status  From ActivityHistories), (Select Id, ActivityDate,LastModifiedDate, Status  From OpenActivities),
						CRM_Used__c,OwnerId from Lead where email=:leadRecord.Email 
						 and Owner.IsActive=true and isConverted=false and Status != 'Unqualified' and Status != 'Lost' and isDeleted=false and
						Division_Name__c IN :formFloorMap.get(strUse)
						Order by LastActivityDate desc]; */
				}else{
					String queryIs = 'Select Id, LeadID__c,Relevant_Partners1__c,Relevant_Partners2__c, '+
						'Top_Customers1__c,Top_Customers2__c,CreatedDate,LastModifiedDate,FirstName,LastName,Company, '+
						'LinkedIn_URL__c,User_Name__c,Twitter_URL__c,Division_Name__c,LinkedIn_Photo_URL__c,Customer_Products_and_Services__c, '+
						'Other_Locations_Branches__c,LastActivityDate,Owner.Name,Owner.Email, '+
						'(Select Id, ActivityDate,LastModifiedDate, Status  From ActivityHistories), (Select Id, ActivityDate,LastModifiedDate, Status  From OpenActivities), '+
						' CRM_Used__c,OwnerId from Lead where email =\''+leadEmailAddress.trim()+'\''+//email=:leadRecord.Email '+
						 ' and Owner.IsActive=true and isConverted=false and Status != \'Unqualified\' and Status != \'Lost\' and isDeleted=false ';
						System.debug('FormFloorMap : '+selfGenLeadFloorMap  +'--------leadRecord.Division_Name__c: '+leadRecord.Division_Name__c);
						// sathya*****  if(formFloorMap.get(strUse) != null)
						if(selfGenLeadFloorMap.get(leadRecord.Division_Name__c) != null){	
							queryIs = queryIs + ' and Division_Name__c  IN '+selfGenLeadFloorMap.get(leadRecord.Division_Name__c);
						}
						queryIs = queryIs + ' Order by LastActivityDate desc';
						System.debug('QUERY IS :'+queryIs);
						duplicateLeadsList = Database.query(queryIs);	
					/*duplicateLeadsList = [Select Id, LeadID__c,Relevant_Partners1__c,Relevant_Partners2__c,
						Top_Customers1__c,Top_Customers2__c,CreatedDate,LastModifiedDate,FirstName,LastName,Company,
						LinkedIn_URL__c,User_Name__c,Twitter_URL__c,Division_Name__c,LinkedIn_Photo_URL__c,Customer_Products_and_Services__c,
						Other_Locations_Branches__c,LastActivityDate,Owner.Name,Owner.Email,
						(Select Id, ActivityDate,LastModifiedDate, Status  From ActivityHistories), (Select Id, ActivityDate,LastModifiedDate, Status  From OpenActivities),
						CRM_Used__c,OwnerId from Lead where email=:leadRecord.Email 
						 and Owner.IsActive=true and isConverted=false and Status != 'Unqualified' and Status != 'Lost' and isDeleted=false 
						 and Division_Name__c IN :selfGenLeadFloorMap.get(leadRecord.Division_Name__c)
						Order by LastActivityDate desc];*/
				}
				//STEP 2
				// IF Lead exists as Contact, then check on actvities and brand that of same as New Lead: Division
				// IF same brand exists then assign to the AM of the account else assign it to the recent activity account of any brand
				boolean leadProcessed = false;
				boolean leadAsContact = false;
				DateTime accountActivityDate = null;
				String message = '';
				Contact dupContact  = null;
				List<Opportunity> existingOpportunity = new List<Opportunity>();
				Map<String,Contact> contactAccountList = new Map<String,Contact>();
				Map<String,String> ownerLists = new Map<String,String>();
				Map<String,String> accountLists = new Map<String,String>();
				for(Contact contactOwner : existingContactsList){
					accountLists.put(contactOwner.AccountId,contactOwner.AccountId);
					contactAccountList.put(contactOwner.AccountId, contactOwner);
				}
				Map<Id,Account> accountsMap = new Map<Id,Account>([Select Id,Division__c,Owner.Is_Account_Manager__c,
										(Select Id, ActivityDate,LastModifiedDate, Status  From ActivityHistories), 
										(Select Id, ActivityDate,LastModifiedDate, Status  From OpenActivities),  
										(Select Id, CloseDate, StageName  From Opportunities where StageName='Deal'),  
										Owner.Account_Manager__c,Owner.Division from Account 
										where Id in :accountLists.values()]);
				System.debug('ACCOUNTS : '+accountsMap);						
				for(Account accOwner : accountsMap.values()){
					ownerLists.put(accOwner.OwnerId,accOwner.OwnerId);
				}						
				Map<Id,User> usersList = new Map<Id,User>([Select Id,Name, Mapped_UserID_Name__c,Division,Rating__c,Is_Account_Manager__c,
										Account_Manager__c,Account_Manager__r.Mapped_UserID_Name__c from User 
										where Id in :ownerLists.values() and isActive=true]);
										System.debug('USERS :'+usersList);
				/*code to check the opportunity is avilable are  not:vinay*/
   /*Modified By vinay */   
                if(existingContactsList.size() > 0){
                 	system.debug('Log01'+existingContactsList);
                 	for(Account contactOpp:accountsMap.values()){
                 		for(Opportunity openOpp:[select id,name,StageName,client_Name__c from opportunity where  Account.id=:contactOpp.id]){
                 			system.debug('Log02'+openOpp);
                 			existingOpportunity.add(openOpp);
                 		}
                 	}
                 if(existingOpportunity.size() > 0){	
                 	
                 	Note contactNote =new Note();
                 	String leadDetails = 'First Name:'+leadRecord.FirstName+'<br>'+
                    'LastName :'+leadRecord.LastName+'\n'+
                    'Lead Company :'+leadRecord.Company+'\n'+
                    'Email :'+leadRecord.Email+'\n'+
                    'Primary Service : '+leadRecord.Primary_Service_Name__c+'\n'+
                    'Division : '+leadRecord.Division_Name__c+'\n'+
                    'Sub Division : '+leadRecord.Sub_Division_Name__c+'\n'+
                    'Industry : '+leadRecord.Industry+'\n'+
                    'Website : '+leadRecord.Website+'\n'+
                    'Phone : '+leadRecord.Phone+'\n'+
                    'MobilePhone : '+leadRecord.MobilePhone+'\n'+
                    'Address : '+leadRecord.Street+','+leadRecord.State+','+leadRecord.Country+'\n'+
                    'Rating : '+leadRecord.Rating+'\n'+
                    'Purpose : '+leadRecord.Purpose_of_buying_this_List__c+'\n'+
                    'Comments : '+leadRecord.Comments__c+'\n'+
                    'Uploaded By : '+leadRecord.User_Name__c;
                 	contactNote.Body=leaddetails;
                 	contactNote.ParentId=existingContactsList[0].id;
                 	contactNote.Title='New Lead on :'+date.today();
                 	insert contactNote;
	                 	system.debug('^^^^^^^^^^^'+existingOpportunity);
	                 	system.debug('%%%%%%%%%%%%%'+existingContactsList);
	                 	ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO,'This Lead already exists as contact named '+existingContactsList[0].FirstName+''+existingContactsList[0].LastName));
	                 	ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO,'This Lead already exists as a Contact for the company: '+existingOpportunity[0].name));
	                 	return null;
                 	}
                 }
                 /*Modified by vinay*/ 
                  /*End:code to check the opportunity is avilable are  not:vinay*/						
				if(existingContactsList.size() > 0 && accountsMap.size()> 0 ){
					
					for(Account accRecord : accountsMap.values()){
						System.debug('CONTACTRECORD : '+accRecord);
						if(accRecord.Division__c == leadRecord.Division_Name__c && accRecord.Opportunities.size() > 0){
							System.debug('FOUND ACCOUNT OF SAME BRAND');
								if(!(usersList.get(accRecord.OwnerId)).Is_Account_Manager__c){
									leadRecord.OwnerId = ''+(usersList.get(accRecord.OwnerId)).Account_Manager__c;
									leadRecord.Lead_AssignedTo__c = (usersList.get(accRecord.OwnerId)).Account_Manager__r.Mapped_UserID_Name__c;
								}else{
									leadRecord.OwnerId = accRecord.OwnerId;
									leadRecord.Lead_AssignedTo__c = (usersList.get(accRecord.OwnerId)).Mapped_UserID_Name__c;
								}
								leadProcessed = true;
								leadAsContact = true;
								message = 'This Lead already exists as contact of \''+leadRecord.Division_Name__c+'\' and henceforth assigned to AM :'+ leadRecord.Lead_AssignedTo__c;
								
						}
					}
					for(Account accountRecord : accountsMap.values()){
						if(accountRecord.Opportunities.size() > 0){
							if(accountRecord.ActivityHistories.size() > 0 ){
								for(ActivityHistory accountActivityHistory : accountRecord.ActivityHistories){
									if(accountActivityDate != null){
										if(accountActivityHistory.ActivityDate > accountActivityDate){
											accountActivityDate = accountActivityHistory.LastModifiedDate;
											dupContact = contactAccountList.get(accountRecord.Id);//contactRecord;
										}
									}else{
										accountActivityDate = accountActivityHistory.LastModifiedDate;
										dupContact = contactAccountList.get(accountRecord.Id);
									}
								}	
							}else{
								dupContact = contactAccountList.get(accountRecord.Id);
							}
							if(accountRecord.OpenActivities.size() > 0){
								for(OpenActivity accountRecordOpenActivity : accountRecord.OpenActivities){
									if(accountActivityDate != null){
										if(accountRecordOpenActivity.ActivityDate > accountActivityDate){
											accountActivityDate = accountRecordOpenActivity.LastModifiedDate;
											dupContact = contactAccountList.get(accountRecord.Id);
										}
									}else{
										accountActivityDate = accountRecordOpenActivity.LastModifiedDate;
										dupContact = contactAccountList.get(accountRecord.Id);
									}
								}
							}else{
								dupContact = contactAccountList.get(accountRecord.Id);
							}
						}
					}
					if(!leadProcessed && dupContact != null){
						System.debug('FOUND DUP ACCOUNT OF DIFF BRAND : '+dupContact);
						System.debug('BEFORE PROCESSED LEAD : '+leadRecord);
						if(usersList.get(accountsMap.get(dupContact.AccountId).OwnerId).Is_Account_Manager__c != null && 
									!usersList.get(accountsMap.get(dupContact.AccountId).OwnerId).Is_Account_Manager__c){
										System.debug('into first');
								if(usersList.get(accountsMap.get(dupContact.AccountId).OwnerId).Account_Manager__c == null){
									leadRecord.OwnerId = accountsMap.get(dupContact.AccountId).OwnerId;
								}else{
									leadRecord.OwnerId = usersList.get(accountsMap.get(dupContact.AccountId).OwnerId).Account_Manager__c;
								}
								leadRecord.Division_Name__c = accountsMap.get(dupContact.AccountId).Division__c;
								leadRecord.Lead_AssignedTo__c = usersList.get(accountsMap.get(dupContact.AccountId).OwnerId).Account_Manager__r.Mapped_UserID_Name__c;
						}else{
							System.debug('into first------------');
							leadRecord.OwnerId = accountsMap.get(dupContact.AccountId).OwnerId;
							leadRecord.Division_Name__c = accountsMap.get(dupContact.AccountId).Division__c;
							leadRecord.Lead_AssignedTo__c = usersList.get(accountsMap.get(dupContact.AccountId).OwnerId).Mapped_UserID_Name__c;
						}
						System.debug('PROCESSED LEAD : '+leadRecord);
						leadProcessed = true;
						leadAsContact = true;
				//		ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO,'Lead was available as Contact of different brand so assigned to AM :'+leadRecord.OwnerId));
						message = 'This Lead already exists as contact of \''+leadRecord.Division_Name__c+'\' and henceforth assigned to AM :'+ usersList.get(accountsMap.get(dupContact.AccountId).OwnerId).Mapped_UserID_Name__c;
					}	
				}				
				
			//	insert leadRecord;
			//	ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO,'Lead was successfully created or assigned to :'+ leadRecord.OwnerId));
				
				//STEP 3
				// IF Lead exists as Lead already the check for activities and perform steps of
				// attaching note or reassinging to the GM of same brand of New Lead: Division
				if(duplicateLeadsList.size() > 0){
						DateTime leadActivityDateTime = null;
						boolean isDupLeadProcessed = false;
						Lead latestLeadwithActivity = new Lead();
						system.debug('$#DUPLICATES FOUND$#'+duplicateLeadsList);
						for(Lead existingLead : duplicateLeadsList){
							if(isDupLeadProcessed){
								break;
							}
							String ownerIdIs = existingLead.OwnerId;
							if(!ownerIdIs.startsWith('00G') && ownerIdIs != '00590000001LgZg' 
										&& ownerIdIs != '00590000001LgZi' && ownerIdIs != '00590000001LgZh') {
								for(ActivityHistory leadActivityHistory : existingLead.ActivityHistories){
									if(leadActivityDateTime != null){
										if(leadActivityHistory.LastModifiedDate > leadActivityDateTime){
											leadActivityDateTime = leadActivityHistory.LastModifiedDate;
											latestLeadwithActivity = existingLead;
										}
									}else{
										leadActivityDateTime = leadActivityHistory.LastModifiedDate;
										latestLeadwithActivity = existingLead;
									}
								}	
								for(OpenActivity leadRecordOpenActivity : existingLead.OpenActivities){
									if(leadActivityDateTime != null){
										if(leadRecordOpenActivity.LastModifiedDate > leadActivityDateTime){
											leadActivityDateTime = leadRecordOpenActivity.LastModifiedDate;
											latestLeadwithActivity = existingLead;
										}
									}else{
										leadActivityDateTime = leadRecordOpenActivity.LastModifiedDate;
										latestLeadwithActivity = existingLead;
									}
								}
								System.debug(existingLead.OwnerId+'*****************'+existingLead.Division_Name__c);
								if(latestLeadwithActivity.Id == null){
									latestLeadwithActivity = existingLead;
								}
							}
						}
						System.debug('LATEST DUPLICATE RECORD IDENTIFIED IS :'+latestLeadwithActivity);
							List<User> existingLeadOwners = [Select Id,Mapped_UserID_Name__c,Division,Rating__c from User 
										where Id =:latestLeadwithActivity.OwnerId 
										and isActive=true]; //and Division =: existingLead.Division_Name__c 
							System.debug('Existing LEads : Existing Users :'+existingLeadOwners);
							String strMessage = '';
							if(existingLeadOwners.size() > 0){
								//if(existingLeadOwners[0].Rating__c == 'A' || existingLeadOwners[0].Rating__c == 'A+'){
								//	System.debug('INTO A / A+');
								//	attachNoteAndUpdateLead(existingLead,leadRecord,false,null);
								//	newLeadRecord = existingLead;
								//}else{ // lead exists but owner is not rated for A or A+ and activity exists
									System.debug('NOT INTO A/A+');
									Integer activityGap = 0;
									//if(existingLead.LastActivityDate != null){
									//	activityGap = existingLead.LastActivityDate.daysBetween(System.Today());
									//	activityGap = activityGap * 60 * 24;
									//}else 
									if(leadActivityDateTime != null){
										activityGap = Integer.valueof(getDifferenceInMinutes(System.now(), leadActivityDateTime));
									}else{
										activityGap = Integer.valueof(getDifferenceInMinutes(System.now(), latestLeadwithActivity.LastModifiedDate));
									}
									System.debug('ACTIVITY GAP :'+activityGap +'------------daysofLead :'+daysofLead * 60 * 24+'-----------'+daysofLead);
									boolean reassigned = false;
									
									if( activityGap <= daysofLead * 60 * 24){ //existingLead.LastActivityDate != null &&
										attachNoteAndUpdateLead(latestLeadwithActivity,leadRecord,false,null);
										newLeadRecord = latestLeadwithActivity;
										strMessage = 'Note: This Lead was already Existing. Hence it is assigned to :';
										isDupLeadProcessed = true;
									}else{ // lead exists by but owner not A/A+ and No Activity, 
										// This has to be assigned to lead of same brand with respective GM
										List<User> gmUser  = [Select Id, Name, Email,GM__c,IsGM__c, Mapped_UserID_Name__c from User where isActive=true and isGM__c = true and GM__c != '' ];
										reassigned = true;
										attachNoteAndUpdateLead(latestLeadwithActivity,leadRecord,true,gmUser);
										newLeadRecord = latestLeadwithActivity;
										isDupLeadProcessed = true;
										strMessage = 'Note: This Lead was already Existing, but no activities. Hence it is re-assigned to GM. Previous Lead Owner Details:';
									}
								//}
								ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO,
								strMessage));
				        		ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO,'Previous Lead Owner :'+existingLeadOwners[0].Mapped_UserID_Name__c));
				        		ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO,'Previous Lead Uploaded By :'+latestLeadwithActivity.User_Name__c));
				        		ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO,'Previous Lead Modified On :'+latestLeadwithActivity.LastModifiedDate)); 
							}else{ // no existing lead 
								System.debug('EXISTING LEAD : NOT EXISTING OWNER, HENCE CREATING NEW');
									
									insert leadRecord;
									newLeadRecord = leadRecord;
									isDupLeadProcessed = true;
									ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO,'Lead was successfully created and assigned.'));
							}
							
							//else{
							//	ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO,'This lead already exists and is assigned to the Queue.'));
							//	return null;
							//}
						
				}else if(leadProcessed){
					insert leadRecord;
					newLeadRecord = leadRecord;
					//ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO,'Lead was successfully created and assigned.'));
					ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO,message));
				}else {
					insert leadRecord;
					newLeadRecord = leadRecord;
					ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO,'Lead was successfully created and assigned.'));
				}
				// End of FinedTuned Code for Lead Clash - 03 May 2013
			}catch(Exception err){
				System.debug(err.getStackTraceString());
				ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,err.getStackTraceString()));
				return null;
			}
			// End of code to validate the LeadClash Process
			System.debug('LEAD RECORD IS :'+leadRecord);
			System.debug('ATT1 :'+Att1);
			System.debug('ATT2 :'+Att2);
			System.debug('ATT3 :'+Att3);
			System.debug('ATT4 :'+Att4);
			System.debug('ATT5 :'+Att5);
         
			if(Att1.Body!=NULL) {
				Att1.ParentId =newLeadRecord.Id;             
				insert Att1;       
			}
			if(Att2.Body!=NULL) {             
				Att2.ParentId=newLeadRecord.Id;
				insert Att2;       
			}
			if(Att3.Body!=NULL) {             
				Att3.ParentId=newLeadRecord.Id;
				insert Att3;       
			}
			if(Att4.Body!=NULL) {             
				Att4.ParentId=newLeadRecord.Id;
				insert Att4;       
			}
			if(Att5.Body!=NULL) {  
				Att5.ParentId=newLeadRecord.Id;  
				insert Att5;       
			}
			parts.clear();
			leadRecord = new Lead();
			leadRecord.Team_Identification__c = strUse;

			//ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO,'Lead was successfully created and assigned.'));
			System.debug('return NULL');
		}catch(Exception e){
			System.debug(e.getStackTraceString());
			ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,'\nError Occured, Reach your Administrator. Summary :'+e));
		}
		//}
		System.debug('return NULL');
	  	return null; 
	}
	
	public double getDifferenceInMinutes(datetime firstDT, datetime secondDT){
		System.debug(firstDT+'------------------'+secondDT);   
	   long dt1 = firstDT.getTime() / 1000 / 60;  //getTime gives us milliseconds, so divide by 1000 for seconds   
	   long dt2 = secondDT.getTime() / 1000 / 60; 
	   double d = dt1 - dt2;
	   System.debug('TIME DIFF : '+d);
	   return d;
	}
	
	public void attachNoteAndUpdateLead(Lead existingLead,Lead leadRecord,Boolean reassigned, List<User> gmUsers){
		try{
			System.debug('ATTACHNOTE : '+existingLead+'----------'+leadRecord+'---------'+reassigned+'-------------'+gmUsers);
			//Note noteRec = new Note();
			Duplicate_Leads__c noteRec = new Duplicate_Leads__c();
			noteRec.Title__c = 'New Lead On :'+System.Now();
			String leadDetails = 'First Name:'+leadRecord.FirstName+'<br>'+
					'LastName :'+leadRecord.LastName+'<br>'+
					'Lead Company :'+leadRecord.Company+'<br>'+
					'Email :'+leadRecord.Email+'<br>'+
					'Primary Service : '+leadRecord.Primary_Service_Name__c+'<br>'+
					'Division : '+leadRecord.Division_Name__c+'<br>'+
					'Sub Division : '+leadRecord.Sub_Division_Name__c+'<br>'+
					'Industry : '+leadRecord.Industry+'<br>'+
					'Website : '+leadRecord.Website+'<br>'+
					'Phone : '+leadRecord.Phone+'<br>'+
					'MobilePhone : '+leadRecord.MobilePhone+'<br>'+
					'Address : '+leadRecord.Street+','+leadRecord.State+','+leadRecord.Country+'<br>'+
					'Rating : '+leadRecord.Rating+'<br>'+
					'Purpose : '+leadRecord.Purpose_of_buying_this_List__c+'<br>'+
					'Comments : '+leadRecord.Comments__c+'<br>'+
					'Uploaded By : '+leadRecord.User_Name__c;
			noteRec.Lead_Details__c = leadDetails; 
			noteRec.Uploaded_By__c = leadRecord.User_Name__c;
			noteRec.Parent_Lead__c = existingLead.Id;
			insert noteRec;
			System.debug('Duplicate Lead attached : '+noteRec);
			if(existingLead.LinkedIn_URL__c == null){
				existingLead.LinkedIn_URL__c = leadRecord.LinkedIn_URL__c;
			}
			if(existingLead.Twitter_URL__c == null){
				existingLead.Twitter_URL__c = leadRecord.Twitter_URL__c;
			}
			if(existingLead.LinkedIn_Photo_URL__c == null){
				existingLead.LinkedIn_Photo_URL__c = leadRecord.LinkedIn_Photo_URL__c;
			}
			if(existingLead.CRM_Used__c == null){
				existingLead.CRM_Used__c = leadRecord.CRM_Used__c;
			}
			//Relevant_Partners1__c,Relevant_Partners2__c,Top_Customers1__c,Top_Customers2__c
			if(existingLead.Relevant_Partners1__c == null){
				existingLead.Relevant_Partners1__c = leadRecord.Relevant_Partners1__c;
			}
			if(existingLead.Relevant_Partners2__c == null){
				existingLead.Relevant_Partners2__c = leadRecord.Relevant_Partners2__c;
			}
			if(existingLead.Top_Customers1__c == null){
				existingLead.Top_Customers1__c = leadRecord.Top_Customers1__c;
			}
			if(existingLead.Top_Customers2__c == null){
				existingLead.Top_Customers2__c = leadRecord.Top_Customers2__c;
			}
			if(existingLead.Customer_Products_and_Services__c == null){
				existingLead.Customer_Products_and_Services__c = leadRecord.Customer_Products_and_Services__c;
			}
			if(existingLead.Other_Locations_Branches__c == null){
				existingLead.Other_Locations_Branches__c = leadRecord.Other_Locations_Branches__c;
			}
			
			String oldBDName=existingLead.Owner.Name;
			String oldBDEmail = existingLead.Owner.Email;
			User leadGM = null;
			if(reassigned){
				//Get the GM of existing Lead Record of no activity
				System.debug('GMUSERS : '+gmUsers);
				System.debug('Existing Lead : '+existingLead);
				for(User gmRec : gmUsers){
					if(gmRec.GM__c.containsIgnoreCase(existingLead.Division_Name__c)){
						leadGM = gmRec;
					}
				}
				System.debug('Lead GM : '+leadGM);
				existingLead.OwnerID = leadGM.Id;
				existingLead.Lead_AssignedTo__c = leadGM.Mapped_UserID_Name__c;
				//existingLead.OwnerId = leadRecord.OwnerId;
				//existingLead.Division_Name__c = leadRecord.Division_Name__c;
				//existingLead.Sub_Division_Name__c = leadRecord.Sub_Division_Name__c;
				//existingLead.Primary_Service_Name__c = leadRecord.Primary_Service_Name__c;
				//existingLead.Status = 'Yet to Initiate';
				//existingLead.Lead_AssignedTo__c = leadRecord.Lead_AssignedTo__c;		
				//existingLead.Team_Identification__c = leadRecord.Team_Identification__c;
				//existingLead.User_Name__c = leadRecord.User_Name__c;	
				//existingLead.User_EmailId__c = leadRecord.User_EmailId__c; 
			}
			try{
			update existingLead;
			}catch(Exception e){
				ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,'\nError Occured, Reach your Administrator. Summary :'+e));
			}
			//TODO : Email to BD about new Lead and Notes
			
				if(reassigned){
					system.debug('$#%IF REassigned$#%');
					sendEmailNotification(leadRecord,oldBDEmail,
					'Your Lead is reassigned, due to no followup.',
					'Hi '+oldBDName+
					',<br/> Please find the details of the lead, which is reassigned to your GM. Due to non-followup of Lead with ID: '+existingLead.LeadID__c
					+'.<br/><br/>'
					+'<br/>Lead Details: <br/><br/>First Name:'+existingLead.FirstName+'<br/>'+
					'LastName :'+existingLead.LastName+'<br/>'+
					'Lead Company :'+existingLead.Company+'<br/>'+
					'Email :'+leadRecord.Email+'<br/>'+
					'Lead Created Date :'+existingLead.CreatedDate+'<br/>'+
					'Lead Last Activity On :'+existingLead.LastActivityDate+'<br/>'+
					'<br/> Salesforce Support Team');
					system.debug('$#%IF REassigned2$#%');
					sendEmailNotification(leadRecord,leadGM.Email,
					'Lead Reassignment : BD to GM, Due to No-Followup ',
					'Hi '+existingLead.Owner.Name+
					',<br/> Please find the details of the lead, which is reassigned to you. Since your BD :'+oldBDName +' had no activities on the lead.<br/>'+
					+'<br/>Lead Details: <br/><br/>First Name:'+leadRecord.FirstName+'<br/>'+
					'LastName :'+leadRecord.LastName+'<br/>'+
					'Lead Company :'+leadRecord.Company+'\n'+
					'Email :'+leadRecord.Email+'<br/>'+
					'Primary Service : '+leadRecord.Primary_Service_Name__c+'<br/>'+
					'Division : '+leadRecord.Division_Name__c+'<br/>'+
					'Sub Division : '+leadRecord.Sub_Division_Name__c+'<br/>'+
					'Industry : '+leadRecord.Industry+'<br/>'+
					'Website : '+leadRecord.Website+'<br/>'+
					'Phone : '+leadRecord.Phone+'<br/>'+
					'Mobile Phone : '+leadRecord.MobilePhone+'<br/>'+
					'Address : '+leadRecord.Street+','+leadRecord.State+','+leadRecord.Country+'<br/>'+
					'Rating : '+leadRecord.Rating+'<br/>'+
					'Purpose : '+leadRecord.Purpose_of_buying_this_List__c+'<br/>'+
					'Comments : '+leadRecord.Comments__c+'<br/>'+
					'Uploaded By : '+leadRecord.User_Name__c+'<br/>'+
					'Uploaded Date: '+System.now()+'<br/><br/>'+'Salesforce Support Team');
					
			}
            /*else{
				sendEmailNotification(leadRecord,existingLead.Owner.Email,
					'New Lead Attached to your existing Lead.',
					'Hi '+existingLead.Owner.Name+
					',<br/> Please find the details of the lead, which is attached/reassigned to you by LeadGen : '
					+leadRecord.User_Name__c+'.<br/>'
					+'<br/>Lead Details: <br/><br/>First Name:'+leadRecord.FirstName+'<br/>'+
					'LastName :'+leadRecord.LastName+'<br/>'+
					'Lead Company :'+leadRecord.Company+'<br/>'+
					'Email :'+leadRecord.Email+'<br/>'+
					'Primary Service : '+leadRecord.Primary_Service_Name__c+'<br/>'+
					'Division : '+leadRecord.Division_Name__c+'<br/>'+
					'Sub Division : '+leadRecord.Sub_Division_Name__c+'<br/>'+
					'Industry : '+leadRecord.Industry+'<br/>'+
					'Website : '+leadRecord.Website+'<br/>'+
					'Phone : '+leadRecord.Phone+'<br/>'+
					'Mobile Phone : '+leadRecord.MobilePhone+'<br/>'+
					'Address : '+leadRecord.Street+','+leadRecord.State+','+leadRecord.Country+'<br/>'+
					'Rating : '+leadRecord.Rating+'<br/>'+
					'Purpose : '+leadRecord.Purpose_of_buying_this_List__c+'<br/>'+
					'Comments : '+leadRecord.Comments__c+'<br/>'+
					'Uploaded By : '+leadRecord.User_Name__c+'<br/>'+
					'Uploaded Date: '+System.now()+'<br/><br/>'+'Salesforce Support Team');
			}*/
		}catch(Exception e){
			throw e;
		}
	}
	private Integer getNoActivityLeads(Id ownerId){
		List<Lead> noActivityLeads = [select id,(select id,LastModifiedDate From OpenActivities),
			(select id,LastModifiedDate From ActivityHistories) from Lead 
			where LastActivityDate = null and Status != 'Unqualified' and Status != 'Lost' 
			and isConverted=false and isDeleted=false and OwnerId =: ownerId];
			DateTime recentActivity = null;
			Map<String,String> countLeadNoActivityMap = new Map<String,String>();
			System.debug('TOTAL NON_ACTIVE LEADS : '+noActivityLeads);
			//activityGap = Integer.valueof(getDifferenceInMinutes(System.now(), leadActivityDateTime));
			//if( activityGap <= daysofLead * 60 * 24){
			for(Lead leadRec : noActivityLeads){
				/*for(ActivityHistory leadActivityHistory : leadRec.ActivityHistories){
					Integer activityGap = Integer.valueof(getDifferenceInMinutes(System.now(), leadActivityHistory.LastModifiedDate));
					if(activityGap > daysofLead * 60 * 24){
						countLeadNoActivityMap.put(leadRec.Id,leadRec.Id);
					}		
				}*/
				System.debug('LEAD ID : '+leadRec.Id);
				System.debug(leadRec.ActivityHistories.size()+'--------'+leadRec.OpenActivities.size());
				if(leadRec.ActivityHistories.size() == 0 && leadRec.OpenActivities.size() == 0){
					countLeadNoActivityMap.put(leadRec.Id,leadRec.Id);
				}
				/*for(OpenActivity leadOActivityHistory : leadRec.OpenActivities){
					Integer activityGap = Integer.valueof(getDifferenceInMinutes(System.now(), leadOActivityHistory.LastModifiedDate));
					if(activityGap > daysofLead * 60 * 24){
						countLeadNoActivityMap.put(leadRec.Id,leadRec.Id);
					}		
				}*/
			}
			System.debug('TOTAL INACTIVY LEADS : '+countLeadNoActivityMap.size());
			return countLeadNoActivityMap.size();
		//return noActivityLeads.size();
	}
	private boolean sendEmailNotification(Lead leadRecord, String toEmailId, String subject,String emailBody){
		boolean isSuccess = false;
		system.debug('########@@@@@@@@'+leadRecord);
		system.debug('########@@@@@@@@'+subject);		
		system.debug('########@@@@@@@@'+toEmailId);
		Messaging.SingleEmailMessage mailRec = new Messaging.SingleEmailMessage();
		mailRec.setToAddresses(new string[] {toEmailId});
		//mailRec.setCcAddresses(new string[] {'vinay.k@istrategicloud.com'});
		mailRec.setSenderDisplayName('Salesforce SOS Support');
        mailRec.setSaveAsActivity(false);
       //	mailRec.setTargetObjectId(leadRecord.id);
       //   mailRec.setTemplateId(etemp.id);
       mailRec.setSubject(subject);//'New Lead Attached to your existing Lead.'
       String leadDetails = emailBody;
       mailRec.setHtmlBody(leadDetails);
       Messaging.SendEmailResult[] resultMail = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mailRec });
	   isSuccess = resultMail[0].isSuccess();
       return isSuccess;
	}
	
	public PageReference doCancel(){
		PageReference pageCancel = new PageReference('00Q/o');
	return pageCancel;
	}
	
  
  }