public class CenterPageRegion_controller {

    List<PageBlockObject> blockBeanList = new List<PageBlockObject>();
    Integer i = 0;
    public Boolean showHideModule0 {get;set;}
    public Boolean showHideModule1 {get;set;}
    public Boolean showHideModule2 {get;set;}
    public Boolean showHideModule3 {get;set;}
    public Boolean showHideModule4 {get;set;}
    public Boolean showHideModule5 {get;set;}
    public Boolean showHideModule6 {get;set;}
    public Boolean showHideModule7 {get;set;}
    public Boolean showHideModule8 {get;set;}
    public Boolean showHideModule9 {get;set;}
    public Boolean showHideModule10 {get;set;}
    public Boolean showHideModule11 {get;set;}
    public Boolean showHideModule12 {get;set;}
    public Boolean showHideModule13 {get;set;}
    public Boolean showHideModule14 {get;set;}
    public Boolean showHideModule15 {get;set;}
    public Boolean showHideModule16 {get;set;}
    public Boolean showHideModule17 {get;set;}
    public Boolean showHideModule18 {get;set;}
    public Boolean showHideModule19 {get;set;}
    public Boolean showHideModule20 {get;set;}
    public Boolean showHideModule21 {get;set;}
    public Boolean showHideModule22 {get;set;}
    public Boolean showHideModule23 {get;set;}
    public Boolean showHideModule24 {get;set;}
    public Boolean showHideModule25 {get;set;}
    public Boolean showHideModule26 {get;set;}
    public Boolean showHideModule27 {get;set;}
    public Boolean showHideModule28 {get;set;}
    public Boolean showHideModule29 {get;set;}
    
    public String moduleName0 {get;set;}
    public String moduleName1 {get;set;}
    public String moduleName2 {get;set;}
    public String moduleName3 {get;set;}
    public String moduleName4 {get;set;}
    public String moduleName5 {get;set;}
    public String moduleName6 {get;set;}
    public String moduleName7 {get;set;}
    public String moduleName8 {get;set;}
    public String moduleName9 {get;set;}
    public String moduleName10 {get;set;}
    public String moduleName11 {get;set;}
    public String moduleName12 {get;set;}
    public String moduleName13 {get;set;}
    public String moduleName14 {get;set;}
    public String moduleName15 {get;set;}
    public String moduleName16 {get;set;}
    public String moduleName17 {get;set;}
    public String moduleName18 {get;set;}
    public String moduleName19 {get;set;}
    public String moduleName20 {get;set;}
    public String moduleName21 {get;set;}
    public String moduleName22 {get;set;}
    public String moduleName23 {get;set;}
    public String moduleName24 {get;set;}
    public String moduleName25 {get;set;}
    public String moduleName26 {get;set;}
    public String moduleName27 {get;set;}
    public String moduleName28 {get;set;}
    public String moduleName29 {get;set;}
    
