public class SOSLeadFormCtrl_Sean_Fischer
{
      public Lead App{get;set;}
      public Attachment Att{get;set;}
      List<String> emaillist = new List<String>();
      List <Attachment> alist=new List <Attachment>();
      List<Lead> listLead=new List<Lead>();
      List<Spam_Email__c> spamemaillist =new List<Spam_Email__c>();
      List<Spam_Domain__c> spamdomainlist =new List<Spam_Domain__c>();
      List<String> parts= new List<String>();
      List<String> domainlist = new List<String>();
      Integer i=0;
      Integer j=0;
      Integer k=0;
      String s = '';
      List <Lead> lList=new List <Lead>();
      String curPage;
		boolean overrideOwner = false; //NEWLY ADDED
		List <Lead> dupLeadsList=new List <Lead>(); //NEWLY ADDED
      
    public SOSLeadFormCtrl_Sean_Fischer()
    {
        Att=new Attachment();
        App=new Lead ();    
    }
     public void checkemail(){
	/*	SOS__c sosSettings = SOS__c.getInstance();//NEWLY ADDED
		overrideOwner = sosSettings.Assign_DupL_To_Exist_L_Owner_LeadGenForm__c;//NEWLY ADDED
		System.debug('DUP LEADS WILL GET ASSIGNED TO EXISTING LEAD OWNER :'+overrideOwner);//NEWLY ADDED     
     if(App.Email != null){
     s=App.Email;
     parts = s.split('@',2);
     }
     //date d=System.Today().daysbetween(listLead.Lead_Created_Date__c);
     spamemaillist = [select Name from Spam_Email__c where Name=:App.Email.TRIM()] ;
     listLead = [select id,CreatedDate,Email,Lead_Created_Date__c,Status,LastActivityDate,LastModifiedDate,OwnerId,Owner.Name,Division_Name__c,
					Team_Identification__c,User_Name__c,User_Name_Sean_Fischer__c from 
					Lead where Email=:App.Email.TRIM() and isConverted =false order by LastActivityDate desc];
     spamdomainlist = [select Name from Spam_Domain__c where Name=:parts ] ;
		dupLeadsList=new List <Lead>();//NEWLY ADDED
		dupLeadsList.clear();//NEWLY ADDED
     for(lead l : listLead ) {
       Date d = Date.valueof(l.CreatedDate);
      integer i1=d.daysbetween(System.Today());
      
			System.debug('TOTAL DAYS OF LEAD :'+i1+'---------Status:'+l.status);//NEWLY ADDED
			 if(i1 < 120 && (l.status != 'Unqualified' && l.status != 'Lost')) {//NEWLY ADDED
			   dupLeadsList.add(l);                                //NEWLY ADDED
			 }//NEWLY ADDED
     }
		System.debug('LIST OF DUPLICATE LEADS :'+dupLeadsList);//NEWLY ADDED
		i=dupLeadsList.size();//NEWLY ADDED
		//if(overrideOwner){//NEWLY ADDED
		//	i=0;//NEWLY ADDED
		//}//NEWLY ADDED
     j = spamemaillist.size(); 
     k = spamdomainlist.size();    
                  if(i>0){  
						ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,'Leads with the same email are uploaded in last 120 Days'));//NEWLY ADDED
						 ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO,'Please do followup with the current Lead Owner about already existing lead.'));//NEWLY ADDED
						 ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO,'Previous Lead Owner: '+listLead[0].owner.Name)); //NEWLY ADDED
						 ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO,'Previous Lead Uploaded By : '+listLead[0].User_Name__c));//NEWLY ADDED
						 ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO,'Previous Lead Created On: '+listLead[0].Lead_Created_Date__c+'      Last Modification On Lead: '+listLead[0].LastModifiedDate));//NEWLY ADDED
						 //ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO,'Last Modification On Lead: '+listLead[0].LastModifiedDate));//NEWLY ADDED
						 if(listLead[0].LastActivityDate != null){ //NEWLY ADDED
							ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO,'Last Activity on Lead : '+listLead[0].LastActivityDate));//NEWLY ADDED
						 }//NEWLY ADDED  
                  }  
               else if(j>0) {
                  ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,'The lead entered is part of the spam list'));                              
               }
               else if(k>0) {
                  ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,'The lead entered is part of the spam domain'));                              
               }      */ 
     }
     
       
     public pagereference save()
    {   
    
   /*  checkemail();
         Attachment Att1=new Attachment();
         pagereference pr; 
         if ((i==0 && j==0 && k==0 )){
            
                System.debug('-------->'+App.Comments__c);
                     
             if (App.Lead_AssignedTo__c != NULL)
             {
				//if(overrideOwner && dupLeadsList.size() > 0){//NEWLY ADDED
				//	App.OwnerId = listLead[0].OwnerId;//NEWLY ADDED
				//	App.Division_Name__c = listLead[0].Division_Name__c;//NEWLY ADDED
				//}else{//NEWLY ADDED             	
	                 User u = [Select Id, Mapped_UserID_Name__c from User where Mapped_UserID_Name__c =: App.Lead_AssignedTo__c  Limit 1];
	                 App.OwnerId = U.Id;
				//}
             }
             else if (App.Lead_AssignedTo__c == NULL)
             {
             App.OwnerId = '00G900000013cVo';
             }
             App.Team_Identification__c='Sean Fischer';
             //App.Ignore_TriggerCheck__c='IgnoreTriggerCheck for teams 120days check';
             App.IgnoreTriggerCheck__c=TRUE;
              insert App;
            
             Att1.Body = Att.Body;
             Att1.Name = Att.Name;
             Att1.ParentId =App.Id;                    
             if(Att.Body!=NULL) {             
                 insert Att1;       
              }
               Att=new Attachment();//NEWLY ADDED
	        App=new Lead (); //NEWLY ADDED
			ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO,'Lead Uploaded Successfully.'));//NEWLY ADDED
			//if(overrideOwner  && dupLeadsList.size() > 0){//NEWLY ADDED
			//	String message = 'Lead is been assigned to '+listLead[0].owner.Name+' of Division - '+listLead[0].Division_Name__c//NEWLY ADDED
			//		+'. Same lead was uploaded by '+listLead[0].User_Name__c+' on '+listLead[0].Lead_Created_Date__c;//NEWLY ADDED
			//	ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO,'Since it was a Duplicate Lead, Below steps are taken :'));//NEWLY ADDED
			//	ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO,message));//NEWLY ADDED
			//}    //NEWLY ADDED
			return null;//NEWLY ADDED
			// pr=new pagereference('/apex/LeadSuccess10');//NEWLY ADDED
			// pr.setredirect(true);//NEWLY ADDED
			// return pr; //NEWLY ADDED     
        }
       /* else {
               if(i>0) {
                  ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,'Leads with the same email are uploaded in last 120 Days'));                              
               }
               else if(j>0) {
                  ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,'The lead entered is part of the spam list'));                              
               }
               else if(k>0) {
                  ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,'The lead entered is part of the spam domain'));                              
               }
             
               return null;
        }  */
        return null;                    
    }
    public pagereference leadSucess(){
     pagereference pr =new pagereference('http://strategicoutsourcingservices.force.com/SeanFischer'); 
     pr.setredirect(true);
        return pr;
    }
    
static testMethod void myUnitTest_LeadGen(){
	/* SOSLeadFormCtrl_LeadGen LeadGen=new SOSLeadFormCtrl_LeadGen();
	 
	    Lead lead4= new Lead();
        lead4.Company='test123'; 
        lead4.lastname='testclass';
        lead4.Status='Working';
        lead4.Division_Name__c='Gladiators';
        lead4.LeadSource='Other';         
        lead4.Email = 'test@istrategicloud.com';
        LeadGen.App = lead4;
        LeadGen.save();
        
        
        Lead l1= new Lead();
        l1.Company='test123';
        l1.lastname='testclass';
        l1.Status='Working';
        l1.Division_Name__c='Gladiators';
        l1.LeadSource='Other';        
        l1.Email='praveen.r@istrategicloud.com';
       
        LeadGen.App = l1;
        LeadGen.save();
        LeadGen.leadSucess();
        
        Lead l2= new Lead();
        l2.Company='test123';
        l2.lastname='testclass';
        l2.Status='Working';
        l2.Division_Name__c='Gladiators';
        l2.LeadSource='Other';         
        l2.Email = 'praveen.r@1020.net';
        LeadGen.App = l2;
        LeadGen.save();
        
        Lead lead3= new Lead();
        lead3.Company='test123'; 
        lead3.lastname='testclass';
        lead3.Status='Working';
        lead3.Division_Name__c='Gladiators';
        lead3.LeadSource='Other';         
        lead3.Email = 'annekimzey@cisco.com';
        LeadGen.App = lead3;
        LeadGen.save();*/
    }       
           
  }