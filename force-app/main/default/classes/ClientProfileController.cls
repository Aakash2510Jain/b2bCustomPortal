public class ClientProfileController{
    public PageReference Send() {
         PageReference pg=new PageReference('/apex/EmailSingleClient');
         pg.setRedirect(false);
         
         return pg;   
    }

String leadId = '';
    public ClientProfileController(){
      leadId = ApexPages.CurrentPage().getParameters().get('id');  
      getClientProfilesForLead(leadId);
    }
public list<Client_Profile__c> l{set;get;}
public list<Client_Profile__c> getClientProfilesForLead(String leadId) {
l = [SELECT Name ,Document_Id__c,Document_Name__c,CreatedDate,Document_Type__c,Description__c,Subject__c FROM Client_Profile__c where Lead__c =: leadId];
return l;
}
public String getSfInstance()
{
  return URL.getSalesforceBaseUrl().toExternalForm();
}
public static testMethod void main(){
ClientProfileController cli= new ClientProfileController();
cli.getClientProfilesForLead('00QO0000001KR3u');
cli.getSfInstance();
cli.Send();
}
}