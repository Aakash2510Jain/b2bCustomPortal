({
	doInit : function(component, event, helper) {
         debugger;
          var portalUrl = $A.get("$Label.c.PartnerPortalBaseUrl");
        var iframeUrl = portalUrl+'PartnerIncentivePage?partnerId='+component.get("v.partnerId"); 
        component.set('v.dashboardUrl', iframeUrl);
		
	}
})