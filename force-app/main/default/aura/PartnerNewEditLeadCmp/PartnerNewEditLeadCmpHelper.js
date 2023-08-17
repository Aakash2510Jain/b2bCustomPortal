({
	GetPicklistvalues : function(component, event, helper) {
        debugger;
		 var   action = component.get("c.GetPartnerLeadStatus");
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                var resultData = response.getReturnValue();
                var ParsedPicklistLists = JSON.parse(resultData);
                var tempstatusPickmap = [];
                var tempsourcePickmap = [];
                if(ParsedPicklistLists.Lead_Status.length >0){
                    for(var i=0; i<ParsedPicklistLists.Lead_Status.length; i++ ){
                        tempstatusPickmap.push({label:ParsedPicklistLists.Lead_Status[i], value : ParsedPicklistLists.Lead_Status[i] })
                    }
                    component.set("v.LeadStatusPickVal", tempstatusPickmap);
                }
                if(ParsedPicklistLists.Lead_Source.length >0){
                    for(var i=0; i<ParsedPicklistLists.Lead_Source.length; i++ ){
                        tempsourcePickmap.push({label:ParsedPicklistLists.Lead_Source[i], value : ParsedPicklistLists.Lead_Source[i] })
                    }
                    component.set("v.LeadSourcePickVal", tempsourcePickmap);
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
    getTimezone  : function(component, event, helper){
        debugger;
        var timezone =[
           { label: '(UTC+02:00) Jerusalem', value: '(UTC+02:00) Jerusalem' }, 
             { label: '(UTC+02:00) Beirut', value: '(UTC+02:00) Beirut' }, 
             { label: '(UTC-12:00) International Date Line West ', value: '(UTC-12:00) International Date Line West' },
             { label: '(UTC-09:00) Alaska', value: '(UTC-09:00) Alaska' }, 
             { label: '(UTC-11:00) Coordinated Universal Time-11', value: '(UTC-11:00) Coordinated Universal Time-11' }, 
             { label: '(UTC-10:00) Hawaii', value: '(UTC-10:00) Hawaii' }, 
             { label: '(UTC-08:00) Baja California', value: '(UTC-08:00) Baja California' }, 
             { label: '(UTC-08:00) Pacific Time (US and Canada)', value: '(UTC-07:00) Chihuahua, La Paz, Mazatlan' }, 
             { label: '(UTC-07:00) Arizona', value: '(UTC-07:00) Arizona' }, 
             { label: '(UTC-07:00) Mountain Time (US and Canada)', value: '(UTC-07:00) Mountain Time (US and Canada)' }, 
             { label: '(UTC-06:00) Central America', value: '(UTC-06:00) Central America' }, 
            
        ]
        
       component.set("v.LeadTimeZonePicklist",timezone); 
    }
})