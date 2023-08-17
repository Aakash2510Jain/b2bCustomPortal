public class PieChartController2 {
		public string LeadformUserID= '';
		public date thismonth{get;set;}
		public string subdivision=''; 
		public string sessionID = '';	   
		public Map<String,String> subdivision1 = new Map<string,String>();
		public list<Lead> leadList{get;set;}
		public LeadFormUsers__c LeadFormList{get;set;}
		//list<LeadFormUsers__c> LeadFormList= new list<LeadFormUsers__c>();
		
		public PieChartController2(){	
			List<String> divisionname = new List<String>();
			divisionname.add('Gladiators');
			divisionname.add('Jaguars');
			divisionname.add('Winners');
			divisionname.add('Stallions');
			divisionname.add('Rainmakers');
			divisionname.add('Mavericks');
			divisionname.add('Mauryas');
			divisionname.add('Spartans');
			divisionname.add('Team WML');
			divisionname.add('Titans');
			divisionname.add('Content Team');
			divisionname.add('Web Team');
			divisionname.add('Social Media');
			divisionname.add('MPO');
			system.debug('$$$$$$$$************$$$$$$$$'+divisionname);
				
			string WinnerBrands='Brigade Big,Global Health Care,Global IT Users Inc,Info Data House,IT Data Group,Pioneer Marketers,Prepackaged Lists,Procure Data Inc,Xpress Lists Web,Six Channels,B2B Data Partners';
			string stallionsBrand='World data forum';			
			string GladiatorsBrand='Strategic Outsorucing Services';			
			String jaguarsBrand='IT Data Group';			
			String rainmakersBrand='Email Data Group,Health Care Data Group,Info Data House,ROI Marketing Center,B2B Data Partners';			
			String mavericsBrand='European Lists,Global Business Archives,Marketing Drip,Optinlists Web';			
			String mouryasBrand='B2B Data Partners In,Email Data Group,Health Care Data Group,ROI Marketing Center';			
			String spartansBrand='B2B List,B2B Lists,European Lists,Marketing Colors,Media Sellers Online,OnDOT Data Corp,Strategic Outsorucing Services,Technology User Lists,Top Health Care Leads,B2B Datagroup,B2B Global,Lake Group';			
			String temWMLBrand='Strategic Outsorucing Services,Webmailing Lists';			
			String titansBrand='Biz Contrive,Online Leads Inc,Publishing Forces,Webmailing Lists,WML Online';			
			String contentBrand='Content Team';			
			String webTeamBrand='Web Team';			
			String socialMediaBrand='Social Media';			
			String mpoBrand='Marketing outsourcing';
			
	    	subdivision1.put('Rainmakers',rainmakersBrand);
			subdivision1.put('Titans',titansBrand);
			subdivision1.put('Team WML',temWMLBrand);
			subdivision1.put('Spartans',spartansBrand);
			subdivision1.put('Mauryas',mouryasBrand);
			subdivision1.put('Mavericks',mavericsBrand);
			subdivision1.put('Stallions',stallionsBrand);
			subdivision1.put('Winners',WinnerBrands);
			subdivision1.put('Jaguars',jaguarsBrand);
			subdivision1.put('Gladiators',GladiatorsBrand);
			subdivision1.put('Content Team',contentBrand);
			subdivision1.put('Web Team',webTeamBrand);
			subdivision1.put('Social Media',socialMediaBrand);
			subdivision1.put('MPO',mpoBrand);
			system.debug('$$$$$$$$$$$$$$$$'+subdivision1);
            //subdivision= System.currentPageReference().getParameters().get('subdivision');
	        system.debug('+++++6546546+++++'+subdivision);
	        sessionID = System.currentPageReference().getParameters().get('sessionId');
	        system.debug('++++++++++'+sessionID);
	            if(sessionID!=null){
	                Session__c ses =[Select s.Session_For__c, s.Session_For_LeadFormUsers__c, s.SessionId__c  From Session__c s where s.Sessionid__c=:sessionID limit 1];
	                LeadformUserID=ses.Session_For_LeadFormUsers__c;
	            }
	            LeadFormList= [SELECT Active__c,Approval_Message_Page__c,CreatedById,CreatedDate,Division__c,EMail_ID__c,Floor__c,Id,IsDeleted,
	                    LastActivityDate,LastModifiedById,LastModifiedDate,Last_Login__c,Manager__r.Name,Name,OwnerId,Password__c,
	                    Registration_Approved__c,SiteProfile__c,SystemModstamp,UserName__c FROM LeadFormUsers__c 
	                    where ID = :LeadformUserID];	
	                    system.debug('%%%%%%%%%%%%'+LeadFormList);             
			   }
			    
			         
        public List<PieWedgeData3> getPieData3() {
        	List<PieWedgeData3> datal = new List<PieWedgeData3>();
        	
	        	string subdiv = subdivision1.get(LeadFormList.Division__c);
	        	system.debug('^^^^^^^^^^^^^^^'+subdiv);
	        	Boolean result = subdiv.containsAny(',');
	        	if(result==true){
	        	list<string> stringlist = subdiv.split(',');
	        	for(string str:stringlist){
	                   leadList=new list<Lead>();
	                   leadList=[select id from Lead where Sub_Division_Name__c=:str and createdDate=this_month];
	                   system.debug('##########'+leadList);
	                   datal.add(new PieWedgeData3(str,leadList.size()));	
	                }
	        	}
	        	else{
	        	       leadList=new list<Lead>();
	                   leadList=[select id from Lead where Sub_Division_Name__c=:subdiv and createdDate=this_month];
	                   system.debug('##########'+leadList);
	                   datal.add(new PieWedgeData3(subdiv,leadList.size()));
	        	}	  
	        	system.debug('&&&&&&&&&&&&&&'+datal);         
        	return datal;
        }
       
        public class PieWedgeData3 {
        	//public Lead lead1{get;set;}
            public String name { get; set; }
            public Integer data { get; set; }
            public PieWedgeData3(string name,integer data) {
            	//lead1 = l;
                this.name = name;
               this.data = data;
            }
        }   
    }