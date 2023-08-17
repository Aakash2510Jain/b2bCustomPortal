({
	doInit : function(component, event, helper) {
        debugger;
         component.set("v.hideResetPassPage",true);
         const queryString = window.location.search;
        var urlRecid = queryString.split("?id=").pop();	
		component.set("v.recid",urlRecid);
        
        var action = component.get("c.fetchUserRecordData");
        
        action.setParams({
            "URLrecordid" : urlRecid          
        });
        action.setCallback(this,function(response){
         var state = response.getState();
            if(state === "SUCCESS"){
                var data = response.getReturnValue();
                 component.set("v.userRecord",data);
            }
        });
         $A.enqueueAction(action); 
	},
    checkOTP : function(component, event, helper){
        debugger;
         
        var userallrec = component.get("v.userRecord");
        var newotp = component.get("v.otpNumber");
        var recdId = userallrec.Id;
        var action = component.get("c.removeOTP");
         action.setParams({
            "recId" : recdId          
        });
        action.setCallback(this,function(response){
              var state = response.getState();
             if(state === "SUCCESS"){
                 if(userallrec != null){
                     if(newotp != null){
             if(userallrec.OTP_Number__c == newotp){
                component.set("v.otpErrorMessage", "");
                component.set("v.isOTPValid", true);
                component.set("v.showresetPasswordPage",true);
                component.set("v.hideOtp",false);
                // component.set("v.otpNumber","");
                component.set("v.userClass",  'chnageInput');
                component.set("v.hideotpButton", false);
                component.set("v.disableOtpinput", true);
                component.set("v.isFieldDisabled", false);
                component.set("v.OtpButtonDisabled", true);
                 component.set("v.successMessage", true);
                 helper.hideMessageAfterTime(component, event, helper);
                 
             } else{
                 //alert('Incorrect OTP');
                 component.set("v.otpErrorMessage", "This is invalid OTP please check again in your email");
                 component.set("v.isOTPValid", false);
             }
                     }else if(newotp === ""){
                         component.set("v.isOTPValid", false);
                         
                     }              
                 }
             }
        });
        
        $A.enqueueAction(action);     
       
        },
    validatePassword : function(component, event, helper){
        debugger;
        var password = component.get("v.newpassword");
        

        // Regular expression pattern for password validation
       // var passwordPattern = /^(?=.*[0-9A-Za-z])(?=.*[!@#$%^&*])[A-Za-z0-9!@#$%^&*]{8,}$/;
            var showSaveButton = password.length >= 8;
         component.set("v.chnagepasswordDisabled", !showSaveButton);
       /* if (!passwordPattern.test(password)) {
            // Password does not meet the requirements
            component.set("v.chnagepasswordDisabled", false);
            
        }*/

        component.set("v.isSubmitDisabled", isSubmitDisabled);
    },
    
     
     Changepassword : function(component, event, helper){
        debugger;
        var action =  component.get("c.resetPassword");
         var newpsss  =  component.get("v.newpassword");
        var userRecId = component.get("v.recid");
        var portalUrl = $A.get("$Label.c.PartnerPortalBaseUrl");
        action.setParams({
            "userid" : userRecId,
             "setnewpassword" :newpsss
        });
        
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
               // alert('Your New Password has been changed');
               //  window.location.href = "https://sales-production--customport.sandbox.my.salesforce-sites.com/Portal";
                   component.set("v.showAfterPassworChange", true); 
                component.set("v.showresetPasswordPage",false);
                component.set("v.hideResetPassPage",false);
                
                 
            }
        }); 
        $A.enqueueAction(action); 
    },
    backtoLogin : function(component, event, helper){
        debugger;
        var portalUrl = $A.get("$Label.c.PartnerPortalBaseUrl");
         window.location.href = portalUrl;
    }
})