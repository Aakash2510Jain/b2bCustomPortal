public class ManageSite_view {

    public PageReference cmsSiteSetupTab(){
        PageReference pg = new PageReference('/apex/SiteSetup');
        return pg;
    }
    public PageReference cmsProfileTab(){
        Schema.DescribeSObjectResult cmsProfile = SiteProfile__c.sObjectType.getDescribe();
        PageReference pg= new PageReference('/'+cmsProfile.getKeyPrefix());
        return pg;
    }
    public PageReference pageTab(){
        Schema.DescribeSObjectResult page = Page__c.sObjectType.getDescribe();
        PageReference pg= new PageReference('/'+page.getKeyPrefix());
        return pg;
    }
    public PageReference menuTab(){
        Schema.DescribeSObjectResult menu = Menu__c.sObjectType.getDescribe();
        PageReference pg =new PageReference('/'+menu.getKeyPrefix());
        return pg;
    }
    public PageReference blockTab(){
        Schema.DescribeSObjectResult block = PageBlock__c.sObjectType.getDescribe();
        PageReference pg= new PageReference('/'+block.getKeyPrefix());
        return pg;
    }
    
    
    public PageReference menuComponentTab(){
        Schema.DescribeSObjectResult menuComponent = Menu_Component__c.sObjectType.getDescribe();
        PageReference pg= new PageReference('/'+menuComponent.getKeyPrefix());
        return pg;
    }
    public PageReference sessionTab(){
        Schema.DescribeSObjectResult session = Session__c.sObjectType.getDescribe();
        PageReference pg= new PageReference('/'+session.getKeyPrefix());
        return pg;
    }
    
    static testmethod void ManageSite_viewTest() {
    	
    	ManageSite_view con = new ManageSite_view();
    	
    	con.cmsSiteSetupTab();
    	con.cmsProfileTab();
    	con.pageTab();
    	con.menuTab();
    	con.blockTab();
    	con.menuComponentTab();
    	con.sessionTab();
    	
    }

}