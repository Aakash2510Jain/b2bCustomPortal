({
	doInit: function (component, event, helper){
		debugger;
        component.set('v.accountColumns', [
            {label: 'Name', fieldName: 'Name', type: 'text'},
            {label: 'Account Number', fieldName: 'AccountNumber', type: 'text'},
            {label: 'Website', fieldName: 'Website', type: 'url', typeAttributes: { target: '_self'}}
        ]);
        component.set('v.contactColumns', [
            {label: 'Name', fieldName: 'Name', type: 'text'},
            {label: 'Email', fieldName: 'Email', type: 'email'},
            {label: 'Mobile', fieldName: 'MobilePhone', type: 'phone'},
        ]);
            component.set('v.oppColumns', [
            {label: 'Name', fieldName: 'Name', type: 'text'},
            {label: 'Stage Name', fieldName: 'StageName', type: 'text'},
            {label: 'Close Date', fieldName: 'CloseDate', type: 'date'}
        ]);
        component.set('v.leadColumns', [
            {label: 'Name', fieldName: 'Name', type: 'text'},
            {label: 'Company', fieldName: 'Company', type: 'text'},
            {label: 'Email', fieldName: 'Email', type: 'email'}
        ]);

        helper.ShowGlobalSearchLists(component, event);
    },
   
     /* handleSearchChange : function(component, event, helper) {
        helper.getSearchResultsFromHandler(component,helper);
         component.set("v.showSearchResults",true);
     },*/
    
    // this function automatic call by aura:waiting event  
    showSpinner: function(component, event, helper) {
        // make Spinner attribute true for display loading spinner 
        component.set("v.Spinner", true); 
    },
    
    // this function automatic call by aura:doneWaiting event 
    hideSpinner : function(component,event,helper){
        // make Spinner attribute to false for hide loading spinner    
        component.set("v.Spinner", false);
    }
})