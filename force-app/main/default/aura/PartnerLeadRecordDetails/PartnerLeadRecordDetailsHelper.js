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
                var tempindustyrPickmap = [];
                if(ParsedPicklistLists.Lead_Status.length >0){
                    for(var i=0; i<ParsedPicklistLists.Lead_Status.length; i++ ){
                        tempstatusPickmap.push({label:ParsedPicklistLists.Lead_Status[i], value : ParsedPicklistLists.Lead_Status[i] })
                    }
                    component.set("v.LeadStatusPickVal", tempstatusPickmap);
                }
                if(ParsedPicklistLists.Lead_Industry.length >0){
                    for(var i=0; i<ParsedPicklistLists.Lead_Industry.length; i++ ){
                        tempindustyrPickmap.push({label:ParsedPicklistLists.Lead_Industry[i], value : ParsedPicklistLists.Lead_Industry[i] })
                    }
                    component.set("v.LeadIndustryPickVal", tempindustyrPickmap);
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
    
    MarkasCompletedStatus:function(component, event){
        debugger;
        var leadRecStage=component.get("v.SelectedStage");
        var leadRecID=component.get("v.SelectecLeadRec.Id");
        var PartnerRecId=component.get("v.PartnerId");
        var action = component.get("c.updateLeadStatus");
        action.setParams({
            Statusvalue:leadRecStage,
            recordId:leadRecID,
            PartnerId: PartnerRecId
            
        });
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                var resultData = response.getReturnValue();
                //var SelectLdRec = component.get("v.SelectecLeadRec");
                //SelectLdRec.status = leadRecStage;
                //component.set("v.SelectecLeadRec",SelectLdRec);
                //alert("SUCCESS");
                //var cmpEvent = component.getEvent("AuraMessageEvent");
                //cmpEvent.setParams({"Message" : "Refresh Lead List"});
                //cmpEvent.fire();
                if(resultData.message == 'Lead Converted Successfully'){
                    component.set("v.ShowDeleteTransferLeadCmp", false);
                    component.set("v.ShowDeletePopup", false);
                    component.set("v.ShowNewEditLeadComp", false); 
                    component.set("v.leadDetailPage", false); 
                    component.set("v.ShowTransferPopup", false);
                    component.set("v.showlead", true);
                    
                    var appEvent = $A.get("e.c:AuraMessageAppEvent"); 
                    //Set event attribute value
                    appEvent.setParams({
                        "message" : resultData.message,
                        "SelectedRecords":SelectedLeads
                    }); 
                    appEvent.fire(); 
                }
                else if(resultData.message == 'Success'){
                     component.set("v.SelectecLeadRec",resultData.CompleteleadList[0]);
                }
               
            }
            else if (state === "INCOMPLETE") {
				alert("INCOMPLETE")  
            }
                else if (state === "ERROR") {
                    alert("ERROR")  
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
    }
})