global class SiteConfig_controller {
// Used to get values from Config object 
// CustomSettingsComponent changed to CMSSettings by sathya
 
    global static CMSSettings__c getConfigDataSet()
    {
    	//system.debug('&&&&&&&&&&&' +CustomSettingsComponent__c.getValues(System.Label.Default));
    	system.debug('&&&&&&&&&&&' +CMSSettings__c.getValues(System.Label.Default));
        return CMSSettings__c.getValues(System.Label.Default);
    }
    
    // Gets config record by config name.  
    public static Object getConfigSetting(String configName)
    {
    	System.debug('CONFIGNAME:'+configName);
        CMSSettings__c config = getConfigDataSet();
        System.debug('CONFIG GOT : '+config);
        return (config != null) ? config.get(configName) : null;        
    }
    
    public static void setConfigSetting(String configName, Object value)
    {
    	System.debug('Config Name:'+configName +' --- having value of ---- :'+value);
        CMSSettings__c config = getConfigDataSet();
        System.debug('**********ConfigDataSet : '+config);
        if (config == null)
        {
            config = setConfigDataSet(configName, value); 
        }
        else
        {   
            config.put(configName, value);
            update config;
        }
    }
    
    private static CMSSettings__c setConfigDataSet(String configName, Object value)
    {
        CMSSettings__c config = new CMSSettings__c(Name = System.Label.Default);
        config.put(configName,value);
        insert config;
        
        return config;
    }
    
  
  
}