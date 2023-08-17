public without sharing class LeadGenLoginClass {
	   
	   public string userName{get;set;}
	   public string password{get;set;}
	   public string currentPwd{get;set;}
	   public string newPwd{get;set;}
	   public string confirmPwd{get;set;}
	   
	   
	   public string Session;
	   public string UName;
	   public LeadFormUsers__c leadFormUser;
	   public string Userid{get;set;}
	   public date Lastlogin{get;set;}
	   
	   public LeadGenloginClass(){
	   		Userid = ApexPages.currentPage().getParameters().get('emailAdd');
	   }
	
	   public PageReference checkLogin(){
	   	
	   	if((userName!=null && password!=null) || (userName!='' && password!='')){
	   	
	   		try{
	   		leadFormUser=[select EMail_ID__c,Name,Password__c,Division__c,Floor__c,
	   							Last_Login__c from LeadFormUsers__c where 
	   									EMail_ID__c=:Username and password__c=:password limit 1];
	   		}catch(Exception e){
	   			ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,'User not Found'));
				return null;
	   		}							
	   	if(leadFormUser.id!=null){
	   					if(leadFormUser.Last_Login__c==null){
		   						PageReference pageRedirect = new PageReference('/apex/ResetPassword');
		   						pageRedirect.getParameters().put('emailAdd', leadFormUser.EMail_ID__c);
		   						pageRedirect.setRedirect(true);
		   	 					return pageRedirect;
			   				}else{
		   						 Session = String.valueOf(Math.random()).substring(2,16);
		   						 leadFormUser.Last_Login__c=Datetime.now();
		   						 update leadFormUser;
			   	    	    	 // PageReference successPage = new PageReference();
			   	    	    	 PageReference successPage = new PageReference('/apex/SOSLeadClashProcess');
			   	    	    	 //PageReference successPage = new PageReference('/apex/SOSLeadGenForm');
			   	    	    	 successPage.getParameters().put('UName', leadFormUser.Name);
			   	    	    	 successPage.getParameters().put('div', leadFormUser.Division__c);
			   	    	    	 successPage.getParameters().put('Emailid', leadFormUser.EMail_ID__c);
		        				 successPage.getParameters().put('sessionId', Session);
			   	    	    	 successPage.setRedirect(true);
	                		 return successPage;
	   					  }	
	   				}else{
		   				ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,'oops! Enter details are invalid'));
		   				ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,'Please enter Valid details'));
						return null;
	   				}
	   	}else{
	   	   	ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,'oops! Enter details are invalid'));
		   	ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,'Please enter Valid details'));
			return null;
	   	}
	   	  
	   	/*  try{
				if(Username != null){
				   	  	Lfu=[select EMail_ID__c,Name,Password__c,Division__c,Floor__c,Last_Login__c from LeadFormUsers__c where EMail_ID__c=:Username limit 1];
				   	    string pass=Lfu.Password__c;
				   	    div=Lfu.Division__c;
				   	    //team=Lfu.Team__c;
				   	    UName = Lfu.Name;
					} 
	   	 	}catch(Exception e){
				ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO,'User Name does not exists'));
				return null;
			}
	   	    if(Password!=null){
	   	    	    if(lfu.Password__c==Password){
		   	   	    		 Userid =	Username;
		   	    	    	 Session = String.valueOf(Math.random()).substring(2,16);
		   	    	    	 PageReference pr = new PageReference('/apex/SOSLeadGenForm');
		   	    	    	 //?divisionUser='+div+'&UName='+UName+'&Emailid='+Userid
		   	    	    	 pr.getParameters().put('UName', UName);
		   	    	    	 pr.getParameters().put('div', div);
		   	    	    	 pr.getParameters().put('Emailid', Username);
	        				 pr.getParameters().put('sessionId', Session);
		   	    	    	 pr.setRedirect(true);
                		 return pr;
	   	    	      }else{
		   	    	      	 ApexPages.Message Msg = new ApexPages.Message(ApexPages.Severity.WARNING,'Password Mismatch!');
	              			 ApexPages.addMessage(Msg);
	   	    	         return null;
	   	    	        }	
	   	     }*/
	   	     return null;  
	   }
	   
	   	public PageReference updateLogin(){
	   		
	   		if(Userid!=null){
	   			if(currentPwd!='' && newPwd!='' && confirmPwd!=''){
	   				try{
	   						leadFormUser=[select EMail_ID__c,Name,Password__c,Division__c,Floor__c,
	   															Last_Login__c from LeadFormUsers__c where 
	   																					EMail_ID__c=:Userid and password__c=:currentPwd limit 1];
	   					}catch(Exception e){
	   							ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,'User not Found'));
						 return null;
					   	}					
	   					if(leadFormUser.id!=null){
		   						leadFormUser.Password__c=newPwd;
		   						leadFormUser.Last_Login__c= datetime.now();
	   						update leadFormUser;
		   						PageReference pageRedirect = new PageReference('/apex/LeadGenLogin');
			   					pageRedirect.setRedirect(true);
		   	 				return pageRedirect;
	   					}else{
	   						ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,'Reset of password is unsuccessfully'));
						return null;
	   					}				
	   				}else{
	   					ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,'Reset of password is unsuccessfully'));
						return null;
	   				}
	   		}
	   		return null;
	   	}
	   	
		static testmethod void mytestLeadGenLoginclass(){
		 	
		 	LeadFormUsers__c users = new LeadFormUsers__c();
	 		users.Division__c='winners';
	 		users.EMail_ID__c='abc@xyz.com';
	 		users.Password__c='123456';
	 		users.UserName__c='abc@xyz.com';
	 		users.Last_Login__c=datetime.now();
	 		insert users;
				
			PageReference pageref = page.LeadGenLogin;
			Test.setCurrentPage(pageref);
				
	        LeadGenLoginClass log = new LeadGenLoginClass();
		    log.Username='abc@xyz.com';
		    log.Password='123456';
			log.checkLogin();
			log.Userid='abc@xyz.com';
			log.currentPwd='123456';
			log.newPwd='test1234';
			log.confirmPwd='test1234';
			log.updateLogin();
			 
		    LeadFormUsers__c user = new LeadFormUsers__c();
			user.EMail_ID__c='abcs@xyz.com';
			user.Password__c='123456';
			insert user;
		
			LeadGenLoginClass log1 = new LeadGenLoginClass();
			log1.Username='awebc@xyz.com';
			log1.Password='123456';
			log1.checkLogin();
			log1.Userid='abc@xyz.com';
			log1.currentPwd='123456';
			log1.newPwd='test1234';
			log1.confirmPwd='test1234';
			log1.updateLogin();
			
			LeadGenLoginClass log2 = new LeadGenLoginClass();
			log2.Username='awebc@xyz.com';
			log2.Password='123456';
			log2.checkLogin();
			log2.Userid='abc@xyz.com';
			log2.currentPwd='123456';
			log2.newPwd='';
			log2.confirmPwd='test1234';
			log2.updateLogin();
			
			LeadGenLoginClass log3 = new LeadGenLoginClass();
			log3.Username='awebec@xyz.com';
			log3.Password='123456';
			log3.checkLogin();
			log3.Userid='abc@xyz.com';
			log3.currentPwd='123456';
			log3.newPwd='';
			log3.confirmPwd='test1234';
			log3.updateLogin();
			
		 }
}