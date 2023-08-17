({
    doinit : function(component, event, helper) {
        debugger;
        var partnerId = component.get('v.partnerId');
        var leadRecStage=component.get("v.SelectecLeadRec.Status");
        component.set("v.SelectedStage",leadRecStage);
        helper.GetPicklistvalues(component, event);
    },
    
    CreateNewTask : function(component, event, helper){
       debugger;
        component.set("v.ShowNewEditTaskComp", true);
        //component.set("v.ShowEditLead", false);
        component.set("v.ShowNewTask", true);  
    },
    
    
    statusOnclick:function(component, event, helper){
        debugger;
        var getselectedStep = component.get("v.SelectedStage");
        alert(getselectedStep);
        
    },
    
    handleStepSelect: function(component, event, helper) {
        debugger;
        var selectedStep = event.getSource().get("v.value");
        var SelectLdRec =component.get("v.SelectecLeadRec"); 
        //console.log("Selected Step: " + selectedStep);
      //  alert(selectedStep);
        component.set("v.SelectedStage",selectedStep);
        
    },
    MarkLeadStatus: function(component, event, helper) {
        debugger;
        helper.MarkasCompletedStatus(component);
    },
    
    save:function(component, event, helper){
        debugger;
        var action = component.get("c.UpdateLeadRec");
        var EdittedLeadrec = component.get("v.SelectecLeadRec");
        delete EdittedLeadrec.Address;
        delete EdittedLeadrec.CreatedDate;
        delete EdittedLeadrec.IsConverted;
        delete EdittedLeadrec.ischecked;
        delete EdittedLeadrec.LastModifiedDate;
        delete EdittedLeadrec.Lead_Number__c;
        delete EdittedLeadrec.pi__Needs_Score_Synced__c;
        delete EdittedLeadrec.pi__pardot_hard_bounced__c;
        delete EdittedLeadrec.Lead_Age__c;
        delete EdittedLeadrec.Owner;
        
        action.setParams({ LeadRec : EdittedLeadrec });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                alert("From server: " + response.getReturnValue());
                var cmpEvent = component.getEvent("AuraMessageEvent");
                cmpEvent.setParams({"Message" : "Refresh Lead List"});
                cmpEvent.fire();
            }
            else if (state === "INCOMPLETE") {
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
    
    Editable:function(component, event, helper){
        debugger;
        component.set("v.EditRecord",true);
        component.set("v.isButtonEdit",false);
        component.set("v.AllowEdit",false);
        
    },
    DeletetransferLead: function (component, event, helper) {
        debugger;
        
        var leadlist =[];
        var allSelectedLead = component.get("v.SelectecLeadRec");
        if(allSelectedLead != null){
            leadlist.push(allSelectedLead);
        }
        component.set("v.LeadsTobeProcessed", leadlist);
        console.log('selectedLead records ', allSelectedLead);
        var whichBtn = event.getSource().get("v.name");
        if (leadlist.length > 0) {
            if (whichBtn == 'Delete') {
                component.set("v.ShowDeleteTransferLeadCmp", true);
                component.set("v.ShowDeletePopup", true);
                component.set("v.ShowTransferPopup", false);
                
            }
            if (whichBtn == 'Transfer') {
                component.set("v.ShowDeleteTransferLeadCmp", true);
                component.set("v.ShowDeletePopup", false);
                component.set("v.ShowTransferPopup", true);
            }
        }
        else {
            
        }
    },
    Delete:function(component, event, helper){
        debugger;
        var action = component.get("c.deleteExistingLeadRec");
        var leadRec = component.get("v.SelectecLeadRec");
        var leadId = leadRec.Id;
        action.setParams({
            "recordId":leadId
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS"){
                alert('delete succesfully');
            }else{
                
            }
        });
        $A.enqueueAction(action);
    },
    Transfer:function(component, event, helper){
        debugger;
        component.set("v.ShowDeleteTransferLeadCmp",true);
    },
    
    cancel:function(component, event, helper){
        component.set("v.EditRecord",false);
        component.set("v.isButtonEdit",true);
        component.set("v.AllowEdit",true);
    }
})