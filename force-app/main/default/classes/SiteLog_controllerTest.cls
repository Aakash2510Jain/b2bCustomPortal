@isTest(seealldata=true)
global  class  SiteLog_controllerTest {
	
	static testMethod void testRest() {
	SiteLog_controller.addErrorMessage('Error');
	SiteLog_controller.addMessage('TestClass','MyMethod', 'Error');
	SiteLog_controller.sendError('Test', 'errorLog');
	SiteLog_controller.sendLog('Test');
	Contact currentContact1 = new Contact();
	
	try{
		
		if(Test.isRunningTest()) {
        // Cause DMLException
        insert new Contact();
    }
	
	 } catch (Exception e) {
            SiteLog_controller.catchBlockMethod(e, 'test');
        }
	//DMLException  e = new Exception();
	//e.getMessage();
	//e.setMessage('DMLException');
//	SiteLog_controller.catchBlockMethod(e, 'test');
	

	}
}