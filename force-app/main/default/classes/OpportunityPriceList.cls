public class OpportunityPriceList{
    public Boolean selected {get; set;}
    public Id oppId;
    public string targetFieldCon{get;set;}
    list<listwrapper>  listPriceValue= new list<listwrapper>(); 
    list<PricebookEntry> selectedcodes = new list<PricebookEntry>();
    list<Product2> prodCat  = new list<Product2 >();
    public String opportunityId {get;set;}
    public Opportunity opportunityRecord {get;set;}
    
    public OpportunityPriceList(ApexPages.StandardController stdController){
    	this.opportunityId = Apexpages.currentPage().getParameters().get('id');
    	System.debug('OppID : '+this.opportunityId);
    	//randomJsIden = getRandomNumber(1000000);
    	try{
    		opportunityRecord = [Select Id, Name, Account.Name, Brand_Name__c from Opportunity where Id = :opportunityId limit 1];
    	}catch(Exception e){
    		ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,'Opportunity Id Specified does not exists.'));
    	}
    }
    public OpportunityPriceList(){
    //Constructor
    }
    set<string> s1 = new set<string>();
  /* 
    //AutoComplete Features
    public String labelField{ get; set; }
    public String valueField{ get; set; }
    public String sObjVal{get;set;}
    public Integer randomJsIden{get;set;}
    public String cacheField{get;set;} 
   
    //Random number generator to change the js function name if multiple components us
   
    private Integer getRandomNumber(Integer size){
        Double d = Math.random() * size;
        return d.intValue();
    }
    
    
    //This method queries data according to the passed parameters
    
    @RemoteAction
    public static List<SObject> getData(String sObjVal,String labelField,String valueField,String param){
        param = String.escapeSingleQuotes(param);
        System.debug('AUTOCOMPLETE : '+'SELECT '+valueField+','+labelField+' FROM '+sObjVal+' WHERE '+labelField+' LIKE \'%'+param+'%\'');
        return Database.query('SELECT '+valueField+','+labelField+' FROM '+sObjVal+' WHERE '+labelField+' LIKE \'%'+param+'%\'');
    }
    //End of AutoComplete Feature
    */
      List<String> familyListNew = new List<String>();
  		 public List<String> getFamily(){
    		getpr();    
    		familyListNew.sort();
    		return familyListNew;
  		 }
  	Map<String,List<String>> familyParentProducts = new Map<String,List<String>>();
    map<String, List<listwrapper>> listPricesNew = new Map<String, List<listwrapper>>();
    Map<String,PricebookEntry> pbEntryMap = new Map<String,PricebookEntry>();
    //Family -- Products (parents) -- Child products
    //Map<String,List<OpportunityLineItemsWrapper>> oppLineItemMap = new Map<String,List<OpportunityLineItemsWrapper>>();
     Map<String,List<OpportunityLineItemsWrapper>> oppLineItemMap = new Map<String,List<OpportunityLineItemsWrapper>>();
    public  Map<String,Map<String,List<OpportunityLineItemsWrapper>>> oppLineItemMasterMap = new Map<String,Map<String,List<OpportunityLineItemsWrapper>>>();
    //ParentProducts -- ChildProducts
    Map<String, String> oppLineItemParentList = new Map<String, String>();
    
 	public Map<String,List<String>> getfamilyParentProducts(){
 		return familyParentProducts;
 	}
    
    public Map<String,Map<String,List<OpportunityLineItemsWrapper>>> getpr(){
     if(oppLineItemMasterMap.size()== 0 ){
     		//loading current services in Opportunity
     		List<OpportunityLineItem> itemsAlreadyExists = [select id, pricebookentryId,  TotalPrice,Quantity,UnitPrice, discount, 
     				description, opportunityid from OpportunityLineItem where opportunityId =:opportunityId for update];
     		Map<String,OpportunityLineItem> existingMap = new Map<String,OpportunityLineItem>();
     		if(itemsAlreadyExists.size() > 0){
     			for(OpportunityLineItem item : itemsAlreadyExists){
     				existingMap.put(item.pricebookentryId,item);
     			}
     		}
             //Query Parent Products
             List<Product2> parentProducts = new List<Product2>();
				parentProducts = [select id,Name,Family,Proposal_Description__c,
		             Description,Min_req_Units__c,ProductCode,IsParent__c,
		             IsActive from 
		             Product2 where IsActive = true and isParent__c = true order by Name asc];  
             if(parentProducts.size() > 0){
             	for(Product2 prdRec : parentProducts){
             		if(oppLineItemMasterMap.containsKey(prdRec.Family)){
             			Map<String,List<OpportunityLineItemsWrapper>> innerMap = oppLineItemMasterMap.get(prdRec.Family);
             			innerMap.put(prdRec.Name, new List<OpportunityLineItemsWrapper>());
             			oppLineItemMasterMap.put(prdRec.Family,innerMap);
             		}else{
	             		Map<String,List<OpportunityLineItemsWrapper>> innerMap = new Map<String,List<OpportunityLineItemsWrapper>>();
	             		innerMap.put(prdRec.Name, new List<OpportunityLineItemsWrapper>());
	             		innerMap.put('OTHERS', new List<OpportunityLineItemsWrapper>());
	             		oppLineItemMasterMap.put(prdRec.Family, innerMap);
	             		familyListNew.add(prdRec.Family);
             		}
             		if(familyParentProducts.containsKey(prdRec.Family)){
             			familyParentProducts.get(prdRec.Family).add(prdRec.Name);
             		}else{
             			List<String> newList= new List<String>();
             			newList.add(prdRec.Name);
             			newList.add('OTHERS');
             			familyParentProducts.put(prdRec.Family,newList);
             		}
             	}
             }
             System.debug('---------------familyParent'+familyParentProducts +'-------------------'+oppLineItemMasterMap.get('Data Services'));
             list<PricebookEntry> codes = new list<PricebookEntry>();
             codes = [select id,unitprice,Pricebook2Id,Product2.Id,Product2.Name,Product2.Family,Product2.Proposal_Description__c,
             Product2.Description,Product2.Min_req_Units__c,ProductCode,Name,Product2.IsParent__c,
             Product2.Parent_Product__c,Product2.Parent_Product__r.Name,Product2.Parent_Product__r.Id,IsDeleted, IsActive from 
             pricebookentry where Product2.IsActive = true and Product2.IsParent__c=false and 
                    pricebook2.Name='Standard Price Book' 
                    order by product2.Name asc];  
             for(PricebookEntry c : codes){
             	System.debug('---CODES :'+c);
             	String parentName ='OTHERS';
             	if(oppLineItemMasterMap.containsKey(c.Product2.Family)){
             		if(c.Product2.Parent_Product__c != null){
             			parentName = c.Product2.Parent_Product__r.Name;
             		}
             		OpportunityLineItemsWrapper wrapperItem = new OpportunityLineItemsWrapper(c,opportunityId);
             		if(existingMap.containsKey(wrapperItem.pbEntry.Id)){
             			OpportunityLineItem itemPresent = existingMap.get(wrapperItem.pbEntry.Id);
             			wrapperItem.selected = true;
             			wrapperItem.oppLineItemRecord.UnitPrice =itemPresent.UnitPrice;
             			wrapperItem.oppLineItemRecord.Description = itemPresent.Description;
             			wrapperItem.oppLineItemRecord.Discount = itemPresent.Discount; 
             			wrapperItem.oppLineItemRecord.Quantity = itemPresent.Quantity;
             			wrapperItem.totalPrice = itemPresent.TotalPrice;
             			wrapperItem.oppLineItemRecord.Id = itemPresent.Id;
             		}
             		System.debug('INTO IF :'+parentName);
             		if((oppLineItemMasterMap.get(c.Product2.Family)).get(parentName) == null){
             			List<OpportunityLineItemsWrapper> innerList = new List<OpportunityLineItemsWrapper>();
             			innerList.add(wrapperItem);
             			(oppLineItemMasterMap.get(c.Product2.Family)).put(parentName, innerList); 
             		}else{
             			(oppLineItemMasterMap.get(c.Product2.Family)).get(parentName).add(wrapperItem);
             		}
             		System.debug('----------OPPLIST1 :'+oppLineItemMasterMap);
             	}else{
             		if(c.Product2.Parent_Product__c != null){
             			parentName = c.Product2.Parent_Product__r.Name;
             		}
             		OpportunityLineItemsWrapper wrapperItem = new OpportunityLineItemsWrapper(c,opportunityId);
             		if(existingMap.containsKey(wrapperItem.pbEntry.Id)){
             			OpportunityLineItem itemPresent = existingMap.get(wrapperItem.pbEntry.Id);
             			wrapperItem.selected = true;
             			wrapperItem.oppLineItemRecord.UnitPrice =itemPresent.UnitPrice;
             			wrapperItem.oppLineItemRecord.Description = itemPresent.Description;
             			wrapperItem.oppLineItemRecord.Discount = itemPresent.Discount; 
             			wrapperItem.oppLineItemRecord.Quantity = itemPresent.Quantity;
             			wrapperItem.totalPrice = itemPresent.TotalPrice;
             			wrapperItem.oppLineItemRecord.Id = itemPresent.Id;
             		}
             		Map<String,List<OpportunityLineItemsWrapper>> innerMap = new Map<String,List<OpportunityLineItemsWrapper>>();
             		List<OpportunityLineItemsWrapper> listItems = new List<OpportunityLineItemsWrapper>();
             		listItems.add(wrapperItem);
             		innerMap.put(parentName, listItems);
             		oppLineItemMasterMap.put(c.Product2.Family,innerMap);
             		familyListNew.add(c.Product2.Family);
             		System.debug('----------OPPLIST2 :'+oppLineItemMasterMap);
             	}
             	
             	
             	/*if(oppLineItemMap.containsKey(c.Product2.Family)){ //parent
             		OpportunityLineItemsWrapper wrapperItem = new OpportunityLineItemsWrapper(c,opportunityId);
             		if(c.Product2.IsParent__c){
             			oppLineItemParentList.put(c.Product2.Id,c.Product2.Name);
             		}else{ // non parent-child products
             			List<OpportunityLineItemsWrapper> items = oppLineItemMap.get(c.Product2.Family);
	             		items.add(wrapperItem);
	             		oppLineItemMap.put(c.Product2.Family, items);             			
	             		pbEntryMap.put(c.Id,c);
             		}
             	}else{
             		OpportunityLineItemsWrapper wrapperItem = new OpportunityLineItemsWrapper(c,opportunityId);
             		if(c.Product2.IsParent__c){
             			oppLineItemParentList.put(c.Product2.Id,c.Product2.Name);
             		}else{
	             		List<OpportunityLineItemsWrapper> items = new List<OpportunityLineItemsWrapper>();
	             		items.add(wrapperItem);
	             		oppLineItemMap.put(c.Product2.Family, items);
	             		pbEntryMap.put(c.Id,c);
	             		familyListNew.add(c.Product2.Family);
             		}
             	}*/
             }
     }
     System.debug('----------OPPLIST :'+oppLineItemMasterMap.get('Data Services'));
   		return oppLineItemMasterMap;           
    }
    
    public String getParentName(String parentId){
    	return oppLineItemParentList.get(parentId);
    }
    
    list<lableTag> prod = new list<lableTag>();
    public List<lableTag> getLable1(){
    	prod.clear();
    	prod.add(new labletag('Base Cost','Total Cost','Products','Quantity','Data Cost','','','','',''));
    	prod.add(new labletag('Cost/Record','','Data Services','Quantity','Discount','','','','',''));
    	//prod.add(new labletag('Cost/Record','Total Cost','1000+','Quantity','','','','','',''));
    	prod.add(new labletag('Base Plan Cost','Total Cost','Professional Services','Quantity','','Set up Cost','Agency Cost','Min req Units','',''));
   		return prod;
    }
   
    public class labletag{
    public string Cost{get;set;}
    public string TCost{get;set;}
    public string quantity{get;set;} 
    public string tLable{get;set;}
    public string dataLable{get;set;}
    public string setuplable{get;set;}
    public string agencylable{get;set;}
    public string minrequnit{get;set;}
    public string fromDate{get;set;}
    public string toDate{get;set;}
    
        public labletag(string Cost,string TCost,string tLable,string quantity,string dataLable,string setuplable,string minrequnit,string agencylable,string fromDate,string toDate){
        	
		   this.Cost=Cost;
		   this.TCost=TCost;
		   this.tLable=tLable;
		   this.quantity=quantity;
		   this.dataLable=dataLable;
		   this.setuplable=setuplable;
		   this.minrequnit=minrequnit;
		   this.agencylable=agencylable;
		   this.fromDate=fromDate;
		   this.toDate=toDate;
	    }
    }
    
       public PageReference SaveRecord() {
       // oppId = System.currentPageReference().getParameters().get('Id');
        Pricebook2 pb2 = [select Id from pricebook2 where name ='Standard Price Book'];
        System.debug('PRICEBOOK:'+pb2);
        Opportunity oppRecord =  [select Id,pricebook2Id from Opportunity where id=:opportunityId for update];
        System.debug('OPP:'+oppRecord);
        oppRecord.Pricebook2Id = pb2.Id;
        update oppRecord;
        System.debug('UPDATE OPP:'+oppRecord);
        List<OpportunityLineItem > itemsForInsert  = new List<OpportunityLineItem >();
        List<OpportunityLineItem > itemsForUpdate  = new List<OpportunityLineItem >();
            PricebookEntry jobRec = new PricebookEntry();
        System.debug('&&&&&&&&&&&may1&&&&&&&'+oppLineItemMasterMap.size());
        for(Map<String,List<OpportunityLineItemsWrapper>> categoryMap : oppLineItemMasterMap.values()){
        	for(List<OpportunityLineItemsWrapper> parentMap : categoryMap.values()){
        		for(OpportunityLineItemsWrapper oppLineRec : parentMap){
        			System.debug(oppLineRec.pbEntry.Product2.Name+'****************'+oppLineRec.selected+'-*********-'+oppLineRec.oppLineItemRecord.Description);
        			if(oppLineRec.selected && oppLineRec.oppLineItemRecord.Id == null){
        				itemsForInsert.add(oppLineRec.oppLineItemRecord);
        			}else if(oppLineRec.selected && oppLineRec.oppLineItemRecord.Id != null){
        				itemsForUpdate.add(oppLineRec.oppLineItemRecord);
        			}
        		}
        	}
        }   
        System.debug('----INSERT SAVED-----------'+itemsForInsert);
        System.debug('----UPDATE SAVED-----------'+itemsForUpdate);
        try{
            insert itemsForInsert;
            update itemsForUpdate;
             ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Successfully Insert'));
            return null;
        }catch(Exception e){
             ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Error,'UnSuccessfully:'+e));
        }       
        
        return null;
    }
    
    
     public PageReference getSelected(){
          // selectedcodes.clear();
           	System.debug('&&&&&&&&&&&may&&&&&&&'+listPricesNew);
           	
            if( listPricesNew.size()>0){
                for(List<listwrapper> accwrapper :listPricesNew.Values()){
                	for(listwrapper a:accwrapper){
           	     		
           	     		if(a.selected == true){
	           	     		if(a.varPay!='0.0'){
	           	     			System.debug('&&&&&&&&&&&if&&&&&&&'+a.varPay);
	           	     			a.pr.UnitPrice=decimal.valueOf(a.varPay);
	           	     		}
                			selectedcodes.add(a.pr);
                			System.debug('&&&&&&&&&&&may&&&&&&&'+selectedcodes);
           	     		}
                	}
                }
            }
            return null;
        } 