    public CenterPageRegion_controller(){  
        System.debug('****Ramesh Dhull****in public class CMSContentRegionController {****in  CMSContentRegionController(){**');
        system.debug('%%%Current Page%%'+ApexPages.currentPage().getParameters().get('page'));
        blockBeanList=PageBlockGenerator.cmsBlockBuilderMethod(ApexPages.currentPage().getParameters().get('page'),'content',ApexPages.currentPage().getParameters().get('sessionId'));
        System.debug('CONTENT REGION : '+blockBeanList);
         System.debug('CONTENT REGION : '+blockBeanList.size());
        for(Integer j = 0;j<40;j++){
            if(j==0){
                moduleName0 = '/apex/Home';
                
            }
            else if(j==1){
                moduleName1 = '/apex/Home';
                
            }
            else if(j==2){
                moduleName2 = '/apex/Home';
                
            }
            else if(j==3){
                moduleName3 = '/apex/Home';
                
            }
            else if(j==4){
                moduleName4 = '/apex/Home';
                
            }
            else if(j==5){
                moduleName5 = '/apex/Home';
                
            }
            else if(j==6){
                moduleName6 = '/apex/Home';
                
            }
            else if(j==7){
                moduleName7 = '/apex/Home';
                
            }
            else if(j==8){
                moduleName8 = '/apex/Home';
                
            }
            else if(j==9){
                moduleName9 = '/apex/Home';
                
            }
            else if(j==10){
                moduleName10 = '/apex/Home';
                
            }
            else if(j==11){
                moduleName11 = '/apex/Home';
                
            }
            else if(j==12){
                moduleName12 = '/apex/Home';
                
            }
            else if(j==13){
                moduleName13 = '/apex/Home';
                
            }
            else if(j==14){
                moduleName14 = '/apex/Home';
                
            }
            else if(j==15){
                moduleName15 = '/apex/Home';
                
            }
            else if(j==16){
                moduleName16 = '/apex/Home';
                
            }
            else if(j==17){
                moduleName17 = '/apex/Home';
                
            }
            else if(j==18){
                moduleName18 = '/apex/Home';
                
            }
            else if(j==19){
                moduleName19 = '/apex/Home';
                
            }
            else if(j==20){
                moduleName20 = '/apex/Home';
                
            }
            else if(j==21){
                moduleName21 = '/apex/Home';
                
            }
            else if(j==22){
                moduleName22 = '/apex/Home';
                
            }
            else if(j==23){
                moduleName23 = '/apex/Home';
                
            }
            else if(j==24){
                moduleName24 = '/apex/Home';
                
            }
            else if(j==25){
                moduleName25 = '/apex/Home';
                
            }
            else if(j==26){
                moduleName26 = '/apex/Home';
                
            }
            else if(j==27){
                moduleName27 = '/apex/Home';
                
            }
            else if(j==28){
                moduleName28 = '/apex/Home';
                
            }
            else if(j==29){
                moduleName29 = '/apex/Home';
                
            }
            
        }
        for(PageBlockObject blockBean:blockBeanList){
        	system.debug('Counter I'+i+'Bean Block TYpe**'+blockBean.block.Type__c+'label module**'+System.Label.MODULE);
            if(i==0){
                if(blockBean.block.Type__c == System.Label.MODULE){  
                    moduleName0 = blockBean.block.Module_Name__c;
                    showHideModule0=true;
                }
            }
            if(i==1){
                if(blockBean.block.Type__c == System.Label.MODULE){  
                    moduleName1 = '/apex/'+blockBean.block.Module_Name__c;
                    showHideModule1=true;
                }
            }
            if(i==2){
                if(blockBean.block.Type__c == System.Label.MODULE){  
                    moduleName2 = '/apex/'+blockBean.block.Module_Name__c;
                    showHideModule2=true;
                }
            }
            if(i==3){
                if(blockBean.block.Type__c == System.Label.MODULE){  
                    moduleName3 = '/apex/'+blockBean.block.Module_Name__c;
                    showHideModule3=true;
                }
            }
            if(i==4){
                if(blockBean.block.Type__c == System.Label.MODULE){  
                    moduleName4 = '/apex/'+blockBean.block.Module_Name__c;
                    showHideModule4=true;
                }
            }
            if(i==5){
                if(blockBean.block.Type__c == System.Label.MODULE){  
                    moduleName5 = '/apex/'+blockBean.block.Module_Name__c;
                    showHideModule5=true;
                }
            }
            if(i==6){
                if(blockBean.block.Type__c == System.Label.MODULE){  
                    moduleName6 = '/apex/'+blockBean.block.Module_Name__c;
                    showHideModule6=true;
                }
            }
            if(i==7){
                if(blockBean.block.Type__c == System.Label.MODULE){  
                    moduleName7 = '/apex/'+blockBean.block.Module_Name__c;
                    showHideModule7=true;
                }
            }
            if(i==8){
                if(blockBean.block.Type__c == System.Label.MODULE){  
                    moduleName8 = '/apex/'+blockBean.block.Module_Name__c;
                    showHideModule8=true;
                }
            }
            if(i==9){
                if(blockBean.block.Type__c == System.Label.MODULE){  
                    moduleName9 = '/apex/'+blockBean.block.Module_Name__c;
                    showHideModule9=true;
                }
            }
            if(i==10){
                System.debug('*******Ramesh****blockBean.block***'+blockBean.block.Type__c);
                if(blockBean.block.Type__c == System.Label.MODULE){  
                    moduleName10 = '/apex/'+blockBean.block.Module_Name__c;
                    showHideModule10=true;
                }
            }
            if(i==11){
                if(blockBean.block.Type__c == System.Label.MODULE){  
                    moduleName11 = '/apex/'+blockBean.block.Module_Name__c;
                    showHideModule11=true;
                }
            }
            if(i==12){
                if(blockBean.block.Type__c == System.Label.MODULE){  
                    moduleName12 = '/apex/'+blockBean.block.Module_Name__c;
                    showHideModule12=true;
                }
            }
            if(i==13){
                if(blockBean.block.Type__c == System.Label.MODULE){  
                    moduleName13 = '/apex/'+blockBean.block.Module_Name__c;
                    showHideModule13=true;
                }
            }
            if(i==14){
                if(blockBean.block.Type__c == System.Label.MODULE){  
                    moduleName14 = '/apex/'+blockBean.block.Module_Name__c;
                    showHideModule14=true;
                }
            }
            if(i==15){
                if(blockBean.block.Type__c == System.Label.MODULE){  
                    moduleName15 = '/apex/'+blockBean.block.Module_Name__c;
                    showHideModule15=true;
                }
            }
            if(i==16){
                if(blockBean.block.Type__c == System.Label.MODULE){  
                    moduleName16 = '/apex/'+blockBean.block.Module_Name__c;
                    showHideModule16=true;
                }
            }
            if(i==17){
                if(blockBean.block.Type__c == System.Label.MODULE){  
                    moduleName17 = '/apex/'+blockBean.block.Module_Name__c;
                    showHideModule17=true;
                }
            }
            if(i==18){
                if(blockBean.block.Type__c == System.Label.MODULE){  
                    moduleName18 = '/apex/'+blockBean.block.Module_Name__c;
                    showHideModule18=true;
                }
            }
            if(i==19){
                if(blockBean.block.Type__c == System.Label.MODULE){  
                    moduleName19 = '/apex/'+blockBean.block.Module_Name__c;
                    showHideModule19=true;
                }
            }
            if(i==20){
                if(blockBean.block.Type__c == System.Label.MODULE){  
                    moduleName20 = '/apex/'+blockBean.block.Module_Name__c;
                    showHideModule20=true;
                }
            }
            if(i==21){
                if(blockBean.block.Type__c == System.Label.MODULE){  
                    moduleName21 = '/apex/'+blockBean.block.Module_Name__c;
                    showHideModule21=true;
                }
            }
            if(i==22){
                if(blockBean.block.Type__c == System.Label.MODULE){  
                    moduleName22 = '/apex/'+blockBean.block.Module_Name__c;
                    showHideModule23=true;
                }
            }
            if(i==23){
                if(blockBean.block.Type__c == System.Label.MODULE){  
                    moduleName23 = '/apex/'+blockBean.block.Module_Name__c;
                    showHideModule23=true;
                }
            }
            if(i==24){
                if(blockBean.block.Type__c == System.Label.MODULE){  
                    moduleName24 = '/apex/'+blockBean.block.Module_Name__c;
                    showHideModule24=true;
                }
            }
            if(i==25){
                if(blockBean.block.Type__c == System.Label.MODULE){  
                    moduleName25 = '/apex/'+blockBean.block.Module_Name__c;
                    showHideModule25=true;
                }
            }
            if(i==26){
                if(blockBean.block.Type__c == System.Label.MODULE){  
                    moduleName26 = '/apex/'+blockBean.block.Module_Name__c;
                    showHideModule26=true;
                }
            }
            if(i==27){
                if(blockBean.block.Type__c == System.Label.MODULE){  
                    moduleName27 = '/apex/'+blockBean.block.Module_Name__c;
                    showHideModule27=true;
                }
            }
            if(i==28){
                if(blockBean.block.Type__c == System.Label.MODULE){  
                    moduleName28 = '/apex/'+blockBean.block.Module_Name__c;
                    showHideModule28=true;
                }
            }
            if(i==29){
                if(blockBean.block.Type__c == System.Label.MODULE){  
                    moduleName29 = '/apex/'+blockBean.block.Module_Name__c;
                    showHideModule29=true;
                }
            }

            i++;
        }
        
        System.debug('::::::::::moduleName0=' + moduleName0);
    }
    public List<PageBlockObject> getBlockBeanList(){
        System.debug('****Ramesh Dhull****in public class CMSContentRegionController {****in  public List<CMSBlockBean> getBlockBeanList(){**'+blockBeanList);
        return blockBeanList;
    }
    
