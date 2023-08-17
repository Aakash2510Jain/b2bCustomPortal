({
    doInit: function (component, event, helper) {
        debugger;
         var SelectedLeads=component.get("v.LeadsTobeProcessed");
        var tempLeadlist =[];
          for (var i = 0; i < SelectedLeads.length; i++) {
            var recordId = SelectedLeads[i].Id; 
            tempLeadlist.push(recordId);
        }
         if(tempLeadlist.length>0){
             component.set("v.LeadTobeProcessedSize",tempLeadlist.length); 
         }
        var action = component.get("c.getUserbyGroup");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS"){
                debugger;
                var resultData = response.getReturnValue();
                component.set("v.responseWrapper",resultData);
                console.log('Group--'+JSON.stringify(resultData.Groups));
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
     handleCompanyOnChange: function (component, event, helper){
        debugger;
        var selectedName= component.find('Selected').get('v.name');
        if(selectedName =='groupSelect'){
            var selectedValue= component.find('Selected').get('v.value');
            component.set("v.SecletedGroup",selectedValue);
            var GroupMember= component.get("v.responseWrapper.GroupMembers");
            var allUser= component.get("v.responseWrapper.Users");
            var GroupUser=[]; 
            for(var i=0; i<GroupMember.length; i++){
                if(GroupMember[i].GroupId==selectedValue){
                    for(var j=0; j<allUser.length; j++){
                        if(GroupMember[i].UserOrGroupId==allUser[j].Id){
                            GroupUser.push({key:allUser[j].Id, value:allUser[j].Name})
                        }
                     }
                }  
            }
            component.set("v.AlluserList",GroupUser);
          }
     },
    
    TransferLeads: function (component, event, helper){
        debugger;
    	var emailsent= component.get("v.isEmailSent")
      var selectedName= component.find('userSelect').get('v.value');
        alert(component.find('userSelect').get('v.value'));
        
      var SelectedLeads=component.get("v.LeadsTobeProcessed");
        for(var i=0; i<SelectedLeads.length; i++){
            SelectedLeads[i].OwnerId=selectedName;
         }
        var recordIdList =[];
         for (var i = 0; i < SelectedLeads.length; i++) {
            var recordId = SelectedLeads[i].Id; 
            // var ownerid = SelectedLeads[i].OwnerId;
            recordIdList.push(recordId);
            // recordIdList.push(ownerid);
        }
         //component.set("v.LeadsTobeProcessed",SelectedLeads);
         var action = component.get("c.TransferLead");
         action.setParams({
            "leadsTobeTransfredByIDs" :recordIdList,
             "selectedOwnerid" : selectedName
             
      });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS"){
                debugger;
                var resultData = response.getReturnValue();
                console.log('resultData--'+JSON.stringify(resultData));
                component.set("v.CompleteLeadlist",resultData);
                 component.set("v.ShowTransferPopup", false);
                  component.set("v.ShowDeletePopup", false);
                   component.set("v.ShowDeleteTransferLeadCmp", false);
                 component.set("v.ShowNewEditLeadComp", false);
            }
            else if (state === "INCOMPLETE") {
                // do something
                alert('Updated INCOMPLETE');
            }
                else if (state === "ERROR") {
                    alert('Updated ERROR');
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
     closeModel: function(component, event, helper) {
        // Set isModalOpen attribute to false  
        component.set("v.ShowDeleteTransferLeadCmp", false);
    },
     DeleteLeads: function(component, event, helper) {
         debugger;
          component.set("v.showSpinner", true);
         var SelectedLeads=component.get("v.LeadsTobeProcessed");
        var tempLeadlist =[];
       /* for(var i = 0; i < SelectedLeads.length; i++){
             delete SelectedLeads[i].Address;
            tempLeadlist.push(SelectedLeads);
        }*/
         for (var i = 0; i < SelectedLeads.length; i++) {
            var recordId = SelectedLeads[i].Id; 
            tempLeadlist.push(recordId);
        }
          
         var action = component.get("c.deleteLeadrecords");
        action.setParams({
            "LeadstobeDeleted" :tempLeadlist 
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS"){
                var resultData = response.getReturnValue();
                if(resultData=="SUCCESS"){
                      
                    component.set("v.ShowDeleteTransferLeadCmp", false);
                    component.set("v.ShowDeletePopup", false);
                    component.set("v.ShowNewEditLeadComp", false); 
                    component.set("v.leadDetailPage", false); 
                    component.set("v.ShowTransferPopup", false);
                    component.set("v.showSpinner", false);
                    component.set("v.showlead", true);
                     
                    
                    var appEvent = $A.get("e.c:AuraMessageAppEvent"); 
                    //Set event attribute value
                    appEvent.setParams({
                        "message" : "Open Lead List Page",
                        "SelectedRecords":SelectedLeads
                    }); 
                    appEvent.fire(); 
                }
            }
             else if (state === "INCOMPLETE") {
                 alert("deleted INCOMPLETE");
            }
                else if (state === "ERROR") {
                    alert("deleted ERROR");
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