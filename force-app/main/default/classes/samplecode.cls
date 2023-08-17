public class samplecode{
    public string sampleEmail;
    public String sampleSearchKey;
    public String sampleType;
    public string sampledocName;   
    public string code{get;set;} 
    public String userIp;
    public samplecode(){
    	userIp = ApexPages.currentPage().getHeaders().get('X-Salesforce-SIP');
        sampledocName=Apexpages.currentPage().getParameters().get('docName');   
        sampleEmail=Apexpages.currentPage().getParameters().get('uEmail');
        sampleSearchKey = Apexpages.currentPage().getParameters().get('Keyword');
        sampleType = Apexpages.currentPage().getParameters().get('Stype');  
    }
  	public PageReference SampleRequest(){
    /**   SampleRequestDownload__c sample = new SampleRequestDownload__c();
       sample.Email__c = sampleEmail;
       sample.DocumentName__c = sampledocName;
       sample.Category__c = 'Business Analysis';
       sample.Keyword__c=sampleSearchKey;
       sample.Sample_Type__c=sampleType;
       try{
       insert sample;   
       }catch(exception e){
       	system.debug(e);
       }  
      PageReference pagePdf = new PageReference('/'+sample.id); 
      pagePdf.setRedirect(false);
      return pagePdf;  **/
       Sample_Download_Logs__c sample = new Sample_Download_Logs__c();
       sample.Email__c = sampleEmail;
       sample.DocumentName__c = sampledocName;
       //sample.Category__c = 'Business Analysis';
       sample.Keyword__c=sampleSearchKey;
       sample.Sample_Type__c=sampleType;
       sample.User_Ip__c=userIp;
       try{
       insert sample;   
       }catch(exception e){
       	system.debug(e);
       }  
      PageReference pagePdf = new PageReference('/'+sample.id); 
      pagePdf.setRedirect(false);
      return pagePdf;  
      
  	}
  	
 }