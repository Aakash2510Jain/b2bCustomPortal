@isTest 
public class TestClass_RestrctCountRequest {
    
    static testmethod void myUnitTest_CountRequestRestriction(){
        
        Lead l= new Lead();
        l.Company='1';
        l.lastname='testclass';
        l.Status='Working';
        l.User_Name__c='frankb';
        l.Division_Name__c='Gladiators';
        insert l;
        try{
            Case CR= new Case();
            CR.Status='New';
            CR.Lead__c=l.Id;
            insert CR;
        }catch(Exception e){}
        
    }
}