({
    doInit : function(component, event, helper) {
        component.set("v.ShowNewEditLeadComp", true);
		helper.GetPicklistvalues(component, event);
        helper.getTimezone(component, event, helper);
        
    },
	openModel: function(component, event, helper) {
      // Set isModalOpen attribute to true
      component.set("v.ShowNewEditLeadComp", true);
   },
  
   closeModel: function(component, event, helper) {
       debugger;
      // Set isModalOpen attribute to false  
      component.set("v.ShowNewEditLeadComp", false);
   },
  
   submitDetails: function(component, event, helper) {
      // Set isModalOpen attribute to false
      //Add your code to call apex method or do some processing
      component.set("v.ShowNewEditLeadComp", false);
   },
   submitEditLeadDetails :function(component, event, helper){
      debugger;
      var editLeaddetails = component.get("v.EditLeadRec");
       delete editLeaddetails.Address;
       delete editLeaddetails.Owner;
       delete editLeaddetails.CreatedDate;
       delete editLeaddetails.IsConverted;
       delete editLeaddetails.LastModifiedDate;
       delete editLeaddetails.Lead_Age__c;
       delete editLeaddetails.Lead_Number__c;
       delete editLeaddetails.ischecked;

      var   action = component.get("c.UpdateLeadRec");
      action.setParams({
             "LeadRec" :editLeaddetails,
          "PartnerId" : component.get("v.PartnerId")
      });

      action.setCallback(this, function(response) {
         var state = response.getState();
         if (state === "SUCCESS"){
            debugger;
             var resultData = response.getReturnValue();
            //var oRes = JSON.parse(resultData);
            //LeadCompleteList = component.get("v.CompleteLdList");
            //let TempLeadList = LeadCompleteList.filter(eachLead => eachLead.Id != oRes.Id);
            //TempLeadList.push(oRes);
            //component.set("v.LeadCompleteList",TempLeadList);
             if(resultData.message == 'Success'){
                 
                 var leadNewUpdatelist = resultData.CompleteleadList;
                 component.set("v.ShowNewEditLeadComp", false);
                 var cmpEvent = component.getEvent("sampleCmpEvent"); 
                 //Set event attribute value
                 cmpEvent.setParams({
                     "Message" : "Updted Lead  List",
                     "UpdatedLeadList":leadNewUpdatelist
                 }); 
                 cmpEvent.fire(); 
             }
             


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
   },

   submitNewDetails :function(component, event, helper){
    debugger;
     component.set("v.showSpinner", true);
      var ButtonClicked = event.target.dataset.name;
      //var ButtonClicked = event.getSource().get("v.name");
      var NewLeaddetails = component.get("v.NewLead");
       if( (NewLeaddetails.Company_Recent_Blogs__c == null || NewLeaddetails.Company_Recent_Blogs__c == '') ||
          (NewLeaddetails.Webinar_Links__c == null || NewLeaddetails.Webinar_Links__c == '') ||
          ( NewLeaddetails.Events__c === null ||  NewLeaddetails.Events__c === '')||
          ( NewLeaddetails.Client_Time_Zone__c === null ||  NewLeaddetails.Client_Time_Zone__c === '')||
         ( NewLeaddetails.LastName === null ||  NewLeaddetails.LastName === '')||
         ( NewLeaddetails.Company === null ||  NewLeaddetails.Company === '')){
          // alert('first Fill this requiered Fields');
           component.set("v.showPopup", true); 
           component.set("v.showSpinner", false); 
       }else{
           var addressstring = '';
           /*if(NewLeaddetails.street != null){
               NewLeaddetails.address = NewLeaddetails.street;
           }*/
           
          NewLeaddetails.address = NewLeaddetails.street+ ', ' + NewLeaddetails.City__c + ', ' + NewLeaddetails.state + ', ' + NewLeaddetails.country + ', ' + NewLeaddetails.postalCode;
           delete NewLeaddetails.street;
          // delete NewLeaddetails.City__c;
           delete NewLeaddetails.state;
           delete NewLeaddetails.country;
           delete NewLeaddetails.postalCode;
           var   action = component.get("c.CreateNewLeadRec");
      action.setParams({
            "NewLeadRec" :NewLeaddetails,
          "PartnerId" : component.get("v.PartnerId")
      });

      action.setCallback(this, function(response) {
         
         var state = response.getState();
         if (state === "SUCCESS"){
            debugger;
              component.set("v.showSpinner", false);
             var resultData = response.getReturnValue();
             if(resultData.message == "Success" && resultData.leadList1.length>0){
                 var leadData = resultData.leadList1;
                 component.set("v.reTurnCompleteLeadlist",leadData);
                
             }
             else if(resultData.message == "ERROR"){
                 var leadData = resultData.leadList1;
                 component.set("v.reTurnCompleteLeadlist",leadData);
                 
             }
             else if(resultData.message == "Clash Lead Created"){
                 var leadData = resultData.leadList1;
                 component.set("v.reTurnCompleteLeadlist",leadData);
                 alert("Clash Lead Created");
             }
            //var oRes = JSON.parse(resultData);
            component.set("v.CompleteLdList",resultData);
            //let TempLeadList = LeadCompleteList.filter(eachLead => eachLead.Id != oRes.Id);
            //LeadCompleteList.push(resultData);
            //component.set("v.LeadCompleteList",LeadCompleteList);
            var emptyLeadRec = {
               'sobjectType': 'Lead',
               'Title': '',
               'Name': '',
               'Phone': '',
               'Fax': '',
               'Website ': '',
               'AnnualRevenue ': '', 
               'Campaign ': '',
               'Company': '',
               'Description': '',
               'Email': '',
               'Industry': '',
               'Owner': '',
               'LeadSource': '',
               'Status': '',
               'MobilePhone': '',
               'NumberOfEmployees': '',
               'Rating': '',
               'Partner__c': '',
               'Remarks__c': '',
               'Lead_Number__c': '',
               'Demo_Date__c': '',
               'Designation__c': '',
               'Proposal_Date__c': '',
                'Company_Recent_Blogs__c': '',
                'Webinar_Links__c': '',
                'Events__c': '',
                'Client_Time_Zone__c':'',
            }
            if (ButtonClicked == 'Save and New') {
               component.set("v.ShowNewEditLeadComp", true);
               //alert('New Lead has been created!!!!!!');
               component.set("v.NewLead", emptyLeadRec);
               
            }
            if (ButtonClicked == 'New') {
               component.set("v.ShowNewEditLeadComp", false);
               component.set("v.NewLead", emptyLeadRec);
                 
              }
            var leadNewUpdatelist = component.get("v.reTurnCompleteLeadlist");
             var cmpEvent = component.getEvent("sampleCmpEvent"); 
             //Set event attribute value
             cmpEvent.setParams({
                 "Message" : "Updted Lead  List",
                 "UpdatedLeadList":leadNewUpdatelist
             }); 
             cmpEvent.fire(); 
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