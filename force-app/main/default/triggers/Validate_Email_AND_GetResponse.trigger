trigger Validate_Email_AND_GetResponse on Lead (after insert, before update) {
/* This trigger is to validate Email through Credifye webservices class and update the response */
 //   for(Lead leadRec : trigger.new) {
 //   SOS__c sosSettings = SOS__c.getInstance();
 //   boolean execut = sosSettings.CredifeyeTrigger__c;

 //   if(execut){ 
  //             system.debug('!!!!!!!ValidMail!!!!!'+leadRec.Email);   
   //            CredifeyeDuplication cd=new CredifeyeDuplication();
  //             boolean fla=cd.getmaildomain(leadRec.Email);
  //             if(!fla){
                  // tempuriOrgCredifeye.WebServiceSoap toc=new tempuriOrgCredifeye.WebServiceSoap(); 
                  //// if(trigger.isInsert || ( trigger.isUpdate && trigger.oldMap.get(leadRec.Id).Email!=leadRec.Email)){
                  ////     tempuriOrgCredifeye.validateEmailId(leadRec.Id,leadRec.Email);
                  //// }
    //            }
   //     }
  //  }  
}