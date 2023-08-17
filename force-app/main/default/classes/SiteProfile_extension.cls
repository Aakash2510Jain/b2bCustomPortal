global  class SiteProfile_extension {

    // This Extension class is created for the page which is overriding SiteProfile__c's standard page.
    global SiteProfile__c cmsProfile;
    global String recordType;   
    List<RecordType> recordTypeList = [Select r.SobjectType, r.Name, r.Id From RecordType r where r.SobjectType = :System.Label.Contact and r.IsActive = true];
    global Boolean showHideRecordType;
    global Boolean approvalMessagePage {get;set;}
    //Extension's constructor method
    global SiteProfile_extension(ApexPages.StandardController controller){
        cmsProfile = (SiteProfile__c)controller.getRecord();
        if(cmsProfile.Need_Registration_Approval__c == true){
            approvalMessagePage = true;
        }
    }
    global Boolean getShowHideRecordType(){
        if(recordTypeList.size()>0){
            showHideRecordType = true;
        }
        return showHideRecordType;
    }
    
    global String getRecordType(){
        recordType=cmsProfile.User_Record_Type__c;
        return recordType;
    }
    global void setRecordType(String recordType){
        this.recordType = recordType;
        cmsProfile.User_Record_Type__c=recordType;
    }
    global List<SelectOption> getItems() 
    {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption(System.Label.None, System.Label.None));
        
        for(RecordType recordType : recordTypeList)
        {
            options.add(new SelectOption(recordType.Name,recordType.Name));
        }
        return options;
    }
    //This save1 button is overriding the CMSProfiles's standard save button
    global PageReference save1(){
        
        //Checking whether operation is Save or Update
        if(cmsProfile.Need_Registration_Approval__c==true && cmsProfile.Approval_Message_Page__c == null){
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, System.Label.Approval_Message_Page);
            ApexPages.addMessage(msg);
            approvalMessagePage=true;
            return null;
        }
        
        cmsProfile = setupProfile(cmsProfile); 
        PageReference pg = new PageReference('/'+cmsProfile.id);
        return pg;
    }
    //This saveAndNew1 button is overriding the SiteProfile__c's standard saveAndNew button
    global PageReference saveAndNew1(){
        
        if(cmsProfile.Need_Registration_Approval__c==true && cmsProfile.Approval_Message_Page__c == null){
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, System.Label.Approval_Message_Page);
            ApexPages.addMessage(msg);
            approvalMessagePage=true;
            return null;
        }
        cmsProfile = setupProfile(cmsProfile);
        PageReference pg = new PageReference('/apex/Profiles_view');
        pg.setRedirect(true);
        return pg;
        
    }
    global PageReference approvalPage(){
        //CMSProfileExtension cmsProfile = new CMSProfileExtension();
        System.debug('**********Ramesh****cmsProfile.Need_Registration_Approval__c*****'+cmsProfile.Need_Registration_Approval__c);
        if(cmsProfile.Need_Registration_Approval__c == true){
            approvalMessagePage = true;
        }
        else{
            approvalMessagePage = false;
        }
        System.debug('**********Ramesh****approvalMessagePage*****'+approvalMessagePage);
        return null;
    }
    
    
    
    
    
    global static SiteProfile__c setupProfile(SiteProfile__c cmsProfile){
        //These below four Boolean variables are used to track whether 
        //pages which are used in Portal functionality is exist or not if not then based on these variables values we will create them
        Boolean cmsSiteLoginPage;
        Boolean cmsSiteRegisterPage;
        Boolean cmsSiteForgotPassword;
        Boolean cmsSiteForgotPasswordConfirm;
        if(cmsProfile!=null && cmsProfile.id!=null){
            update cmsProfile;
        }
        else if(cmsProfile!=null && cmsProfile.id==null){
            insert cmsProfile;
        }
        //Below logic is for if user want to enable Portal for this profile.
        if(cmsProfile.Portal_Enabled__c == true){
            List<Page__c> pageList = [select id,Name__c,Active__c from Page__c where Name__c='CMSForgotPasswordConfirm' or 
                                            Name__c='CMSSiteLogin' or Name__c='CMSSiteRegister' or Name__c='CMSForgotPassword'];
            System.debug('*****ramesh******pageList1*****'+pageList);
            if(pageList.size()>0){
                for(Page__c page:pageList){
                    if(page.Name__c == 'CMSSiteLogin'){
                        cmsSiteLoginPage = true;
                        if(page.Active__c == false){
                            page.Active__c = true;
                            update page;
                        }
                    }
                    else if(page.Name__c == 'CMSSiteRegister'){
                        cmsSiteRegisterPage = true;
                        if(page.Active__c == false){
                            page.Active__c = true;
                            update page;
                        }
                    }
                    else if(page.Name__c == 'CMSForgotPassword'){
                        cmsSiteForgotPassword = true;
                        if(page.Active__c == false){
                            page.Active__c = true;
                            update page;
                        }
                    }
                    else if(page.Name__c == 'CMSForgotPasswordConfirm'){
                        cmsSiteForgotPasswordConfirm = true;
                        if(page.Active__c == false){
                            page.Active__c = true;
                            update page;
                        }
                    }
                }
            }
            //Based on the value of four Boolean variables used for pages existence we are creating page which is not exist. 
            System.debug('******ramesh****cmsSiteLoginPage*****'+cmsSiteLoginPage);
            if(cmsSiteLoginPage==null){
                Page__c page1 = new Page__c();
                page1.Name = 'CMSSiteLogin';
                page1.Name__c = 'CMSSiteLogin';
                page1.Active__c = true;
                insert page1;
                
            }
            
            if(cmsSiteRegisterPage==null){
                Page__c page2 = new Page__c();
                page2.Name = 'CMSSiteRegister';
                page2.Name__c = 'CMSSiteRegister';
                page2.Active__c = true;
                insert page2;
            }
            if(cmsSiteForgotPassword==null){
                Page__c page3 = new Page__c();
                page3.Name = 'CMSForgotPassword';
                page3.Name__c = 'CMSForgotPassword';
                page3.Active__c = true;
                insert page3;
            }
            if(cmsSiteForgotPasswordConfirm==null){
                Page__c page4 = new Page__c();
                page4.Name = 'CMSForgotPasswordConfirm';
                page4.Name__c = 'CMSForgotPasswordConfirm';
                page4.Active__c = true;
                insert page4;
            }
            
            pageList = [select id,Name__c,Active__c from Page__c where Name__c='CMSForgotPasswordConfirm' or 
                        Name__c='CMSSiteLogin' or Name__c='CMSSiteRegister' or Name__c='CMSForgotPassword'];
            System.debug('*****ramesh******pageList2*****'+pageList);
            //Checking blocks and their permission for these pages for this profile. If these exist then ok otherwise we are creating them here.
            for(Page__c pg:pageList){
                if(pg.Name__c=='CMSSiteLogin'){
                    List<PageBlock__c> blockList = [select id,Name__c from PageBlock__c where Page__r.Name__c = 'CMSSiteLogin' 
                                                    and Name__c = 'CMSSiteLogin' limit 1];
                    if(blockList.size()>0){
                        List<Permission__c> blockPermissionList = [select id from Permission__c where PageBlock__c = :blockList[0].id 
                                                                        and SiteProfile__c = :cmsProfile.id];
                        if(blockPermissionList.size()==0){
                            Permission__c permission = new Permission__c();
                            permission.SiteProfile__c = cmsProfile.id;
                            permission.PageBlock__c = blockList[0].id;
                            insert permission;  
                        }
                    }
                    else{

                        PageBlock__c block = new PageBlock__c();
                        block.Name = 'CMSSiteLogin';
                        block.Name__c = 'CMSSiteLogin';
                        block.Page__c = pg.id;
                        block.Active__c = true;
                        block.Type__c = System.Label.MODULE;
                        block.DisplayOrder__c = 0.0;
                        block.Module_Name__c ='CMSSiteLogin';
                        
                        insert block;
                        Permission__c permission = new Permission__c();
                        permission.SiteProfile__c = cmsProfile.id;
                        permission.PageBlock__c = block.id;
                        insert permission;
                    }
                }
                else if(pg.Name__c=='CMSSiteRegister'){
                    List<PageBlock__c> blockList = [select id,Name__c from PageBlock__c where Page__r.Name__c = 'CMSSiteRegister' 
                                                    and Name__c = 'CMSSiteRegister' limit 1];
                    if(blockList.size()>0){
                        List<Permission__c> blockPermissionList = [select id from Permission__c 
                                                                        where PageBlock__c = :blockList[0].id and SiteProfile__c = :cmsProfile.id];
                        if(blockPermissionList.size()==0){
                            Permission__c permission = new Permission__c();
                            permission.SiteProfile__c = cmsProfile.id;
                            permission.PageBlock__c = blockList[0].id;
                            insert permission;  
                        }
                    }
                    else{
                        PageBlock__c block = new PageBlock__c();
                        block.Name = 'CMSSiteRegister';
                        block.Name__c = 'CMSSiteRegister';
                        block.Page__c = pg.id;
                        block.Active__c = true;
                        block.Type__c = System.Label.MODULE;
                        block.DisplayOrder__c = 0.0;
                        block.Module_Name__c ='CMSSiteRegister';
                        insert block;
                        Permission__c permission = new Permission__c();
                        permission.SiteProfile__c = cmsProfile.id;
                        permission.PageBlock__c = block.id;
                        insert permission;
                    }
                }
                else if(pg.Name__c=='CMSForgotPassword'){
                    List<PageBlock__c> blockList = [select id,Name__c from PageBlock__c where Page__r.Name__c = 'CMSForgotPassword' 
                                                        and Name__c = 'CMSForgotPassword' limit 1];
                    if(blockList.size()>0){
                        List<Permission__c> blockPermissionList = [select id from Permission__c 
                                                                        where PageBlock__c = :blockList[0].id and SiteProfile__c = :cmsProfile.id];
                        if(blockPermissionList.size()==0){
                            Permission__c permission = new Permission__c();
                            permission.SiteProfile__c = cmsProfile.id;
                            permission.PageBlock__c = blockList[0].id;
                            insert permission;  
                        }
                    }
                    else{
                        PageBlock__c block = new PageBlock__c();
                        block.Name = 'CMSForgotPassword';
                        block.Name__c = 'CMSForgotPassword';
                        block.Page__c = pg.id;
                        block.Active__c = true;
                        block.Type__c = System.Label.MODULE;
                        block.DisplayOrder__c = 0.0;
                        block.Module_Name__c ='CMSForgotPassword';
                        insert block;
                        Permission__c permission = new Permission__c();
                        permission.SiteProfile__c = cmsProfile.id;
                        permission.PageBlock__c = block.id;
                        insert permission;
                    }
                }
                else if(pg.Name__c=='CMSForgotPasswordConfirm'){
                    List<PageBlock__c> blockList = [select id,Name__c from PageBlock__c 
                                                    where Page__r.Name__c = 'CMSForgotPasswordConfirm' and 
                                                    Name__c = 'CMSForgotPasswordConfirm' limit 1];
                    if(blockList.size()>0){
                        List<Permission__c> blockPermissionList = [select id from Permission__c 
                                                                        where PageBlock__c = :blockList[0].id and SiteProfile__c = :cmsProfile.id];
                        if(blockPermissionList.size()==0){
                            Permission__c permission = new Permission__c();
                            permission.SiteProfile__c = cmsProfile.id;
                            permission.PageBlock__c = blockList[0].id;
                            insert permission;  
                        }
                    }
                    else{
                        PageBlock__c block = new PageBlock__c();
                        block.Name = 'CMSForgotPasswordConfirm';
                        block.Name__c = 'CMSForgotPasswordConfirm';
                        block.Page__c = pg.id;
                        block.Active__c = true;
                        block.Type__c = System.Label.MODULE;
                        block.DisplayOrder__c = 0.0;
                        block.Module_Name__c ='CMSForgotPasswordConfirm';
                        insert block;
                        Permission__c permission = new Permission__c();
                        permission.SiteProfile__c = cmsProfile.id;
                        permission.PageBlock__c = block.id;
                        insert permission;
                    }
                }
            }
            List<PageBlock__c> cmsLoginManagementBlockList = [select id from PageBlock__c where Name__c = 'CMSLoginManagement' limit 1];
            if(cmsLoginManagementBlockList.size()>0){
                List<Permission__c> cmsLoginManagementPermissionList = [select id from Permission__c 
                                                                            where PageBlock__c = :cmsLoginManagementBlockList[0].id and 
                                                                            SiteProfile__c = :cmsProfile.id];
                if(cmsLoginManagementPermissionList.size()==0){
                    Permission__c cmsLoginManagementPermission = new Permission__c();
                    cmsLoginManagementPermission.SiteProfile__c = cmsProfile.id;
                    cmsLoginManagementPermission.PageBlock__c = cmsLoginManagementBlockList[0].id;
                    insert cmsLoginManagementPermission;
                }
            }
            else if(cmsLoginManagementBlockList.size()==0){
                PageBlock__c cmsLoginManagementBlock = new PageBlock__c();
                cmsLoginManagementBlock.Name = 'CMSLoginManagement';
                cmsLoginManagementBlock.Name__c = 'CMSLoginManagement';
                cmsLoginManagementBlock.Active__c = true;
                cmsLoginManagementBlock.Type__c = System.Label.MODULE;
                cmsLoginManagementBlock.DisplayOrder__c = 0.0;
                cmsLoginManagementBlock.Layout_Placement__c = 'header';
                cmsLoginManagementBlock.CSSStyle__c ='welcome-user';
                cmsLoginManagementBlock.Module_Name__c ='CMSLoginManagement';
                insert cmsLoginManagementBlock;
                Permission__c cmsLoginManagementBlockPermission = new Permission__c();
                cmsLoginManagementBlockPermission.SiteProfile__c = cmsProfile.id;
                cmsLoginManagementBlockPermission.PageBlock__c = cmsLoginManagementBlock.id;
                insert cmsLoginManagementBlockPermission;
            }
        }
        //Below logic is if user want to disable portal functionality for this profile.
        else if(cmsProfile.Portal_Enabled__c == false){
            List<Permission__c> currentCMSProfilePortalPermission = [select id from Permission__c where SiteProfile__c =:cmsProfile.id and 
                                                                    (PageBlock__r.Name__c = 'CMSLoginManagement' or 
                                                                    PageBlock__r.Name__c = 'CMSSiteLogin' or PageBlock__r.Name__c = 'CMSSiteRegister' 
                                                                    or PageBlock__r.Name__c = 'CMSForgotPassword' or 
                                                                    PageBlock__r.Name__c = 'CMSForgotPasswordConfirm')];
            delete currentCMSProfilePortalPermission;
        }
        return cmsProfile;
    }    
    
    
    
    global static testmethod void tstCMSProfileExtension(){
        SiteProfile__c cmsProfile = new SiteProfile__c();
        ApexPages.StandardController sc = new ApexPages.StandardController(cmsProfile);
        SiteProfile_extension cmsProfileExtension = new SiteProfile_extension(sc);
        List<Page__c> pageList = [select id from Page__c limit 1000];
        if(pageList.size()>0){
            delete pageList;
        }
        List<PageBlock__c> blockList = [select id from PageBlock__c limit 1000];
        if(blockList.size()>0){
            delete blockList;
        }
        List<Permission__c> permissionList = [select id from Permission__c limit 1000];
        if(permissionList.size()>0){
            delete permissionList;
        }
        
        cmsProfileExtension.cmsProfile.Name__c = 'Test Profile';
        cmsProfileExtension.cmsProfile.Portal_Enabled__c = true;
        cmsProfileExtension.save1();
        pageList = [select id from Page__c limit 1000];
        for(Integer i=0;i<pageList.size();i++){
            pageList[i].Active__c = false;
        }
        update pageList;
        cmsProfileExtension.save1();
        permissionList = [select id from Permission__c limit 1000];
        if(permissionList.size()>0){
            delete permissionList;
        }
       cmsProfileExtension.save1();
        cmsProfileExtension.cmsProfile.Portal_Enabled__c = false;
        cmsProfileExtension.save1();
        pageList = [select id from Page__c limit 1000];
        if(pageList.size()>0){
            delete pageList;
        }
        blockList = [select id from PageBlock__c limit 1000];
        if(blockList.size()>0){
            delete blockList;
        }
        permissionList = [select id from Permission__c limit 1000];
        if(permissionList.size()>0){
            delete permissionList;
        }
        cmsProfileExtension.cmsProfile.Portal_Enabled__c = true;
        cmsProfileExtension.saveAndNew1();
        pageList = [select id from Page__c limit 1000];
        for(Integer i=0;i<pageList.size();i++){
            pageList[i].Active__c = false;
        }
        update pageList;
        cmsProfileExtension.saveAndNew1();
        permissionList = [select id from Permission__c limit 1000];
        if(permissionList.size()>0){
            delete permissionList;
        }
        cmsProfileExtension.saveAndNew1();
        cmsProfileExtension.cmsProfile.Portal_Enabled__c = false;
        cmsProfileExtension.approvalPage();
        cmsProfileExtension.saveAndNew1();
    }

}