public class MenuComponent_controller {

    List<String> availableMenus = new List<String>();
    List<String> selectedMenus = new List<String>();
    List<Menu__c> availableMenusList = new List<Menu__c>();
    List<Menu__c> selectedMenusList = new List<Menu__c>();
    Boolean count = false;
    
    Menu_Component__c menuComponent = getMComponent();
    public Menu_Component__c getMenuComponent(){
        return menuComponent;
    }
    List<Menu_Component__c> menuComponentList; 
    public Menu_Component__c getMComponent(){
        String menuComponentId = ApexPages.currentPage().getParameters().get('id');
        if(menuComponentId!=null){
            menuComponentList = [Select m.Name, m.Override_Class__c, m.Name__c, m.Id, m.Display_Type__c, m.Component_Menus__c, m.Active__c 
                                From Menu_Component__c m where m.id = :menuComponentId];
        }
        
        if(menuComponentList!=null && menuComponentList.size()>0){
            menuComponent = menuComponentList[0];
            System.debug('*****menuComponentList[0].Component_Menus__c******'+menuComponentList[0].Component_Menus__c);
            if(menuComponentList[0].Component_Menus__c!=null && menuComponentList[0].Component_Menus__c.length()>0){
                List<String> selectedMenuNames = menuComponentList[0].Component_Menus__c.split(',');
                if(selectedMenuNames!=null && selectedMenuNames.size()>0){
                    selectedMenusList = [select id , Name__c from Menu__c where Active__c = true and Name__c in :selectedMenuNames order by Name__c];
                    availableMenusList = [select id , Name__c from Menu__c where Active__c = true and Name__c NOT in :selectedMenuNames order by Name__c];
                }
                else{
                    availableMenusList = [select id , Name__c from Menu__c where Active__c = true order by Name__c];
                }
            }
            else{
                availableMenusList = [select id , Name__c from Menu__c where Active__c = true order by Name__c];
            }
        }
        else{
            menuComponent = new Menu_Component__c();
            availableMenusList = [select id , Name__c from Menu__c where Active__c = true order by Name__c];
        }
        System.debug('*****ramesh*****getMComponent()*****'+menuComponent);
        return menuComponent;
    }
    public List<String> getAvailableMenus(){
        System.debug('*****RAMESH DHULL*****getAvailableMenus()*******'+availableMenus);
        return availableMenus;
    }
    public void setAvailableMenus(List<String> availableMenus){
        this.availableMenus = availableMenus;
        System.debug('*****RAMESH DHULL*****setAvailableMenus(List<String> availableMenus)******)'+this.availableMenus);
    }

    public List<String> getSelectedMenus(){
        System.debug('*****RAMESH DHULL*****getSelectedMenus()******return selectedMenus;'+selectedMenus);
        return selectedMenus;
    }
    public void setSelectedMenus(List<String> selectedMenus){
        
        this.selectedMenus = selectedMenus;
        System.debug('*****RAMESH DHULL*****setSelectedMenus(List<Id> selectedMenus)******)'+this.selectedMenus);
    }
    List<SelectOption> options1 = new List<SelectOption>();
    List<SelectOption> options2 = new List<SelectOption>();
    public List<SelectOption> getAvailableMenus1(){
        options1.clear();
        
            if(availableMenusList.size()>0)
            {
                for(Menu__c menu : availableMenusList)
                {
                    options1.add(new SelectOption(menu.Name__c,menu.Name__c));
                }
            }
        System.debug('*****RAMESH DHULL*****getAvailableMenus1()******'+options1);
        return options1;
    }
    public List<SelectOption> getSelectedMenus1(){
       options2.clear();
        if(selectedMenusList.size()>0)
        {
            for(Menu__c menu : selectedMenusList)
            {
                options2.add(new SelectOption(menu.Name__c,menu.Name__c));
            }
        }
        System.debug('*****RAMESH DHULL*****getSelectedMenus1()******'+options2);
        return options2;
    }
    public PageReference add()
    {   
        System.debug('****ramesh***add()*****');
        System.debug('****ramesh***********availableMenus.size()********'+availableMenus.size()+'**availableMenusList.size()*****'+availableMenusList.size()+'******selectedMenusList.size()****'+selectedMenusList.size());
        if(availableMenus.size()>0)
        {
            for(String menuName : availableMenus)
            {
                if (availableMenusList.size()>0)
                {
                    for(Integer i=0;i<availableMenusList.size();i++)
                    {
                        if (menuName == availableMenusList[i].Name__c)
                        {
                            selectedMenusList.add(availableMenusList[i]);
                            availableMenusList.remove(i);
                            break;
                        }
                    }
                }
            }
        }
        System.debug('****ramesh***availableMenusList.size()*****'+availableMenusList.size()+'******selectedMenusList.size()****'+selectedMenusList.size());
        return null;
    }
    public PageReference remove()
    {   
        System.debug('****ramesh***remove()*****');
        if(selectedMenus.size()>0)
        {
            for(String menuName : selectedMenus)
            {
                if (selectedMenusList.size()>0)
                {
                    for(Integer i=0;i<selectedMenusList.size();i++)
                    {
                        if (menuName == selectedMenusList[i].Name__c)
                        {
                            availableMenusList.add(selectedMenusList[i]);
                            selectedMenusList.remove(i);
                            break;
                        }
                    }
                }
            }
        }
        return null;
    }

