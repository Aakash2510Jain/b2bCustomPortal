({
    fetchPicklistVal : function(component, event, helper) {
        var fieldByObjectMap = {
            Status : 'Lead',
            StageName : 'Opportunity'
        };
        
        var action = component.get('c.getAllPickListVal');
        action.setParams({ObjectByField : fieldByObjectMap});
        
        action.setCallback(this, function(res){
            var state = res.getState();
            if(state === "SUCCESS"){
                var result = res.getReturnValue();
                for(var i in result){
                    if(i == "Status"){
                        component.set("v.leadStatusList", result[i]);
                    }
                    if(i == "StageName"){
                        component.set("v.oppStageList", result[i]);
                    }
                }
            }
            else{
                alert("Some Error Occured");
            }
        });
        $A.enqueueAction(action);
        
    },
    

    validateStartDate : function(component, event, helper) {
        debugger;
        var startDateString = component.get("v.startDate");
        if(startDateString!=null && startDateString!=undefined && startDateString!=''){
            
            var startDateArray = startDateString.split("-");
            for(var i in startDateArray){
                startDateArray[i] = parseInt(startDateArray[i]);
            }
            var startDate=new Date();
            startDate.setDate(startDateArray[2]);
            startDate.setFullYear(startDateArray[0]);
            startDate.setMonth(startDateArray[1]-1);
            startDate.setHours(0);
            startDate.setMinutes(0);
            startDate.setSeconds(0);
            
            var endDateString = component.get("v.endDate");
            if(endDateString == undefined || endDateString == null || endDateString == ""){
                var endDate=new Date();
            }
            else{
                var endDateArray = endDateString.split("-");
                for(var i in endDateArray){
                    endDateArray[i] = parseInt(endDateArray[i]);
                }
                var endDate=new Date();
                endDate.setDate(endDateArray[2]);
                endDate.setFullYear(endDateArray[0]);
                endDate.setMonth(endDateArray[1]-1);
                endDate.setHours(0);
                endDate.setMinutes(0);
                endDate.setSeconds(0); 
            }
            
            var todayDate = new Date();
            if(startDate>todayDate || startDate>endDate){
                var startDateBox = component.find("StartDateField");
                $A.util.addClass(startDateBox, "DateError");
                var errorMessage = component.find("startDateErrorMsg");
                $A.util.removeClass(errorMessage, "errorMessagInactive");
                $A.util.addClass(errorMessage, "errorMessageActive");           
                component.set("v.isLeadDateError", true);
                
            }
            if(startDate<=todayDate && startDate<=endDate && endDate<=todayDate){
                var startDateBox = component.find("StartDateField");
                $A.util.removeClass(startDateBox, "DateError");
                var errorMessage = component.find("startDateErrorMsg");
                $A.util.addClass(errorMessage, "errorMessagInactive");
                $A.util.removeClass(errorMessage, "errorMessageActive");
                var endDateBox = component.find("EndDateField");
                $A.util.removeClass(endDateBox, "DateError");
                var errorMessage = component.find("endDateErrorMsg");
                $A.util.addClass(errorMessage, "errorMessagInactive");
                $A.util.removeClass(errorMessage, "errorMessageActive");
                component.set("v.isLeadDateError", false);
            }
        }
    },
    
    validateEndDate : function(component, event, helper) {
        debugger;
        var endDateString = component.get("v.endDate");
        if(endDateString!=null && endDateString!=undefined && endDateString!=''){
            var endDateArray = endDateString.split("-");
            for(var i in endDateArray){
                endDateArray[i] = parseInt(endDateArray[i]);
            }
            var endDate=new Date();
            endDate.setDate(endDateArray[2]);
            endDate.setFullYear(endDateArray[0]);
            endDate.setMonth(endDateArray[1]-1);
            endDate.setHours(0);
            endDate.setMinutes(0);
            endDate.setSeconds(0);
            
            var startDateString = component.get("v.startDate");
            if(startDateString == undefined || startDateString == null || startDateString == ""){
                var startDate=new Date();
                startDate.setDate(1);
                startDate.setMonth(1);
                startDate.setHours(0);
                startDate.setMinutes(0);
                startDate.setSeconds(0);
            }
            else{
                var startDateArray = startDateString.split("-");
                for(var i in startDateArray){
                    startDateArray[i] = parseInt(startDateArray[i]);
                }
                var startDate=new Date();
                startDate.setDate(startDateArray[2]);
                startDate.setFullYear(startDateArray[0]);
                startDate.setMonth(startDateArray[1]-1);
                startDate.setHours(0);
                startDate.setMinutes(0);
                startDate.setSeconds(0);
            }
            
            
            var todayDate = new Date();
            
            if(startDate>endDate || endDate>todayDate){
                var endDateBox = component.find("EndDateField");
                $A.util.addClass(endDateBox, "DateError");
                var errorMessage = component.find("endDateErrorMsg");
                $A.util.removeClass(errorMessage, "errorMessagInactive");
                $A.util.addClass(errorMessage, "errorMessageActive");
                component.set("v.isLeadDateError", true);
            }
            if(startDate<=endDate && endDate<=todayDate){
                var endDateBox = component.find("EndDateField");
                $A.util.removeClass(endDateBox, "DateError");
                var errorMessage = component.find("endDateErrorMsg");
                $A.util.addClass(errorMessage, "errorMessagInactive");
                $A.util.removeClass(errorMessage, "errorMessageActive");
                var startDateBox = component.find("StartDateField");
                $A.util.removeClass(startDateBox, "DateError");
                var errorMessage = component.find("startDateErrorMsg");
                $A.util.addClass(errorMessage, "errorMessagInactive");
                $A.util.removeClass(errorMessage, "errorMessageActive");
                component.set("v.isLeadDateError", false);
            }
        }
        

    },
    
    validateOppStartDate : function(component, event, helper) {
        debugger;
         var startDateString = component.get("v.startDateOpp");
        if(startDateString!=null && startDateString!=undefined && startDateString!=''){
            var startDateArray = startDateString.split("-");
            for(var i in startDateArray){
                startDateArray[i] = parseInt(startDateArray[i]);
            }
            var startDate=new Date();
            startDate.setDate(startDateArray[2]);
            startDate.setFullYear(startDateArray[0]);
            startDate.setMonth(startDateArray[1]-1);
            startDate.setHours(0);
            startDate.setMinutes(0);
            startDate.setSeconds(0);
            
            var endDateString = component.get("v.endDateOpp");
            if(endDateString == undefined || endDateString == null || endDateString == ""){
                var endDate=new Date();
            }
            else{
                var endDateArray = endDateString.split("-");
                for(var i in endDateArray){
                    endDateArray[i] = parseInt(endDateArray[i]);
                }
                var endDate=new Date();
                endDate.setDate(endDateArray[2]);
                endDate.setFullYear(endDateArray[0]);
                endDate.setMonth(endDateArray[1]-1);
                endDate.setHours(0);
                endDate.setMinutes(0);
                endDate.setSeconds(0); 
            }
            
            var todayDate = new Date();
            if(startDate>todayDate || startDate>endDate){
                var startDateBox = component.find("StartDateFieldOpp");
                $A.util.addClass(startDateBox, "DateError");
                var errorMessage = component.find("startDateOppErrorMsg");
                $A.util.removeClass(errorMessage, "errorMessagInactive");
                $A.util.addClass(errorMessage, "errorMessageActive");
                component.set("v.isOppDateError", true);
                
            }
            if(startDate<=todayDate && startDate<=endDate && endDate<=todayDate){
                var startDateBox = component.find("StartDateFieldOpp");
                $A.util.removeClass(startDateBox, "DateError");
                var errorMessage = component.find("startDateOppErrorMsg");
                $A.util.addClass(errorMessage, "errorMessagInactive");
                $A.util.removeClass(errorMessage, "errorMessageActive");
                var endDateBox = component.find("EndDateFieldOpp");
                $A.util.removeClass(endDateBox, "DateError");
                var errorMessage = component.find("endDateOppErrorMsg");
                $A.util.addClass(errorMessage, "errorMessagInactive");
                $A.util.removeClass(errorMessage, "errorMessageActive");
                component.set("v.isOppDateError", false);
            }
        }
        
       
    },
    
    validateOppEndDate : function(component, event, helper) {
        debugger;
        var endDateString = component.get("v.endDateOpp");
        if(endDateString!=null && endDateString!=undefined && endDateString!=''){
            var endDateArray = endDateString.split("-");
            for(var i in endDateArray){
                endDateArray[i] = parseInt(endDateArray[i]);
            }
            var endDate=new Date();
            endDate.setDate(endDateArray[2]);
            endDate.setFullYear(endDateArray[0]);
            endDate.setMonth(endDateArray[1]-1);
            endDate.setHours(0);
            endDate.setMinutes(0);
            endDate.setSeconds(0);
            
            var startDateString = component.get("v.startDateOpp");
            if(startDateString == undefined || startDateString == null || startDateString == ""){
                var startDate=new Date();
                startDate.setDate(1);
                startDate.setMonth(1);
                startDate.setHours(0);
                startDate.setMinutes(0);
                startDate.setSeconds(0);
            }
            else{
                var startDateArray = startDateString.split("-");
                for(var i in startDateArray){
                    startDateArray[i] = parseInt(startDateArray[i]);
                }
                var startDate=new Date();
                startDate.setDate(startDateArray[2]);
                startDate.setFullYear(startDateArray[0]);
                startDate.setMonth(startDateArray[1]-1);
                startDate.setHours(0);
                startDate.setMinutes(0);
                startDate.setSeconds(0); 
            }
            
            
            var todayDate = new Date();
            
            if(startDate>endDate || endDate>todayDate){
                var endDateBox = component.find("EndDateFieldOpp");
                $A.util.addClass(endDateBox, "DateError");
                var errorMessage = component.find("endDateOppErrorMsg");
                $A.util.removeClass(errorMessage, "errorMessagInactive");
                $A.util.addClass(errorMessage, "errorMessageActive");
                component.set("v.isOppDateError", true);
            }
            if(startDate<=endDate && endDate<=todayDate){
                var endDateBox = component.find("EndDateFieldOpp");
                $A.util.removeClass(endDateBox, "DateError");
                var errorMessage = component.find("endDateOppErrorMsg");
                $A.util.addClass(errorMessage, "errorMessagInactive");
                $A.util.removeClass(errorMessage, "errorMessageActive");
                var startDateBox = component.find("StartDateFieldOpp");
                $A.util.removeClass(startDateBox, "DateError");
                var errorMessage = component.find("startDateOppErrorMsg");
                $A.util.addClass(errorMessage, "errorMessagInactive");
                $A.util.removeClass(errorMessage, "errorMessageActive");
                component.set("v.isOppDateError", false);
            }
        }
      
    },
    
    getNewLeadFollowUpTaskRecords : function(component, event, helper,startDate,endDate){
        debugger;
        const queryString = window.location.search;
        var userid = queryString.split("&id=").pop();
        component.set("v.PartnerId",userid);
        var partnerIdforapex = component.get("v.PartnerId");
        var leadStatus = component.get("v.leadStatus");
        component.set('v.showdropdown', false);
        var   action = component.get("c.GetFilteredPartnerLeadFollowUpActivities");
        action.setParams({
           "PartnerId" :userid,
            "StartDate" : startDate,
            "endDate" : endDate,
            "status" : leadStatus
        });
        action.setCallback(this,function(response){
            var state = response.getState();
            var Opptemparray = [];
           var Leadtemparray = [];
            if(state === "SUCCESS"){
               var resultData = response.getReturnValue();
               var ParsedFollowUpWrapdata = JSON.parse(resultData);
               

            // var convert = ParsedFollowUpWrapdata.Who.IsConverted;
                if(ParsedFollowUpWrapdata.LeadTaskList != null && ParsedFollowUpWrapdata.LeadTaskList != '' && ParsedFollowUpWrapdata.LeadTaskList != undefined){
                    for (let i = 0; i < ParsedFollowUpWrapdata.LeadTaskList.length; i++) {

                        var leadobject ={};
                          var date = ParsedFollowUpWrapdata.LeadTaskList[i].CreatedDate;
                            var createdDate = new Date(date);
                            var timeCreated = createdDate.toLocaleTimeString();
                            var convert = JSON.stringify(  ParsedFollowUpWrapdata.LeadTaskList[i].Who.IsConverted);
                           leadobject.leadName = ParsedFollowUpWrapdata.LeadTaskList[i].Who.Name;
                            leadobject.Subject = ParsedFollowUpWrapdata.LeadTaskList[i].Subject;
                             leadobject.CreatedDate = ParsedFollowUpWrapdata.LeadTaskList[i].CreatedDate;
                              leadobject.datetime = timeCreated;
                           // var date = ParsedFollowUpWrapdata.LeadTaskList[i].CreatedDate;
                          
                            Leadtemparray.push(leadobject);
                            //Leadtemparray.push(ParsedFollowUpWrapdata.LeadTaskList[i].Who.Name);
                           // Leadtemparray.push(ParsedFollowUpWrapdata.LeadTaskList[i].Subject);
                           // Leadtemparray.push(ParsedFollowUpWrapdata.LeadTaskList[i].ActivityDate);
                            
                        }
                  //  component.set("v.CompleteLeadTaskList",[]);

                     component.set("v.CompleteLeadTaskList", Leadtemparray);
                     component.set("v.NodatalistAvailable",false);
                }else{
                    component.set("v.NodatalistAvailable",true);
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
    
    getNewOppFollowUpTaskRecords : function(component, event, helper,startDate,endDate){
        debugger;
        const queryString = window.location.search;
        var userid = queryString.split("&id=").pop();
        component.set("v.PartnerId",userid);
        var partnerIdforapex = component.get("v.PartnerId");
        var stageName = component.get("v.oppStage");
        component.set('v.showdropdown', false);
        var   action = component.get("c.GetFilteredPartnerOppFollowUpActivities");
        action.setParams({
          "PartnerId" :userid,
            "StartDate" : startDate,
            "endDate" : endDate,
            "stage" : stageName
        });
        action.setCallback(this,function(response){
            var state = response.getState();
            var Opptemparray = [];
            if(state === "SUCCESS"){
               var resultData = response.getReturnValue();
               var ParsedFollowUpWrapdata = JSON.parse(resultData);
                if(ParsedFollowUpWrapdata.OpptaskList != null && ParsedFollowUpWrapdata.OpptaskList != '' && ParsedFollowUpWrapdata.OpptaskList != undefined){

                    for (let i = 0; i < ParsedFollowUpWrapdata.OpptaskList.length; i++) {
                    var date = ParsedFollowUpWrapdata.OpptaskList[i].CreatedDate;
                    var createdDate = new Date(date);
                    var timeCreated = createdDate.toLocaleTimeString();
                    var oppobject ={};
                    oppobject.OppName = ParsedFollowUpWrapdata.OpptaskList[i].What.Name;
                    oppobject.Subject = ParsedFollowUpWrapdata.OpptaskList[i].Subject;
                    oppobject.CreatedDate = ParsedFollowUpWrapdata.OpptaskList[i].CreatedDate;
                    oppobject.datetime = timeCreated;

                    Opptemparray.push(oppobject);
                }
                    component.set("v.CompleteOppTaskList",[]);
                     component.set("v.CompleteOppTaskList", Opptemparray);
                    component.set("v.NodatalistAvailableforOpp",false);
                    
                } else{
                    component.set("v.NodatalistAvailableforOpp",true);
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
    }
})