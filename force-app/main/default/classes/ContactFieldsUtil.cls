global class ContactFieldsUtil
{
   
    global static Map<string, Schema.SObjectField> fieldMap
    {
        get
        {
            if (fieldMap == null)
                fieldMap = Schema.SObjectType.Contact.fields.getMap();
                
            return fieldMap;
        }
        set;
    }
    
    global static String getAllFieldsString()
    {
        String result = '';
        
        for (Schema.SObjectField field : fieldMap.values())
            result += ',' + field.getDescribe().Name;
            
        return result.substring(1);
    }
    
    global static void updateRecords(sObject source, sObject target){
        SiteLog_controller.addMessage('ContactFieldsUtil', 'updateRecords', 'start');
        
        for (string key : fieldMap.keySet()){
            Schema.SObjectField f = fieldMap.get(key);  
            Boolean access = f.getDescribe().isAccessible();
			try{
				if(access && key != 'ownerId'){
	                Object valueSource = source.get(key);
	                Object valueTarget = target.get(key);
	                
	                if(valueSource != valueTarget && valueSource != null){
	                	if ((valueTarget == false || valueTarget == true) && valueSource == null){
	                		target.put(key, valueTarget);
	                	}else{
	                		target.put(key, valueSource);
	                	}
	                }
	            }
            }catch(Exception ex){}  
        }
        SiteLog_controller.addMessage('ContactFieldsUtil', 'updateRecords', 'finish');
	}
	static testmethod void TestContactfields()
	{
		
		getAllFieldsString();
		contact con = new contact();
		ContactFieldsUtil.updateRecords(con,con) ;
		//updateRecords(0039000000IdSyy,0039000000JofJM);
	   
	}
}