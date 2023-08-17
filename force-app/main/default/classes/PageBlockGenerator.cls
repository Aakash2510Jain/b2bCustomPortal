public without sharing class PageBlockGenerator {
    public Static List<PageBlockObject> cmsBlockBuilderMethod(String cmsPage,String LayoutPlacement,String sessionId)
    {
        String profile = ApexPages.currentPage().getParameters().get('p'); //getting Profile Name
        System.debug('*****ramesh*****profile***'+profile);
        System.debug('****Ramesh Dhull****in public class CMSBlocksBuilder {****in  public Static List<CMSBlockBean> cmsBlockBuilderMethod(String cmsPage,String section,String sessionId){******LayoutPlacement*****'+LayoutPlacement);
        List<PageBlockObject> blockBeanList = new List<PageBlockObject>();
        List<PageBlock__c> blockList = new List<PageBlock__c>();
        //Menu component code
        List<Permission__c> permissionList= new List<Permission__c>(); 
        List<Permission__c> blockPermissionList= new List<Permission__c>(); 
        
        //end Menu component code
        //This Map is used for Session Management functionality.
        Map<String,String> headerMap = System.currentPageReference().getHeaders();
        String userAgent;
        userAgent = headerMap.get('User-Agent');
        System.debug('*****userAgent*** '+userAgent);
        
        if(userAgent!=null && userAgent.length()>255){
        	
            userAgent = userAgent.trim();
            userAgent = userAgent.substring(0,254);
        }
        List<Page__c> page=[Select p.Name__c, p.Id, p.Authentication_Required__c, p.Active__c From Page__c p 
                            where p.Active__c = true and p.Name__c=:cmsPage];
        List<Permission__c> permission = new List<Permission__c>();
        
           
        
        Id loginId = LoginBlock.getLoggedInContact(); // get logged in user based on the session id
        System.debug('!!!!!!!!!!!!!!!!!!!!!!!!!loginId=' + loginId);
        /*Contact con = (loginId != null)
                ? [SELECT SiteProfile__c
                   FROM Contact 
                   WHERE id = :loginId]
                : new Contact();
                */
                  
        SiteProfile__c profileRecord = SiteUtility.getProfile(); // get Profile 
        
        //IF Authentication is required for a page then we have to check permission for this page for the current profile.
        if(page.size()>0 && page[0].Authentication_Required__c==true && LoginBlock.id!=null){
            permission=[Select p.Id From Permission__c p where p.Page__r.Name__c=:page[0].Name__c and  p.SiteProfile__c =:LoginBlock.siteproName];
        }
        //If page name is valid then based on session and profile we are fatching all blocks for the current region of the current page.
        system.debug('!!!!!!!!! '+page.size());
        if(page.size()>0){
            //if(sessionId!=null && sessionId.length()>0){
            if(LoginBlock.id!=null){
                if(page[0].Authentication_Required__c==true && permission.size()>0){
                    blockPermissionList=[Select p.PageBlock__r.Auto_Height_Iframe_Code__c,p.PageBlock__r.Content_text__c, p.PageBlock__r.Flash_Play__c,p.PageBlock__r.Flash_Loop__c,p.PageBlock__r.FlashVars__c,p.PageBlock__r.Existing_Block_Name__c,
                     p.PageBlock__r.Width__c, p.PageBlock__r.DisplayOrder__c, p.PageBlock__r.Type__c, p.PageBlock__r.Layout_Placement__c, p.PageBlock__r.Page__r.Name__c, p.PageBlock__r.Page__c, 
                            p.PageBlock__r.CSSStyle__c, p.PageBlock__r.Name__c, p.PageBlock__r.Module_Name__c, p.PageBlock__r.Id, p.PageBlock__r.IFrame_URL__c, p.PageBlock__r.Height__c, 
                            p.PageBlock__r.Content__c, p.PageBlock__r.Active__c,p.PageBlock__r.Menu_Component_Name__c From Permission__c p 
                            where p.SiteProfile__c = :profileRecord.id and p.PageBlock__r.Active__c=true and (p.PageBlock__r.Page__r.Name__c ='' or p.PageBlock__r.Page__r.Name__c =:cmsPage)
                             and p.PageBlock__r.Layout_Placement__c=:LayoutPlacement order by  p.PageBlock__r.DisplayOrder__c];
                }  
                else if(page[0].Authentication_Required__c==true && permission.size()==0){
                    
                }
                else if(page[0].Authentication_Required__c==false){
                    blockPermissionList=[Select p.PageBlock__r.Auto_Height_Iframe_Code__c,p.PageBlock__r.Content_text__c,p.PageBlock__r.Flash_Play__c,p.PageBlock__r.Flash_Loop__c,p.PageBlock__r.FlashVars__c,
                                        p.PageBlock__r.Existing_Block_Name__c,p.PageBlock__r.Width__c, p.PageBlock__r.DisplayOrder__c, p.PageBlock__r.Type__c,
                                        p.PageBlock__r.Layout_Placement__c, p.PageBlock__r.Page__r.Name__c, p.PageBlock__r.Page__c, 
                            p.PageBlock__r.CSSStyle__c, p.PageBlock__r.Name__c, p.PageBlock__r.Module_Name__c, p.PageBlock__r.Id, p.PageBlock__r.IFrame_URL__c, p.PageBlock__r.Height__c, 
                            p.PageBlock__r.Content__c, p.PageBlock__r.Active__c,p.PageBlock__r.Menu_Component_Name__c From Permission__c p 
                            where p.SiteProfile__c = :profileRecord.id and p.PageBlock__r.Active__c=true and (p.PageBlock__r.Page__r.Name__c ='' or p.PageBlock__r.Page__r.Name__c =:cmsPage)
                             and p.PageBlock__r.Layout_Placement__c=:LayoutPlacement order by  p.PageBlock__r.DisplayOrder__c];
                }
            }
            
            //System.debug('*****Ramesh dhull**toString()*Home****'+pg.getContent().toString());
            //}  
            else{
               blockPermissionList=[Select p.PageBlock__r.Auto_Height_Iframe_Code__c,p.PageBlock__r.Content_text__c,p.PageBlock__r.Flash_Play__c,p.PageBlock__r.Flash_Loop__c,p.PageBlock__r.FlashVars__c,
                                        p.PageBlock__r.Existing_Block_Name__c,p.PageBlock__r.Width__c, p.PageBlock__r.DisplayOrder__c, p.PageBlock__r.Type__c,
                                        p.PageBlock__r.Layout_Placement__c, p.PageBlock__r.Page__r.Name__c, p.PageBlock__r.Page__c, 
                            p.PageBlock__r.CSSStyle__c, p.PageBlock__r.Name__c, p.PageBlock__r.Module_Name__c, p.PageBlock__r.Id, p.PageBlock__r.IFrame_URL__c, p.PageBlock__r.Height__c, 
                            p.PageBlock__r.Content__c, p.PageBlock__r.Active__c,p.PageBlock__r.Menu_Component_Name__c From Permission__c p 
                            where p.SiteProfile__c = :profileRecord.id and p.PageBlock__r.Active__c=true and (p.PageBlock__r.Page__r.Name__c ='' or p.PageBlock__r.Page__r.Name__c = :cmsPage)
                         and p.PageBlock__r.Authentication_Required__c = false and p.PageBlock__r.Layout_Placement__c=:LayoutPlacement order by  p.PageBlock__r.DisplayOrder__c];
           system.debug('profileRecord.id '+profileRecord.id);
           system.debug('cmsPage '+cmsPage);
            }
        }
        List<String> blockIds = new List<String>();
        for(Permission__c blockPermission:blockPermissionList){
            blockIds.add(blockPermission.PageBlock__r.Id);
        }
        blockList = [Select b.Auto_Height_Iframe_Code__c,b.Content_text__c,b.Parent_Window_Parameters__c, b.Flash_Play__c,b.Flash_Loop__c,b.FlashVars__c,b.Existing_Block_Name__c,b.Width__c, b.DisplayOrder__c, b.Type__c, b.Layout_Placement__c, b.Page__r.Name__c, b.Page__c, 
                        b.CSSStyle__c, b.Name__c, b.Module_Name__c, b.Id, b.IFrame_URL__c, b.Height__c, 
                        b.Content__c, b.Active__c, b.Menu_Component_Name__c From PageBlock__c b 
                        where b.id in :blockIds order by b.DisplayOrder__c];
         System.debug('*****Ramesh dhull**blockList***'+blockList.size());
         System.debug('*****Ramesh dhull**blockList***'+blockList);
        
        Integer i = 0;
        //Here in the below code we are proccesing all blocks for the required output for the current region of the current page.
        
        for(PageBlock__c blk:blockList){
            PageBlockObject bean = new PageBlockObject();
            system.debug('@@@@@@@ '+blk.Type__c);
            if(blk.Type__c == System.Label.IFRAME){
                String src;
                if(blk.IFrame_URL__c.contains('?')){
                    src = '&';
                }
                else{
                    src = '?';
                }
                List<String> parametersList = new List<String>();
                List<String> parametersNameList = new List<String>();
                List<String> parametersValueList = new List<String>();
                if(blk.Parent_Window_Parameters__c!=null && blk.Parent_Window_Parameters__c !=''){
                    parametersList=blk.Parent_Window_Parameters__c.split(',');
                    for(String parameter:parametersList){
                        parameter = parameter.trim();
                        List<String> parameterNameValueList = parameter.split('=');
                        if(parameterNameValueList.size()==2){
                            System.debug('*****ramesh***parameterNameValueList.size()==2***');
                            parametersNameList.add(parameterNameValueList[0]);
                            parametersValueList.add(parameterNameValueList[1]);
                        }
                        else if(parameterNameValueList.size()==1){
                            System.debug('*****ramesh***parameterNameValueList.size()==1***');
                            parametersNameList.add(parameterNameValueList[0]);
                            parametersValueList.add('');
                        }
                    }
                    
                    // Changed by Mikhail 11/23/2010 to remove parameter from iFrame 
                    // if value is not presented in parent page
                    String additionalParameters = '';
                    for(Integer x = 0;x<parametersNameList.size();x++)
                    {
                        String name = parametersNameList[x];
                        String value = parametersValueList[x];
                        if(value == '')
                        {
                            System.debug('*****ramesh***parametersValueList[x]11***');
                            String par = ApexPages.currentPage().getParameters().get(name);
                            if (par != null)
                                additionalParameters += '&' + name + '=' + par;
                        }
                        else
                        {
                            System.debug('*****ramesh***parametersValueList[x]22***');
                            additionalParameters += '&' + name + '=' + value;
                        }
                    }
                    if (additionalParameters != '')
                        additionalParameters = additionalParameters.substring(1);
                        
                    src += additionalParameters;                
                }
                System.debug('*****ramesh***src***'+src);
                blk.IFrame_URL__c = '<iframe src=\''+blk.IFrame_URL__c+src+'\''+' width=\''+blk.Width__c+'\' height=\''+blk.Height__c+'\' scrolling=\'auto\' frameborder=\'0\'> </iframe>';
                System.debug('****ramesh****blk.IFrame_URL__c*****'+blk.IFrame_URL__c);
            }
            
            
            if(blk.Type__c == System.Label.Auto_Height_Iframe){
                blk.Auto_Height_Iframe_Code__c = blk.Auto_Height_Iframe_Code__c.replace('&lt;','<');
                blk.Auto_Height_Iframe_Code__c = blk.Auto_Height_Iframe_Code__c.replace('&quot;','"');
                blk.Auto_Height_Iframe_Code__c = blk.Auto_Height_Iframe_Code__c.replace('&gt;','>');
                blk.Auto_Height_Iframe_Code__c = blk.Auto_Height_Iframe_Code__c.replace('&#39;','\'');
                blk.Auto_Height_Iframe_Code__c = blk.Auto_Height_Iframe_Code__c.replace('&amp;','&');
                System.debug('************blk.Auto_Height_Iframe_Code__c******'+blk.Auto_Height_Iframe_Code__c);
                List<String> autoHeightIframeCodeOuterList;
                List<String> autoHeightIframeCodeInnerList;
                if(blk.Auto_Height_Iframe_Code__c!=null && blk.Auto_Height_Iframe_Code__c.length()>0){
                    String autoHeightIframeCode;
                    autoHeightIframeCodeOuterList = blk.Auto_Height_Iframe_Code__c.split('.load',2);
                    System.debug('************autoHeightIframeCodeOuterList******'+autoHeightIframeCodeOuterList);
                    System.debug('************autoHeightIframeCodeOuterList******'+autoHeightIframeCodeOuterList.size());
                    
                    if(autoHeightIframeCodeOuterList!=null && autoHeightIframeCodeOuterList.size()>1){
                        autoHeightIframeCode = autoHeightIframeCodeOuterList[0]+'.load';
                        autoHeightIframeCodeInnerList=autoHeightIframeCodeOuterList[1].split(';',2);
                        if(autoHeightIframeCodeInnerList!=null && autoHeightIframeCodeInnerList.size()>1){
                            System.debug('************autoHeightIframeCodeInnerList[0]******'+autoHeightIframeCodeInnerList[0]);
                            String src;
                            if(autoHeightIframeCodeInnerList[0].contains('?')){
                                src = '&';
                            }
                            else{
                                src = '?';
                            }
                            
                            List<String> parametersList = new List<String>();
                            List<String> parametersNameList = new List<String>();
                            List<String> parametersValueList = new List<String>();
                            if(blk.Parent_Window_Parameters__c!=null && blk.Parent_Window_Parameters__c !=''){
                                parametersList=blk.Parent_Window_Parameters__c.split(',');
                                for(String parameter:parametersList){
                                    parameter = parameter.trim();
                                    List<String> parameterNameValueList = parameter.split('=');
                                    System.debug('************parameterNameValueList******'+parameterNameValueList.size()); 
                                    if(parameterNameValueList.size()==2){
                                        parametersNameList.add(parameterNameValueList[0]);
                                        parametersValueList.add(parameterNameValueList[1]);
                                    }
                                    else if(parameterNameValueList.size()==1){
                                        parametersNameList.add(parameterNameValueList[0]);
                                        parametersValueList.add('');
                                    }
                                }
                                for(Integer x = 0;x<parametersNameList.size();x++){
                                    if(x==0){
                                        src=src+parametersNameList[x];
                                        if(parametersValueList[x]==''){
                                            src = src+'='+ApexPages.currentPage().getParameters().get(parametersNameList[x]);
                                        }
                                        else{
                                            src = src+'='+parametersValueList[x];
                                        }
                                    }
                                    else{
                                        src=src+'&'+parametersNameList[x];
                                        if(parametersValueList[x]==''){
                                            src = src+'='+ApexPages.currentPage().getParameters().get(parametersNameList[x]);
                                        }
                                        else{
                                            src = src+'='+parametersValueList[x];
                                        }
                                    }
                                }
                                System.debug('********8autoHeightIframeCodeOuterList******'+autoHeightIframeCodeOuterList[0]+'***************'+autoHeightIframeCodeOuterList[1]);
                                System.debug('');
                                System.debug('');
                            }
                            autoHeightIframeCodeInnerList[0]=autoHeightIframeCodeInnerList[0].replace('")','');
                            System.debug('************autoHeightIframeCodeInnerList[0]******'+autoHeightIframeCodeInnerList[0]+src);
                            if(src!=null && src.length()>1){
                                autoHeightIframeCodeInnerList[0]=autoHeightIframeCodeInnerList[0]+src;
                            }
                            autoHeightIframeCodeInnerList[0]=autoHeightIframeCodeInnerList[0]+'")';
                            System.debug('************autoHeightIframeCodeInnerList[0]******'+autoHeightIframeCodeInnerList[0]);
                            autoHeightIframeCode=autoHeightIframeCode+autoHeightIframeCodeInnerList[0]+';'+autoHeightIframeCodeInnerList[1];
                            blk.Auto_Height_Iframe_Code__c=autoHeightIframeCode;
                            System.debug('************blk.Auto_Height_Iframe_Code__c******'+blk.Auto_Height_Iframe_Code__c);
                        }
                    }
                
                }
                
                System.debug('******Ramesh Text******blk.Content_text__c******'+blk.Content_text__c);
                bean.block = blk;
            }
            
            //Below code is used if block type is Menu Component.
            if(blk.Type__c=='Menu Component'){
                //CMSMenuComponentBean menuComponent = new CMSMenuComponentBean();
                List<Menu_Component__c> menuComponentList = [Select m.Override_Class__c, m.Name__c, m.Id, m.Display_Type__c, m.Component_Menus__c, m.Active__c 
                                                            From Menu_Component__c m where m.Name__c = :blk.Menu_Component_Name__c];
                if(menuComponentList.size()>0 && menuComponentList[0].Component_Menus__c!=null && menuComponentList[0].Component_Menus__c.length()>0){
                    List<String> menusName = menuComponentList[0].Component_Menus__c.split(',');
                   // List<String> menusName  = new List<String>();
                   // menusName.add('Home');
                    //menusName.add('Menu1');
                    //menusName.add('Menu2');
                   // menusName.add('Menu21');
                    if(profileRecord != null){
                        System.debug('****ramesh**if(cmsProfileList.size()>0)***' +menusName+'-------------------'+profileRecord.Id);
                        permissionList=[Select p.Menu__r.Page__c, p.Menu__r.Active__c,p.Menu__r.Order__c, p.Menu__r.Link__c,
                         p.Menu__r.Parent_Menu__c, p.Menu__r.Name__c,p.Menu__r.Parameters__c,p.Menu__c, p.Id, p.SiteProfile__c    
                          From Permission__c p
                        where p.Menu__r.Active__c = true and p.Menu__r.Name__c in :menusName and p.SiteProfile__c = :profileRecord.id order by p.Menu__r.Order__c];
                    
                    }
                    else{
                        ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, System.Label.May_be_CMSDefaultProfile);
                        ApexPages.addMessage(msg);
                    }
                    Set<Id> menuIdsSet;
                    system.debug('permissionList.size() '+permissionList.size());
                    if(permissionList.size()>0){
                        System.debug('****ramesh**if(permissionList.size()>0)***');
                        menuIdsSet = new Set<Id>();
                        for(Permission__c pemission:permissionList){
                            menuIdsSet.add(pemission.Menu__c);
                        }
                        List<Menu__c> menuList = new List<Menu__c>();
                        if(LoginBlock.id!=null){
                            menuList=[Select m.Name,m.Parent_Menu__c, m.Parameters__c, m.Page__r.Name__c, 
                                    m.Page__c, m.Order__c, 
                                     m.Name__c, m.Link__c, m.Id, m.Active__c
                                     From Menu__c m where m.id in :menuIdsSet order by m.Order__c]; 
                        
                        }
                        else{
                            menuList=[Select m.Name,m.Parent_Menu__c, m.Parameters__c, m.Page__r.Name__c, m.Page__c, 
                                     m.Order__c,m.Name__c, m.Link__c, m.Id, m.Active__c
                                     From Menu__c m where m.Parent_Menu__c='' and m.id in :menuIdsSet and m.Visiblity_Authentication__c = false order by m.Order__c];
                        } //added m.Parent_Menu__c='' for the above code (SCS CMS)
                        for(Menu__c parentMenu:menuList){
                            
                            permissionList=[Select p.Menu__c, p.Id, p.SiteProfile__c
                            From Permission__c p
                            where p.Menu__r.Active__c = true and p.Menu__r.Parent_Menu__c = :parentMenu.Id 
                            and p.SiteProfile__c = :profileRecord.id order by p.Menu__r.Order__c];
                            menuIdsSet.clear();
                            for(Permission__c pemission:permissionList){
                                menuIdsSet.add(pemission.Menu__c);
                            }
                            List<Menu__c> childMenuList = new List<Menu__c>();
                            if(LoginBlock.id!=null){
                                childMenuList=[Select m.Name,m.Parent_Menu__c, m.Parameters__c, m.Page__r.Name__c,
                                                m.Page__c, m.Order__c, 
                                                m.Name__c, m.Link__c, m.Id, m.Active__c
                                                From Menu__c m where m.id in :menuIdsSet  
                                                and m.Active__c = true order by m.Order__c];
                            }
                            else{
                                childMenuList=[Select m.Name,m.Parent_Menu__c, m.Parameters__c, m.Page__r.Name__c, 
                                                m.Page__c, m.Order__c, 
                                                m.Name__c, m.Link__c, m.Id, m.Active__c
                                                From Menu__c m where m.id in :menuIdsSet  
                                                and m.Active__c = true and m.Visiblity_Authentication__c = false order by m.Order__c];
                            }
                            bean.cmsMenuBeanList.add(PageBlockObject.setCMSMenuBean(blk,parentMenu,childMenuList));
                            System.debug('*****ramesh***bean.cmsMenuBeanList******'+bean.cmsMenuBeanList);
                        }
                    }
                    bean.ulID = blk.Layout_Placement__c+blk.DisplayOrder__c;
                    bean.menuDisplayType = menuComponentList[0].Display_Type__c;
                    bean.menuOverrideClass= menuComponentList[0].Override_Class__c; 
                }
            }
            if(blk.Type__c == System.Label.MODULE){
                bean.includePageName = blk.Module_Name__c;
            }
            if(blk.Type__c=='Text'){
                if(blk.Content_text__c!=null){
                    blk.Content_text__c = blk.Content_text__c.replace('&lt;','<');
                    blk.Content_text__c = blk.Content_text__c.replace('&quot;','"');
                    blk.Content_text__c = blk.Content_text__c.replace('&gt;','>');
                    blk.Content_text__c = blk.Content_text__c.replace('&#39;','\'');
                    blk.Content_text__c = blk.Content_text__c.replace('&amp;','&');
                    
                    System.debug('******Ramesh Text******blk.Content_text__c******'+blk.Content_text__c);
                }
                bean.block = blk;
                //blk.Content_text__c = 'Ramesh Dhull';
            }
            
            //Below code is for if block type is existing block.
            if(blk.Type__c=='Existing Block'){
                List<PageBlock__c> existBlkList = new List<PageBlock__c>();
                existBlkList.add(blk);
                //Sobject sobj = LoginBlock.currentContact;
                system.debug('profileRecord '+profileRecord.Id);
                system.debug('existBlkList '+existBlkList);
                List<PageBlock__c> existingBlockList = getExistingBlock(profileRecord,LoginBlock.currentContact,existBlkList);
                
                System.debug('******ramesh***public static List<PageBlock__c> getExistingBlock(********'+existingBlockList);
                if (existingBlockList.size()>0){  
                    /*if(existingBlockList[0].Type__c==System.Label.IFRAME){
                    //existingBlockList[0].IFrame_URL__c = '<iframe src='+existingBlockList[0].IFrame_URL__c +' width='+existingBlockList[0].Width__c+' height='+existingBlockList[0].Height__c+'  />';
                    blk.IFrame_URL__c = '<iframe src=\''+blk.IFrame_URL__c +'?page='+ApexPages.currentPage().getParameters().get('page')+'&sessionId='+ApexPages.currentPage().getParameters().get('sessionId')+'\''+' width=\''+blk.Width__c+'\' height=\''+blk.Height__c+'\' scrolling=\'no\' frameborder=\'0\'> </iframe>';
                    }*/
                    if(existingBlockList[0].Type__c==System.Label.IFRAME){
                        String src;
                        if(existingBlockList[0].IFrame_URL__c.contains('?')){
                            src = '&';
                        }
                        else{
                            src = '?';
                        }
                        List<String> parametersList = new List<String>();
                        List<String> parametersNameList = new List<String>();
                        List<String> parametersValueList = new List<String>();
                        if(existingBlockList[0].Parent_Window_Parameters__c!=null && existingBlockList[0].Parent_Window_Parameters__c !=''){
                            parametersList=existingBlockList[0].Parent_Window_Parameters__c.split(',');
                            for(String parameter:parametersList){
                                parameter = parameter.trim();
                                List<String> parameterNameValueList = parameter.split('=');
                                if(parameterNameValueList.size()==2){
                                    parametersNameList.add(parameterNameValueList[0]);
                                    parametersValueList.add(parameterNameValueList[1]);
                                }
                                else if(parameterNameValueList.size()==1){
                                    parametersNameList.add(parameterNameValueList[0]);
                                    parametersValueList.add('');
                                }
                            }
                            for(Integer x = 0;x<parametersNameList.size();x++){
                                if(x==0){
                                    src=src+parametersNameList[x];
                                    if(parametersValueList[x]==''){
                                        src = src+'='+ApexPages.currentPage().getParameters().get(parametersNameList[x]);
                                    }
                                    else{
                                        src = src+'='+parametersValueList[x];
                                    }
                                }
                                else{
                                    src=src+'&'+parametersNameList[x];
                                    if(parametersValueList[x]==''){
                                        src = src+'='+ApexPages.currentPage().getParameters().get(parametersNameList[x]);
                                    }
                                    else{
                                        src = src+'='+parametersValueList[x];
                                    }
                                }
                            }
                        }
                        System.debug('*****ramesh***src***'+src);
                        //blk.IFrame_URL__c = '<iframe src=\''+existingBlockList[0].IFrame_URL__c+src+'\''+' width=\''+existingBlockList[0].Width__c+'\' height=\''+existingBlockList[0].Height__c+'\' scrolling=\'no\' frameborder=\'0\'> </iframe>';
                        blk.IFrame_URL__c = '<iframe src=\''+existingBlockList[0].IFrame_URL__c+src+'\''+' width=\''+existingBlockList[0].Width__c+'\' height=\''+existingBlockList[0].Height__c+'\' scrolling=\'auto\' frameborder=\'0\'> </iframe>';  
                        /*if(blk.Height__c!=null){
                            blk.IFrame_URL__c = '<iframe src=\''+existingBlockList[0].IFrame_URL__c+src+'\''+' width=\''+existingBlockList[0].Width__c+'\' height=\''+existingBlockList[0].Height__c+'\' scrolling=\'auto\' frameborder=\'0\'> </iframe>';
                        }
                        else{
                             blk.IFrame_URL__c = '<iframe src=\''+existingBlockList[0].IFrame_URL__c+src+'\''+' width=\''+existingBlockList[0].Width__c+'\' scrolling=\'no\' frameborder=\'0\' marginwidth=\'0\' marginheight=\'0\' vspace=\'0\' hspace=\'0\' > </iframe>';
                        }
                        */
                        System.debug('****ramesh****blk.IFrame_URL__c*****'+blk.IFrame_URL__c);
                    }
                    if(existingBlockList[0].Type__c == System.Label.Text){
                        if(existingBlockList[0].Content_text__c!=null){
                            existingBlockList[0].Content_text__c = existingBlockList[0].Content_text__c.replace('&lt;','<');
                            existingBlockList[0].Content_text__c = existingBlockList[0].Content_text__c.replace('&quot;','"');
                            existingBlockList[0].Content_text__c = existingBlockList[0].Content_text__c.replace('&gt;','>');
                            existingBlockList[0].Content_text__c = existingBlockList[0].Content_text__c.replace('&#39;','\'');
                            existingBlockList[0].Content_text__c = existingBlockList[0].Content_text__c.replace('&amp;','&');
                        }
                    }
                    
                    if(existingBlockList[0].Type__c == System.Label.Auto_Height_Iframe){
                        existingBlockList[0].Auto_Height_Iframe_Code__c = existingBlockList[0].Auto_Height_Iframe_Code__c.replace('&lt;','<');
                        existingBlockList[0].Auto_Height_Iframe_Code__c = existingBlockList[0].Auto_Height_Iframe_Code__c.replace('&quot;','"');
                        existingBlockList[0].Auto_Height_Iframe_Code__c = existingBlockList[0].Auto_Height_Iframe_Code__c.replace('&gt;','>');
                        existingBlockList[0].Auto_Height_Iframe_Code__c = existingBlockList[0].Auto_Height_Iframe_Code__c.replace('&#39;','\'');
                        existingBlockList[0].Auto_Height_Iframe_Code__c = existingBlockList[0].Auto_Height_Iframe_Code__c.replace('&amp;','&');
                        System.debug('************existingBlockList[0].Auto_Height_Iframe_Code__c******'+existingBlockList[0].Auto_Height_Iframe_Code__c);
                        List<String> autoHeightIframeCodeOuterList;
                        List<String> autoHeightIframeCodeInnerList;
                        if(existingBlockList[0].Auto_Height_Iframe_Code__c!=null && existingBlockList[0].Auto_Height_Iframe_Code__c.length()>0){
                            String autoHeightIframeCode;
                            autoHeightIframeCodeOuterList = existingBlockList[0].Auto_Height_Iframe_Code__c.split('.load',2);
                            System.debug('************autoHeightIframeCodeOuterList******'+autoHeightIframeCodeOuterList);
                            if(autoHeightIframeCodeOuterList!=null && autoHeightIframeCodeOuterList.size()>1){
                                autoHeightIframeCode = autoHeightIframeCodeOuterList[0]+'.load';
                                autoHeightIframeCodeInnerList=autoHeightIframeCodeOuterList[1].split(';',2);
                                if(autoHeightIframeCodeInnerList!=null && autoHeightIframeCodeInnerList.size()>1){
                                    System.debug('************autoHeightIframeCodeInnerList[0]******'+autoHeightIframeCodeInnerList[0]);
                                    String src;
                                    if(autoHeightIframeCodeInnerList[0].contains('?')){
                                        src = '&';
                                    }
                                    else{
                                        src = '?';
                                    }
                                    
                                    List<String> parametersList = new List<String>();
                                    List<String> parametersNameList = new List<String>();
                                    List<String> parametersValueList = new List<String>();
                                    if(existingBlockList[0].Parent_Window_Parameters__c!=null && existingBlockList[0].Parent_Window_Parameters__c !=''){
                                        parametersList=existingBlockList[0].Parent_Window_Parameters__c.split(',');
                                        for(String parameter:parametersList){
                                            parameter = parameter.trim();
                                            List<String> parameterNameValueList = parameter.split('=');
                                            if(parameterNameValueList.size()==2){
                                                parametersNameList.add(parameterNameValueList[0]);
                                                parametersValueList.add(parameterNameValueList[1]);
                                            }
                                            else if(parameterNameValueList.size()==1){
                                                parametersNameList.add(parameterNameValueList[0]);
                                                parametersValueList.add('');
                                            }
                                        }
                                        for(Integer x = 0;x<parametersNameList.size();x++){
                                            if(x==0){
                                                src=src+parametersNameList[x];
                                                if(parametersValueList[x]==''){
                                                    src = src+'='+ApexPages.currentPage().getParameters().get(parametersNameList[x]);
                                                }
                                                else{
                                                    src = src+'='+parametersValueList[x];
                                                }
                                            }
                                            else{
                                                src=src+'&'+parametersNameList[x];
                                                if(parametersValueList[x]==''){
                                                    src = src+'='+ApexPages.currentPage().getParameters().get(parametersNameList[x]);
                                                }
                                                else{
                                                    src = src+'='+parametersValueList[x];
                                                }
                                            }
                                        }
                                        System.debug('********8autoHeightIframeCodeOuterList******'+autoHeightIframeCodeOuterList[0]+'***************'+autoHeightIframeCodeOuterList[1]);
                                        System.debug('');
                                        System.debug('');
                                    }
                                    autoHeightIframeCodeInnerList[0]=autoHeightIframeCodeInnerList[0].replace('")','');
                                    System.debug('************autoHeightIframeCodeInnerList[0]******'+autoHeightIframeCodeInnerList[0]+src);
                                    if(src!=null && src.length()>1){
                                        autoHeightIframeCodeInnerList[0]=autoHeightIframeCodeInnerList[0]+src;
                                    }
                                    autoHeightIframeCodeInnerList[0]=autoHeightIframeCodeInnerList[0]+'")';
                                    System.debug('************autoHeightIframeCodeInnerList[0]******'+autoHeightIframeCodeInnerList[0]);
                                    autoHeightIframeCode=autoHeightIframeCode+autoHeightIframeCodeInnerList[0]+';'+autoHeightIframeCodeInnerList[1];
                                    existingBlockList[0].Auto_Height_Iframe_Code__c=autoHeightIframeCode;
                                    System.debug('************existingBlockList[0].Auto_Height_Iframe_Code__c******'+existingBlockList[0].Auto_Height_Iframe_Code__c);
                                }
                            }
                        
                        }
                        
                        
                    }
                    
                    
                    
                    
                    if(existingBlockList[0].Type__c == System.Label.Menu_Component){
                        List<Menu_Component__c> menuComponentList = [Select m.Override_Class__c, m.Name__c, m.Id, m.Display_Type__c, m.Component_Menus__c, m.Active__c 
                                                                    From Menu_Component__c m where m.Name__c = :existingBlockList[0].Menu_Component_Name__c];
                        if(menuComponentList.size()>0 && menuComponentList[0].Component_Menus__c!=null && menuComponentList[0].Component_Menus__c.length()>0){
                            List<String> menusName = menuComponentList[0].Component_Menus__c.split(',');
                            
                            if(profileRecord != null){
                                System.debug('****ramesh**if(cmsProfileList.size()>0)***');
                                permissionList=[Select p.Menu__r.Page__c, p.Menu__r.Active__c, p.Menu__r.Order__c, p.Menu__r.Link__c,
                                 p.Menu__r.Parent_Menu__c, p.Menu__r.Name__c,p.Menu__r.Parameters__c,p.Menu__c, p.Id, p.SiteProfile__c 
                                  From Permission__c p
                                where p.Menu__r.Active__c = true and p.Menu__r.Name__c in :menusName and p.SiteProfile__c = :profileRecord.id order by p.Menu__r.Order__c];
                            
                            }
                            else{
                                ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, System.Label.May_be_CMSDefaultProfile);
                                ApexPages.addMessage(msg);
                            }
                            Set<Id> menuIdsSet;
                            if(permissionList.size()>0){
                                System.debug('****ramesh**if(permissionList.size()>0)***');
                                menuIdsSet = new Set<Id>();
                                for(Permission__c pemission:permissionList){
                                    menuIdsSet.add(pemission.Menu__c);
                                }
                                List<Menu__c> menuList = new List<Menu__c>();
                                if(LoginBlock.id!=null){
                                    menuList=[Select m.Name, m.Parent_Menu__c, m.Parameters__c, m.Page__r.Name__c, m.Page__c, m.Order__c, 
                                                            m.Name__c, m.Link__c, m.Id, m.Active__c
                                                         From Menu__c m where m.id in :menuIdsSet order by m.Order__c]; 
                                }
                                else{
                                    menuList=[Select m.Name, m.Parent_Menu__c, m.Parameters__c, m.Page__r.Name__c, m.Page__c, m.Order__c, 
                                                            m.Name__c, m.Link__c, m.Id, m.Active__c
                                                         From Menu__c m where m.id in :menuIdsSet 
                                                         and m.Visiblity_Authentication__c = false order by m.Order__c]; 
                                }
                                for(Menu__c parentMenu:menuList){
                                    
                                    permissionList=[Select p.Menu__c, p.Id, p.SiteProfile__c 
                                    From Permission__c p
                                    where p.Menu__r.Active__c = true and p.Menu__r.Parent_Menu__c = :parentMenu.Id 
                                    and p.SiteProfile__c = :profileRecord.id order by p.Menu__r.Order__c];
                                    menuIdsSet.clear();
                                    for(Permission__c pemission:permissionList){
                                        menuIdsSet.add(pemission.Menu__c);
                                    }
                                    List<Menu__c> childMenuList = new List<Menu__c>();
                                    if(LoginBlock.id!=null){
                                        childMenuList=[Select m.Name,m.Parent_Menu__c, m.Parameters__c, m.Page__r.Name__c,
                                                         m.Page__c, m.Order__c, 
                                                         m.Name__c, m.Link__c, m.Id, m.Active__c
                                                         From Menu__c m where m.id in :menuIdsSet  and m.Active__c = true order by m.Order__c];
                                    }
                                    else{
                                        childMenuList=[Select m.Name,m.Parent_Menu__c, m.Parameters__c, m.Page__r.Name__c,
                                                        m.Page__c, m.Order__c, 
                                                        m.Name__c, m.Link__c, m.Id, m.Active__c
                                                        From Menu__c m where m.id in :menuIdsSet  and m.Active__c = true 
                                                        and m.Visiblity_Authentication__c = false order by m.Order__c];
                                    }
                                    bean.cmsMenuBeanList.add(PageBlockObject.setCMSMenuBean(blk,parentMenu,childMenuList));
                                    System.debug('*****ramesh***bean.cmsMenuBeanList******'+bean.cmsMenuBeanList);
                                }
                                
                            }
                            bean.ulID = blk.Layout_Placement__c+blk.DisplayOrder__c;
                            bean.menuDisplayType = menuComponentList[0].Display_Type__c;
                            bean.menuOverrideClass= menuComponentList[0].Override_Class__c; 
                        }
                    }
                    if(existingBlockList[0].Type__c == System.Label.MODULE){
                        bean.includePageName = existingBlockList[0].Module_Name__c;
                    }
                    if(existingBlockList[0].Type__c == System.Label.Flash){
                        blk.IFrame_URL__c = existingBlockList[0].IFrame_URL__c;
                    }
                    blk.Type__c = existingBlockList[0].Type__c;
                    blk.Flash_Play__c = existingBlockList[0].Flash_Play__c;
                    blk.Flash_Loop__c = existingBlockList[0].Flash_Loop__c;
                    blk.FlashVars__c = existingBlockList[0].FlashVars__c;
                    blk.CSSStyle__c = existingBlockList[0].CSSStyle__c;
                    blk.Module_Name__c = existingBlockList[0].Module_Name__c;
                    blk.Width__c = existingBlockList[0].Width__c;
                    blk.Height__c = existingBlockList[0].Height__c;
                    blk.Content__c = existingBlockList[0].Content__c;
                    blk.Auto_Height_Iframe_Code__c=existingBlockList[0].Auto_Height_Iframe_Code__c;
                    blk.Content_text__c=existingBlockList[0].Content_text__c;
                    bean.block = blk;
                }
                else{
                    bean.block = blk;
                }
            }
            else{
                bean.block = blk;
            }
            bean.blockNumber = i;
            i++;
            blockBeanList.add(bean);
            System.debug('******Ramesh Text******blk.Content_text__c******'+bean);
        }
        return blockBeanList;
    }
    //This static method will return the block information for block which block type is existing block in any number of deep node.
    public static List<PageBlock__c> getExistingBlock(SiteProfile__c profileRecord,SObject con ,List<PageBlock__c> existingBlockList){
    	System.debug('PROFILE RECORD :'+profileRecord+'---------'+con+'-----------'+existingBlockList);
    	List<PageBlock__c> existingBlockList1;
        List<Permission__c> blockPermissionList = [Select id,p.PageBlock__r.id From Permission__c p 
                            where p.SiteProfile__c = :profileRecord.id and p.PageBlock__r.Name__c = :existingBlockList[0].Existing_Block_Name__c];
        String blockId;  
        if(blockPermissionList.size()>0){
            blockId = blockPermissionList[0].PageBlock__r.id;
        }
        system.debug('con '+con);
        system.debug('existingBlockList '+existingBlockList);
        system.debug('existingBlockList[0].Existing_Block_Name__c '+existingBlockList[0].Existing_Block_Name__c);
        System.debug('profilrRecord  '+profileRecord.id);
        System.debug('blockPermissionList '+blockPermissionList);
        System.debug('******ramesh***public static List<PageBlock__c> getExistingBlock(********'+existingBlockList[0].id+'****blockId*****'+blockId);
        //if(con.get('Id')!=null){
        if(con != NULL && con.id !=NULL){
            existingBlockList1 = [Select b.Auto_Height_Iframe_Code__c,b.Content_text__c,b.Parent_Window_Parameters__c, b.Flash_Play__c,b.Flash_Loop__c,b.FlashVars__c,b.Existing_Block_Name__c,b.Width__c, b.DisplayOrder__c, b.Type__c, b.Layout_Placement__c, b.Page__r.Name__c, b.Page__c, 
                        b.CSSStyle__c, b.Name__c, b.Module_Name__c, b.Id, b.IFrame_URL__c, b.Height__c, 
                        b.Content__c, b.Active__c, b.Menu_Component_Name__c From PageBlock__c b 
                        where b.id = :blockId and b.Active__c=true and  b.Name__c =:existingBlockList[0].Existing_Block_Name__c limit 1];
        }
        else{
            existingBlockList1 = [Select b.Auto_Height_Iframe_Code__c,b.Content_text__c,b.Parent_Window_Parameters__c, b.Flash_Play__c,b.Flash_Loop__c,b.FlashVars__c,b.Existing_Block_Name__c,b.Width__c, b.DisplayOrder__c, b.Type__c, b.Layout_Placement__c, b.Page__r.Name__c, b.Page__c, 
                        b.CSSStyle__c, b.Name__c, b.Module_Name__c, b.Id, b.IFrame_URL__c, b.Height__c, 
                        b.Content__c, b.Active__c, b.Menu_Component_Name__c From PageBlock__c b 
                        where b.id = :blockId and b.Active__c=true and b.Name__c =:existingBlockList[0].Existing_Block_Name__c and b.Authentication_Required__c = false limit 1];
        }
        if(existingBlockList1.size()>0 && existingBlockList1[0].Type__c == System.Label.Existing_Block){
            existingBlockList1 = getExistingBlock(profileRecord,con,existingBlockList1);
        }
        System.debug('******ramesh***public static List<PageBlock__c> getExistingBlock(********'+existingBlockList1);
        return existingBlockList1;
    
}
	public static testmethod void TestPageblock()
	{
		//list<PageBlock__c> hy = [select id,name from PageBlock__c];
		
		List<PageBlock__c> pbl=new List<PageBlock__c>();
		//pbl=[select name,DisplayOrder__c,Name__c from PageBlock__c limit 1];
		
		Account account = new Account();
        account.Name = 'Candidate Pool2';
        insert account;
		
		Page__c page = new Page__c();
        page.Name = 'OnlineJobSearch';
        page.Name__c = 'OnlineJobSearch';
        page.Active__c = true;
        insert page;
		
		SiteProfile__c cmsProfile = new SiteProfile__c();
        cmsProfile.Name__c = 'CMSDefaultProfile';
        cmsProfile.Profile_Account__c = account.id;
        cmsProfile.CMSCss__c = 'CustomStyleSheet';
        cmsProfile.User_Registration__c = true;
		cmsProfile.Default_Home_Page__c = page.Id;
        insert cmsProfile;
        system.debug('cmsProfile '+cmsProfile.Id);
				
		Contact contact = new Contact();
        contact.FirstName = 'suresh';
        contact.LastName = 'R';
        contact.UserName__c = 'suresh@gmail.com';
        contact.Email = 'suresh@gmail.com';
        contact.Password__c = 'avankia1';
        contact.SiteProfile__c = cmsProfile.id;
        insert contact;
		
		Map<String,String> headerMap = System.currentPageReference().getHeaders();
		String sessionString;
		Session__c session = new Session__c();
        session.Session_For__c = contact.Id;
        session.User_Agent__c=headerMap.get('User-Agent');
        session.IP_Address__c=headerMap.get('X-Salesforce-SIP');
        session.SessionId__c = sessionString;
        insert session;
	
		
		PageBlock__c block = new PageBlock__c();
		block.Name__c='PageBlock';
		block.Name='PageBlock';
		block.Type__c='Text';
		block.DisplayOrder__c=0;
		block.Layout_Placement__c ='header';
		block.Page__c = page.Id;
		block.Content_Text__c ='hgbhd<sdsd>hh&sd/,uhui";js68sb';
		insert block;
		pbl.add(block);
		
		Permission__c per1 = new Permission__c();
		per1.PageBlock__c = block.Id;
		per1.Page__c = page.Id;
		per1.SiteProfile__c = cmsProfile.Id;
		insert per1;
		
		
		PageBlock__c blockiframe = new PageBlock__c();
		blockiframe.Name__c='PageBlockiframe';
		blockiframe.Name='PageBlockiframe';
		blockiframe.Type__c='IFRAME';
		blockiframe.DisplayOrder__c=1;
		blockiframe.Layout_Placement__c ='header';
		blockiframe.Page__c = page.Id;
		blockiframe.IFrame_URL__c = 'www.google.com';
		blockiframe.parent_Window_Parameters__c ='2343,4343434!@#$%^&*()?dfdf;dfd';
		insert blockiframe;
		pbl.add(blockiframe);
		
		Permission__c per2 = new Permission__c();
		per2.PageBlock__c = blockiframe.Id;
		per2.Page__c = page.Id;
		per2.SiteProfile__c = cmsProfile.Id;
		insert per2;
		
		PageBlock__c blockautoiframe = new PageBlock__c();
		blockautoiframe.Name__c='PageBlockautoiframe';
		blockautoiframe.Name='PageBlockautoiframe';
		blockautoiframe.Type__c='Auto Height Iframe';
		blockautoiframe.DisplayOrder__c=2;
		blockautoiframe.Layout_Placement__c ='header';
		blockautoiframe.Page__c = page.Id;
		blockautoiframe.IFrame_URL__c = 'www.google.com';
		blockautoiframe.Auto_Height_Iframe_Code__c = 'hididhfidhifhdi3434k34i<<<< .load 2>>>>>098,?9868;76545^%&&&)^(*&^&*)^&*';
		blockautoiframe.parent_Window_Parameters__c ='2343,4343434!@#$%^&*()?dfdf;dfd';
		insert blockautoiframe;
		pbl.add(blockautoiframe);
		
		Permission__c per3 = new Permission__c();
		per3.PageBlock__c = blockautoiframe.Id;
		per3.Page__c = page.Id;
		per3.SiteProfile__c = cmsProfile.Id;
		insert per3;
		
		Menu__c menu = new Menu__c();
        menu.Name__c = 'menu';
        menu.Active__c = true;
        menu.Order__c = 1;
        insert menu;
        
        
        Menu__c menu1 = new Menu__c();
        menu1.Name__c = 'menu1';
        menu1.Active__c = true;
        menu1.Order__c = 2;
        insert menu1;
		
		Menu_Component__c menucom = new Menu_Component__c();
		menucom.Name ='menucom';
		menucom.Name__c ='menucom';
		menucom.Active__c =true;
		menucom.Display_Type__c = 'horizontal';
		menucom.Component_Menus__c = 'menu,menu1';
		insert menucom;
		
		PageBlock__c blockmenucomp = new PageBlock__c();
		blockmenucomp.Name__c='Pageblockmenucomp';
		blockmenucomp.Name='Pageblockmenucomp';
		blockmenucomp.Type__c='Menu Component';
		blockmenucomp.DisplayOrder__c=3;
		blockmenucomp.Layout_Placement__c ='header';
		blockmenucomp.Page__c = page.Id;
		blockmenucomp.IFrame_URL__c = 'www.google.com';
		blockmenucomp.Menu_Component_Name__c ='menucom';
		insert blockmenucomp;
		pbl.add(blockmenucomp);
		
		Permission__c per4 = new Permission__c();
		per4.PageBlock__c = blockmenucomp.Id;
		per4.Page__c = page.Id;
		per4.SiteProfile__c = cmsProfile.Id;
		insert per4;
		
		
        Permission__c permenu = new Permission__c();
		permenu.PageBlock__c = blockmenucomp.Id;
		permenu.Page__c = page.Id;
		permenu.SiteProfile__c = cmsProfile.Id;
		permenu.Menu__c = menu.Id;
		insert permenu;
		
		Permission__c permenu1 = new Permission__c();
		permenu1.PageBlock__c = blockmenucomp.Id;
		permenu1.Page__c = page.Id;
		permenu1.SiteProfile__c = cmsProfile.Id;
		permenu1.Menu__c = menu1.Id;
		insert permenu1;
		
		
		PageBlock__c blockexeblock = new PageBlock__c();
		blockexeblock.Name__c='Pageblockexeblock';
		blockexeblock.Name='Pageblockexeblock';
		blockexeblock.Type__c='Existing Block';
		blockexeblock.DisplayOrder__c=4;
		blockexeblock.Layout_Placement__c ='header';
		blockexeblock.Page__c = page.Id;
		blockexeblock.IFrame_URL__c = 'www.google.com';
		blockexeblock.Existing_Block_Name__c = 'PageBlock';
		insert blockexeblock;
		pbl.add(blockexeblock);
		
		Permission__c per5 = new Permission__c();
		per5.PageBlock__c = blockexeblock.Id;
		per5.Page__c = page.Id;
		per5.SiteProfile__c = cmsProfile.Id;
		insert per5;
		
		PageBlock__c blockexeblock2 = new PageBlock__c();
		blockexeblock2.Name__c='Pageblockexeblock2';
		blockexeblock2.Name='Pageblockexeblock2';
		blockexeblock2.Type__c='Existing Block';
		blockexeblock2.DisplayOrder__c=5;
		blockexeblock2.Layout_Placement__c ='header';
		blockexeblock2.Page__c = page.Id;
		blockexeblock2.IFrame_URL__c = 'www.google.com';
		blockexeblock2.Existing_Block_Name__c = 'PageBlockiframe';
		insert blockexeblock2;
		pbl.add(blockexeblock2);	
		
		Permission__c per6 = new Permission__c();
		per6.PageBlock__c = blockexeblock2.Id;
		per6.Page__c = page.Id;
		per6.SiteProfile__c = cmsProfile.Id;
		insert per6;
		
		PageBlock__c blockexeblock3 = new PageBlock__c();
		blockexeblock3.Name__c='Pageblockexeblock3';
		blockexeblock3.Name='Pageblockexeblock3';
		blockexeblock3.Type__c='Existing Block';
		blockexeblock3.DisplayOrder__c=6;
		blockexeblock3.Layout_Placement__c ='header';
		blockexeblock3.Page__c = page.Id;
		blockexeblock3.IFrame_URL__c = 'www.google.com';
		blockexeblock3.Existing_Block_Name__c = 'PageBlockautoiframe';
		insert blockexeblock3;
		pbl.add(blockexeblock3);	
		
		Permission__c per7 = new Permission__c();
		per7.PageBlock__c = blockexeblock3.Id;
		per7.Page__c = page.Id;
		per7.SiteProfile__c = cmsProfile.Id;
		insert per7;
		
		
		PageBlock__c blockexeblock4 = new PageBlock__c();
		blockexeblock4.Name__c='Pageblockexeblock4';
		blockexeblock4.Name='Pageblockexeblock4';
		blockexeblock4.Type__c='Existing Block';
		blockexeblock4.DisplayOrder__c=7;
		blockexeblock4.Layout_Placement__c ='header';
		blockexeblock4.Page__c = page.Id;
		blockexeblock4.IFrame_URL__c = 'www.google.com';
		blockexeblock4.Existing_Block_Name__c = 'Pageblockmenucomp';
		insert blockexeblock4;
		pbl.add(blockexeblock4);	
		
		Permission__c per8 = new Permission__c();
		per8.PageBlock__c = blockexeblock4.Id;
		per8.Page__c = page.Id;
		per8.SiteProfile__c = cmsProfile.Id;
		insert per8;
		
		cmsBlockBuilderMethod(page.Name__c,'header',contact.id);
		//SiteProfile__c profileRecord,Contact contact,List<PageBlock__c> existingBlockList
		//SiteProfile__c profileRecord =[select id,name from SiteProfile__c];
		//Contact con =[select id,name from Contact];
	    //List<PageBlock__c> existingBlockList=[select id,name from PageBlock__c];
		
		getExistingBlock(cmsProfile,contact, pbl);
		PageBlockGenerator gt= new PageBlockGenerator();
	}
}