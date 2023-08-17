global without sharing class SiteLog_controller {
 
     private static string messages = '';

    global static void addMessage(String className, String methodName, String message)
    {
        String logMessage =
                'Class name: \'' + className +
             '\' Method name: \'' + methodName +
             '\' Message: \'' + message + '\'';

        System.debug(logMessage);

        messages += logMessage + '\r\n\r\n';
    }

    global static void catchBlockMethod(Exception e, String subject)
    {
        if (e instanceOf System.DmlException)
        {
            addMessage('Logger', 'catchBlockMethod', 'e.getDmlFieldNames(0)=' + e.getDmlFieldNames(0));
            addMessage('Logger', 'catchBlockMethod', 'e.getDmlFields(0)=' + e.getDmlFields(0));
            addMessage('Logger', 'catchBlockMethod', 'e.getDmlStatusCode(0)=' + e.getDmlStatusCode(0));
            addMessage('Logger', 'catchBlockMethod', 'e.getDmlMessage(0)=' + e.getDmlMessage(0));
            addMessage('Logger', 'catchBlockMethod', 'e.getDmlType(0)=' + e.getDmlType(0));
            addMessage('Logger', 'catchBlockMethod', 'e.getNumDml()=' + e.getNumDml());

            if(e.getDmlStatusCode(0) == 'FIELD_CUSTOM_VALIDATION_EXCEPTION')
            {
                addErrorMessage(e.getDmlMessage(0));
                return;
            }
        }

        addMessage('Logger', 'catchBlockMethod', 'e.getMessage()=' + e.getMessage());
        addMessage('Logger', 'catchBlockMethod','getCause()=' + e.getCause());
        addMessage('Logger', 'catchBlockMethod','getLineNumber()=' + e.getLineNumber());
        addMessage('Logger', 'catchBlockMethod','getStackTraceString()=' + e.getStackTraceString());
		addMessage('Logger', 'catchBlockMethod','getTypeName()=' + e.getTypeName());


        addErrorMessage(System.Label.An_error_has_occured_in_the_application_process);
        sendError(e.getMessage(), subject);
    }

    global static void addErrorMessage(String message)
    {
        ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, message);
        ApexPages.addMessage(msg);
    }
       
    global static void sendLog(String subject)
    {
        Boolean sendLog = (Boolean)SiteConfig_controller.GetConfigSetting('Send_Logs__c');
        if (sendLog != null && sendlog)
            sendError('Test Log', subject);
    }

    global static void sendError(String lastMessage, String subject)
    {
        if (Site.getName() != null)
        {
            messages =
                    'Organization: \'' + UserInfo.getOrganizationName() + '\'\r\n' +
                    'Site Name: \'' + Site.getName() + '\'\r\n' +
                    'Site Url: \'' + Site.getCurrentSiteUrl() + '\'\r\n' +
                    'Page Url: \'' + ApexPages.currentPage().getUrl() + '\'\r\n\r\n' +
                    messages;
        }
        else
        {
            messages =
                    'Organization: \'' + UserInfo.getOrganizationName() + '\'\r\n\r\n' +
                    messages;
        }

        String fullLog = messages + lastMessage;
		/*if(SiteConfig_controller.getConfigDataSet().ErrorsReceiver__c != null){
	        Messaging.SingleEmailMessage emailMessage = new Messaging.SingleEmailMessage();
	        emailMessage.setSubject(subject);
	        emailMessage.setPlainTextBody(fullLog);
	        emailMessage.setToAddresses(new List<String> {
	                SiteConfig_controller.getConfigDataSet().ErrorsReceiver__c });
	
	        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {emailMessage});
		}*/
        if (fullLog.length() > 31950)
            fullLog = fullLog.substring(fullLog.length() - 31950);

        insert new SiteLog__c(  
                Name__c = '' + DateTime.now(),
                Value__c = fullLog);
    }

    

}