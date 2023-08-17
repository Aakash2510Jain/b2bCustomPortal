/**
*GenerateOrdersController class is used to generate an PDF Format.
* Classname: GenerateOrdersController
*
* Version information:1
*
* Date :May 28th  2013
*
* Copyright notice: cirrologix
*
* Developer: vinay
*/

public without sharing class GenerateOrdersController{	/* Class with without  sharing rules*/

        public Id opportunityId;					/**Initializing all required data types **/
        public Map<String,List<String>> templateMap {get;set;}
        public Map<String,Map<String,String>> typeTemplatesMap {get;set;}
        public List<Brand_Details__c> brandTemplateList = new List<Brand_Details__c>();
        public Map<String,String> selfGenLeadFloorMap = new Map<string,String>();
        public Map<String,String> leadGenFloorMap = new Map<string,String>();
        public Opportunity opportunityRecord{get;set;}
        public String selectedTemplateType{get;set;}
        public String selectedTemplateName{get;set;}
      //  public String selectedTemplateId{get;set;}
        public String sTemplateURL{get;set;}
       // public String sTemplate{get;set;}
        public String valueToSet;
        public String valueParameter;
        public String finalFloor;
        public list<string> wireDetaials1{get;set;}
        public list<string> wireDetaials2{get;set;}
        public list<string> checkDetails{get;set;}
        public String modeOfPay{get;set;} 
        public String faxNumber{get;set;}
        public list<string> divlist;
        public String bankAddress{get;set;}
      //  public list<string> wireAddress1{get;set;}
        private User userDetails;
        public String FinalDivision;
        public String user_Ip;
        
        
        public GenerateOrdersController(ApexPages.StandardController controller){	  /*Standard Controller Constructor */
        	modeOfPay = '';
	        String thirdFloorStr = '(\'Rainmakers\',\'Titans\',\'Team WML\')';
	        String secondFloorStr = '(\'Spartans\',\'Mauryas\',\'Mavericks\',\'Stallions\')';
	        String firstFloorStr = '(\'Winners\',\'Jaguars\')';
	        String groundFloorStr = '(\'Gladiators\')';

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
            opportunityId=ApexPages.currentPage().getParameters().get('id');
            system.debug('**********'+opportunityId);
            opportunityRecord = [select  id, Name,Check_payment__c,Wire_Payment_Type2__c,Wire_Payment__c,Division__c ,
            							Opportunity_Number__c,Brand_Name__c from Opportunity where id=:opportunityId];
			system.debug('@@@@@@@@@@@@@'+opportunityRecord);            							
            valueParameter=Apexpages.currentPage().getParameters().get('value');
            String recordDivision = opportunityRecord.Division__c;
            string div=selfGenLeadFloorMap.get(recordDivision);
            if(div != null){				 /**code to load payment details in work order onload**/
                divlist=div.split(',');
                string trackdiv=divlist[0].SubString(2,6);
                boolean firstDiv=firstFloorStr.contains(trackdiv);
                boolean secondDiv=secondFloorStr.contains(trackdiv);
                boolean thirdDiv=thirdFloorStr.contains(trackdiv);
                if(firstDiv==true){
                    FinalDivision='First';
                }else if(secondDiv==true){
                    FinalDivision='Second';
                }else if(thirdDiv==true){
                    FinalDivision='Third';
                }
          	}
          	system.debug('FINAL DIVISION***'+FinalDivision);
          	system.debug('FINAL BRAND***'+opportunityRecord.Brand_Name__c);
         /* 	if(opportunityRecord.Wire_Payment__c==true && opportunityRecord.Wire_Payment_Type2__c==true){
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Cannot have both wire details selected!');
                  ApexPages.addMessage(myMsg); 
                
                //modeOfPay='Check Payment';
                //ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL, 'Cannot have both wire details selected!');
                //ApexPages.addMessage(﻿myMsg);      
              	          
            } */
            if(opportunityRecord.Check_payment__c==true){
                modeOfPay='Check Payment';              
            }
            if(opportunityRecord.Wire_Payment__c==true){
                modeOfPay='Wire Payment1';
            }
            if(opportunityRecord.Wire_Payment_Type2__c==true){
                modeOfPay='Wire Payment2';
            }
            if(opportunityRecord.Wire_Payment__c==true && opportunityRecord.Check_payment__c==true || opportunityRecord.Wire_Payment_Type2__c==true && opportunityRecord.Check_payment__c==true){
                modeOfPay='Wire Payment/Check Payment';
            }
            if(opportunityRecord.Wire_Payment__c==true || opportunityRecord.Check_payment__c==true || opportunityRecord.Wire_Payment_Type2__c==true){
                 
                 List<Brand_Details__c> brandDetails = [select id,Cheque__c,Phone__c,Wire__c,WireDetails_Type2__c from Brand_Details__c where Floor__c=:FinalDivision and Brand_Name__c=:opportunityRecord.Brand_Name__c limit 1];
                 system.debug('BRAND DETAILS########'+brandDetails);
                 if(brandDetails[0].Wire__c !=null && brandDetails[0].Wire__c !=''){
                 	wireDetaials1=brandDetails[0].Wire__c.split('//');
                 }
                 system.debug('wireDetaials1'+wireDetaials1);
                 if(brandDetails[0].WireDetails_Type2__c !=null && brandDetails[0].WireDetails_Type2__c !=''){
                	 wireDetaials2=brandDetails[0].WireDetails_Type2__c.split('//');
                 }
                 system.debug('wireDetaials2'+wireDetaials2);
                 if(brandDetails[0].Cheque__c !=null && brandDetails[0].Cheque__c !=''){/**Pattern for dispaly payment details**/
                	 checkDetails=brandDetails[0].Cheque__c.split('//');
                 }
                 if(brandDetails[0].Phone__c !=null && brandDetails[0].Phone__c !=null){
                 	system.debug('NNNNNNNNNNNNNNN');
                	 faxNumber=brandDetails[0].Phone__c;
                 }
                 system.debug('FAXXXX'+faxNumber);
             }
           }
           
        public string getValueToSet(){		/**this method invoked when pdf format to be displayed**/ 
            if(valueParameter==null){
                    return '';
               }else{
                    return 'pdf';
                	}
         }
         
        public GenerateOrdersController(){	/*Constructor used  for load GenerateOrder display Page */
        	user_Ip = ApexPages.currentPage().getHeaders().get('X-Salesforce-SIP');
            opportunityId=ApexPages.currentPage().getParameters().get('id');
            bankAddress='Bank of America';
            opportunityRecord = [select  id, Name,Check_payment__c,Wire_Payment_Type2__c,Wire_Payment__c,Division__c ,Opportunity_Number__c,Brand_Name__c from Opportunity 
                        where id=:opportunityId];
            brandTemplateList = [Select Id, Name__c, Brand_Name__c,Type__c,Signature__c,phone__c,email__c,Website__c, 
                        Brand_Template_VF_Page__c from Brand_Details__c 
                        where Brand_Name__c =: opportunityRecord.Brand_Name__c];
            if(brandTemplateList.size() > 0){
                templateMap = new Map<String,List<String>>();
                typeTemplatesMap = new Map<String,Map<String,String>>();
                for(Brand_Details__c brandRec : brandTemplateList){
                        Map<String,String> tempTemplateMap = new Map<String,String>();
                        if(typeTemplatesMap.containsKey(brandRec.Type__c)){
                                tempTemplateMap = typeTemplatesMap.get(brandRec.Type__c);
                                tempTemplateMap.put(brandRec.Name__c,brandRec.Brand_Template_VF_Page__c+'?id='+opportunityRecord.Id);
                                typeTemplatesMap.put(brandRec.Type__c,tempTemplateMap);
                        }else{
                                tempTemplateMap.put(brandRec.Name__c,brandRec.Brand_Template_VF_Page__c+'?id='+opportunityRecord.Id);
                                typeTemplatesMap.put(brandRec.Type__c,tempTemplateMap);
                        }
                        if(templateMap.containsKey(brandRec.Type__c)){
                                templateMap.get(brandRec.Type__c).add(brandRec.Name__c);
                        }else{
                                List<String> newList= new List<String>();
                                newList.add(brandRec.Name__c);
                                templateMap.put(brandRec.Type__c,newList);
                        }
                }
            }else{			/**when no brand details avilable then display errror message**/
            		
                ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO,'No Templates available for the brand :'+opportunityRecord.Brand_Name__c));
            }
        }
        	
        public PageReference previousPage(){	/**this method used to load opportunity page**/
                PageReference pagePdf = new PageReference('/'+opportunityId);
                pagePdf.setRedirect(true);
        return pagePdf;
        }
       
        public PageReference pdfAttachment(){	/** this method used attach the work order pdf format to opportunity**/
        	
               userDetails = [Select Id,Name,Email,UserName from user where Id =: UserInfo.getUserId()];
               if(sTemplateURL!=''){
	                  PageReference pdf= new PageReference('/'+sTemplateURL+'&value=pdf');
	                  Attachment attach = new Attachment();
	                  list<Attachment> listPdf = new list<Attachment>();
	                  listPdf=[select id from Attachment where ParentId=:opportunityId];
	      		      if(listPdf.size()>2){  
	           				delete listPdf;
                      	}
                      Blob body;
				      try{  
		                    body = pdf.getContent();
		                    }catch (VisualforceException e) {
		                            body = Blob.valueOf('Some Text');
		         		       }
			          attach.Body = body;
			          attach.Name = selectedTemplateType+'_'+opportunityRecord.Opportunity_Number__c+'.pdf';//selectedTemplateType+'_'+opportunityRecord.Opportunity_Number__c+'.pdf';
			          attach.IsPrivate = false;
			          attach.ParentId = opportunityId;
			          insert attach;
   
   		     /**         SampleRequestDownload__c sample = new SampleRequestDownload__c(); **/ /**track the record while inserting in sampleRequestDownload**/
              /**        sample.Email__c = userDetails.Email;
                      sample.DocumentName__c = attach.Name;
                      sample.Category__c = 'WorkOrder';
                      insert sample;    **/  
              
              WorkOrder_Download_Log__c wSample= new WorkOrder_Download_Log__c();
              wSample.Email__c = userDetails.Email;
              wSample.DocumentName__c = attach.Name;
              wSample.Opportunity_ID__c=opportunityId;
              wSample.User_Ip__c=user_Ip;
              wSample.Brand_Name__c=opportunityRecord.Brand_Name__c;
              insert wSample;
              
                      ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'PDF is successfully attached to the Opportunity, Either Click on Save and Send Email button to email or Click on Back to Opportunity' ));
                  return null;
                  
                }else{
                	
                      ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'PDF is Unsuccessfully,Please choose one of the Template'));
                   return null;
                }  
     	  return null;
     	}
      /*  public PageReference saveAttach(){	/**sending document details to doc sign 
        	
            PageReference pagePdf = new PageReference('/apex/sendtodocusign2?id='+opportunityId+'&sTempUrl='+sTemplateURL+'&sTempType='+selectedTemplateType+'&selectedTemplateName='+selectedTemplateName);
            pagePdf.setRedirect(true);
            
        return pagePdf;
        }
	    
	    public Pagereference sendDocsToDS(){	/**requesting the status of document for docu sign
	    	
		    string urlSample=Apexpages.currentPage().getParameters().get('sTempUrl');
		    string SampleName=Apexpages.currentPage().getParameters().get('selectedTemplateName');
		 	Pagereference page = null;
		    try{
		        page = DocusignServices2.processDocument(opportunityId,urlSample,SampleName);
		    }catch(Exception ex){
		         ApexPages.addMessages(ex);
		    }
	  		return page;
	 	}*/
	}//end of class