public class PageBlockObject {

		// This Class is created for giving all types of blocks content to regions pages
		public PageBlock__c block {get;set;}
		public String menuDisplayType {get;set;}
		public String menuOverrideClass {get;set;}
		//ulID is used for menu functionality. now we can remove it.
		public String ulID {get;set;}
		public String includePageName {get;set;}
		public Integer blockNumber {get;set;} 
		public List<CMSMenuBean> cmsMenuBeanList = new List<CMSMenuBean>();
		public static CMSMenuBean setCMSMenuBean(PageBlock__c blk,Menu__c menu,List<Menu__c> childMenuList){
			CMSMenuBean cmsMenuBean = new CMSMenuBean();
			cmsMenuBean.parentMenu = menu;
			if(childMenuList.size()>0){
				cmsMenuBean.isChildMenusExist = true;
			}
			cmsMenuBean.liID = blk.Layout_Placement__c+blk.DisplayOrder__c+menu.Order__c;
			cmsMenuBean.childMenuList = childMenuList;
			return cmsMenuBean;
		}
		public List<CMSMenuBean> getCmsMenuBeanList(){
			return cmsMenuBeanList;
		}
		public void setCmsMenuBeanList(List<CMSMenuBean> cmsMenuBeanList){
			this.cmsMenuBeanList = cmsMenuBeanList;
		}
		//public CMSMenuComponentBean menuComponent {get;set;}


		public class CMSMenuBean{
			public Menu__c parentMenu {get;set;}
			public Boolean isChildMenusExist{get;set;}
			public String liID{get;set;}
			public List<Menu__c> childMenuList {get;set;}
		}
		
		public static testmethod void Testpageblock()
		{
			PageBlock__c bloc=new PageBlock__c();
			//ApexPages.StandardController bc = new ApexPages.standardController(bloc);
			List<CMSMenuBean> cmsMenuBean=new List<CMSMenuBean>();
			
			PageBlockObject pb=new PageBlockObject();
			pb.block=bloc;
			pb.blockNumber=4;
			pb.cmsMenuBeanList=cmsMenuBean;
			pb.getCmsMenuBeanList();
			pb.setCmsMenuBeanList(cmsMenuBean);
			
				
			Menu__c mn=new Menu__c();
			//ApexPages.StandardController men = new ApexPages.standardController(mn);
			List<Menu__c> childMenu=new List<Menu__c>();
			
			CMSMenuBean cb=new CMSMenuBean();
			cb.isChildMenusExist=true;
			cb.liID='sample';
			cb.parentMenu=mn;
			cb.childMenuList=childMenu;
			
			setCMSMenuBean(bloc, mn, childMenu);
		}
	
}