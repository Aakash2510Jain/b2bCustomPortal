({
	GetPicklistvalues : function(component, event, helper) {
        debugger;
		 var   action = component.get("c.GetTaskPicklists");
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                var resultData = response.getReturnValue();
                var ParsedPicklistLists = JSON.parse(resultData);
                var tempstatusPickmap = [];
                var tempsourcePickmap = [];
                var tempPriorityPickmap = [];
                if(ParsedPicklistLists.Task_Status.length >0){
                    for(var i=0; i<ParsedPicklistLists.Task_Status.length; i++ ){
                        tempstatusPickmap.push({label:ParsedPicklistLists.Task_Status[i], value : ParsedPicklistLists.Task_Status[i] })
                    }
                    component.set("v.TaskStatusPickVal", tempstatusPickmap);
                }
                if(ParsedPicklistLists.Task_Subject.length >0){
                    for(var i=0; i<ParsedPicklistLists.Task_Subject.length; i++ ){
                        tempsourcePickmap.push({label:ParsedPicklistLists.Task_Subject[i], value : ParsedPicklistLists.Task_Subject[i] })
                    }
                    component.set("v.TaskSubjectPickVal", tempsourcePickmap);
                }
                if(ParsedPicklistLists.Task_Priority.length >0){
                    for(var i=0; i<ParsedPicklistLists.Task_Priority.length; i++ ){
                        tempPriorityPickmap.push({label:ParsedPicklistLists.Task_Priority[i], value : ParsedPicklistLists.Task_Priority[i] })
                    }
                    component.set("v.TaskPriorityPicklist", tempPriorityPickmap);
                }
                
            }
            else if (state === "INCOMPLETE") {
                // do something
            }
            else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + 
                                 errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
         $A.enqueueAction(action); 
	},
})