/*	public Boolean option1{get;set;}
	public Boolean option2{get;set;}
	public Boolean option3{get;set;} 
        
    public class ChooseView{
  		public string question{get;set;}
  		public Boolean option1{get;set;}
  		public Boolean option2{get;set;}
  		public Boolean option3{get;set;}
  		
	public ChooseView(string s,Boolean i,Boolean j,Boolean k){
		  	question=s;
		  	option1=i;
		  	option2=j;
		  	option3=k;
		  }
  		}
  
 	list<ChooseView> cho = new list<ChooseView>();
 
	public List<ChooseView> getChoose(){
	  	cho.clear();
	  	cho.add(new ChooseView('Q1',false,false,false));
	  	cho.add(new ChooseView('Q2',false,false,false));	
	    return cho; 
	}
    
 public  PageReference testSub(){
 
 			if(cho.size()>0){
	 			for(ChooseView a:cho){
		 			if(a.option1==true){ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'option1'));}
		 			if(a.option2==true){ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'option2'));}
		 			if(a.option3==true){ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'option3'));}
		 			System.debug(a.option1+'+++++++'+a.option2+'+++++++++++'+a.option3);
		 			}
		 		try{
		             ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'vinay Insert'));
		            return null;
		            }catch(Exception e){
		             ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Error,'vinay UnSuccessfully'));
		  			}
           	 }   
 			return null;
 		} */     
 	
 	public class OpportunityLineItemsWrapper{
 		public Boolean isParent {get;set;}
 		public String parentId {get;set;}
 		public String priceBookEntryId {get;set;}
 		public double totalPrice {get;set;}
 		public boolean selected {get;set;}
 		
 		//public double discount {get;set;}
 		//public double listPrice {get;set;}
 		//public double salesPrice {get;set;}
 		//public integer quantity {get;set;}
 		//public double min_req_units {get;set;}
 		public OpportunityLineItem oppLineItemRecord {get;set;}
 		public PricebookEntry pbEntry {get;set;}
 		//public String description {get;set;}
 		public String opportunityId {get;set;}
 		public OpportunityLineItemsWrapper(PricebookEntry inRecord,String opportunityId){
 			this.pbEntry = inRecord;
 			this.opportunityId = opportunityId;
 			this.selected = false;
 			parentId  = inRecord.Product2.Parent_Product__c;
 			this.isParent = inRecord.Product2.isParent__c;
 			//this.discount=0.0;
 			///this.listPrice = inRecord.unitprice;
 			//this.salesPrice = inRecord.unitprice;
 			//this.description = inRecord.Product2.Description;
 			//this.quantity = 0;
 			//this.min_req_units = inRecord.product2.Min_req_Units__c;
 			this.oppLineItemRecord = generateLineItem(inRecord);
 		}
 		public OpportunityLineItem generateLineItem(PriceBookEntry pbRecord){
 			OpportunityLineItem itemRecord = new OpportunityLineItem();
             		itemRecord.PriceBookEntryId = pbRecord.Id;
             		itemRecord.UnitPrice = pbRecord.UnitPrice;
             		itemRecord.Description = pbRecord.Product2.Description;
             		itemRecord.Min_req_Units__c = pbRecord.Product2.Min_req_Units__c;
             		itemRecord.OpportunityId = this.opportunityId;
             		itemRecord.Discount = 0;
             		itemRecord.Quantity = 0;
             		return itemRecord;
 			/*lineItem.pricebookentryId = pbEntry.Id;
 			lineItem.UnitPrice = salesPrice;
 			lineItem.Description = description;
 			lineItem.Quantity = quantity;
 			lineItem.Discount = discount;
 			lineItem.Min_req_Units__c = min_req_units;
 			lineItem.opportunityId = opportunityId;
 			return lineItem;*/
 		}
 	}
  
    public class listwrapper{  
            public PricebookEntry pr{get; set;}
            public Boolean selected {get; set;}
            public string varPay{get;set;}
            public string Quantity{get;set;} 
            public decimal dataCost{get;set;}
            public decimal setupCost{get;set;}
            public decimal agencyCost{get;set;}
            public decimal minreqUnits{get;set;}
            public decimal fromPrice{get;set;}
            public decimal toPrice{get;set;}
                     
            public listwrapper(){
            		
            	varPay='0.0';
            	Quantity='0';
            	dataCost=0.0;
            	setupCost=0.0;
            	agencyCost=0.0;
            	minreqUnits=0.0;
            	fromPrice=0.0;
            	toPrice=0.0;
                selected = false;
            }
            
           
      }      
 }