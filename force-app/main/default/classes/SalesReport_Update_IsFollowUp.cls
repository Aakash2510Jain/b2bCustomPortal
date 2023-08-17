public class SalesReport_Update_IsFollowUp{
 /* public void getBeforeLastMonthInfo(){
       date dt= date.today();  
       dt = dt-60;
       Date dt1 = dt.toStartOfMonth();
       integer noOfDays = date.daysInMonth(dt1.year(),dt1.month());
       Date dt2 = date.newInstance(dt1.year(),dt1.month(),noOfDays); 
       
       List<Task> beforeLastMonthTaskList = [select id, whoid from Task where CREATEDDATE >= :dt1 and CREATEDDATE <= :dt2 and whoid != null]; 
       List<Event> beforeLastMonthEventList = [select id, whoid from Event where CREATEDDATE >= :dt1 and CREATEDDATE <= :dt2 and whoid != null];
       Set<ID> beforeLastMonthActivitySetID = new Set<ID>();
       for(Task loopTask : beforeLastMonthTaskList ){
           beforeLastMonthActivitySetID.add(loopTask.whoid);
       }
       for(Event loopEvent : beforeLastMonthEventList){
           beforeLastMonthActivitySetID.add(loopEvent.whoid);
       }
       List<Lead> beforeLastMonthList = [select id, isFollowUp__c from Lead where ID IN : beforeLastMonthActivitySetID and isFollowUp__c=false limit 5000];
       if(beforeLastMonthList.size() > 0 ){
           for( Lead loopLead : beforeLastMonthList){
               loopLead.isFollowUp__c = true;
           }
           update beforeLastMonthList;
       }
   }
   
   public void getFebruaryMonthInfo(){
       date dt_Feb= date.today();  
       dt_Feb = dt_Feb-90;
       Date dt1_Feb = dt_Feb.toStartOfMonth();
       integer noOfDays_Feb = date.daysInMonth(dt1_Feb.year(),dt1_Feb.month());
       Date dt2_Feb = date.newInstance(dt1_Feb.year(),dt1_Feb.month(),noOfDays_Feb); 
       
       List<Task> beforeLastMonthTaskList_Feb = [select id, whoid from Task where CREATEDDATE >= :dt1_Feb and CREATEDDATE <= :dt2_Feb and whoid != null]; 
       List<Event> beforeLastMonthEventList_Feb = [select id, whoid from Event where CREATEDDATE >= :dt1_Feb and CREATEDDATE <= :dt2_Feb and whoid != null];
       Set<ID> beforeLastMonthActivitySetID_Feb = new Set<ID>();
       for(Task loopTask_Feb : beforeLastMonthTaskList_Feb ){
           beforeLastMonthActivitySetID_Feb.add(loopTask_Feb.whoid);
       }
       for(Event loopEvent_Feb : beforeLastMonthEventList_Feb){
           beforeLastMonthActivitySetID_Feb.add(loopEvent_Feb.whoid);
       }
       List<Lead> beforeLastMonthList_Feb = [select id, isFollowUp__c from Lead where ID IN : beforeLastMonthActivitySetID_Feb and isFollowUp__c=false limit 5000 ];
       if(beforeLastMonthList_Feb.size() > 0 ){
           for( Lead loopLead_Feb : beforeLastMonthList_Feb){
               loopLead_Feb.isFollowUp__c = true;
           }
           update beforeLastMonthList_Feb;
       }
   }
   
       public void getLastMonthInfo(){
       List<Task> lastMonthTaskList = [select id, whoid from Task where CREATEDDATE = last_month and whoid != null]; 
       List<Event> lastMonthEventList = [select id, whoid from Event where CREATEDDATE = last_month and whoid != null];
       Set<ID> lastMonthActivitySetID = new Set<ID>();
       for(Task loopTask : lastMonthTaskList ){
           lastMonthActivitySetID.add(loopTask.whoid);
       }
       for(Event loopEvent : lastMonthEventList){
           lastMonthActivitySetID.add(loopEvent.whoid);
       }
       List<Lead> lastMonthList = [select id, isFollowUp__c from Lead where ID IN : lastMonthActivitySetID and isFollowUp__c=false ];
       if(lastMonthList.size() > 0 ){
           for( Lead loopLead : lastMonthList){
               loopLead.isFollowUp__c = true;
           }
           update lastMonthList;
       }
   }
   
   public void getThisMonthInfo(){
       List<Task> currentMonthTaskList = [select id, whoid from Task where CREATEDDATE = this_month and whoid != null]; 
       List<Event> currentMonthEventList = [select id, whoid from Event where CREATEDDATE = this_month and whoid != null];
       Set<ID> currentMonthActivitySetID = new Set<ID>();
       for(Task loopTask : currentMonthTaskList ){
           currentMonthActivitySetID.add(loopTask.whoid);
       }
       for(Event loopEvent : currentMonthEventList){
           currentMonthActivitySetID.add(loopEvent.whoid);
       }
       List<Lead> currentMonthList = [select id, isFollowUp__c from Lead where ID IN : currentMonthActivitySetID and isFollowUp__c=false ];
       if(currentMonthList.size() > 0 ){
           for( Lead loopLead : currentMonthList){
               loopLead.isFollowUp__c = true;
           }
           update currentMonthList;
       }
   }
   
    public void getBeforeLastMonthInfo_Oppty(){
       date dt= date.today();  
       dt = dt-60;
       Date dt1 = dt.toStartOfMonth();
       integer noOfDays = date.daysInMonth(dt1.year(),dt1.month());
       Date dt2 = date.newInstance(dt1.year(),dt1.month(),noOfDays); 
     
       List<Task> beforeLastMonthTaskList = [select id, whatid from Task where CREATEDDATE >= :dt1 and CREATEDDATE <= :dt2 and whatid != null]; 
       List<Event> beforeLastMonthEventList = [select id, whatid from Event where CREATEDDATE >= :dt1 and CREATEDDATE <= :dt2 and whatid != null];
       Set<ID> beforeLastMonthActivitySetID = new Set<ID>();
       for(Task loopTask : beforeLastMonthTaskList ){
           beforeLastMonthActivitySetID.add(loopTask.whatid);
       }
       for(Event loopEvent : beforeLastMonthEventList){
           beforeLastMonthActivitySetID.add(loopEvent.whatid);
       }
       List<Opportunity> beforeLastMonthList = [select id, isFollowUp__c from Opportunity where ID IN : beforeLastMonthActivitySetID and isFollowUp__c=false limit 5000 ];
       if(beforeLastMonthList.size() > 0 ){
           for( Opportunity loopOpty : beforeLastMonthList){
               loopOpty.isFollowUp__c = true;
           }
           update beforeLastMonthList;
       }
   }
   
   public void getBeforeLastMonthInfo_Oppty_Feb(){
       date dt= date.today();  
       dt = dt-90;
       Date dt1 = dt.toStartOfMonth();
       integer noOfDays = date.daysInMonth(dt1.year(),dt1.month());
       Date dt2 = date.newInstance(dt1.year(),dt1.month(),noOfDays); 
     
       List<Task> beforeLastMonthTaskList = [select id, whatid from Task where CREATEDDATE >= :dt1 and CREATEDDATE <= :dt2 and whatid != null]; 
       List<Event> beforeLastMonthEventList = [select id, whatid from Event where CREATEDDATE >= :dt1 and CREATEDDATE <= :dt2 and whatid != null];
       Set<ID> beforeLastMonthActivitySetID = new Set<ID>();
       for(Task loopTask : beforeLastMonthTaskList ){
           beforeLastMonthActivitySetID.add(loopTask.whatid);
       }
       for(Event loopEvent : beforeLastMonthEventList){
           beforeLastMonthActivitySetID.add(loopEvent.whatid);
       }
       List<Opportunity> beforeLastMonthList_Feb = [select id, isFollowUp__c from Opportunity where ID IN : beforeLastMonthActivitySetID and isFollowUp__c=false limit 5000 ];
       if(beforeLastMonthList_Feb.size() > 0 ){
           for( Opportunity loopOpty : beforeLastMonthList_Feb){
               loopOpty.isFollowUp__c = true;
           }
           update beforeLastMonthList_Feb;
       }
   }
   
   public void getLastMonthInfo_Oppty(){
       List<Task> lastMonthTaskList = [select id, whatid from Task where CREATEDDATE = last_month and whatid != null]; 
       List<Event> lastMonthEventList = [select id, whatid from Event where CREATEDDATE = last_month and whatid != null];
       Set<ID> lastMonthActivitySetID = new Set<ID>();
       for(Task loopTask : lastMonthTaskList ){
           lastMonthActivitySetID.add(loopTask.whatid);
       }
       for(Event loopEvent : lastMonthEventList){
           lastMonthActivitySetID.add(loopEvent.whatid);
       }
       List<Opportunity> lastMonthList = [select id, isFollowUp__c from Opportunity where ID IN : lastMonthActivitySetID and isFollowUp__c=false ];
       if(lastMonthList.size() > 0 ){
           for( Opportunity loopOpty : lastMonthList){
               loopOpty.isFollowUp__c = true;
           }
           update lastMonthList;
       }
   }
   
   public void getCurrentMonthInfo_Oppty(){
       List<Task> currentMonthTaskList = [select id, whatid from Task where CREATEDDATE = this_month and whatid != null]; 
       List<Event> currentMonthEventList = [select id, whatid from Event where CREATEDDATE = this_month and whatid != null];
       Set<ID> currentMonthActivitySetID = new Set<ID>();
       for(Task loopTask : currentMonthTaskList ){
           currentMonthActivitySetID.add(loopTask.whatid);
       }
       for(Event loopEvent : currentMonthEventList){
           currentMonthActivitySetID.add(loopEvent.whatid);
       }
       List<Opportunity> currentMonthList = [select id, isFollowUp__c from Opportunity where ID IN : currentMonthActivitySetID and isFollowUp__c=false ];
       if(currentMonthList.size() > 0 ){
           for( Opportunity loopOpty : currentMonthList){
               loopOpty.isFollowUp__c = true;
           }
           update currentMonthList;
       }
   }*/
}