    public PageReference save(){
        if(menuComponent.Name__c==null || menuComponent.Name__c.length()==0){
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, System.Label.Menu_Component_can_not_be_blank);
            ApexPages.addMessage(msg);
            return null;
        }
        String selectedMenusString;
        Boolean flag = false;
        System.debug('*****ramesh**save()*****selectedMenus*******'+selectedMenus);
        for(Menu__c selectedMenu:selectedMenusList){
            if(flag==false){
                selectedMenusString = selectedMenu.Name__c;
                flag=true;
            }
            else{
                selectedMenusString = selectedMenusString+','+selectedMenu.Name__c;
            }
        }
        menuComponent.Component_Menus__c = selectedMenusString;
        System.debug('*****ramesh***menuComponent.Component_Menus__c***'+menuComponent.Component_Menus__c);
        if(menuComponent.id==null){
            List<Menu_Component__c> cmsMenuComponentList = [select id from Menu_Component__c where Name__c = :menuComponent.Name__c];
            if(cmsMenuComponentList.size()>0){
                ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, System.Label.Menu_Component_Name_is_already_exist_Please_select_another_Name);
                ApexPages.addMessage(msg);
                return null;
            }
            else{
                insert menuComponent;
            }
        }
        else{
            update menuComponent;
        }
        PageReference pg = new PageReference('/'+menuComponent.id);
        return pg;
    }
    public PageReference saveAndNew(){
        if(menuComponent.Name__c==null || menuComponent.Name__c.length()==0){
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, System.Label.Menu_Component_can_not_be_blank);
            ApexPages.addMessage(msg);
            return null;
        }
        String selectedMenusString;
        Boolean flag = false;
        for(Menu__c selectedMenu:selectedMenusList){
            if(flag==false){
                selectedMenusString = selectedMenu.Name__c;
                flag=true;
            }
            else{
                selectedMenusString = selectedMenusString+','+selectedMenu.Name__c;
            }
        }
        
        menuComponent.Component_Menus__c = selectedMenusString;
        System.debug('*****ramesh***menuComponent.Component_Menus__c***'+menuComponent.Component_Menus__c);
        if(menuComponent.id==null){
            List<Menu_Component__c> cmsMenuComponentList = [select id from Menu_Component__c where Name__c = :menuComponent.Name__c];
            if(cmsMenuComponentList.size()>0){
                ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, System.Label.Menu_Component_Name_is_already_exist);
                ApexPages.addMessage(msg);
                return null;
            }
            else{
                insert menuComponent;
            }
        }
        else{
            update menuComponent;
        }
        PageReference pg = new PageReference('/apex/MenuComponentPage');
        pg.setRedirect(true);
        return pg;
        return null;
    }
    public PageReference cancel(){
        PageReference pg;
        Schema.DescribeSObjectResult D = Menu_Component__c.sObjectType.getDescribe();
        if(menuComponent.id==null){
            pg= new PageReference('/'+d.getKeyPrefix());
        }
        else{
            pg= new PageReference('/'+menuComponent.id);
        } 
        return pg;
        //return null;
    }
    public static testmethod void tstMenuComponent_controller(){
        Menu__c menu = new Menu__c();
        menu.Name__c = 'OnlineJobSearch';
        menu.Active__c = true;
        menu.Order__c = 1;
        insert menu;
        Menu__c menu1 = new Menu__c();
        menu1.Name__c = 'OnlineJobSearch1';
        menu1.Active__c = true;
        menu1.Order__c = 1;
        insert menu1;
        MenuComponent_controller menuComponent = new MenuComponent_controller();
        menuComponent.getMenuComponent();
        List<String> availableMenuList = new List<String>();
        for(Menu__c availableMenu:menuComponent.availableMenusList){
            availableMenuList.add(availableMenu.Name__c);
        }
        menuComponent.getAvailableMenus1();
        menuComponent.getSelectedMenus1();
        menuComponent.setSelectedMenus(availableMenuList);
        menuComponent.getSelectedMenus();
        menuComponent.remove();
        menuComponent.setAvailableMenus(availableMenuList);
        menuComponent.getAvailableMenus();
        menuComponent.add();
        menuComponent.menuComponent.Name__c = 'HeaderMenuComponent';
        menuComponent.menuComponent.Active__c = true;
        menuComponent.save();
        menuComponent.saveAndNew();
        menuComponent.cancel();
        PageReference pg = new PageReference('/apex/MenuComponentPage');
        pg.getParameters().put('id',menuComponent.menuComponent.id);
        Test.setCurrentPageReference(pg);
        MenuComponent_controller menuComponent1 = new MenuComponent_controller();
        menuComponent.save();
        menuComponent.saveAndNew();
        menuComponent.cancel();
    }

}