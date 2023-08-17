public class openleads_allowed_ctrl{
    public User u{get;set;}    
    public openleads_allowed_ctrl()
    {
        u=new User();
    }
    
    public pagereference save()    { 
    pagereference pr;
         List <User> ulist=[select id,Name,Open_Leads_Allowed__c,Open_Opportunities_Allowed__c,No_of_days_since_Lead_Created__c from User where Rollup_should_hapen__c=true];
         for(user u1 : ulist){
          u1.Open_Leads_Allowed__c=u.Open_Leads_Allowed__c;
          u1.Open_Opportunities_Allowed__c=u.Open_Opportunities_Allowed__c;
          u1.No_of_days_since_Lead_Created__c=u.No_of_days_since_Lead_Created__c;
          }                        
        if(ulist.size() > 0)
         Update ulist;                  
         pr=new pagereference('/home/home.jsp');                  
         pr.setredirect(true); 
         return pr;             
  }// End of save() method
  }