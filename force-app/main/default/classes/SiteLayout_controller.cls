public class SiteLayout_controller {

    private Page__c page;

    public String selectLanguage { get; set; }
    public String cmsCssCustom { get; set; }
    public String metaText { get; set; }
    public String pageTitle { get; set; }
    public String layoutWidth { get; set; }

    private String subject = System.Label.CMSLayout_Page_Error;

    public void init() {
        
        System.debug('Test');
        try {
            Cookie v_selectLanguage = ApexPages.currentPage().getCookies().get('selectLanguage');
            System.debug('------------- COOKIE ' + v_selectLanguage);
   
            if (v_selectLanguage != null && v_selectLanguage.getValue() != null) {
                selectLanguage = v_selectLanguage.getValue();
            } else {
                selectLanguage = 'en_US';
            }
            System.debug('-------------selectLanguage COOKIE ' + selectLanguage);
            SiteLog_controller.addMessage('init', 'SiteLayout_controller', '');

            SiteProfile__c profile = SiteUtility.getProfile();
            System.debug('!!!!!!!!!!!!!!!!!!!!!!!!!userId=' + UserInfo.getUserId());
            SiteLog_controller.addMessage('init', 'SiteLayout_controller', 'profile=' + profile);

            cmsCssCustom = SiteUtility.getCSSStyles();

            SiteLog_controller.addMessage('init', 'SiteLayout_controller', 'cmsCssCustom=' + cmsCssCustom);
            System.debug('PAGE URL :'+ApexPages.currentPage().getParameters().get('page'));
            List<Page__c> pages = [ 
                    SELECT Name, Meta_Text__c, Name__c,
                           Authentication_Required__c, Active__c
                    FROM Page__c
                    WHERE Active__c = true
                      AND Name__c =:ApexPages.currentPage().getParameters().get('page')];
            System.debug('@@@@@@@@@Pages Got :'+pages);
            
            if (pages.size() == 0) {
                SiteLog_controller.addErrorMessage(System.Label.This_URL_does_not_exist);

                return;
            }

            page = pages[0];
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@ Pages :'+page);

            List<Permission__c> permissions;
            if(page.Authentication_Required__c)
                permissions = [
                        SELECT Id
                        FROM Permission__c
                        WHERE Page__r.Name__c = :page.Name__c
                          AND SiteProfile__r.Name__c = :profile.Name__c];


                System.debug('PERMISSION  :'+profile.Name__c);
            SiteLog_controller.addMessage('SiteLayout_controller', 'SiteLayout_controller', 'permissions=' + permissions);

            if(permissions != null && permissions.size() == 0)
            {
                SiteLog_controller.addErrorMessage(System.Label.You_have_not_sufficient_rights_to_access_this_page);
            }

            SiteLog_controller.addMessage('SiteLayout_controller', 'SiteLayout_controller', 'page=' + page);

            metaText = page != null ? page.Meta_Text__c : '';
            pageTitle = page != null ? page.Name : '';

            setLayoutWidth(profile);
        }
        catch (Exception e)
        {
            SiteLog_controller.catchBlockMethod(e, subject);
        }
    }

    private void setLayoutWidth(SiteProfile__c profile)
    {
        SiteLog_controller.addMessage('SiteLayout_controller', 'setLayoutWidth', '');

        String sections = '';

        List<Permission__c> blockList = [
                SELECT PageBlock__r.Layout_Placement__c
                FROM Permission__c
                WHERE SiteProfile__c = :profile.id
                  AND PageBlock__r.Active__c = true
                  AND (PageBlock__r.Page__r.Name__c = '' OR
                       PageBlock__r.Page__r.Name__c = :ApexPages.currentPage().getParameters().get('page'))
                ORDER BY PageBlock__r.DisplayOrder__c];

        SiteLog_controller.addMessage('SiteLayout_controller', 'setLayoutWidth', 'blockList=' + blockList);

        for(Permission__c block : blockList)
            sections = sections + ';' + block.PageBlock__r.Layout_Placement__c;

        SiteLog_controller.addMessage('SiteLayout_controller', 'setLayoutWidth', 'sections=' + sections);

        if(sections.length() > 0 && sections.contains('left') && sections.contains('right'))
            layoutWidth = 'sidebars';
        else if(sections.length() > 0 && sections.contains('left'))
            layoutWidth = 'sidebar-left';
        else if(sections.length()>0 && sections.contains('right'))
            layoutWidth = 'sidebar-right';
        else if(sections.length()>0 && !sections.contains('right') && !sections.contains('left'))
            layoutWidth = 'cms-default';
        else if(sections.length()>0 && sections.contains('right') && sections.contains('left') && sections.contains('content'))
            layoutWidth = 'sidebars';

        SiteLog_controller.addMessage('SiteLayout_controller', 'setLayoutWidth', 'layoutWidth=' + layoutWidth);
    }

    public PageReference redirectIfNotLoggedIn()
    {
        PageReference pg = null;

        try
        {
            init();

            if (!ApexPages.hasMessages(ApexPages.Severity.ERROR))
            {
                SiteLog_controller.addMessage('SiteLayout_controller', 'redirectIfNotLoggedIn', '');

                Id contactId = LoginBlock.getLoggedInContact();

                SiteLog_controller.addMessage('SiteLayout_controller', 'redirectIfNotLoggedIn', 'contactId=' + contactId);

                if (page.Authentication_Required__c)
                {
                    if (contactId == null)
                    {
                        String startUrl = ApexPages.currentPage().getUrl().replace('&', '~');

                        SiteLog_controller.addMessage('SiteLayout_controller', 'redirectIfNotLoggedIn', 'startUrl=' + startUrl);

                        pg = new PageReference('/apex/SiteView');
                        pg.getParameters().put('page', 'LoginPage_view');
                        pg.getParameters().put('startUrl', startUrl);
                        pg.getParameters().put('jobSite', ApexPages.currentPage().getParameters().get('jobSite'));
                        pg.getParameters().put('p', ApexPages.currentPage().getParameters().get('p'));
                        pg.setRedirect(true);
                    }
                    else
                    {
                      /*s  Contact cont = [
                                SELECT Registration_Approved__c,
                                       SiteProfile__r.Need_Registration_Approval__c
                                FROM Contact
                                WHERE Id = :contactId];
                            system.debug('*********'+cont);
                        SiteLog_controller.addMessage('SiteLayout_controller', 'redirectIfNotLoggedIn', 'cont=' + cont); */

                       if (LoginBlock.NeedRegApproval &&
                            !LoginBlock.RegApp)
                        {
                            pg = new PageReference(
                                    '/apex/SiteView?page=' +
                                    LoginBlock.AprvlMsgPageName);
                            pg.setRedirect(true);
                        }
                    }
                }
            }
            System.debug('LOGGING MESSAGE---------'+subject);
            SiteLog_controller.sendLog(subject);
        }
        catch (Exception e)
        {
            SiteLog_controller.catchBlockMethod(e, subject);
        }

        return pg;
    }

    public static testmethod void tstSiteLayout_controller(){
        List<Account> accList = [select id from Account where Name = 'Candidate Pool2'];
        if(accList.size()>0){
            delete accList;
        }
        Account account = new Account();
        account.Name = 'Candidate Pool2';
        insert account;
        List<SiteProfile__c> profileList = [select id from SiteProfile__c];
        delete profileList;
        SiteProfile__c cmsProfile = new SiteProfile__c();
        cmsProfile.Name__c = 'CMSDefaultProfile';
        cmsProfile.Profile_Account__c = account.id;
        cmsProfile.CMSCss__c = 'CustomStyleSheet';
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
            block.Layout_Placement__c = 'right';
            block.Type__c = System.Label.Menu_Component;
            block.Menu_Component_Name__c = menuComponent.Name__c;
            block.IFrame_URL__c = '';
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
            block1.Layout_Placement__c = 'right';
            block1.Type__c = System.Label.IFRAME;
            block1.Menu_Component_Name__c = menuComponent.Name__c;
            block1.IFrame_URL__c = '';
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
            block2.Layout_Placement__c = 'right';
            block2.Type__c = System.Label.Flash;
            block2.Menu_Component_Name__c = menuComponent.Name__c;
            block2.IFrame_URL__c = '';
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
            block3.Layout_Placement__c = 'right';
            block3.Type__c = System.Label.MODULE;
            block3.Menu_Component_Name__c = menuComponent.Name__c;
            block3.IFrame_URL__c = '';
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
            block4.Layout_Placement__c = 'right';
            block4.Type__c = System.Label.HTML;
            block4.Menu_Component_Name__c = menuComponent.Name__c;
            block4.IFrame_URL__c = '';
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
            block5.Layout_Placement__c = 'right';
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
            block5.IFrame_URL__c = '';
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

        PageReference pg = new PageReference('/apex/SiteView');
        pg.getParameters().put('page',page.Name__c);
        pg.getParameters().put('sessionId',session.SessionId__c);
        Test.setCurrentPageReference(pg);
        SiteLayout_controller SiteLayoutcontroller = new SiteLayout_controller();
        SiteLayoutcontroller.redirectIfNotLoggedIn();

        PageBlockGenerator.cmsBlockBuilderMethod(page.Name__c,'header',contact.id);
        PageBlockGenerator.cmsBlockBuilderMethod(page.Name__c,'header','');
        page.Authentication_Required__c = true;
        update page;
        PageBlockGenerator.cmsBlockBuilderMethod(page.Name__c,'header',contact.id);
        PageReference pg1 = new PageReference('/apex/SiteView');
        pg1.getParameters().put('page',page.Name__c);

        Test.setCurrentPageReference(pg1);
        SiteLayout_controller SiteLayoutcontroller1 = new SiteLayout_controller();
        SiteLayoutcontroller1.redirectIfNotLoggedIn();
        Test.stopTest();
    }
 
}