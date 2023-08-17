public class HeaderPageRegion_controller {

    public Boolean showHideRegion = false;
    List<PageBlockObject> blockBeanList = new List<PageBlockObject>();
    Integer i =0;
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
    
    public HeaderPageRegion_controller() {
    	 System.debug('*****ramesh******public CMSHeaderRegionController()***USERID******'+ UserInfo.getUserId());
        blockBeanList = PageBlockGenerator.cmsBlockBuilderMethod(
        		ApexPages.currentPage().getParameters().get('page'),
        		'header',
        		ApexPages.currentPage().getParameters().get('sessionId'));
		System.debug('***************************'+blockBeanList);
        if (!blockBeanList.isEmpty()) {
            showHideRegion = true;
        }
        
        for (Integer j = 0; j < 40; j++) {
            if (j == 0) {
                moduleName0 = '/apex/Home';
                
            } else if(j==1) {
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
        
        for (PageBlockObject blockBean : blockBeanList) {
            if (i == 0) {
                if (blockBean.block.Type__c == System.Label.MODULE) {
                    moduleName0 = '/apex/'+blockBean.block.Module_Name__c;
                    showHideModule0=true;
                }
            }
            
            if (i == 1) {
                if (blockBean.block.Type__c == System.Label.MODULE){
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
        System.debug('*****ramesh******public CMSHeaderRegionController()***moduleName0******'+moduleName0);
        System.debug('*****ramesh******public CMSHeaderRegionController()***moduleName1******'+moduleName1);
        System.debug('*****ramesh******public CMSHeaderRegionController()***moduleName2******'+moduleName2);
        System.debug('*****ramesh******public CMSHeaderRegionController()***moduleName3******'+moduleName3);
        System.debug('*****ramesh******public CMSHeaderRegionController()***moduleName4******'+moduleName4);
        System.debug('*****ramesh******public CMSHeaderRegionController()***moduleName5******'+moduleName5);
        System.debug('*****ramesh******public CMSHeaderRegionController()***moduleName6******'+moduleName6);
        System.debug('*****ramesh******public CMSHeaderRegionController()***moduleName7******'+moduleName7);
        System.debug('*****ramesh******public CMSHeaderRegionController()***moduleName8******'+moduleName8);
        System.debug('*****ramesh******public CMSHeaderRegionController()***moduleName9******'+moduleName9);
        System.debug('*****ramesh******public CMSHeaderRegionController()***USERID******'+ UserInfo.getUserId());
        PageReference pg = new PageReference('/apex/AVTRRT__JobApplicationPage');
        PageReference pg1 = new PageReference('/apex/Home');
        System.debug('******Ramesh*******pg'+pg.getUrl()+'******pg1*****'+pg1.getUrl());
        
    }
    
    public Boolean getShowHideRegion(){
        System.debug('****Ramesh Dhull****in public class CMSHeaderRegionController {****in  public Boolean getShowHideRegion(){**');
        System.debug('*****Ramesh Dhull****in public class CMSHeaderRegionController {****in  public Boolean getShowHideRegion(){*********ApexPages.currentPage().getUrl()******'+ApexPages.currentPage().getUrl());
        return showHideRegion;
    }
    
    public List<PageBlockObject> getBlockBeanList(){
        System.debug('****Ramesh Dhull****in public class CMSHeaderRegionController {****in  public List<CMSBlockBean> getBlockBeanList(){**');
        return blockBeanList;
    }
    
    public static testmethod void tstCMSHeaderRegionController(){
        List<Account> accList = [select id from Account where Name = 'Candidate Pool2'];
        if(accList.size()>0){
            delete accList;
        }
        Account account = new Account();
        account.Name = 'Candidate Pool2';
        insert account;
        List<SiteProfile__c> profileList = [select id from SiteProfile__c];
        if(profileList.size()>0){
            delete profileList;
        }
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
        menu.Order__c = 1;
        menu.Page__c=page.id;
        insert menu;
        Menu_Component__c menuComponent = new Menu_Component__c();
        menuComponent.Name__c = 'OnlineJobSearch';
        menuComponent.Component_Menus__c = 'OnlineJobSearch';
        menuComponent.Active__c = true;
        menuComponent.Display_Type__c = 'horizontal';
        menuComponent.Override_Class__c = 'parent-menu';
        insert menuComponent;
        for(Integer i=0;i<5;i++){
            PageBlock__c block = new PageBlock__c();
            block.Name__c = 'OnlineJobSearch'+i;
            block.Page__c = page.id;
            block.Width__c = '400px';
            block.Height__c = '400px';
            block.DisplayOrder__c = 1;
            block.CSSStyle__c ='';
            block.Layout_Placement__c = 'header';
            block.Type__c = 'Menu Component';
            block.Menu_Component_Name__c = menuComponent.Name__c;
            block.IFrame_URL__c = 'www.google.com';
            block.Content__c = '<h1>Hello How are you?</h1>';
            block.Active__c =true;
            insert block;
            Permission__c permission = new Permission__c();
            permission.SiteProfile__c = cmsProfile.id;
            permission.Page__c = page.id;
            permission.PageBlock__c = block.id;
            insert permission;
            PageBlock__c block1 = new PageBlock__c();
            block1.Name__c = 'OnlineJobSearchIFRAME'+i;
            block1.Page__c = page.id;
            block1.Width__c = '400px';
            block1.Height__c = '400px';
            block1.DisplayOrder__c = 1;
            block1.CSSStyle__c ='';
            block1.Layout_Placement__c = 'header';
            block1.Type__c = System.Label.IFRAME;
            block1.Menu_Component_Name__c = menuComponent.Name__c;
            block1.IFrame_URL__c = 'www.google.com';
            block1.Content__c = '<h1>Hello How are you?</h1>';
            block1.Active__c =true;
            insert block1;
            Permission__c permission1 = new Permission__c();
            permission1.SiteProfile__c = cmsProfile.id;
            permission1.Page__c = page.id;
            permission1.PageBlock__c = block1.id;
            insert permission1;
            PageBlock__c block2 = new PageBlock__c();
            block2.Name__c = 'OnlineJobSearchFlash'+i;
            block2.Page__c = page.id;
            block2.Width__c = '400px';
            block2.Height__c = '400px';
            block2.DisplayOrder__c = 1;
            block2.CSSStyle__c ='';
            block2.Layout_Placement__c = 'header';
            block2.Type__c = System.Label.Flash;
            block2.Menu_Component_Name__c = menuComponent.Name__c;
            block2.IFrame_URL__c = 'www.google.com';
            block2.Content__c = '<h1>Hello How are you?</h1>';
            block2.Active__c =true;
            insert block2;
            Permission__c permission2 = new Permission__c();
            permission2.SiteProfile__c = cmsProfile.id;
            permission2.Page__c = page.id;
            permission2.PageBlock__c = block2.id;
            insert permission2;
            PageBlock__c block3 = new PageBlock__c();
            block3.Name__c = 'OnlineJobSearchMODULE'+i;
            block3.Page__c = page.id;
            block3.Width__c = '400px';
            block3.Height__c = '400px';
            block3.DisplayOrder__c = 1;
            block3.CSSStyle__c ='';
            block3.Layout_Placement__c = 'header';
            block3.Type__c = System.Label.MODULE;
            block3.Menu_Component_Name__c = menuComponent.Name__c;
            block3.IFrame_URL__c = 'www.google.com';
            block3.Content__c = '<h1>Hello How are you?</h1>';
            block3.Active__c =true;
            insert block3;
            Permission__c permission3 = new Permission__c();
            permission3.SiteProfile__c = cmsProfile.id;
            permission3.Page__c = page.id;
            permission3.PageBlock__c = block3.id;
            insert permission3;
            PageBlock__c block4 = new PageBlock__c();
            block4.Name__c = 'OnlineJobSearchHTML'+i;
            block4.Page__c = page.id;
            block4.Width__c = '400px';
            block4.Height__c = '400px';
            block4.DisplayOrder__c = 1;
            block4.CSSStyle__c ='';
            block4.Layout_Placement__c = 'header';
            block4.Type__c = System.Label.HTML;
            block4.Menu_Component_Name__c = menuComponent.Name__c;
            block4.IFrame_URL__c = 'www.google.com';
            block4.Content__c = '<h1>Hello How are you?</h1>';
            block4.Active__c =true;
            insert block4;
            Permission__c permission4 = new Permission__c();
            permission4.SiteProfile__c = cmsProfile.id;
            permission4.Page__c = page.id;
            permission4.PageBlock__c = block4.id;
            insert permission4;
            PageBlock__c block5 = new PageBlock__c();
            block5.Name__c = 'OnlineJobSearchExisting Block'+i;
            block5.Page__c = page.id;
            block5.Width__c = '400px';
            block5.Height__c = '400px';
            block5.DisplayOrder__c = 1;
            block5.CSSStyle__c ='';
            block5.Layout_Placement__c = 'header';
            block5.Type__c = System.Label.Existing_Block;
            if(i==0){
                block5.Existing_Block_Name__c = block.Name__c;
            }
            if(i==1){
                block5.Existing_Block_Name__c = block1.Name__c;
            }
            if(i==2){
                block5.Existing_Block_Name__c = block2.Name__c;
            }
            if(i==3){
                block5.Existing_Block_Name__c = block3.Name__c;
            }
            if(i==4){
                block5.Existing_Block_Name__c = block4.Name__c;
            }
            if(i==5){
                block5.Existing_Block_Name__c = block5.Name__c;
            }

            block5.Menu_Component_Name__c = menuComponent.Name__c;
            block5.IFrame_URL__c = 'www.google.com';
            block5.Content__c = '<h1>Hello How are you?</h1>';
            block5.Active__c =true;
            insert block5;
            Permission__c permission5 = new Permission__c();
            permission5.SiteProfile__c = cmsProfile.id;
            permission5.Page__c = page.id;
            permission5.PageBlock__c = block5.id;
            insert permission5;
            
        }
        Permission__c permission6 = new Permission__c();
        permission6.SiteProfile__c = cmsProfile.id;
        permission6.Page__c = page.id;
        insert permission6;
        Permission__c permission7 = new Permission__c();
        permission7.SiteProfile__c = cmsProfile.id;
        permission7.Menu__c = menu.id;
        insert permission7;
        
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
        
        Test.startTest();
        
        PageBlockObject cmsBlockBean = new PageBlockObject();
        List<PageBlockObject.CMSMenuBean> menuBean = new List<PageBlockObject.CMSMenuBean>();
        cmsBlockBean.setCmsMenuBeanList(menuBean);
        cmsBlockBean.getCmsMenuBeanList();
        
        PageReference pg = new PageReference('/apex/CMSLayout');
        pg.getParameters().put('page',page.Name__c);
        pg.getParameters().put('sessionId',session.SessionId__c);
        Test.setCurrentPageReference(pg);
        HeaderPageRegion_controller cmsHeaderRegion= new HeaderPageRegion_controller();
        cmsHeaderRegion.getBlockBeanList();
        cmsHeaderRegion.getShowHideRegion();
        Test.stopTest();
    }
    
    public static testmethod void tstCMSHeaderRegionController1(){
        List<Account> accList = [select id from Account where Name = 'Candidate Pool2'];
        if(accList.size()>0){
            delete accList;
        }
        Account account = new Account();
        account.Name = 'Candidate Pool2';
        insert account;
        List<SiteProfile__c> profileList = [select id from SiteProfile__c];
        if(profileList.size()>0){
            delete profileList;
        }
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
        menu.Order__c = 1;
        menu.Page__c=page.id;
        insert menu;
        Menu_Component__c menuComponent = new Menu_Component__c();
        menuComponent.Name__c = 'OnlineJobSearch';
        menuComponent.Component_Menus__c = 'OnlineJobSearch';
        menuComponent.Active__c = true;
        menuComponent.Display_Type__c = 'horizontal';
        menuComponent.Override_Class__c = 'parent-menu';
        insert menuComponent;
        for(Integer i=0;i<30;i++){
            
            PageBlock__c block3 = new PageBlock__c();
            block3.Name__c = 'OnlineJobSearchMODULE'+i;
            block3.Page__c = page.id;
            block3.Width__c = '400px';
            block3.Height__c = '400px';
            block3.DisplayOrder__c = 1;
            block3.CSSStyle__c ='';
            block3.Layout_Placement__c = 'header';
            block3.Type__c = System.Label.MODULE;
            block3.Menu_Component_Name__c = menuComponent.Name__c;
            block3.IFrame_URL__c = 'www.google.com';
            block3.Content__c = '<h1>Hello How are you?</h1>';
            block3.Active__c =true;
            insert block3;
            Permission__c permission3 = new Permission__c();
            permission3.SiteProfile__c = cmsProfile.id;
            permission3.Page__c = page.id;
            permission3.PageBlock__c = block3.id;
            insert permission3;
            
            
        }
        Permission__c permission6 = new Permission__c();
        permission6.SiteProfile__c = cmsProfile.id;
        permission6.Page__c = page.id;
        insert permission6;
        Permission__c permission7 = new Permission__c();
        permission7.SiteProfile__c = cmsProfile.id;
        permission7.Menu__c = menu.id;
        insert permission7;
        
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
        
        Test.startTest();
        
        PageBlockObject cmsBlockBean = new PageBlockObject();
        List<PageBlockObject.CMSMenuBean> menuBean = new List<PageBlockObject.CMSMenuBean>();
        cmsBlockBean.setCmsMenuBeanList(menuBean);
        cmsBlockBean.getCmsMenuBeanList();
        
        PageReference pg = new PageReference('/apex/CMSLayout');
        pg.getParameters().put('page',page.Name__c);
        pg.getParameters().put('sessionId',session.SessionId__c);
        Test.setCurrentPageReference(pg);
        HeaderPageRegion_controller cmsHeaderRegion= new HeaderPageRegion_controller();
        cmsHeaderRegion.getBlockBeanList();
        cmsHeaderRegion.getShowHideRegion();
        Test.stopTest();
    }

}