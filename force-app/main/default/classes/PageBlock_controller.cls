public without sharing class PageBlock_controller {

    PageBlock__c block = getBlk();
    List<PageBlock__c> blockList;
    Boolean showHideContent = true;
    public Boolean showHideTextContent {get;set;}
    public Boolean showHideMenuComponent {get;set;} 
    public Boolean showHideMODULE {get;set;} 
    public Boolean showHideIFRAME {get;set;} 
    public Boolean showHideAutoHeightIFRAME {get;set;}
    public Boolean showHideExistingBlock{get;set;}
    public Boolean showHideFlash{get;set;}
    public String existingBlockName;
    public String menuComponentName;
    public String moduleName;
    public PageBlock_controller(){
        setBlockType();
    }
    public Boolean getShowHideContent(){
        return showHideContent;
    }
    public String getExistingBlockName(){
        existingBlockName=block.Existing_Block_Name__c;
        return existingBlockName;
    }
    public void setExistingBlockName(String existingBlockName){
        this.existingBlockName = existingBlockName;
        block.Existing_Block_Name__c = existingBlockName;
    }
    public String getMenuComponentName(){
        menuComponentName=block.Menu_Component_Name__c;
        return menuComponentName;
    }
    public void setMenuComponentName(String menuComponentName){
        this.menuComponentName = menuComponentName;
        block.Menu_Component_Name__c=menuComponentName;
    }
    public String getModuleName(){
        moduleName=block.Module_Name__c;
        return moduleName;  
    }
    public void setModuleName(String moduleName){
        this.moduleName=moduleName;
        block.Module_Name__c=moduleName;
    }
    public List<SelectOption> getExistingBlockItems(){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption(System.label.None,System.label.None));
        List<PageBlock__c> existingBlockList = [select Name, Name__c from PageBlock__c where Active__c = true order by Name__c];
        for(PageBlock__c block:existingBlockList){
            options.add(new SelectOption(block.Name__c,block.Name__c)); 
        }
        return options;
    }
    public List<SelectOption> getModuleItems() 
    {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption(System.label.None, System.label.None));
        List<ApexPage> pageList = [Select a.Name,a.NamespacePrefix, a.Id From ApexPage a];
        for(ApexPage page : pageList)
        {   
            if(page.NamespacePrefix!=null && page.NamespacePrefix.length()>0){
                options.add(new SelectOption(page.NamespacePrefix+'__'+page.Name,page.NamespacePrefix+'__'+page.Name));
            }
            else
            {
                options.add(new SelectOption(page.Name,page.Name));
            }
        }
        return options;
    }
    public List<SelectOption> getItems() 
    {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption(System.label.None, System.label.None));
        List<Menu_Component__c> menuComponentList = [Select id,Name,Name__c From Menu_Component__c where Active__c = true];
        for(Menu_Component__c menuComponent : menuComponentList)
        {
            options.add(new SelectOption(menuComponent.Name__c,menuComponent.Name__c));
        }
        return options;
    }
    
    public PageBlock__c getBlock(){
        return block;
    }
    public void setBlock(PageBlock__c block){
        this.block = block;
    }
    public PageBlock__c getBlk(){
        String blockId = ApexPages.currentPage().getParameters().get('id');
        String pageId = ApexPages.currentPage().getParameters().get('pageId');
        if(blockId!=null){
            blockList = [Select Name,b.Auto_Height_Iframe_Code__c,b.Content_Text__c,b.Parent_Window_Parameters__c, b.Flash_Play__c,b.Flash_Loop__c,b.FlashVars__c,b.Existing_Block_Name__c,b.Width__c,
            b.DisplayOrder__c, b.Type__c,b.Menu_Component_Name__c, b.Layout_Placement__c, b.Page__c, b.OwnerId, b.CSSStyle__c,
             b.Name__c, b.Module_Name__c, b.IFrame_URL__c, b.Height__c, b.Content__c, b.Authentication_Required__c, b.Active__c
              From PageBlock__c b where b.id = :blockId];
        }
        
        if(blockList!=null && blockList.size()>0){
            block = blockList[0];
        }
        else{
            block = new PageBlock__c();
            block.Type__c = System.Label.HTML;
            if(pageId!=null && pageId.length()>0){ 
                block.Page__c=pageId;
            }
        }
        System.debug('*****ramesh*****getBlk()*****'+block);
        return block;
    }
    public void setBlockType(){
        if(block.Type__c == System.Label.IFRAME) {
            System.debug('****ramesh****changeBlockType()**IFRAME*'+block.Type__c);
            showHideIFRAME = true;
            showHideMODULE = false;
            showHideMenuComponent = false;
            showHideContent = false;
            showHideExistingBlock = false;
            showHideFlash = false;
            showHideTextContent = false;
            showHideAutoHeightIFRAME = false;
        }
        else if(block.Type__c == System.Label.Flash) {
            showHideIFRAME = true;
            showHideMODULE = false;
            showHideMenuComponent = false;
            showHideContent = false;
            showHideExistingBlock = false;
            showHideFlash = true;
            showHideTextContent = false;
            showHideAutoHeightIFRAME = false;
        }
        else if(block.Type__c == System.Label.MODULE) {
            System.debug('****ramesh****changeBlockType()**MODULE*****'+block.Type__c);
            showHideIFRAME = false;
            showHideMODULE = true;
            showHideMenuComponent = false;
            showHideContent = false;
            showHideExistingBlock = false;
            showHideFlash = false;
            showHideTextContent = false;
            showHideAutoHeightIFRAME = false;
        }
        else if(block.Type__c == System.Label.HTML) {
            System.debug('****ramesh****changeBlockType()**HTML*****'+block.Type__c);
            showHideIFRAME = false;
            showHideMODULE = false;
            showHideMenuComponent = false;
            showHideContent = true;
            showHideExistingBlock = false;
            showHideFlash = false;
            showHideTextContent = false;
            showHideAutoHeightIFRAME = false;
        }
        else if(block.Type__c == System.Label.Menu_Component) {
            System.debug('****ramesh****changeBlockType()**Menu Component*****'+block.Type__c);
            showHideIFRAME = false;
            showHideMODULE = false;
            showHideMenuComponent = true;
            showHideContent = false;
            showHideExistingBlock = false;
            showHideFlash = false;
            showHideTextContent = false;
            showHideAutoHeightIFRAME = false;
        }
        else if (block.Type__c == System.Label.Existing_Block) {
            showHideIFRAME = false;
            showHideMODULE = false;
            showHideMenuComponent = false;
            showHideContent = false;
            showHideExistingBlock = true;
            showHideFlash = false;
            showHideTextContent = false;
            showHideAutoHeightIFRAME = false;
        }
        else if (block.Type__c == System.Label.Text) {
            showHideIFRAME = false;
            showHideMODULE = false;
            showHideMenuComponent = false;
            showHideContent = false;
            showHideExistingBlock = false;
            showHideFlash = false;
            showHideTextContent = true;
            showHideAutoHeightIFRAME = false;
        }
        else if (block.Type__c == System.Label.Auto_Height_Iframe) {
            showHideIFRAME = false;
            showHideMODULE = false;
            showHideMenuComponent = false;
            showHideContent = false;
            showHideExistingBlock = false;
            showHideFlash = false;
            showHideTextContent = false;
            showHideAutoHeightIFRAME = true;
        }
        else {
            System.debug('****ramesh****changeBlockType()******None****'+block.Type__c);
            showHideIFRAME = false;
            showHideMODULE = false;
            showHideMenuComponent = false;
            showHideContent = true;
            showHideExistingBlock = false;
            showHideFlash = false;
            showHideTextContent = false;
            showHideAutoHeightIFRAME = false;
        }
    }
    private void addErrorMessage(String message) {
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, message);
            ApexPages.addMessage(msg);
    }
    public PageReference save(){
        System.debug('*****ramesh*****block.Page__c***'+block.Page__c);
        List<PageBlock__c> blkList = [select id from PageBlock__c where Name__c != :block.Name__c and  Layout_Placement__c=:block.Layout_Placement__c 
                                        and DisplayOrder__c = :block.DisplayOrder__c and (Page__c = :block.Page__c or Page__c = null)];
        if(blkList.size()>0){
            addErrorMessage(System.Label.Combination_of_selected_Section);
            return null;
        }
        String ckeditor = ApexPages.currentPage().getParameters().get('editor1');
        if(ckeditor!=null){
            block.Content__c = ckeditor;
        }
        String textContent = ApexPages.currentPage().getParameters().get('textContent');
        if(textContent!=null){
            block.Content_Text__c = textContent;
        }
        String autoHeightIframeCode = ApexPages.currentPage().getParameters().get('autoHeightIframeCode');
        if(autoHeightIframeCode!=null){
            block.Auto_Height_Iframe_Code__c = autoHeightIframeCode;
        }
        
        System.debug('*******ramesh****ckeditor***'+ckeditor);
        if(block.id==null){
            if(block.Type__c == System.Label.IFRAME && (block.IFrame_URL__c !=null && block.IFrame_URL__c.length()>0)){
            }
            else if(block.Type__c == System.Label.MODULE && (block.Module_Name__c !=null && block.Module_Name__c!= System.label.None)){
            }
            else if(block.Type__c == System.Label.Menu_Component && (block.Menu_Component_Name__c !=null && block.Menu_Component_Name__c != System.label.None)){
            }
            else if(block.Type__c == System.Label.HTML){
            }
            else if(block.Type__c == System.Label.Text){
            }
            else if(block.Type__c == System.Label.Flash && (block.IFrame_URL__c !=null && block.IFrame_URL__c.length()>0)){
            }
            else if(block.Type__c == System.Label.Existing_Block && (block.Existing_Block_Name__c !=null && block.Existing_Block_Name__c != System.label.None)){
            }
            else if(block.Type__c == null){
            }
            else if(block.Type__c == System.Label.Auto_Height_Iframe && (block.Auto_Height_Iframe_Code__c !=null && block.Auto_Height_Iframe_Code__c.length()>0)){
            }
            else{
                addErrorMessage(System.Label.Please_select_or_enter_some_value);
                return null;
            }
            insert block;
        }
        else{
            if(block.Type__c == System.Label.IFRAME && (block.IFrame_URL__c !=null && block.IFrame_URL__c.length()>0)){
            }
            else if(block.Type__c == System.Label.MODULE && (block.Module_Name__c !=null && block.Module_Name__c!=System.Label.None)){
            }
            else if(block.Type__c == System.Label.Menu_Component && (block.Menu_Component_Name__c !=null && block.Menu_Component_Name__c !=System.Label.None)){
            }
            else if(block.Type__c == System.Label.HTML){
            }
            else if(block.Type__c == System.Label.Text){
            }
            else if(block.Type__c == System.Label.Flash && (block.IFrame_URL__c !=null && block.IFrame_URL__c.length()>0)){
            }
            else if(block.Type__c == System.Label.Existing_Block && (block.Existing_Block_Name__c !=null && block.Existing_Block_Name__c !=System.Label.None)){
            }
            else if(block.Type__c == null){
            }
            else if(block.Type__c == System.Label.Auto_Height_Iframe && (block.Auto_Height_Iframe_Code__c !=null && block.Auto_Height_Iframe_Code__c.length()>0)){
            }
            else{
                addErrorMessage(System.Label.Please_select_or_enter_some_value);
                return null;
            }
            update block;
        }
        PageReference pg = new PageReference('/'+block.id);
        return pg;
    }
    public PageReference saveAndNew(){
        List<PageBlock__c> blkList = [select id from PageBlock__c where Name__c != :block.Name__c and  Layout_Placement__c=:block.Layout_Placement__c 
                                        and DisplayOrder__c = :block.DisplayOrder__c and (Page__c = :block.Page__c or Page__c = '')];
        if(blkList.size()>0){
            addErrorMessage(System.Label.Combination_of_selected_Section);
            return null;
        }
        String ckeditor = ApexPages.currentPage().getParameters().get('editor1');
        if(ckeditor!=null){
            block.Content__c = ckeditor;
        }
        String textContent = ApexPages.currentPage().getParameters().get('textContent');
        if(textContent!=null){
            block.Content_Text__c = textContent;
        }
        String autoHeightIframeCode = ApexPages.currentPage().getParameters().get('autoHeightIframeCode');
        if(autoHeightIframeCode!=null){
            block.Auto_Height_Iframe_Code__c = autoHeightIframeCode;
        }
        System.debug('*******ramesh****ckeditor***'+ckeditor);
        if(block.id==null){
            if(block.Type__c == System.Label.IFRAME && (block.IFrame_URL__c !=null && block.IFrame_URL__c.length()>0)){
            }
            else if(block.Type__c == System.Label.MODULE && (block.Module_Name__c !=null && block.Module_Name__c!=System.Label.None)){
            }
            else if(block.Type__c == System.Label.Menu_Component && (block.Menu_Component_Name__c !=null && block.Menu_Component_Name__c !=System.Label.None)){
            }
            else if(block.Type__c == System.Label.HTML){
            }
            else if(block.Type__c == System.Label.Text){
            }
            else if(block.Type__c == System.Label.Flash && (block.IFrame_URL__c !=null && block.IFrame_URL__c.length()>0)){
            }
            else if(block.Type__c == System.Label.Existing_Block && (block.Existing_Block_Name__c !=null && block.Existing_Block_Name__c !=System.Label.None)){
            }
            else if(block.Type__c == null){
            }
            else if(block.Type__c == System.Label.Auto_Height_Iframe && (block.Auto_Height_Iframe_Code__c !=null && block.Auto_Height_Iframe_Code__c.length()>0)){
            }
            else{
                addErrorMessage(System.Label.Please_select_or_enter_some_value);
                return null;
            }
            insert block;
        }
        else{
            if(block.Type__c == System.Label.IFRAME && (block.IFrame_URL__c !=null && block.IFrame_URL__c.length()>0)){
            }
            else if(block.Type__c == System.Label.MODULE && (block.Module_Name__c !=null && block.Module_Name__c!=System.Label.None)){
            }
            else if(block.Type__c == System.Label.Menu_Component && (block.Menu_Component_Name__c !=null && block.Menu_Component_Name__c !=System.Label.None)){
            }
            else if(block.Type__c == System.Label.HTML){
            }
            else if(block.Type__c == System.Label.Text){
            }
            else if(block.Type__c == System.Label.Flash && (block.IFrame_URL__c !=null && block.IFrame_URL__c.length()>0)){
            }
            else if(block.Type__c == System.Label.Existing_Block && (block.Existing_Block_Name__c !=null && block.Existing_Block_Name__c !=System.Label.None)){
            }
            else if(block.Type__c == null){
            }
            else if(block.Type__c == System.Label.Auto_Height_Iframe && (block.Auto_Height_Iframe_Code__c !=null && block.Auto_Height_Iframe_Code__c.length()>0)){
            }
            else{
                addErrorMessage(System.Label.Please_select_or_enter_some_value);
                return null;
            }
            update block;
        }
        PageReference pg = new PageReference('/apex/New_Edit_Block');
        pg.setRedirect(true);
        return pg;
    }
    public PageReference cancel(){
        Schema.DescribeSObjectResult D = PageBlock__c.sObjectType.getDescribe();
        //Map<String, Schema.SObjectField> pageMap = Schema.SObjectType.ApexPage.fields.getMap();
        //System.debug('*****RAEMSH***pageMap*****'+pageMap);
        PageReference pg;
        if(block.id==null){
            pg= new PageReference('/'+d.getKeyPrefix());
        }
        else{
            pg= new PageReference('/'+block.id);
        } 
        return pg;
    }
    public PageReference changeBlockType(){
        if(block.Name__c =='.'){
            block.Name__c = '';
        }
        String ckeditor = ApexPages.currentPage().getParameters().get('editor1');
        if(ckeditor!=null){
            block.Content__c = ckeditor;
        }
        setBlockType();
        //pg.setRedirect(true);
        //return pg;
        return null;
    }
   
    public static testmethod void tstBlockController()
    {
        
        PageBlock_controller blockController = new PageBlock_controller();
        blockController.setMenuComponentName('TestComponent');
        blockController.getMenuComponentName();
        blockController.setModuleName('Home');
        blockController.getModuleName();
        blockController.getShowHideContent();
        blockController.getExistingBlockItems();
        blockController.getModuleItems();
        blockController.getItems();
        blockController.block.Name__c = 'Home0';
        blockController.block.DisplayOrder__c = 0.0;
        blockController.setBlock(blockController.block);
        blockController.getBlock();
        blockController.changeBlockType();
        blockController.block.Type__c = System.Label.IFRAME;
        blockController.setBlockType();
        blockController.block.Type__c = System.Label.Flash;
        blockController.setBlockType();
        blockController.block.Type__c = System.Label.MODULE;
        blockController.setBlockType();
        blockController.block.Type__c = System.Label.Menu_Component;
        blockController.setBlockType();
        blockController.block.Type__c = System.Label.Existing_Block;
        blockController.setBlockType();
        blockController.block.Type__c = System.Label.none;
        blockController.setBlockType();
        blockController.save();
        blockController.setExistingBlockName(System.Label.MODULE);
        blockController.getExistingBlockName();
        PageBlock_controller blockController1 = new PageBlock_controller();
        blockController1.block.Name__c = 'Home';
        blockController1.block.DisplayOrder__c = 0.0;
        blockController1.saveAndNew();
        //blockController.cancel();
        Page__c page = new Page__c();
        page.Name = 'OnlineJobSearch';
        page.Name__c = 'OnlineJobSearch';
        page.Active__c = true;
        //page.Authentication_Required__c = true;
        insert page;
        PageReference pg = new PageReference('/apex/New_Edit_Block');
        pg.getParameters().put('id',blockController.block.id);
        pg.getParameters().put('pageId',page.id);
        Test.setCurrentPageReference(pg);
        PageBlock_controller blockController2 = new PageBlock_controller();
        blockController2.block.Name__c = 'Home1';
        blockController2.block.DisplayOrder__c = 0.0;
        blockController2.save();
        PageBlock_controller blockController3 = new PageBlock_controller();
        blockController3.block.Name__c = 'Home2';
        blockController3.block.DisplayOrder__c = 0.0;
        blockController2.saveAndNew();
        blockController2.cancel();
    
}
}