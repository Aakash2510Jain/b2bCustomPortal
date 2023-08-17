public class CredifeyeDuplication {
  List<String> parts= new List<String>();
  list<string> st=new List<String>();
     public boolean getmaildomain(string emailid){
            boolean flag;
            string s='';
            string domain;
            list<Config__c> cmail=new list<Config__c>();
        //    cmail=[select name,Value__c from Config__c where Key__c='Key-004']; /*fetching Domain values from Config object */
          /*     for(Config__c cf:cmail){
                   if(cf.Value__c!=null){
                       string emailDomain=cf.Value__c;
                       list<string> mailDomain=emailDomain.split(',');
                             for(string f:mailDomain){    
                                 if(emailid != null){
                                      s=emailid;
                                      System.debug('&&&&&&&&&&&&email'+s);
                                      parts = s.split('@',2);
                                      System.debug('&&&&&&&&&&&&&&'+parts);
                                      domain=parts[1];
                                      System.debug('&&&&&&&&&&&&&&dom'+domain);
                                   }
                                  for(string m:mailDomain){
                                     if(domain==m){
                                         st.add(m);
                                       }
                                   }
                                  if(st.size()>0){
                                      flag=true;
                                   }
                                    else{ 
                                      flag=false;
                                    }      
                              }
                      }
               }*/ 
            return flag;
       }
       
     /*  static testMethod void myUnitTest_Credifeye(){
       			
       		CredifeyeDuplication cd=new CredifeyeDuplication();
            Config__c cf=new Config__c();
            cf.NumberOfDays__c=5;
            cf.NoLeadActivity__c=3;
            cf.Division__c='Alex; Blake Cooper; Campaign; Content; Jeff Anderson; LeadGen; Manager_Robin Smith';
            cf.BrandWise__c='B2B Contacts; B2B Data Partners In';
            cf.Value__c='dell.com,span.com';
            //cf.Key__c='sample';
            insert cf;
            
            list<string> mailDomain=new list<string>(); 
            List<String> parts= new List<String>();
            List<String> st= new List<String>();
            boolean fla=cd.getmaildomain('test@istrategicloud.com');
       }*/
		 
}