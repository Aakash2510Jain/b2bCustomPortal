({
    doInit : function(component, event, helper) {
        debugger;
        component.set("v.ShowNewEditTaskComp", true);
		helper.GetPicklistvalues(component, event);
        
    },
	openModel: function(component, event, helper) {
      // Set isModalOpen attribute to true
      component.set("v.ShowNewEditTaskComp", true);
   },
  
   closeModel: function(component, event, helper) {
       debugger;
      // Set isModalOpen attribute to false  
      component.set("v.ShowNewEditTaskComp", false);
   },
  

   submitNewDetails :function(component, event, helper){
    debugger;
     component.set("v.showSpinner", true);
      var ButtonClicked = event.target.dataset.name;
       var leadRec = component.get('v.leadRec');
      //var ButtonClicked = event.getSource().get("v.name");
      var newTaskDetails = component.get("v.NewTask");
       if(newTaskDetails.Priority == null || newTaskDetails.Status == null || newTaskDetails.Subject == null || newTaskDetails.Description == null || newTaskDetails.ActivityDate == null){
          // alert('first Fill this requiered Fields');
           component.set("v.showPopup", true); 
           component.set("v.showSpinner", false); 
       }else{
           newTaskDetails.OwnerId = leadRec.OwnerId;
           newTaskDetails.WhoId = leadRec.Id;
           newTaskDetails.Partner__c = component.get("v.PartnerId");
           var action = component.get("c.saveNewLeadTask");
      action.setParams({
            "tk" :component.get('v.NewTask'),
          "PartnerId" : component.get("v.PartnerId")
      });

      action.setCallback(this, function(response) {
         
         var state = response.getState();
         if (state === "SUCCESS"){
            debugger;
              component.set("v.showSpinner", false);
             var resultData = response.getReturnValue();
             if(resultData.message == "Success"){
                 alert("New task has been successfully created");
             }
            if (ButtonClicked == 'New') {
                var emptyTaskRec ={
               'sobjectType': 'Task',
               'Priority': '',
               'Status': '',
               'Subject': '',
               'OwnerId': '',
               'WhoId': ''
                }
               component.set("v.ShowNewEditTaskComp", false);
               component.set("v.NewTask", emptyTaskRec);
                 
              } 
             //component.set("v.showlead", true);
         }else if (state === "INCOMPLETE") {
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
       }
       
   },
    closeModel1: function(component, event, helper) {
       debugger;
      // Set isModalOpen attribute to false  
      component.set("v.showPopup", false);
   },
})