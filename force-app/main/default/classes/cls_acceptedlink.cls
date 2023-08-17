public class cls_acceptedlink {
   //   public String nwsltrldbckts ;
    /*    public cls_acceptedlink(){
        nwsltrldbckts = Apexpages.CurrentPage().getParameters().get('id');
            system.debug('+++++++++id++++++++++++++'+nwsltrldbckts);
        }
*/
    public pagereference fieldUpdate(){
  //  nwsltrldbckts = Apexpages.CurrentPage().getParameters().get('id');
  //  system.debug('+++++++++id++++++++++++++'+nwsltrldbckts);
    if(Apexpages.currentpage().getParameters().get('id')!=null){
        Lead ld = [select id,name,NewsLetter_Lead_Buckets__c from lead where id=:Apexpages.currentpage().getParameters().get('Id')];
            ld.NewsLetter_Lead_Buckets__c='UnSubscribed';
    update ld;
    }
        return null;
    }
}