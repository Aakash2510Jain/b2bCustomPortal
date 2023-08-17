({
	doinit : function(component, event, helper) {
        debugger;
        var partnerIdforapex = component.get("v.PartnerId");
        helper.doInitHelper(component, event, partnerIdforapex);
	},
    doFilter: function (component, event, helper) {
        helper.searchRecords(component);
    },
    navigateToPage: function(component, event, helper) {
        debugger;
        var selectedPage = event.getSource().get("v.label");
        component.set("v.currentPage", parseInt(selectedPage));
        var completeList = component.get("v.OpplistToBeDisplayed");
        helper.fetchData(component, event, completeList);
    },
    previousPage: function(component, event, helper) {
        debugger;
        var currentPage = component.get("v.currentPage");
        if (currentPage > 1) {
            component.set("v.currentPage", currentPage - 1);
            var completeList = component.get("v.OpplistToBeDisplayed");
            helper.fetchData(component, event, completeList);
        }
    },
    
    nextPage: function(component, event, helper) {
        debugger;
        var currentPage = component.get("v.currentPage");
        var totalPages = component.get("v.totalPages");
        if (currentPage < totalPages) {
            component.set("v.currentPage", currentPage + 1);
            var completeList = component.get("v.OpplistToBeDisplayed");
            helper.fetchData(component, event, completeList);
        }
    },
    navigateToOpportunity : function (component, event, helper){
        debugger;
         component.set("v.showOppPage",false);
         component.set("v.OpportunityDetailPage",true);
          var oppId = event.currentTarget.dataset.recordid;
        component.set("v.SelectedOppRecordId", oppId);
        helper.fetchOppRecord(component, event, oppId, 'Show');
    },
     backtoPginationpage: function (component, event, helper){
        debugger;
        component.set("v.OpportunityDetailPage",false);
        component.set("v.showOppPage",true);
    }
})