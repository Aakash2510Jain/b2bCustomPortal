({
	doinit : function(component, event, helper) {
        debugger;
        helper.fetchPicklistVal(component, event, helper);
         const queryString = window.location.search;
         helper.getNewLeadFollowUpTaskRecords(component, event, helper,null,null);
         helper.getNewOppFollowUpTaskRecords(component, event, helper,null,null);

       /* var userid = queryString.split("&id=").pop();
        component.set("v.PartnerId",userid);
        var partnerIdforapex = component.get("v.PartnerId");
        var   action = component.get("c.GetPartnerFollowUpActivities");
        action.setParams({
          "PartnerId" :userid
        });
        action.setCallback(this,function(response){
            var state = response.getState();
            var Opptemparray = [];
            if(state === "SUCCESS"){
               var resultData = response.getReturnValue();
               var ParsedFollowUpWrapdata = JSON.parse(resultData);
                if(ParsedFollowUpWrapdata.OpptaskList != null && ParsedFollowUpWrapdata.OpptaskList != '' && ParsedFollowUpWrapdata.OpptaskList != undefined){
                     component.set("v.CompleteOppTaskList", ParsedFollowUpWrapdata.OpptaskList);
                    component.set("v.NodatalistAvailableforOpp",false);
                } else{
                    component.set("v.NodatalistAvailableforOpp",true);
                }
                if(ParsedFollowUpWrapdata.LeadTaskList != null && ParsedFollowUpWrapdata.LeadTaskList != '' && ParsedFollowUpWrapdata.LeadTaskList != undefined){
                     component.set("v.CompleteLeadTaskList", ParsedFollowUpWrapdata.LeadTaskList);
                     component.set("v.NodatalistAvailable",false);
                }else{
                    component.set("v.NodatalistAvailable",true);
                }
                
               
               
                //if (Accounttemparray.length >0) {
                    //component.set("v.showleadPagination", true);
                //}
             /*}
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
         $A.enqueueAction(action);  */
		/*var  action = component.get("c.getFollowuPTaskOnLead");
         action.setParams({
          "userPortalid" :userid
        });
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                var data = response.getReturnValue();
                if(data != null){
                   component.set("v.CompleteLeadTaskList", data); 
                }
            }
            
        });
        $A.enqueueAction(action); */
	},
    
        mainDivClick : function(component, event, helper) {
        component.set("v.showdropdown", false);
    },
    
    
    validateStartDate : function(component, event, helper){
        debugger;
        component.set("v.isDateEnabled", true); 
        helper.validateStartDate(component, event, helper);
    },
    validateEndDate : function(component, event, helper){
        debugger;
        helper.validateEndDate(component, event, helper);
    },
    
        validateOppStartDate : function(component, event, helper){
        debugger;
        component.set("v.isDateEnabled", true); 
        helper.validateOppStartDate(component, event, helper);
    },
    validateOppEndDate : function(component, event, helper){
        debugger;
        helper.validateOppEndDate(component, event, helper);
    },
    
    showFilterMenu : function(component, event, helper){
        debugger;
        var state = component.get('v.showdropdown');
        if(state == "true"){
          component.set('v.showdropdown', 'false');
        }if(state == "false"){
        component.set('v.showdropdown', 'true');
        }
        if(state == true){
          component.set('v.showdropdown', 'false');  
        }if(state == false){
        component.set('v.showdropdown', 'true');
        }
    },
    
    selectLeadTab : function(component, event, helper){
        debugger;
        var cmpLead = component.find('selectLead');
        $A.util.addClass(cmpLead, 'selectLeadActive');
        var cmpOpp = component.find('selectOpp');
        $A.util.removeClass(cmpOpp, 'selectOppActive');
        component.set('v.isLeadSelected', true);
        component.set('v.isOppSelected', false);
    },
    
    selectOppTab : function(component, event, helper){
        debugger;
        var cmpLead = component.find('selectLead');
        $A.util.removeClass(cmpLead, 'selectLeadActive');
        var cmpOpp = component.find('selectOpp');
        $A.util.addClass(cmpOpp, 'selectOppActive');
        component.set('v.isLeadSelected', false);
        component.set('v.isOppSelected', true);
    },
    getNewLeadTaskRecords:function(component, event, helper){
       debugger;
        var startDate = component.get('v.startDate');
        var endDate = component.get('v.endDate');
        helper.getNewLeadFollowUpTaskRecords(component, event, helper,startDate,endDate);
    },
    getNewOppTaskRecords:function(component, event, helper){
        debugger;
        var startDate = component.get('v.startDateOpp');
        var endDate = component.get('v.endDateOpp');
        helper.getNewOppFollowUpTaskRecords(component, event, helper,startDate,endDate);
    },
    handleSelectChangeLeadStatus:function(component, event, helper){
        debugger;
       

    }
    
})