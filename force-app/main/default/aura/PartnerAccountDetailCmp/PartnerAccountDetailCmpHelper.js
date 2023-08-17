({
	doInitHelper : function(component,event, partnerIdforapex){ 
        debugger;
        //var partnerIdforapex = component.get("v.PartnerId");
        var   action = component.get("c.GetPartnerAccounts");
        action.setParams({
          "PartnerId" :partnerIdforapex
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
             var Accounttemparray = [];
            if (state === "SUCCESS"){
                var resultData = response.getReturnValue();
                 var oRes = JSON.parse(resultData);
                if(oRes.length > 0){
                    for (let i = 0; i < oRes.length; i++) {
                        delete oRes[i].attributes;
                        oRes[i].ischecked = false;
                        Accounttemparray.push(oRes[i]);
                        
                    }
                    component.set('v.CompleteAccountlist', Accounttemparray);
                    component.set('v.AccountlistToBeDisplayed', Accounttemparray);
                    if (Accounttemparray.length >0) {
                        component.set("v.showAccountPage", true);
                          component.set("v.PaginationList1" , true);
                    }
                    
                    var helper = this;
                    helper.fetchData(component, event, Accounttemparray);
                     if (Accounttemparray.length >0) {
                       // component.set("v.hideHeaderSarchBar",true);
                       // component.set("v.showPagination", true); 
                       //   component.set("v.showleadPagination", true);
                        
                    }
                    else{
                        component.set("v.showtableHead", true);
                        component.set("v.ShowNoAccountImage", true); 
                          component.set("v.PaginationList1" , false);
                    }
                    
                }else{
                    // if there is no records then display message
                    component.set("v.bNoRecordsFound" , true);
                     component.set("v.ShowNoAccountImage" , true);
                      component.set("v.PaginationList1" , false);
                     component.set("v.showtableHead", true);
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
    searchRecords: function(component) {  
         debugger;
         var helper = this;
        //data showing in table  
        var data = component.get("v.data");   //CompleteLeadlist
        // all data featched from apex when component loaded  
        var allData = component.get("v.CompleteAccountlist"); 
       // var accData = component.get("v.AccountlistToBeDisplayed");
        //Search tems  
        var searchKey = component.get("v.filter");
         let TempValue;
        if(searchKey!=""){
            TempValue=searchKey;
        }else if(searchKey== "" || searchKey==null || searchKey==undefined){
            component.set("v.AccountlistToBeDisplayed",allData);
            component.set("v.PaginationList",allData);
             component.set("v.showAccountPage", true);
            helper.fetchData(component, event, allData);
            
        }
        let arr=[];
        if(TempValue){
            TempValue = TempValue.charAt(0).toUpperCase() + TempValue.slice(1);
            console.log('TempValue=',TempValue);
            //const results = allData.filter(Account => Account.Name.includes(TempValue));
            var results = allData.filter(word => (!TempValue) || word.Name.toLowerCase().indexOf(TempValue.toLowerCase()) > -1); 
            // let interestRate = this.data.find(item=>item.Name==TempValue);
            // console.log('interestRate----',interestRate);
            console.log('results====',results);
            results.forEach(element => {
                arr.push(element);
            });
            
            //arr.push(results.product);
            console.log('arr====',arr);
                component.set("v.AccountlistToBeDisplayed",arr);
                //component.set("v.PaginationList",arr);
                helper.fetchData(component, event, arr);
                 //component.set("v.showAccountPage", true);
        }
            },
    fetchData: function(component, event, completeData) {
        debugger;
        
        //var completeData = component.get("v.data");
        var currentPage = component.get("v.currentPage");
        var startIndex = (currentPage - 1) * component.get("v.pageSize");
        var endIndex = startIndex + component.get("v.pageSize");
        if(completeData.length < endIndex){
            endIndex = completeData.length;
        }
        
        var TempArray = [];
        for(var i=startIndex; i<endIndex; i++){
            TempArray.push(completeData[i]);
        }
        // Set the dummy data and total records
        component.set("v.PaginationList", TempArray);
        component.set("v.totalRecords", completeData.length);
        
        // Calculate the total pages and initialize the current page
        var pageSize = component.get("v.pageSize");
        var totalRecords = component.get("v.totalRecords");
        var totalPages = Math.ceil(totalRecords / pageSize);
        component.set("v.totalPages", totalPages);
        
        // Calculate the page numbers to display
        this.calculatePageRange(component);
    },
    
    calculatePageRange: function(component) {
        var currentPage = component.get("v.currentPage");
        var totalPages = component.get("v.totalPages");
        var maxPageLinks = 5; // Maximum number of page links to display
        
        var startPage = Math.max(1, currentPage - Math.floor(maxPageLinks / 2));
        var endPage = Math.min(totalPages, startPage + maxPageLinks - 1);
        
        // Adjust the range if the current page is near the start or end
        if (endPage - startPage < maxPageLinks - 1) {
            startPage = Math.max(1, endPage - maxPageLinks + 1);
        }
        
        var pageNumbers = [];
        for (var i = startPage; i <= endPage; i++) {
            pageNumbers.push(i);
        }
        
        component.set("v.startPage", startPage);
        component.set("v.endPage", endPage);
        component.set("v.pageNumbers", pageNumbers);
    },
      fetchAccRecord : function(component, event, selectedAccRecId, type){
        debugger;
        var completeAccList = component.get("v.CompleteAccountlist");
        let SelectedAccRec = completeAccList.find(eachAccount => eachAccount.Id == selectedAccRecId);
        
        if(type == 'Show'){
            component.set("v.singleAccountRec",SelectedAccRec);
         }
        else if(type == 'Edit'){
            //component.set("v.EditSelectedLeadRec",SelectedLeadRec);
           // component.set("v.ShowNewEditLeadComp", true);
            //component.set("v.ShowEditLead", true);
           // component.set("v.ShowNewLead", false);
        }
    },
        
              
})