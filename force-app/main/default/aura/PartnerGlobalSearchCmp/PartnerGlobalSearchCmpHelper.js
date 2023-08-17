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
                // SOSL will always return the list in the order they were queried
                component.set("v.accountList",result[0]);
                component.set("v.contactList",result[1]);
                component.set("v.oppList",result[2]);
                component.set("v.leadList",result[3]);
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
    ShowGlobalSearchLists : function(component,searchInputtext){
        debugger;
        
        var result = component.get("v.GlobalSearchResult");
        component.set("v.accountList",result[0]);
                component.set("v.contactList",result[1]);
                component.set("v.oppList",result[2]);
                component.set("v.leadList",result[3]);
        if(result.length >0){
            component.set("v.showSearchResults", true);
        }
        
    }
    
})