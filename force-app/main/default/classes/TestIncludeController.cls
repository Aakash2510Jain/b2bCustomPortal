public without sharing class TestIncludeController {


    public PageReference init() {
        return null;
    }


    public testIncludeController () {
        pageName = 'LoginPage_view';
    }


    public PageReference open() {
        return null;
    }


    public String pageName { get; set; }
    
    static testMethod void test()
    {
        testIncludeController c = new testIncludeController();
        c.init();
        c.open();
        c.pageName = '2';
        String pageName = c.pageName;
    }

}