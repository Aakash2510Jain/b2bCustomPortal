({
	getSearchResultsFromHandler : function(component,searchInputtext){   
        debugger;
            
        
        var action = component.get("c.getSearchRecords");
              action.setParams({ searchKey : searchInputtext });
         
        // callback that is executed after the server-side action returns
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var result = response.getReturnValue();
                component.set("v.GlobalSearchResult",result);
                if(result.length >0){
                    component.set("v.searchKey",searchInputtext);
                    component.set("v.showOnlyOndashboardbutton",false);
                    component.set("v.showPartnerdashboard",false);
                    component.set("v.showlead",false);
                    component.set("v.showfollowup",false);
                    component.set("v.showAccount",false);
                    component.set("v.showOpportunity",false);
                    component.set("v.showUserProfile",false);
                    component.set("v.showGlobalSearch",true);
                }
                // SOSL will always return the list in the order they were queried
            }
            else if (state === "INCOMPLETE") {
                // do something
            }
                else if (state === "ERROR") {
                    var errors = response.getError();
                    if (errors) {
                        if (errors[0] && errors[0].message) {
                            console.log("Error message: " +errors[0].message);
                        }
                    } 
                    else {
                        console.log("Unknown error");
                    }
                }
        });
        $A.enqueueAction(action);
    },
})