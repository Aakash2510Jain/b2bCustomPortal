({
	  GetPicklistvalues : function(component, event, helper) {
        debugger;
        var   action = component.get("c.GetOpprtunityStagePicklist");
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                var resultData = response.getReturnValue();
                var ParsedPicklistLists = JSON.parse(resultData);
                var tempstagePickmap = [];
                if(ParsedPicklistLists.Lead_Status.length >0){
                    for(var i=0; i<ParsedPicklistLists.Lead_Status.length; i++ ){
                        tempstagePickmap.push({label:ParsedPicklistLists.Lead_Status[i], value : ParsedPicklistLists.Lead_Status[i] })
                    }
                    component.set("v.OppLeadPickVal", tempstagePickmap);
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
            }
        });
        $A.enqueueAction(action); 
      }
})