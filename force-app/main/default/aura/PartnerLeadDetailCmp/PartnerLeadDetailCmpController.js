({

doInit: function (component, event, helper) {
    var options = [
        { label: 'All', value: 'All' },
        { label: 'Today Lead', value: 'Today Lead' },
        { label: 'Last Week Lead', value: 'Last Week Lead' },
        { label: 'Last Month Lead', value: 'Last Month Lead' },
        { label: 'Last Quarter Lead', value: 'Last Quarter Lead' }
                
    ];
    debugger;
    component.set('v.Listviewoptions', options);
    var partnerIdforapex = component.get("v.partnerId");
    helper.doInitHelper(component, event, partnerIdforapex);
    
    
},
doFilter: function (component, event, helper) {
        //component.set("v.showSpinner", true);
    helper.searchRecords(component);
},

navigateToLead: function (component, event, helper) {
    debugger;
    //component.set("v.showleadPagination", false);
        component.set("v.showSpinner", true);
    component.set("v.leadDetailPage", true);
    component.set("v.hideHeaderSarchBar", false);
    var leadId = event.currentTarget.dataset.recordid;
    component.set("v.SelectedleadRecordId", leadId);
    debugger;
    
    helper.fetchleadRecord(component, event, leadId, 'Show');
    
},

EditLeadrec: function (component, event, helper) {
    debugger;
    var leadId = event.currentTarget.dataset.id;
    helper.fetchleadRecord(component, event, leadId, 'Edit');
},
CreateNewLead: function (component, event, helper) {
    debugger;
    component.set("v.ShowNewEditLeadComp", true);
    component.set("v.ShowEditLead", false);
    component.set("v.ShowNewLead", true);
    
},

handleSelectAllLead: function (component, event, helper) {
    debugger;
    
    var selectedHeaderCheck = event.getSource().get("v.value");
    var updatedAllRecords = [];
    var updatedPaginationList = [];
    var CompleteLeadlist = component.get("v.CompleteLeadlist");
    var PaginationList = component.get("v.PaginationList");
    
    
    
    // play a for loop on all records list 
    for (var i = 0; i < CompleteLeadlist.length; i++) {
        // check if header checkbox is 'true' then update all checkbox with true and update selected records count
        // else update all records with false and set selectedCount with 0  
        if (selectedHeaderCheck == true) {
            CompleteLeadlist[i].isChecked = true;
            component.set("v.selectedCount", CompleteLeadlist.length);
        } else {
            CompleteLeadlist[i].isChecked = false;
            component.set("v.selectedCount", 0);
        }
        updatedAllRecords.push(CompleteLeadlist[i]);
    }
    // update the checkbox for 'PaginationList' based on header checbox 
    for (var i = 0; i < PaginationList.length; i++) {
        if (selectedHeaderCheck == true) {
            PaginationList[i].isChecked = true;
        } else {
            PaginationList[i].isChecked = false;
        }
        updatedPaginationList.push(PaginationList[i]);
    }
    component.set("v.CompleteLeadlist", updatedAllRecords);
    component.set("v.PaginationList", updatedPaginationList);
},

//Process the selected Lead
checkboxSelect: function (component, event, helper) {
    debugger;
    // on each checkbox selection update the selected record count 
    var selectedRec = event.getSource().get("v.value");
    /* if(selectedRec = true){
        component.set("v.isRecordSelected", false);  
    }else{
        component.set("v.isRecordSelected", true); 
    }*/
        
        var getSelectedNumber = component.get("v.selectedCount");
    if (selectedRec == true) {
        getSelectedNumber++;
    } else {
        getSelectedNumber--;
        
        component.find("selectAllId").set("v.value", false);
        component.set("v.isRecordSelected", true); 
    }
    component.set("v.selectedCount", getSelectedNumber);
    var getSelectedleadCount = component.get("v.selectedCount");
    if(getSelectedleadCount >0){
        component.set("v.isRecordSelected", false); 
            component.set("v.deletemessage", 'Delete Leads'); 
        
    }else if(getSelectedleadCount === 0){
        component.set("v.isRecordSelected", true);
        component.set("v.deletemessage", 'First Select Leads'); 
    }
    // if all checkboxes are checked then set header checkbox with true   
    if (getSelectedNumber == component.get("v.totalRecordsCount")) {
        component.find("selectAllId").set("v.value", true);
    }
},

DeletetransferLead: function (component, event, helper) {
    debugger;
    
    var selectedLeads = [];
    var selectedLeadIds = [];
    var allSelectedLead = component.get("v.CompleteLeadlist");
    for (let i = 0; i < allSelectedLead.length; i++) {
        if (allSelectedLead[i].isChecked == true) {
            selectedLeads.push(allSelectedLead[i]);
            selectedLeadIds.push(allSelectedLead[i].Id);
        }
    }
    component.set("v.LeadsTobeProcessed", selectedLeads);
    
    console.log('selectedLead records ', selectedLeads);
    console.log('selectedLead records Ids ', selectedLeadIds);
    var whichBtn = event.getSource().get("v.name");
    if (selectedLeads.length > 0) {
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
        // alert(' NO Records Selected, Please select the record ');
        helper.openAlert(component, event);
    }
},

TransferLeads: function (component, event, helper) {
    debugger;
    var selectedLeads = [];
    var selectedLeadIds = [];
    var allSelectedLead = component.get("v.CompleteLeadlist");
    for (let i = 0; i < allSelectedLead.length; i++) {
        if (allSelectedLead[i].isChecked == true) {
            selectedLeads.push(allSelectedLead[i]);
            selectedLeadIds.push(allSelectedLead[i].Id);
        }
    }
    console.log('selectedLead records ', selectedLeads);
    console.log('selectedLead records Ids ', selectedLeadIds);
    if (selectedLeads.length > 0) {
        
        //alert('Records Selected count', selectedLeads.length);
        helper.openAlert(component, event);
    }
    else {
        
        //  alert(' NO Records Selected count ');
    }
},

handleListView:function (component, event, helper){
    debugger;
        component.set("v.showSpinner", true); 
        var selectedValue = event.currentTarget.dataset.value;
        component.set("v.listviewvalue", selectedValue);
    // var selectedListview = component.get("v.listviewselectedValue");
    // var SelectedListViewViaAurId = component.find('listviewId').get('v.value');
    var partnerUserid = component.get("v.partnerId");
    var action = component.get("c.getLeadRecordByListViewByname");
        action.setParams({
        "listViewName": selectedValue,
        "partnerId" : partnerUserid
    });
    action.setCallback(this, function(response) {
        var state = response.getState();
        var Leadtemparray = [];
        if(state ==='SUCCESS'){
                component.set("v.showSpinner", false);
                component.set("v.showdropdown", false);
            var leadListViesRecords = response.getReturnValue();
            // var oRes = JSON.parse(leadListViesRecords);
            if(leadListViesRecords.length > 0){
                for (let i = 0; i < leadListViesRecords.length; i++) {
                    delete leadListViesRecords[i].attributes;
                    leadListViesRecords[i].ischecked = false;
                    Leadtemparray.push(leadListViesRecords[i]);
                    
                }
                component.set("v.LeadlistForPagination", Leadtemparray);
                component.set("v.PaginationList", Leadtemparray);
                helper.fetchData(component, event, Leadtemparray);
                
                if (Leadtemparray.length >0) {
                    component.set("v.hideHeaderSarchBar",true);
                    component.set("v.showPagination", true); 
                    component.set("v.showleadPagination", true);
                    component.set("v.ShowNoleadImage", false);
                    
                }
                
            }else if(leadListViesRecords.length == 0){
                    
                    component.set("v.ShowNoleadImage", true); 
                    component.set("v.LeadlistForPagination", Leadtemparray);
                    component.set("v.PaginationList", Leadtemparray);
                    helper.fetchData(component, event, Leadtemparray);
                }
        }
    });
    $A.enqueueAction(action);  
    
    /* var CompleteLeadlist = component.get("v.CompleteLeadlist");
    
    let NewcurrentDate = new Date();
    let formattedCurrentDate = NewcurrentDate.getFullYear() + '-' + ('0' + (NewcurrentDate.getMonth() + 1)).slice(-2) + '-' + ('0' + NewcurrentDate.getDate()).slice(-2); 
    
    var today = new Date(); // Get the current date
    // ====================== Last week Start Date =======================
    var lastWeekStartDate = new Date(); // Create a new Date object for the start date of last week
    
    lastWeekStartDate.setDate(today.getDate() - today.getDay() - 6); // Subtract current day of the week plus 6 days
    
    // Format start date as 'YYYY-MM-DD'
    var lastWeekStartDateFormatted = lastWeekStartDate.toISOString().slice(0, 10);
    console.log('Last week start date:', lastWeekStartDateFormatted);
    var LastWeekSD = new Date(lastWeekStartDateFormatted);
    
    // ================== Last Week End date ======================
    
    var lastWeekEndDate = new Date(); // Create a new Date object for the end date of last week
    
    lastWeekEndDate.setDate(today.getDate() - today.getDay() - 1); // Subtract current day of the week plus 1 day
    
    // Format end date as 'YYYY-MM-DD'
    var lastWeekEndDateFormatted = lastWeekEndDate.toISOString().slice(0, 10);
    console.log('Last week end date:', lastWeekEndDateFormatted);
    var LastWeekED = new Date(lastWeekEndDateFormatted);
    
    // =============================== Last Month Start Date ==============================
    var today = new Date(); // Get the current date
    var lastMonthStartDate = new Date(today.getFullYear(), today.getMonth() - 1, 1); // Create a new Date object for the start date of last month
    
    // Format start date as 'YYYY-MM-DD'
    var lastMonthStartDateFormatted = lastMonthStartDate.toISOString().slice(0, 10);
    console.log('Last month start date:', lastMonthStartDateFormatted);
    var LastMonthSD = new Date(lastMonthStartDateFormatted);
    
    // ==================== Last Month End Date ============================
    var today = new Date(); // Get the current date
    var lastMonthEndDate = new Date(today.getFullYear(), today.getMonth(), 0); // Create a new Date object for the end date of last month
    
    // Format end date as 'YYYY-MM-DD'
    var lastMonthEndDateFormatted = lastMonthEndDate.toISOString().slice(0, 10);
    console.log('Last month end date:', lastMonthEndDateFormatted);
    var LastMonthED = new Date(lastMonthEndDateFormatted);
    
    
    // ===================== Get Previous Quarter Start and End date =======================
    var today = new Date(); // Get the current date
    
    var currentQuarter = Math.floor((today.getMonth() + 3) / 3); // Determine the current quarter
    var previousQuarter = currentQuarter - 1; // Calculate the previous quarter
    
    var previousQuarterStartDate = new Date(today.getFullYear(), (previousQuarter - 1) * 3, 1); // Create a new Date object for the start date of the previous quarter
    var previousQuarterEndDate = new Date(today.getFullYear(), previousQuarter * 3, 0); // Create a new Date object for the end date of the previous quarter
    
    // Format start and end dates as 'YYYY-MM-DD'
    var previousQuarterStartDateFormatted = previousQuarterStartDate.toISOString().slice(0, 10);
    var previousQuarterEndDateFormatted = previousQuarterEndDate.toISOString().slice(0, 10);
    
    console.log('Previous quarter start date:', previousQuarterStartDateFormatted);
    console.log('Previous quarter end date:', previousQuarterEndDateFormatted);
    
    var LastQuarterSD = new Date(previousQuarterStartDateFormatted);
    var LastQuarterED = new Date(previousQuarterEndDateFormatted);
    
    var tempLeadArrray = [];
    if(SelectedListViewViaAurId == 'Today Lead'){
        for(var i=0; i<CompleteLeadlist.length; i++){
            var apexDateTime = CompleteLeadlist[i].CreatedDate;
            var apexyear = apexDateTime.substring(0, 4);
            var apexmonth = apexDateTime.substring(5, 7);
            var apexday = apexDateTime.substring(8, 10);
            
            // Construct the formatted date string in 'yyyy-MM-dd' format
            var apexformattedDateString = apexyear + '-' + apexmonth + '-' + apexday;
            var date1 = new Date(apexformattedDateString);
            var date2 = new Date(formattedCurrentDate);
            if(date1 ===date2 ){
                //tempLeadArrray.push(leadcompleteLeadList[i]);Changed
                tempLeadArrray.push(CompleteLeadlist[i]);
            }
        }           
        component.set("v.LeadlistForPagination", tempLeadArrray);
    }
    
    if(SelectedListViewViaAurId == 'Last Week Lead'){
        for(var i=0; i<CompleteLeadlist.length; i++){
            var apexDateTime = CompleteLeadlist[i].CreatedDate;
            var apexyear = apexDateTime.substring(0, 4);
            var apexmonth = apexDateTime.substring(5, 7);
            var apexday = apexDateTime.substring(8, 10);
            
            // Construct the formatted date string in 'yyyy-MM-dd' format
            var formattedDateString = apexyear + '-' + apexmonth + '-' + apexday;
            var date1 = new Date(formattedDateString);
            
            if(date1 <= LastWeekED && date1 >= LastWeekSD){
                //tempLeadArrray.push(leadcompleteLeadList[i]);Changed
                tempLeadArrray.push(CompleteLeadlist[i]);
            }
        } 
        component.set("v.LeadlistForPagination", tempLeadArrray);
    }
    if(SelectedListViewViaAurId == 'Last Month Lead'){
        for(var i=0; i<CompleteLeadlist.length; i++){
            var apexDateTime = CompleteLeadlist[i].CreatedDate;
            var apexyear = apexDateTime.substring(0, 4);
            var apexmonth = apexDateTime.substring(5, 7);
            var apexday = apexDateTime.substring(8, 10);
            
            // Construct the formatted date string in 'yyyy-MM-dd' format
            var formattedDateString = apexyear + '-' + apexmonth + '-' + apexday;
            var date1 = new Date(formattedDateString);
            
            if(date1 <= LastMonthED && date1 >= LastMonthSD){
                //tempLeadArrray.push(leadcompleteLeadList[i]);Changed
                tempLeadArrray.push(CompleteLeadlist[i]);
            }
        } 
        component.set("v.LeadlistForPagination", tempLeadArrray);
    }
    if(SelectedListViewViaAurId == 'Last Quarter Lead'){
        for(var i=0; i<CompleteLeadlist.length; i++){
            var apexDateTime = CompleteLeadlist[i].CreatedDate;
            var apexyear = apexDateTime.substring(0, 4);
            var apexmonth = apexDateTime.substring(5, 7);
            var apexday = apexDateTime.substring(8, 10);
            
            // Construct the formatted date string in 'yyyy-MM-dd' format
            var formattedDateString = apexyear + '-' + apexmonth + '-' + apexday;
            var date1 = new Date(formattedDateString);
            
            if(date1 <= LastQuarterED && date1 >= LastQuarterSD){
                //tempLeadArrray.push(leadcompleteLeadList[i]);Changed
                tempLeadArrray.push(CompleteLeadlist[i]);
            }
        } 
        component.set("v.LeadlistForPagination", tempLeadArrray);
        
    }
    if(SelectedListViewViaAurId == 'All'){
        
        //var completeleadList = component.get("v.CompleteLeadlist");
        component.set("v.LeadlistForPagination", completeleadList);
    }*/
},

handlerComponentEvent: function (component, event, helper){
    debugger;
    var AuraMessageEvent = event.getParam('Message');
    if(AuraMessageEvent== 'Refresh Lead List'){
        var doinitaction = component.get("c.doInit");
        $A.enqueueAction(doinitaction);
    }else  if(AuraMessageEvent=='Updted Lead  List'){
        var UpdatedLeads = event.getParam('UpdatedLeadList');
        component.set("v.hideHeaderSarchBar",true);
        component.set("v.showleadPagination",true); 
        
        component.set("v.LeadlistForPagination",UpdatedLeads); 
        
    }
},

backtoPginationpage: function (component, event, helper){
    debugger;
    component.set("v.leadDetailPage",false);
    component.set("v.hideHeaderSarchBar",true);
},
component2Event:function (component, event, helper){
    debugger;
    var UpdatedArray=[];
    var message = event.getParam("message");
    var Records = event.getParam("SelectedRecords");
    console.log('Records--'+JSON.stringify(Records));
    if(Records!=null || Records!=undefined){
        var PaginationList=component.get("v.PaginationList");
        for(let i=0;i<Records.length;i++){
            if(PaginationList.find(item=>item.Id==Records[i].Id)){
                let rec=Records[i];
                PaginationList.splice(PaginationList.findIndex(row => row.Id === rec.Id), 1);
            }
        }
    }
    console.log('PaginationList--'+JSON.stringify(PaginationList));
    console.log('UpdatedArray--'+JSON.stringify(UpdatedArray));
    component.set("v.PaginationList",PaginationList);
    component.set("v.LeadlistForPagination",PaginationList);
    
    if(message=='Show Child Lead Page' || message=='Open Lead List Page'){
        
        //$A.get('e.force:refreshView').fire();
        component.set("v.hideHeaderSarchBar",true);
        component.set("v.showPagination", true); 
        /*var partnerIdforapex = component.get("v.partnerId");
        var action = component.get('c.doInit');
        $A.enqueueAction(action);*/
        //helper.doInitHelper(component, event, partnerIdforapex);
        
    }
    if(message == 'Lead Converted Successfully'){
        var completeList = event.getParam("SelectedRecords");
        helper.fetchData(component, event, completeList);
    }
    
},
navigateToPage: function(component, event, helper) {
    debugger;
    var selectedPage = event.getSource().get("v.label");
    component.set("v.currentPage", parseInt(selectedPage));
    var completeList = component.get("v.LeadlistForPagination");
    helper.fetchData(component, event, completeList);
},
previousPage: function(component, event, helper) {
    debugger;
    var currentPage = component.get("v.currentPage");
    if (currentPage > 1) {
        component.set("v.currentPage", currentPage - 1);
        var completeList = component.get("v.LeadlistForPagination");
        helper.fetchData(component, event, completeList);
    }
},

nextPage: function(component, event, helper) {
    debugger;
    var currentPage = component.get("v.currentPage");
    var totalPages = component.get("v.totalPages");
    if (currentPage < totalPages) {
        component.set("v.currentPage", currentPage + 1);
        var completeList = component.get("v.LeadlistForPagination");
        helper.fetchData(component, event, completeList);
    }
},
showDopdownMenu: function(component, event, helper) {
    debugger;
    
    component.set("v.showdropdown", true);
    component.set("v.hidedropdownButton", true);
    component.set("v.showdropdownButton", false);

},
showDropdownButton  :function(component, event, helper) {
    debugger;
    
    component.set("v.showdropdown", false);
    component.set("v.hidedropdownButton", false);
    component.set("v.showdropdownButton", true);
},
hidelistviewDropdown: function(component, event, helper) {
    debugger;
// component.set("v.showdropdown", true);
},

applyfilter  :function(component, event, helper) {
    debugger;
    component.set("v.showSpinner", true);
    var stdate = component.get("v.startDate");
    var endate= component.get("v.endDate");
    var StartDate = new Date(stdate);
    var EndDate = new Date(endate);
    var daysOfWeek = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
    var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    
    // Extract the day of the week, day of the month, month, and year
    var dayOfWeek = daysOfWeek[StartDate.getDay()];
    var dayOfMonth = StartDate.getDate();
    var month = months[StartDate.getMonth()];
    var year = StartDate.getFullYear();
    
    var dayOfWeekEndDate = daysOfWeek[EndDate.getDay()];
    var dayOfMonthEndDate = EndDate.getDate();
    var monthEndDate = months[EndDate.getMonth()];
    var yearEndDate = EndDate.getFullYear();
    
    // Format the date string
    var formattedStartDate = ` ${dayOfMonth} ${month}`;
    var formattedEndDate = ` ${dayOfMonthEndDate} ${monthEndDate}`;
    var acctualDate = `${formattedStartDate} - ${formattedEndDate}`;
        component.set("v.listviewvalue", acctualDate);
    
    var partnerUserid = component.get("v.partnerId");
    var action = component.get("c.getLeadRecordByDate");
    
    action.setParams({
        "startdate": stdate,
        "endDate" : endate,
        "partnerId" : partnerUserid
    });
    action.setCallback(this, function(response) {
        var state = response.getState();
        var Leadtemparray = [];
        if(state ==='SUCCESS'){
                component.set("v.showSpinner", false);
                component.set("v.showdropdown", false);
            var leadListViesRecords = response.getReturnValue();
            // var oRes = JSON.parse(leadListViesRecords);
            if(leadListViesRecords.length > 0){
                for (let i = 0; i < leadListViesRecords.length; i++) {
                    delete leadListViesRecords[i].attributes;
                    leadListViesRecords[i].ischecked = false;
                    Leadtemparray.push(leadListViesRecords[i]);
                    
                }
                component.set("v.LeadlistForPagination", Leadtemparray);
                component.set("v.PaginationList", Leadtemparray);
                helper.fetchData(component, event, Leadtemparray);
                
                if (Leadtemparray.length >0) {
                    component.set("v.hideHeaderSarchBar",true);
                    component.set("v.showPagination", true); 
                    component.set("v.showleadPagination", true);
                    component.set("v.ShowNoleadImage", false); 
                    
                }
                else{
                        component.set("v.ShowNoleadImage", true); 
                }
            }
            else{
                    component.set("v.PaginationList", response.getReturnValue());
                component.set("v.ShowNoleadImage", true); 
                    component.set("v.showleadPagination", false); 
            }
        }
    });
    $A.enqueueAction(action); 
}
})