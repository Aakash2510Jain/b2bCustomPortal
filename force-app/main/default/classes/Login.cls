global without sharing class Login {


   /*sathya
    global static Id getLoggedInContact() {	
        SiteLog_controller.addMessage('Login', 'getLoggedInContact', '');

        String sessionId = ApexPages.currentPage().getParameters().get('sessionId');

        SiteLog_controller.addMessage('Login', 'getLoggedInContact', 'sessionId=' + sessionId);

        if (sessionId != null && sessionId.length() > 0) {
            SiteLog_controller.addMessage('Login', 'getLoggedInContact', 'sessionId found');

            List<Session__c> sessionList = [
                    SELECT Session_For__c, CurrentDateTime__c, LastModifiedDate
                    FROM Session__c
                    WHERE Is_Valid__c = true
                      AND SessionId__c = :sessionId];

            SiteLog_controller.addMessage('Login', 'getLoggedInContact', 'sessionList=' + sessionList);

            if (sessionList.size() > 0) {
                Session__c session = sessionList[0];

                Integer hoursFromLastLogin =
                        session.CurrentDateTime__c.hour() - session.LastModifiedDate.hour();

                SiteLog_controller.addMessage('Login', 'getLoggedInContact', 'hoursFromLastLogin=' + hoursFromLastLogin);

                if (hoursFromLastLogin > 0 && hoursFromLastLogin < SiteConfig_controller.getConfigDataSet().SessionTimeout__c) {
                    List<Contact> contactIdList = [
                            SELECT Id
                            FROM Contact
                            WHERE ID = :session.Session_For__c];

                    SiteLog_controller.addMessage('Login', 'getLoggedInContact', 'contactIdList=' + contactIdList);

                    if (contactIdList.size()>0) {
                        return contactIdList[0].Id;
                    }
                }
            }
        }

        SiteLog_controller.addMessage('Login', 'getLoggedInContact', 'return null');

        return null;
    }*/

    public static String getUserAgent()
    {
        Map<String,String> headerMap = System.currentPageReference().getHeaders();

        SiteLog_controller.addMessage('Login', 'getUserAgent', 'headerMap=' + headerMap);

        String userAgent = headerMap.get('User-Agent');
        if(userAgent != null && userAgent.trim().length() > 255)
            userAgent = userAgent.trim().substring(0, 254);

        SiteLog_controller.addMessage('Login', 'getUserAgent', 'userAgent=' + userAgent);

        return userAgent;
    }

    public static String getIP()
    {
        Map<String,String> headerMap = System.currentPageReference().getHeaders();

        SiteLog_controller.addMessage('Login', 'getIP', 'headerMap=' + headerMap);

        String ip = headerMap.get('X-Salesforce-SIP');

        SiteLog_controller.addMessage('Login', 'getIP', 'ip=' + ip);

        return ip;
    }

    private static testmethod void tstLogin()
    {
        String sessionId = '94369116479407'; //62486944141904
        ApexPages.currentPage().getParameters().put('sessionId', sessionId);
        Map<String,String> headerMap = System.currentPageReference().getHeaders();

        /* s Contact candidate = new Contact(
                LastName = 'ContactName name',
                Email = 'test@mailinator.com');
        insert candidate; */

        Session__c session = new Session__c(
                Is_Valid__c = true,
                IP_Address__c = headerMap.get('X-Salesforce-SIP'),
                //Session_For__c = candidate.Id,
                User_Agent__c = headerMap.get('User-Agent'),
                SessionId__c = sessionId);
        insert session;

        List<Session__c> sessionList = new List<Session__c>();
        sessionList.add(session);

        Login login = new Login();

        Test.startTest();
        //Id contactId = GetLoggedInContact();
        Test.stopTest();
    }

}