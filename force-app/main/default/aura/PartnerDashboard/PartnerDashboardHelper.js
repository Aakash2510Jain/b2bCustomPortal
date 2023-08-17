({
    getAnnualOpportunityRevenue : function(component, event, helper,startDate,EndDate) {
        debugger;
        component.set("v.showSpinner", true); 
        var action = component.get("c.getUserDashboardData");
        const queryString = window.location.search;
        var userid = queryString.split("&id=").pop();
        action.setParams({
            "userPortalid" : userid,
            "startDate":startDate,
            "EndDate":EndDate
        });
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                component.set("v.showSpinner", false); 
                var data = response.getReturnValue();
                
                if(data!=null){
                    var totalrev = data.Revenue;
                     totalrev!=null ? component.set("v.TotalAnnualRevenue",totalrev) :component.set("v.TotalAnnualRevenue",0); 
                    var lastmonthRevenue = data.LeadCount;
                     lastmonthRevenue!=null ?  component.set("v.LeadCount",lastmonthRevenue): component.set("v.LeadCount",0); 
                    var leadconvert = data.ConvertedLeadRatio;
                     leadconvert!=null ? component.set("v.LeadConversionRatio",leadconvert) :component.set("v.LeadConversionRatio",0); 
                    var totaldeal = data.Deals;
                    totaldeal!=null ? component.set("v.OppChurnRatio",totaldeal) :component.set("v.OppChurnRatio",0);  
                    var revenuePerLead = data.RevenuePerLead;
                    revenuePerLead!=null ? component.set("v.perleadRevenue",revenuePerLead) :component.set("v.perleadRevenue",0); 
                    var ClashLeadcount = data.LeadNameXClashLeadCount;
                    ClashLeadcount!=null ? component.set("v.countClashLead",ClashLeadcount) :component.set("v.countClashLead",0);  
                }
            }
        }); 
        $A.enqueueAction(action);  
    },
    
    validateStartDate : function(component, event, helper) {
        debugger;
        var startDateString = component.get("v.startDate");
        if(startDateString!=null || startDateString!=undefined || startDateString!=''){
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
                component.set("v.isDateError", true);
                
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
                component.set("v.isDateError", false);
                
            }
        } 
    },
    
    validateEndDate : function(component, event, helper) {
        debugger;
        var endDateString = component.get("v.endDate");
        if(endDateString!=null || endDateString!=undefined || endDateString!=''){
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
                component.set("v.isDateError", true);
            }
            if(startDate<=endDate && endDate<=todayDate ){
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
                component.set("v.isDateError", false);
            }
        }
    },
    
    getTodaysTaskforUser : function(component, event, helper){
        debugger;
        var action = component.get("c.getTodaysTaskForUserPortal");
        const queryString = window.location.search;
        var userid = queryString.split("&id=").pop();
        var contactList = component.get("v.contactList");
        var noDataImage = component.find("noDataImage");
        action.setParams({
            "userPortalid" : userid  
        }); 
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                
                var data = response.getReturnValue();

                var ledobAray= [];

                if(data != null &&  data.length > 0){
                    for (let i = 0; i < data.length; i++) {
                        var date = data[i].CreatedDate;
                        var createdDate = new Date(date);
                        var timeCreated = createdDate.toLocaleTimeString();
                        var ldoject ={};
                        ldoject.leadName = data[i].Who.Name;
                        ldoject.Subject = data[i].Subject;
                        ldoject.CreatedDate = data[i].CreatedDate;
                        ldoject.datetime = timeCreated;
    
                        ledobAray.push(ldoject);
                    }
                    component.set("v.todayListofTask",ledobAray); 
                    component.set("v.datalistAvailable",true);
                }else   {
                    component.set("v.NodatalistAvailable",true);
                    component.set("v.datalistAvailable",false);
                }
                
            }
        }); 
        $A.enqueueAction(action);  
    },
    getClosedLoastOpportunity: function(component, event, helper){
        debugger;
        var action = component.get("c.getCloseLostOpportunityofAccont");
        const queryString = window.location.search;
        var userid = queryString.split("&id=").pop();
        action.setParams({
            "userPortalid" : userid  
        }); 
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                var data = response.getReturnValue();
                if(data != null &&  data.length > 0){
                    component.set("v.closedLostOpportunity",data); 
                    component.set("v.OpportunilistAvailable",true)
                }else   {
                    component.set("v.NoOpportunitylistAvailable",true);
                    component.set("v.OpportunilistAvailable",false);
                }
                
                
            }
        }); 
        $A.enqueueAction(action);  
    },
    /*getOpportunityUnderProposal: function(component, event, helper){
        debugger;
        var action = component.get("c.getOpportunityTaskUnderProposal");
        const queryString = window.location.search;
        var userid = queryString.split("&id=").pop();
        action.setParams({
            "userPortalid" : userid  
        }); 
        action.setCallback(this,function(response){
            debugger;
            var state = response.getState();
            debugger;
            if(state === "SUCCESS"){
                var data = response.getReturnValue();
                debugger;
                //alert('data Available');
                if(data != null ){
                    component.set("v.UnnderProposalOpportunity",data);
                    component.set("v.ProposallistAvailable",true)
                    component.set("v.NoProposallistAvailable",false)
                }else {
                    
                } 
            }
            if(state === "ERROR"){
                component.set("v.NoProposallistAvailable",true);
                component.set("v.ProposallistAvailable",false);
                
            }
        }); 
        $A.enqueueAction(action);  
        
    },*/
    
    getClashleadList : function(component, event, helper){
         debugger;
         var action = component.get("c.getLeadsAndClashLeads"); 
         const queryString = window.location.search;
         var userid = queryString.split("&id=").pop();
         action.setParams({
             "userPortalid" : userid  
         }); 
         action.setCallback(this,function(response){
             debugger;
             var state = response.getState();
             debugger;
             if(state === "SUCCESS"){
                 var data = response.getReturnValue();
                 debugger;
                 //alert('data Available');
                 if(data != null ){
                     component.set("v.ListofLeads",data);
                     component.set("v.ClashlistAvailable",true)
                     component.set("v.NodatalistAvailable",false)
                 }else {
                     
                 } 
             }
             if(state === "ERROR"){
                 component.set("v.NodatalistAvailable",true);
                 component.set("v.ClashlistAvailable",false);
                 
             }
         }); 
         $A.enqueueAction(action); 

    },

    getOverDueTask : function(component, event, helper){
        debugger;
        var action = component.get("c.getOverudeTaskList"); 
        const queryString = window.location.search;
        var userid = queryString.split("&id=").pop();
        action.setParams({
            "userPortalid" : userid  
        }); 
        action.setCallback(this,function(response){
            debugger;
            var state = response.getState();
            debugger;
            if(state === "SUCCESS"){
                var data = response.getReturnValue();

                var duetaskArray = [];
                debugger;
                //alert('data Available');
                if(data != null ){

                    for (let i = 0; i < data.length; i++) {
                        var date = data[i].CreatedDate;
                        var createdDate = new Date(date);
                        var timeCreated = createdDate.toLocaleTimeString();
                        var ldoject ={};
                        ldoject.leadName = data[i].Who.Name;
                        ldoject.Subject = data[i].Subject;
                        ldoject.createdDate = data[i].CreatedDate;
                        ldoject.datetime = timeCreated;
    
                        duetaskArray.push(ldoject);
                    }
                    component.set("v.OverDueTaskList",duetaskArray);
                    component.set("v.OverdurTaskData",true)
                    component.set("v.NoOverdueTask",false)
                }else {
                    
                } 
            }
            if(state === "ERROR"){
                component.set("v.NoOverdueTask",true);
                component.set("v.OverdurTaskData",false);
                
            }
        }); 
        $A.enqueueAction(action); 

   },

    
   /* helperDoinit : function(component, event, helper){
        debugger;
        var action = component.get("c.PartnerdashboardChartsData1"); 
        var userid = component.get("v.partnerId");
        action.setParams({
            "userPortalid" : userid  
        });
        action.setCallback(this, function(response) { 
            var state = response.getState(); 
            //alert(state);
            if (state === "SUCCESS") { 
                var dataObj= response.getReturnValue();
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
                
                var opportunityNego =  Data.opportunityNegotiation;
                if(Object.keys(opportunityNego).length != 0){
                    component.set("v.hideDonutOppNego",true);
                    component.set("v.NoOppNego",false);   
                    var oppMapvalue =[];
                    for(var key in opportunityNego){
                        var templist = {};
                        templist.name = key;
                        templist.y = opportunityNego[key];
                        oppMapvalue.push(templist);
                        
                    }
                }else{
                    component.set("v.hideDonutOppNego",false);
                    component.set("v.NoOppNego",true); 
                }    
                var lastweekOpportunitycount =  Data.LastweekOpportunity;
                if(Object.keys(lastweekOpportunitycount).length != 0){
                    component.set("v.hidebargraphLastWeekOpp",true);
                    component.set("v.NolastWeekOpp",false);
                    var opplastweekCatArrayValue =[];
                    var opplastweekDataArrayValue =[];
                    //opplastweekValue.push(['Category2', 'Value']);
                    for(var key in lastweekOpportunitycount){
                        opplastweekCatArrayValue.push(key.toString());
                        opplastweekDataArrayValue.push(parseInt(lastweekOpportunitycount[key]));
                    }
                }else{
                    component.set("v.hidebargraphLastWeekOpp",false);
                    component.set("v.NolastWeekOpp",true);
                }    
                
                var leadProposalCount =  Data.LeadProposalCount;
                if(Object.keys(leadProposalCount).length != 0){
                    component.set("v.hidebargraphLastWeekpro",true);
                    component.set("v.NolastWeekPro",false);   
                    var leadWeekProposalCatCount =[];
                    var leadWeekProposalDataCount =[];
                    //leadWeekProposalCount.push(['Category2', 'Value']);
                    for(var key in leadProposalCount){
                        leadWeekProposalCatCount.push(key.toString());
                        leadWeekProposalDataCount.push(parseInt(leadProposalCount[key]));
                    }
                }else{
                    component.set("v.hidebargraphLastWeekpro",false);
                    component.set("v.NolastWeekPro",true);   
                    
                }
                var leadCountByCountry =  Data.leadsCountByCountry;
                if(Object.keys(leadCountByCountry).length != 0){
                    component.set("v.hideDonutLeadCount",true);
                    component.set("v.NoLeadCount",false); 
                    var CountryLeadsCount =[];
                    //CountryLeadsCount.push(['Category2', 'Value']);
                    for(var key in leadCountByCountry){
                        var templist = {};
                        templist.name = key;
                        templist.y = leadCountByCountry[key];
                        CountryLeadsCount.push(templist);
                        
                    }
                }else{
                    component.set("v.hideDonutLeadCount",false);
                    component.set("v.NoLeadCount",true);   
                    
                }    
                var AccountConvertedbyState =  Data.accountConvertedbyState;
                if(Object.keys(AccountConvertedbyState).length != 0){
                    component.set("v.hideDonutAccountCon",true);
                    component.set("v.NoAccountCount",false); 
                    var convertedAccountState =[];
                    //convertedAccountState.push(['Category2', 'Value']);
                    for(var key in AccountConvertedbyState){
                        var templist = {};
                        templist.name = key;
                        templist.y = AccountConvertedbyState[key];
                        convertedAccountState.push(templist);
                        
                    }
                }else{
                    component.set("v.hideDonutAccountCon",false);
                    component.set("v.NoAccountCount",true);   
                    
                }
                //jsonData = dataObj;
                console.log('===='+dataObj);
                component.set("v.data",dataObj);
                //helper.piechart(component,event,helper);
                //helper.Linechart(component,event,helper);
                helper.donutchart(component,event,helper, 'LeadCountdonutchart', 'Lead Week Lead Count', 'Lead Count Stage', completemap );
                helper.donutchart(component,event,helper, 'OppByStagedonutchart', 'Opportunity Stages', 'Opportunity Stages', oppMapvalue );
                helper.BarChart(component,event,helper, 'LastWeekOppCountBarChart', 'Last Week Opportunity Count',opplastweekCatArrayValue,opplastweekDataArrayValue);
                helper.BarChart(component,event,helper, 'LastWeekProCountBarChart', 'Last Week Proposal Count',leadWeekProposalCatCount,opplastweekDataArrayValue);
                
                helper.donutchart(component,event,helper, 'LeadByCountdonutchart', 'Lead By Country', 'Lead Count Stage', CountryLeadsCount );
                helper.donutchart(component,event,helper, 'AccConvertedByStatedonutchart', 'Account Converted By state', 'Converted Account', convertedAccountState );
            } 
        });
        $A.enqueueAction(action);
    },*/
    NewhelperDoinit : function(component, event, helper,startDate,EndDate){
        debugger;
        component.set("v.showSpinner", true); 
        var action = component.get("c.PartnerdashboardChartsData"); 
        var userid = component.get("v.partnerId");
        action.setParams({
            "userPortalid" : userid,
            "startDate":startDate,
            "endDate":EndDate
        });
        action.setCallback(this, function(response) { 
            var state = response.getState(); 
            //alert(state);
            if (state === "SUCCESS") { 
                component.set("v.showSpinner", false); 
                var dataObj= response.getReturnValue();
                var Data = JSON.parse(dataObj);
                //LeadStatus
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
                //Opportunity Stage
               var opportunityNego =  Data.opportunityNegotiation;
                if(Object.keys(opportunityNego).length != 0){
                    component.set("v.hideDonutOppNego",true);
                    component.set("v.NoOppNego",false);   
                    var oppMapvalue =[];
                    for(var key in opportunityNego){
                        var templist = {};
                        templist.name = key;
                        templist.y = opportunityNego[key];
                        oppMapvalue.push(templist);
                        
                    }
                }else{
                    component.set("v.hideDonutOppNego",false);
                    component.set("v.NoOppNego",true); 
                } 
                   //Lead  Industry
                var LeadCountIndusryData =  Data.LastweekLeadIndustryMap;
                if(Object.keys(LeadCountIndusryData).length != 0){
                    component.set("v.hideDonutLeadIndustry",true);
                    component.set("v.NoLeadIndustry",false);    
                    var completeindustrymap=[];
                    for(var key in LeadCountIndusryData){
                        var templist = {};
                        templist.name = key;
                        templist.y = LeadCountIndusryData[key];
                        completeindustrymap.push(templist);
                    }
                }else{
                    component.set("v.hideDonutLeadIndustry",false);
                    component.set("v.NoLeadIndustry",true);  
                }   
                
                var LeadCountTitleData =  Data.LeadTitlelistMap;
                if(Object.keys(LeadCountTitleData).length != 0){
                    component.set("v.hideDonutLeadTitle",true);
                    component.set("v.NoLeadTitle",false);    
                    var completeTitlemap=[];
                    for(var key in LeadCountTitleData){
                        var templist = {};
                        templist.name = key;
                        templist.y = LeadCountTitleData[key];
                        completeTitlemap.push(templist);
                    }
                }else{
                    component.set("v.hideDonutLeadTitle",false);
                    component.set("v.NoLeadTitle",true);  
                }  

                var LeadCoutEmployeeData =  Data.LeadEmployeetMap;
                if(Object.keys(LeadCoutEmployeeData).length != 0){
                    component.set("v.hideDonutLeadEmployee",true);
                    component.set("v.NoLeadEmployee",false);    
                    var completEmployeemap=[];
                    for(var key in LeadCoutEmployeeData){
                        var templist = {};
                        templist.name = key;
                        templist.y = LeadCoutEmployeeData[key];
                        completEmployeemap.push(templist);
                    }
                }else{
                    component.set("v.hideDonutLeadEmployee",false);
                    component.set("v.NoLeadEmployee",true);  
                }

                
             
                var LeadCoutCountryData =  Data.LeadCountryMap;
                if(Object.keys(LeadCoutCountryData).length != 0){
                    component.set("v.hideDonutLeadCountry",true);
                    component.set("v.NoLeadCountry",false);    
                    var completCountrymap=[];
                    for(var key in LeadCoutCountryData){
                        var templist = {};
                        templist.name = key;
                        templist.y = LeadCoutCountryData[key];
                        completCountrymap.push(templist);
                    }
                }else{
                    component.set("v.hideDonutLeadCountry",false);
                    component.set("v.NoLeadCountry",true);  
                }  

                var LeadCoutRatingData =  Data.LeadRatingMap;
                if(Object.keys(LeadCoutRatingData).length != 0){
                    component.set("v.hideDonutLeadRating",true);
                    component.set("v.NoLeadRating",false);    
                    var completRatingmap=[];
                    for(var key in LeadCoutRatingData){
                        var templist = {};
                        templist.name = key;
                        templist.y = LeadCoutRatingData[key];
                        completRatingmap.push(templist);
                    }
                }else{
                    component.set("v.hideDonutLeadRating",false);
                    component.set("v.NoLeadRating",true);  
                }  
                
                 
                var LeadstatusUnqualifiedData =  Data.LeadUnquailifiedMap;
                if(Object.keys(LeadstatusUnqualifiedData).length != 0){
                    component.set("v.hideDonutLeadUNqualified",true);
                    component.set("v.NoLeadUnqualified",false);    
                    var completStatusmap=[];
                    for(var key in LeadstatusUnqualifiedData){
                        var templist = {};
                        templist.name = key;
                        templist.y = LeadstatusUnqualifiedData[key];
                        completStatusmap.push(templist);
                    }
                }else{
                    component.set("v.hideDonutLeadUNqualified",false);
                    component.set("v.NoLeadUnqualified",true);  
                } 
                

                var LeadindustryData =  Data.LeadindustryConverteddMap;
                if(Object.keys(LeadindustryData).length != 0){
                    component.set("v.hideIndustryqualiqualified",true);
                    component.set("v.NoLeadindustryLead",false);    
                    var completeIndustrymap=[];
                    for(var key in LeadindustryData){
                        var templist = {};
                        templist.name = key;
                        templist.y = LeadindustryData[key];
                        completeIndustrymap.push(templist);
                    }
                }else{
                    component.set("v.hideIndustryqualiqualified",false);
                    component.set("v.NoLeadindustryLead",true);  
                }

                //Lead Industry
                /*var lastweekOpportunitycount =  Data.LastweekOpportunity;
                if(Object.keys(lastweekOpportunitycount).length != 0){
                    component.set("v.hidebargraphLastWeekOpp",true);
                    component.set("v.NolastWeekOpp",false);
                    var opplastweekCatArrayValue =[];
                    var opplastweekDataArrayValue =[];
                    //opplastweekValue.push(['Category2', 'Value']);
                    for(var key in lastweekOpportunitycount){
                        opplastweekCatArrayValue.push(key.toString());
                        opplastweekDataArrayValue.push(parseInt(lastweekOpportunitycount[key]));
                    }
                }else{
                    component.set("v.hidebargraphLastWeekOpp",false);
                    component.set("v.NolastWeekOpp",true);
                }    
                
                var leadProposalCount =  Data.LeadProposalCount;
                if(Object.keys(leadProposalCount).length != 0){
                    component.set("v.hidebargraphLastWeekpro",true);
                    component.set("v.NolastWeekPro",false);   
                    var leadWeekProposalCatCount =[];
                    var leadWeekProposalDataCount =[];
                    //leadWeekProposalCount.push(['Category2', 'Value']);
                    for(var key in leadProposalCount){
                        leadWeekProposalCatCount.push(key.toString());
                        leadWeekProposalDataCount.push(parseInt(leadProposalCount[key]));
                    }
                }else{
                    component.set("v.hidebargraphLastWeekpro",false);
                    component.set("v.NolastWeekPro",true);   
                    
                }
                var leadCountByCountry =  Data.leadsCountByCountry;
                if(Object.keys(leadCountByCountry).length != 0){
                    component.set("v.hideDonutLeadCount",true);
                    component.set("v.NoLeadCount",false); 
                    var CountryLeadsCount =[];
                    //CountryLeadsCount.push(['Category2', 'Value']);
                    for(var key in leadCountByCountry){
                        var templist = {};
                        templist.name = key;
                        templist.y = leadCountByCountry[key];
                        CountryLeadsCount.push(templist);
                        
                    }
                }else{
                    component.set("v.hideDonutLeadCount",false);
                    component.set("v.NoLeadCount",true);   
                    
                }    
                var AccountConvertedbyState =  Data.accountConvertedbyState;
                if(Object.keys(AccountConvertedbyState).length != 0){
                    component.set("v.hideDonutAccountCon",true);
                    component.set("v.NoAccountCount",false); 
                    var convertedAccountState =[];
                    //convertedAccountState.push(['Category2', 'Value']);
                    for(var key in AccountConvertedbyState){
                        var templist = {};
                        templist.name = key;
                        templist.y = AccountConvertedbyState[key];
                        convertedAccountState.push(templist);
                        
                    }
                }else{
                    component.set("v.hideDonutAccountCon",false);
                    component.set("v.NoAccountCount",true);   
                    
                }*/
                //jsonData = dataObj;
            console.log('===='+dataObj);
            component.set("v.data",dataObj);
            //helper.piechart(component,event,helper);
            //helper.Linechart(component,event,helper);
            helper.donutchart(component,event,helper, 'LeadCountdonutchart', 'Lead Stage', 'Lead Count Stage', completemap );
            helper.donutchart(component,event,helper, 'OppByStagedonutchart', 'Opportunity Stages', 'Opportunity By Stages', oppMapvalue );
            helper.donutchart(component,event,helper, 'LeadinustryCountdonutchart', ' Industry Wise Leads', 'Lead Industry', completeindustrymap );
            helper.donutchart(component,event,helper, 'LeadTitleCountdonutchart', 'Title Wise Leads', 'Lead Title', completeTitlemap );   
            helper.donutchart(component,event,helper, 'LeadEmployeeountdonutchart', 'No.Of Employees Wise Leads', 'Lead Emaployee', completEmployeemap ); 
            helper.donutchart(component,event,helper, 'LeadCountryDuntdonutchart', 'Country Wise Leads', 'Lead Country', completCountrymap );  
            helper.donutchart(component,event,helper, 'LeadRatingDuntdonutchart', 'Rating Wise Leads', 'Lead Rating', completRatingmap ); 
            helper.donutchart(component,event,helper, 'LeadUnqualifiedDuntdonutchart', 'Unquailified Leads', 'Lead Unquailified', completStatusmap );
            helper.donutchart(component,event,helper, 'LeadIndustryDuntdonutchart', 'Most Industry Converted Leads', 'Lead Converted', completeIndustrymap );
            /*helper.BarChart(component,event,helper, 'LastWeekOppCountBarChart', 'Last Week Opportunity Count',opplastweekCatArrayValue,opplastweekDataArrayValue);
            helper.BarChart(component,event,helper, 'LastWeekProCountBarChart', 'Last Week Proposal Count',leadWeekProposalCatCount,opplastweekDataArrayValue);
                
                helper.donutchart(component,event,helper, 'LeadByCountdonutchart', 'Lead By Country', 'Lead Count Stage', CountryLeadsCount );
                helper.donutchart(component,event,helper, 'AccConvertedByStatedonutchart', 'Account Converted By state', 'Converted Account', convertedAccountState );*/
            } 
        });
        $A.enqueueAction(action);
    },
    /*piechart : function(component,event,helper, completemap) {
        var jsonData = component.get("v.data");
        var dataObj = JSON.parse(jsonData);
        new Highcharts.Chart({
            chart: {
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: false,
                renderTo: component.find("chart").getElement(),
                type: 'pie'
            },
            title: {
                text: component.get("v.chartTitle")+' (Pie Chart)'
            },
            subtitle: {
                text: component.get("v.chartSubTitle")
            },
            xAxis: {
                categories: component.get("v.xAxisCategories"),
                crosshair: true
            },
            yAxis: {
                min: 0,
                title: 
                {
                    text: component.get("v.yAxisParameter")
                }
            },
            tooltip: {
                pointFormat: '{series.name}: <b>{point.y}</b>'
            },
            plotOptions: {
                pie: {
                    allowPointSelect: true,
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: true,
                        format: '<b>{point.name}</b>: {point.y} ',
                        style: {
                            color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                        }
                    }
                }
            },
            series: [{
                name:'StageName',
                data:completemap
            }]
            
        });
        
    },
    
    Linechart : function(component,event,helper) {
        var jsonData = component.get("v.data");
        var dataObj = JSON.parse(jsonData);
        
        new Highcharts.Chart({
            chart: {
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: false,
                renderTo: component.find("linechart").getElement(),
                type: 'line'
            },
            title: {
                text: component.get("v.chartTitle")+' (Line Chart)'
            },
            subtitle: {
                text: component.get("v.chartSubTitle")
            },
            xAxis: {
                categories: component.get("v.xAxisCategories"),
                crosshair: true
            },
            yAxis: {
                min: 0,
                title: 
                {
                    text: component.get("v.yAxisParameter")
                }
            },
            tooltip: {
                pointFormat: '{series.name}: <b>{point.y}</b>'
            },
            plotOptions: {
                line: {
                    dataLabels: {
                        enabled: true
                    },
                    enableMouseTracking: false
                }
            },
            series: [{
                name:'StageName',
                data:dataObj
            }]
            
        });
        
    },*/
    
    donutchart : function(component,event,helper, chartId, Title, subtitle, datamap) {
        debugger;
        new Highcharts.Chart({
            chart: {
                renderTo: component.find(chartId).getElement(),
                type: 'pie',
                options3d: {
                    enabled: true,
                    alpha: 45
                },
                background: '#EDE4E3'
            },
            title: {
                text: Title    //component.get("v.chartTitle")
            },
            subtitle: {
                text: 	subtitle						//component.get("v.chartSubTitle")
            },
            tooltip: {
                pointFormat: '{ }: <b>{point.percentage:.1f}%</b>'
            },
            plotOptions: {
                pie: {
                    innerSize: 100,
                    depth: 45
                }
            },
           /* theme: {
                mode: 'light', 
                palette: 'palette1', 
                monochrome: {
                    enabled: false,
                    color: '#255aee',
                    shadeTo: 'light',
                    shadeIntensity: 0.65
                },
            },*/
            series: [{
                type: 'pie',
                name:'',
                data:datamap
            }]
            
        });
        
    },
    
    BarChart: function(component, event, helper, chartId, Title, catArray, dataArray ) {
        // Define chart configuration
        var chartConfig = {
            chart: {
                type: 'bar',
                renderTo: component.find(chartId).getElement(),
                background: '#EDE4E3'
            },
            title: {
                text: Title
            },
            xAxis: {
                categories: catArray //['Category 1', 'Category 2', 'Category 3']
            },
            yAxis: {
                title: {
                    text: 'Counts'
                }
            },
            series: [{
                name: '',
                data: dataArray // [10, 20, 30]
            }]
        };
        
        // Create the chart
        var chart = new Highcharts.Chart(chartConfig);
    },
    getUserRecorod:function(component, event, helper){
        debugger;
        const queryString = window.location.search;
        var userid = queryString.split("&id=").pop();	
        var action = component.get("c.getUserRecord");
        var currentDate = new Date();
        var selectedDate = component.get('v.setDate');
        if(selectedDate !=null){
            currentDate=selectedDate;
        }
        // var options = { weekday: 'long',month:'short',year:'numeric',date:'new Date()' };
        // var formattedDate = today.toLocaleDateString(undefined, options);
        
        var daysOfWeek = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
        var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
        
        // Extract the day of the week, day of the month, month, and year
        var dayOfWeek = daysOfWeek[currentDate.getDay()];
        var dayOfMonth = currentDate.getDate();
        var month = months[currentDate.getMonth()];
        var year = currentDate.getFullYear();
        
        // Format the date string
        var formattedDate = `${dayOfWeek}, ${dayOfMonth} ${month} ${year}`;
        
        component.set("v.showdate",formattedDate);
        action.setParams({
            "currentuserid" : userid  
        });
        
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                component.set("v.showPartnerdashboard",true);
                component.set("v.showUserProfile",false);
                
                var data = response.getReturnValue();
                component.set("v.userRecord",data.PortlUserRec);
                if(data!=null){
                    var recid = data.Id;
                    component.set("v.recordid",recid);
                }
            }
        }); 
        $A.enqueueAction(action);   
    }
    
    
})