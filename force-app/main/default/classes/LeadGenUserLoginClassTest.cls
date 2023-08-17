@isTest
public class LeadGenUserLoginClassTest {

    @isTest
    public static  void LoginFail()
	{
		LeadGenUserLoginClass  lgul= new LeadGenUserLoginClass ();
        
		lgul.checkLogin();
	}

 	@isTest
    public static  void LoginFailEmptyValeu()
	{
		LeadGenUserLoginClass  lgul= new LeadGenUserLoginClass ();
        lgul.userName='';
        lgul.password='';  
		lgul.checkLogin();
	}
    
    @isTest
	public static void loginPass()
	{
		 LeadGenUserLoginClass  lgul=new LeadGenUserLoginClass ();
         LeadFormUsers__c user = new LeadFormUsers__c();
      	user.UserName__c='test@test.com';
      	user.Password__c='passport';
      	insert user;
        lgul.userName='test@test.com';
        lgul.password='passport';    
		lgul.checkLogin();
	}
    
	}