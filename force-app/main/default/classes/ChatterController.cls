public class ChatterController {
	public List<chatterObject> result {get;set;}
	Map<Id,User> userRecords = new Map<Id,User>();
	public void init(){
		List<User> users= [Select Id, FirstName, SmallPhotoUrl,FullPhotoUrl,LastName, Name,UserName,IsActive from User];
		for(User record : users){
			userRecords.put(record.Id,record);
		}
		
		System.debug('*************************************');
		getSearchResult();
	}
	public ChatterController(){
		/*List<User> users= [Select Id, FirstName, LastName, Name,UserName,IsActive from User];
		for(User record : users){
			userRecords.put(record.Id,record);
		}
		System.debug('--------------------------------------');*/
	}
	
	/*
	public Pagereference performSearch(){
		result = new List<chatterObject>();
	 getSearchResult();
	 return null;
	}*/
	
	
	public void getSearchResult(){
		
		List<ChatterActivity> activities = [Select Id,ParentId,PostCount,CommentCount,
				CommentReceivedCount,LikeReceivedCount from ChatterActivity order by LikeReceivedCount desc limit 10];
		System.debug('Activities :'+activities);
		result = new List<chatterObject>();
		if(activities.size() > 0){
			for(ChatterActivity rec : activities){
				chatterObject record = new chatterObject();
				User userRec = userRecords.get(rec.ParentId);
				if(userRec != null){
					record.FullName=userRec.Name+'   ';
					record.FullPhoto = userRec.FullPhotoUrl;
					record.SmallPhoto = userRec.SmallPhotoUrl;
				}else{
					record.FullName='#';
				}
				record.Id = rec.Id;
				record.LikesReceived = rec.LikeReceivedCount;
				record.CommentReceived = rec.CommentReceivedCount;
				record.PostCount = rec.PostCount;				
				result.add(record);
			}
		}
	}
	
	class chatterObject {
		public String FullName{get;set;}
		public String Id{get;set;}
		public Integer LikesReceived{get;set;}
		public Integer PostCount{get;set;}
		public Integer CommentReceived{get;set;}
		public String FullPhoto{get;set;}
		public String SmallPhoto{get;set;}
	}
public static testmethod void chatterReport() {
    
    Profile p = [select id from profile where Name = 'System Administrator' limit 1];
        User pu = new User(profileId = p.id, username = 'aaskdgkagskdgasdbc@abc.com', email = 'aaskdgkagskdgasdbc@abc.com',
        emailencodingkey = 'UTF-8', localesidkey = 'en_US',
        languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
        alias='cspu', lastname='lastname');
        insert pu;
    
    FeedItem item = new FeedItem(
    parentId = pu.id, // where to post message
    createdById = pu.Id, // author to impersonate
    body = '#case is created from feed'
);

insert item;
		ChatterController contr = new ChatterController();
		contr.init();		
	}	
	// ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,'Please select Sample request or None'));  
}