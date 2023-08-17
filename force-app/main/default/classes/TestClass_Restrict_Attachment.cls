@IsTest
private class TestClass_Restrict_Attachment {
static testMethod void myUnitTest_Attachment(){
Attachment att=new Attachment();
/*
Profile userProfile = [select ID, name from profile where name ='BDSE'];
User u=[select Id, IsActive from User where Profile.name =: userProfile.name limit 1];
if(! u.IsActive){
u.IsActive = true;
update u;
}
*/
Profile userProfile = [select ID, name from profile where name ='BDSE'];
User u = new User(
    alias = 'stUser', 
    email='testuser@test.com',
    emailencodingkey='UTF-8',
    firstname='USER',
    lastname='TEST',
    languagelocalekey='en_US',
    localesidkey='en_US', 
    profileid = userProfile.Id,
    timezonesidkey='America/Los_Angeles',
    username='site_test123@trmp.com'
);
insert u;
system.debug('################UserName is'+u.firstname);
system.runas(u){
try{

system.debug('%%%%%%%UserName is%%%%%%'+u.lastname);
Sample_Request__c SR=new Sample_Request__c();
SR.OwnerId=u.Id;
SR.Name='TEST SAMPLE';
SR.Sample_Type__c='Website';
SR.Status__c = 'New';
Insert SR;

att.Name='TEST Attachment';
 string str='testtesttest';
 Blob blbVal = Blob.valueof(str);
 Att.Body=blbVal ;
att.ParentId=SR.Id;
Insert att;
system.debug('&&&&&&& Ataachment name is &&&&&&'+att.Name);
delete att;

}
  catch (exception e){
system.debug('If error occurs while delete operation');
        }              
    }
  } 


static testMethod void myUnitTest_Notes(){
Note n=new Note();
/*
Profile userProfile = [select ID, name from profile where name ='BDSE'];
User u=[select Id, IsActive from User where Profile.name =: userProfile.name limit 1];
if(! u.IsActive){
u.IsActive = true;
update u;
}
*/
Profile userProfile = [select ID, name from profile where name ='BDSE'];
User u = new User(
    alias = 'stUser', 
    email='testuser@test.com',
    emailencodingkey='UTF-8',
    firstname='USER',
    lastname='TEST',
    languagelocalekey='en_US',
    localesidkey='en_US', 
    profileid = userProfile.Id,
    timezonesidkey='America/Los_Angeles',
    username='site_test123@trmp.com'
);
insert u;
system.debug('################UserName is'+u.firstname);
system.runas(u){
try{

system.debug('%%%%%%%UserName is%%%%%%'+u.lastname);

Sample_Request__c SR1=new Sample_Request__c();
SR1.OwnerId=u.Id;
SR1.Name='TEST SAMPLE123';
SR1.Sample_Type__c='Website';
SR1.Status__c = 'New';
Insert SR1;

n.Title='TEST';
n.Body='TESTESTESTES';
n.ParentId=SR1.Id;
insert n;
system.debug('$$$$$$ Notes name is $$$$$$'+n.Title);
delete n;

}
  catch (exception e){
system.debug('If error occurs while delete operation');
        }              
    }
  }  
}