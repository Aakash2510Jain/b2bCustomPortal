({
    doInit : function(component, event, helper) {
        debugger;        
        component.set("v.showOnlyOndashboardbutton",true);
        component.set("v.hideDashboardforLeadButton",true);
        var partnerId = component.get("v.recordId");
        const queryString = window.location.search;
        var userid = queryString.split("&id=").pop();	
        var action = component.get("c.getUserRecord");
        var currentDate = new Date();
        // var options = { weekday: 'long',month:'short',year:'numeric',date:'new Date()' };
        // var formattedDate = today.toLocaleDateString(undefined, options);
        
        var daysOfWeek = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
        var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
        
        // Extract the day of the week, day of the month, month, and year
        var dayOfWeek = daysOfWeek[currentDate.getDay()];
        var dayOfMonth = currentDate.getDate();
        var month = months[currentDate.getMonth()];
        var year = currentDate.getFullYear();
        
        // Format the date string
        var formattedDate = `${dayOfWeek}, ${dayOfMonth} ${month} ${year}`;
        
        component.set("v.showdate",formattedDate);
        action.setParams({
            "currentuserid" : userid  
        });
        
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                component.set("v.showPartnerdashboard",true);
                component.set("v.showUserProfile",false);
                
                var data = response.getReturnValue();
                component.set("v.userRecord",data);
                if(data!=null){
                    var recid = data.Id;
                    component.set("v.recordid",recid);
                }
            }
        }); 
        $A.enqueueAction(action);   
    },
    
    userLogout : function(component, event, helper){
        debugger;
       
        const queryString = window.location.search;
        var currentuserid = queryString.split("&id=").pop();	
        var action = component.get("c.logOutUserByHashCode");
         component.set("v.showSpinner", true);
        action.setParams({
            "userid" : currentuserid  
        });
        
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                component.set("v.showSpinner", false);
                var hrefString =  "https://b2bdatapartners--uat.sandbox.my.salesforce-sites.com/Portal";
               window.history.pushState(null, null, hrefString);
                
                window.onpopstate = function() {
                    //window.history.go(1);
                    window.history.forward();
                };
                 window.history.go(1);
                window.location.href = "https://b2bdatapartners--uat.sandbox.my.salesforce-sites.com/Portal";
               // window.history.pushState(null, null, window.location.href);
            }
        }); 
        $A.enqueueAction(action);   
    },
    showUserProfile :function(component, event, helper){
        debugger;
        
        var clickedElement = event.currentTarget;
        var titleValue = clickedElement.getAttribute("title");
         component.set("v.BackgroundClass", 'B');
        component.set("v.showSpinner",true);
        component.set("v.showUserProfile",true);
        component.set("v.show2ndProfileButton",true);
        component.set("v.show1stProfileButton",false);
        component.set("v.showPartnerdashboard",false);
        component.set("v.showOnlyOndashboardbutton",false);
        component.set("v.showlead",false);
        component.set("v.showfollowup",false);
        component.set("v.showAccount",false);
        component.set("v.showOpportunity",false);
        component.set("v.showIncentive",false);
        component.set("v.hideDashboardforLeadButton",false);
        component.set("v.showGlobalSearch",false);
        const queryString = window.location.search;
        var partnerid = queryString.split("&id=").pop();
        component.set("v.partneruserid",partnerid);
        // var button = event.getSource();
        // var dashboardname = button.get("v.title");
        component.set("v.headerName",titleValue);
        var action = component.get("c.fetchUserProfileRecord");
        action.setParams({
            "userid" : partnerid
        });
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                component.set("v.showSpinner",false);
                var data = response.getReturnValue();
                component.set("v.UserProfileRecord",data);
            }
            
        });
        $A.enqueueAction(action); 
    },
    hideUserProfile :function(component, event, helper){
        debugger;
        var clickedElement = event.currentTarget;
        var titleValue = clickedElement.getAttribute("title");
        component.set("v.headerName",'Dashboard');
         component.set("v.BackgroundClass", 'A');
        component.set("v.showUserProfile",false);
        component.set("v.show2ndProfileButton",false);
        component.set("v.show1stProfileButton",true);
        component.set("v.showPartnerdashboard",true);
    },
    onHobverShowNotification :function(component, event, helper){
        debugger;
        
        component.set("v.showNotification",true);  
        const queryString = window.location.search;
        var partnerid = queryString.split("&id=").pop();
        var action = component.get("c.getLeadTask");
        action.setParams({
            "userPortalid" : partnerid
        });
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                var data = response.getReturnValue();
                component.set("v.notificationList",data);
            }
        });
        $A.enqueueAction(action); 
    },
    closeModel :function(component, event, helper){
        component.set("v.showNotification",false);  
    },
    ShowDashboard :function(component, event, helper){
        debugger;
        
        var button = event.getSource();
        var dashboardname = button.get("v.label");
         component.set("v.BackgroundClass", 'A');
        component.set("v.headerName",dashboardname);
        component.set("v.showlead",false);
        component.set("v.showfollowup",false);
        component.set("v.showAccount",false);
        component.set("v.showOpportunity",false);
        component.set("v.showIncentive",false);
        component.set("v.hideDashboardforLeadButton",true);
        component.set("v.showUserProfile",false);
        component.set("v.showOnlyOndashboardbutton",true);
        component.set("v.showGlobalSearch",false);
        component.set("v.showPartnerdashboard",true);
        
        
    },
    ShowLeadRecord :function(component, event, helper){
        debugger;
        var button = event.getSource();
        var leadname = button.get("v.label");
        
        component.set("v.headerName",leadname);
        component.set("v.showOnlyOndashboardbutton",false);
         component.set("v.BackgroundClass", 'B');
        component.set("v.showPartnerdashboard",false);
        component.set("v.showfollowup",false);
        component.set("v.showAccount",false);
        component.set("v.showOpportunity",false);
        component.set("v.showIncentive",false);
        component.set("v.hideDashboardforLeadButton",false);
        component.set("v.showUserProfile",false);
        component.set("v.showGlobalSearch",false);
        component.set("v.showlead",true);
        var LeadCmp=component.get("v.showlead");
        if(LeadCmp==true){ 
            /*var appEvent = $A.get("e.c:SampleApplicationEvent"); 
            //Set event attribute value
            appEvent.setParams({"message" : "Show Child Lead Page"}); 
            appEvent.fire(); */
        } 
    },
    ShowFollowUp :function(component, event, helper){
        debugger;
        var button = event.getSource();
        var followup = button.get("v.label");
         component.set("v.BackgroundClass", 'B');
        component.set("v.headerName",followup);
        component.set("v.showOnlyOndashboardbutton",false);
        component.set("v.showPartnerdashboard",false);
        component.set("v.showlead",false);
        component.set("v.showAccount",false);
        component.set("v.showOpportunity",false);
        component.set("v.showIncentive",false);
        component.set("v.showUserProfile",false);
        component.set("v.showGlobalSearch",false);
        component.set("v.showfollowup",true);
    },
    ShowAccountRec :function(component, event, helper){
        debugger;
        var button = event.getSource();
        var accname = button.get("v.label");
         component.set("v.BackgroundClass", 'B');
        component.set("v.headerName",accname);
        component.set("v.showOnlyOndashboardbutton",false);
        component.set("v.showPartnerdashboard",false);
        component.set("v.showfollowup",false);
        component.set("v.showOpportunity",false);
        component.set("v.showIncentive",false);
        component.set("v.showUserProfile",false);
        component.set("v.showlead",false);
        component.set("v.showGlobalSearch",false);
        component.set("v.showAccount",true);
    },
    ShowOpportunity :function(component, event, helper){
        debugger;
        var button = event.getSource();
        var oppname = button.get("v.label");
         component.set("v.BackgroundClass", 'B');
        component.set("v.headerName",oppname);
        component.set("v.showOnlyOndashboardbutton",false);
        component.set("v.showPartnerdashboard",false);
        component.set("v.showlead",false);
        component.set("v.showfollowup",false);
        component.set("v.showAccount",false);
        component.set("v.showIncentive",false);
        component.set("v.showUserProfile",false);
        component.set("v.showGlobalSearch",false);
        component.set("v.showOpportunity",true);
    },
    showIncentiveRec :function(component, event, helper){
        debugger;
        var button = event.getSource();
        var incentiveName = button.get("v.label");
         component.set("v.BackgroundClass", 'B');
        component.set("v.headerName",incentiveName);
        component.set("v.showOnlyOndashboardbutton",false);
        component.set("v.showPartnerdashboard",false);
        component.set("v.showlead",false);
        component.set("v.showfollowup",false);
        component.set("v.showAccount",false);
        component.set("v.showOpportunity",false);
        component.set("v.showUserProfile",false);
        component.set("v.showGlobalSearch",false);
        component.set("v.showIncentive",true);
        
    },
    EditUserProfile: function(component, event, helper) {
        debugger;
        var cl =component.get("v.userClass");
        var cl2 = 'chnageInput';
        component.set("v.userClass", cl2);
        component.set("v.isFieldDisabled", false);
        component.set("v.showButtonFooter", true); 
        
        
    },
    handlePasswordChange : function(component, event, helper) {
        debugger;
        // Retrieve the password input field using the aura:id
        var passwordField = component.find("passwordField");
        
        // Get the current value of the password field
        var password = passwordField.get("v.value");
        
        // Convert the password to a star-marked format
        //var maskedPassword = "*".repeat(password.length);
        
        // Set the masked password value back to the input field
        passwordField.set("v.UserProfileRecord.Password__c", password);
    },
    
    UpdateUserProfileDetail: function(component, event, helper) {
        // Perform save logic
        component.set("v.showSpinner",true);   
        var action = component.get("c.UpdateUserProfile");
        var profileRec = component.get("v.UserProfileRecord");
        action.setParams({
            "useRec" : profileRec
        });
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                // alert('Your Profile record has been Updated');
                component.set("v.showSpinner",false); 
                component.set("v.isFieldDisabled", true); 
                component.set("v.showButtonFooter", false);
                  component.set("v.userClass", "no-border-input");
            }
            
        });
        $A.enqueueAction(action); 
    },
    
    cancelHandle: function(component, event, helper) {
        component.set("v.isFieldDisabled", true); 
        component.set("v.showButtonFooter", false);
          component.set("v.userClass", "no-border-input");
    },
    component2Event : function(component, event) { 
        debugger;
        //Get the event message attribute
        var message = event.getParam("message"); 
        //Set the handler attributes based on event data 
        if(message == 'Open Lead List Page'){
            var button = event.getSource();
            var leadname = button.get("v.label");
            component.set("v.headerName",leadname);
            component.set("v.showOnlyOndashboardbutton",false);
            
            component.set("v.showPartnerdashboard",false);
            component.set("v.showfollowup",false);
            component.set("v.showAccount",false);
            component.set("v.showOpportunity",false);
            component.set("v.showIncentive",false);
            component.set("v.hideDashboardforLeadButton",false);
            component.set("v.showUserProfile",false);
            component.set("v.showlead",true);
            
        }
        //cmp.set("v.eventMessage", message + 'Biswajeet');         
    },
    handleKeyPress : function(component, event, helper) {
        debugger;
        if (event.which === 13) {
            var searchInputtext = component.find('searchInput').get("v.value");
            helper.getSearchResultsFromHandler(component, searchInputtext);
        }
    },
    myFunction : function(component, event, helper) {
        debugger;
        var showPassword = component.get("v.showPassword");
        component.set("v.showPassword", !showPassword);
    }
    
})