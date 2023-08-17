({
	doInit : function(component, event, helper) {
        debugger;
        var portalUrl = $A.get("$Label.c.PartnerPortalBaseUrl");
        var iframeUrl = portalUrl+'PartnerDashBoardPage?partnerId='+component.get("v.partnerId");
        
        component.set('v.dashboardUrl', iframeUrl);
        helper.getUserRecorod(component, event, helper);
		helper.getAnnualOpportunityRevenue(component, event, helper,null,null);
        helper.getTodaysTaskforUser(component, event, helper);
        //helper.getOpportunityUnderProposal(component, event, helper);
        helper.getClosedLoastOpportunity(component, event, helper);
        helper.getClashleadList(component, event, helper);
        helper.getOverDueTask(component, event, helper);
	},
    afterScriptsLoaded : function(component, event, helper) {
        debugger;
        //helper.helperDoinit(component,event,helper)
        var startDateString = component.get("v.startDate");
        var endDateString = component.get("v.endDate");
        if(startDateString != null && startDateString!= null){
            helper.NewhelperDoinit(component,event,helper,startDateString,startDateString);
        }else if (startDateString == null && endDateString == null){
            helper.NewhelperDoinit(component,event,helper,null,null);

        }
 
    },
    
        validateStartDate : function(component, event, helper){
        debugger;
        helper.validateStartDate(component, event, helper);
    },
    validateEndDate : function(component, event, helper){
        debugger;
        helper.validateEndDate(component, event, helper);
    },
    
    showDopdownMenu : function(component, event, helper){
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
    
    getNewRecords:function(component, event, helper){
        debugger;
        var startDateString = component.get("v.startDate");
        var endDateString = component.get("v.endDate");
       
        helper.getAnnualOpportunityRevenue(component, event, helper,startDateString,endDateString);
        helper.NewhelperDoinit(component,event,helper,startDateString,endDateString);
        component.set("v.showdropdown",false);

        /*component.set('v.showdropdown','false');
        const queryString = window.location.search;
        var userid = queryString.split("&id=").pop();
        
        var action = component.get("c.PartnerdashboardChartsData1");
        //var currentDate = new Date();
        var startDate = component.get('v.startDate');
        var endDate = component.get('v.endDate');
        var showDate = startDate + " To " + endDate;
        component.set("v.showdate", showDate);
        var datebox = component.find("box1");
        $A.util.removeClass(datebox, "box1");
        $A.util.addClass(datebox, "box1DateSel");

        action.setParams({
            "currentuserid" : userid,
            "startDate" : startDate,
            "endDate" : endDate
        });
        
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                component.set("v.showPartnerdashboard",true);
                component.set("v.showUserProfile",false);
                var data = response.getReturnValue();
                var Data = JSON.parse(dataObj);
                
                var LeadCountData =  Data.LastweekLeadMap;
                if(Object.keys(LeadCountData).length != 0){
                    component.set("v.hideDonutLeadWeek",true);
                    component.set("v.NoLeadWeek",false);    
                    var completemap =[];
                    for(var key in LeadCountData){
                        var templist = {};
                        templist.name = key;
                        templist.y = LeadCountData[key];
                        completemap.push(templist);
                    }
                }else{
                    component.set("v.hideDonutLeadWeek",false);
                    component.set("v.NoLeadWeek",true);  
                }
                
                
            }
        }); */
        //$A.enqueueAction(action);   
    }
})