@isTest

private class leadtestclass{

   static testmethod void emailalert() {
      Lead ld = new Lead();
      ld.Email = 'kishore.psvm@gmail.com';
      ld.Division_Name__c = 'Winners';
      ld.CreatedDate = system.Today();
      ld.LeadSource='SEO Leads';
      ld.NewsLetter_Lead_Buckets__c = 'Subscribed'; 
      ld.Subscribed_to_Newsletter__c = true;
      ld.company='citrologix';
      ld.Lastname='test';
      insert ld;
      
      Lead ld1 = new Lead();
      ld1.Email = 'kishore.psvm1@gmail.com';
      ld1.Division_Name__c = 'Winners';
      ld1.CreatedDate = system.Today();
      ld1.LeadSource='Other';      
      ld1.Subscribed_to_Newsletter__c = false;
      ld1.company='citrologix';
      ld1.Lastname='test5';      
      insert ld1;
      Task e=new Task();     
      e.whoId=ld1.Id;     
      e.Subject='Call';
      e.ActivityDate=System.Today();     
      e.Status = 'Completed';
      insert e;
      Sample_Request__c SR= new Sample_Request__c();
      SR.Status__c='New';
      SR.Name='TEST';
      SR.Sample_Type__c='Custom Business List Sample';
      SR.Sample_Type_Description__c='TEST DESCRIPTION';
      SR.Lead__c=ld1.Id;
      insert SR;
      Database.LeadConvert lc = new database.LeadConvert();
     lc.setLeadId(ld1.id);
     lc.setDoNotCreateOpportunity(false);
     lc.setConvertedStatus('Warm/Samples Sent');
     Database.LeadConvertResult lcr = Database.convertLead(lc);
     System.assert(lcr.isSuccess());     
     
     
     
  //    ApexPages.StandardController sc = new ApexPages.StandardController(ld);
         
           cls_acceptedlink ad = new cls_acceptedlink ();
           Apexpages.currentpage().getparameters().put('Id',ld.id);
           ad.fieldUpdate();
             
      } 
    }