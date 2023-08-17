@istest
public class Searchleadorcontactemailtest{
static testmethod void Searchleadorcontactemailtestmethod(){
Lead l =new Lead(Test_mandatory_check__c = 'test',Company='KVP',LastName='test',Email='test@gmail.com',Primary_Service_Name__c='Primary_Service_Name__c',
                   LeadSource='Fax Lead',Status='Warm');
  insert l;
Contact c=new Contact(FirstName='test',LastName='test',Email='test1@gmail.com');
  insert c;

 ApexPages.StandardController sc1 = new ApexPages.StandardController(l);
  ApexPages.StandardController sc12 = new ApexPages.StandardController(c);
 ApexPages.currentPage().getParameters().put('ID',l.id);
Searchleadorcontactemail sce=new Searchleadorcontactemail(sc1);

 sce.getAppSearchData(); 
 sce.getAppSearchData1();
     sce.AppSearch();
}
}