   public static testmethod void tstCMSContentRegionController(){
   		Account account = new Account();
        account.Name = 'Candidate Pool2';
        insert account;       
        
        SiteProfile__c cmsProfile = new SiteProfile__c();
        cmsProfile.Name__c = 'CMSDefaultProfile';
        cmsProfile.Profile_Account__c = account.id;
        cmsProfile.CMSCss__c = 'CMSCssCustom';
        cmsProfile.User_Registration__c = true;
        insert cmsProfile;      
        
        Contact contact = new Contact();
        contact.FirstName = 'Ramesh';
        contact.LastName = 'Dhull';
        contact.UserName__c = 'dhull.ramesh@gmail.com';
        contact.Email = 'dhull.ramesh@gmail.com';
        contact.Password__c = 'avankia1';
        contact.SiteProfile__c = cmsProfile.id;      
        insert contact;
        
        Page__c page = new Page__c();
        page.Name = 'OnlineJobSearch';
        page.Name__c = 'OnlineJobSearch';
        page.Active__c = true;
        insert page;
        
        Menu__c menu = new Menu__c();
        menu.Name = 'OnlineJobSearch';
        menu.Name__c = 'OnlineJobSearch';
        menu.Active__c = true;
        menu.Order__c = 2;
        menu.Page__c=page.id;
        insert menu;
        
        Menu_Component__c menuComponent = new Menu_Component__c();
        menuComponent.Name__c = 'OnlineJobSearch';
        menuComponent.Component_Menus__c = 'OnlineJobSearch';
        menuComponent.Active__c = true;
        menuComponent.Display_Type__c = 'horizontal';
        menuComponent.Override_Class__c = 'parent-menu';
        insert menuComponent;
        
        for(integer i=0;i<30;i++){        
	        PageBlock__c pageBlock = new PageBlock__c();
	        pageBlock.Name='OnlineJobSearch';         
	        pageBlock.Name__c = 'OnlineJobSearch';
	        pageBlock.Page__c = page.id;
	        pageBlock.Width__c = '400px';
	        pageBlock.Height__c = '400px';
	        pageBlock.CSSStyle__c ='';
	        pageBlock.Layout_Placement__c = 'content';
	        pageBlock.Type__c = 'MODULE';//'Menu Component';
	        pageBlock.Menu_Component_Name__c = menuComponent.Name__c;
	        pageBlock.IFrame_URL__c = 'www.google.com';
	        pageBlock.Content__c = '<h1>Hello How are you?</h1>';
	        pageBlock.Active__c =true;
	 		insert pageBlock;
	 			
	 	    Permission__c permission = new Permission__c();
			permission.PageBlock__c =  pageBlock.id;
			permission.SiteProfile__c=cmsProfile.id;
			permission.Menu__c=menu.id;
			insert permission;
        }
		
         
        Map<String,String> headerMap = System.currentPageReference().getHeaders();
        String sessionString;
        sessionString = String.valueOf(Math.random());
        sessionString = sessionString.substring(2,16);
        Session__c session = new Session__c();
        session.Session_For__c = contact.Id;
        session.User_Agent__c=headerMap.get('User-Agent');
        session.IP_Address__c=headerMap.get('X-Salesforce-SIP');
        session.SessionId__c = sessionString;
        insert session;       
        
        PageBlockObject cmsBlockBean = new PageBlockObject();       
        List<PageBlockObject.CMSMenuBean> menuBean = new List<PageBlockObject.CMSMenuBean>();
        cmsBlockBean.setCmsMenuBeanList(menuBean);
        cmsBlockBean.getCmsMenuBeanList();
        
        PageReference pg = new PageReference('/apex/SiteView');
        pg.getParameters().put('page',page.Name__c);
        pg.getParameters().put('sessionId',session.SessionId__c);
        System.debug('PAGE REFERENCE------------');
        Test.setCurrentPageReference(pg);
        System.debug('INIT CLASS CENTERPAGEREGION-----');
        CenterPageRegion_controller cmsContentRegion= new CenterPageRegion_controller();
        System.debug('GETBLOCKBEANLIST');
        cmsContentRegion.getBlockBeanList(); 
        
    }
}