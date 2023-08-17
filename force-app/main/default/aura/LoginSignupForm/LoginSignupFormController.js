({
    doInit: function(component, event, helper) {
        debugger;
        // component.set("v.showLoginPage", false);
    },
    userLogin : function(component, event, helper) {
        debugger;
        component.set("v.showSpinner", true);
        var portalUrl = $A.get("$Label.c.PartnerPortalBaseUrl");
        component.set("v.showWelcomePage", true);
        component.set("v.showLoginPage", false);
        
        var uname = component.get("v.username");
        var upass  = component.get("v.password");
        var action = component.get("c.loginUser");
        
        if(uname == null){
            //alert('please Enter User Name first');
        }
        action.setParams({
            "username" : uname,
            "password" : upass
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                component.set("v.showSpinner", false);
                var data = response.getReturnValue();
                if(data != null){
                    var emailmessage = data.Message;
                    if(emailmessage == 'SUCCESS'){
                        var hashcodeid = data.PortlUserRec.Hash_Code__c;
                        var recordid  = data.PortlUserRec.Id;
                        component.set("v.showLoginPage", false);
                        component.set("v.showWelcomePage", true);
                        //alert('You Are Loged In'); 
                        
                        window.location.href = portalUrl+'PartnerWelcomePage?hashcode='+hashcodeid+'&id='+recordid; 
                        component.set("v.emailErrorMessageForUserName", "");
                        component.set("v.isEmailValidForUserName", true);
                    }else if(emailmessage == 'INCORRECT USERNAME OR PASSWORD'){
                        component.set("v.emailErrorMessageForUserName", "INCORRECT USERNAME OR PASSWORD");
                        component.set("v.isEmailValidForUserName", true);
                        component.set("v.showLoginPage", true);
                        // alert('Please enter correct Username & Password');
                    }
                } 
                
                
            }else{
                if(data == null){
                    alert('Please enter correct Username & Password');
                }
            }
        });
        $A.enqueueAction(action);
    },
    forgotPassword : function(component, event, helper){
        component.set("v.changePassword", true); 
        component.set("v.showLoginPage", false);
    },
    generateOTPforPassword  : function(component, event, helper){
        debugger;
        var action = component.get("c.generateOTP");
        var useremail = component.get("v.usernameForOTP");
        var portalUrl = $A.get("$Label.c.PartnerPortalBaseUrl");
        action.setParams({
            "username" : useremail
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                var data = response.getReturnValue();
                
                if(data != null){
                    var recordId = data.recordId;
                    
                    if(data.message == 'SUCCESS'){
                        component.set("v.emailErrorMessageforOTP", "");
                        component.set("v.isEmailforCreateOTPValid", true);
                        component.set("v.showChangePasswordPage", false); 
                        // component.set("v.ResndOTP", true);
                        window.location.href = portalUrl+'ResetPasswordPage?id='+recordId;
                        component.set("v.showResetPassword", true);
                        component.set("v.changePassword", false);
                    }else{
                        component.set("v.emailErrorMessageforOTP", "Invalid email address");
                        component.set("v.isEmailforCreateOTPValid", false);
                    }
                }else{
                    component.set("v.emailErrorMessageforOTP", "Invalid email address");
                    component.set("v.isEmailforCreateOTPValid", false);
                }
                
            } 
        });
        $A.enqueueAction(action);
        
    },
    resendOTP : function(component, event, helper){
        debugger;
        var action = component.get("c.generateOTP");
        var useremail = component.get("v.usernameForOTP");
        
        action.setParams({
            "username" : useremail
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                var data = response.getReturnValue();
                if(data != null){
                    if(data == 'SUCCESS'){
                        component.set("v.emailErrorMessageforOTP", "");
                        component.set("v.isEmailforCreateOTPValid", true);
                        component.set("v.showChangePasswordPage", false); 
                        component.set("v.ResndOTP", true);
                        component.set("v.changePassword", false);
                    }else{
                        component.set("v.emailErrorMessageforOTP", "Invalid email address");
                        component.set("v.isEmailforCreateOTPValid", false);
                    }
                }else{
                    component.set("v.emailErrorMessageforOTP", "Invalid email address");
                    component.set("v.isEmailforCreateOTPValid", false);
                }
                
            } 
        });
        $A.enqueueAction(action);
        
    },
    backtologinform :function(component, event, helper){
        debugger;
        component.set("v.showLoginPage", true); 
        component.set("v.changePassword", false);
        
    },
    backSinguptologinform:function(component, event, helper){
        debugger;
        component.set("v.showLoginPage", true); 
        component.set("v.showSignPage", false); 
        
    },
    newPassword  : function(component, event, helper){
        component.set("v.showChangePasswordPage", false);
        component.set("v.showLoginPage", true);
        
    },
    userSignUp : function(component, event, helper){
        debugger;
        component.set("v.showSignPage", true); 
        component.set("v.showLoginPage", false);
        component.set("v.changePassword", false); 
    },
    validateEmail: function(component, event, helper){
        debugger;
        var email = component.get("v.UserPortalRec.User_Name__c");
        /*var emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        //  var emailRegex = /^[a-zA-Z0-9._%+-]+@gmail\.com$/;
        if (!emailRegex.test(email)) {
            // Invalid email format
            component.set("v.emailErrorMessage", "Invalid email address");
            component.set("v.isEmailValid", false);
        } else {
            // Valid email format
            component.set("v.emailErrorMessage", "");
            component.set("v.isEmailValid", true);
        }*/
        var isEmailValid = helper.validateEmailFormat(email); // Custom helper method for email validation
        //var isPasswordValid = helper.validatePasswordFormat(password); // Custom helper method for password validation
        
        // Update the isLoginDisabled attribute based on email and password validation results
        component.set("v.isLoginDisabled", !(isEmailValid));
        
        
    },
    validateEmailforOTP : function(component, event, helper){
        debugger;
        var email = component.get("v.usernameForOTP");
        var emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        //  var emailRegex = /^[a-zA-Z0-9._%+-]+@gmail\.com$/;
        if (!emailRegex.test(email)) {
            // Invalid email format
            component.set("v.emailErrorMessageforOTP", "Invalid email address");
            component.set("v.isEmailforCreateOTPValid", false);
        } else {
            // Valid email format
            component.set("v.emailErrorMessageforOTP", "");
            component.set("v.isEmailforCreateOTPValid", true);
        }
        
    },
    validateEmailforlogiUser : function(component, event, helper){
        debugger;
        var email = component.get("v.username");
        var isEmailValid = helper.validateEmailFormat(email); // Custom helper method for email validation
        // Custom helper method for password validation
        
        // Update the isLoginDisabled attribute based on email and password validation results
        
    },
    validatePasswordforlogiUser : function(component, event, helper){
        debugger;
        
        var password = component.get("v.password");
        var isPasswordValid = helper.validatePasswordFormat(password); // Custom helper method for password validation
        
        // Update the isLoginDisabled attribute based on email and password validation results
        component.set("v.isLoginDisabled", !(isPasswordValid));
        
    },
    CreateUser : function(component, event, helper){
        debugger;
        
        var action = component.get("c.signUpUser");
        var userRec = component.get("v.UserPortalRec");
        if( (userRec.First_Name__c == null || userRec.First_Name__c == '') ||
           (userRec.Last_Name__c == null || userRec.Last_Name__c == '') ||
           (userRec.Phone__c == null || userRec.Phone__c == '') ||
           (userRec.User_Name__c == null || userRec.User_Name__c == '') ){
            component.set("v.emailErrorMessage", "Please First Fill Mandatory Fields");
            component.set("v.isLoginDisabled", true);
        }else{
            component.set("v.isLoginDisabled", false);
        }
        action.setParams({
            "userPortalRec" : userRec
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                var data = response.getReturnValue();
                if(data != null){
                    if(data.Message =='Success'){
                        component.set("v.showSignPage", false); 
                        component.set("v.signupSuccess", true);
                        //component.set("v.showLoginPage", true); 
                        component.set("v.UserPortalRec","");
                        
                    }else if(data.Message =='Error'){
                        component.set("v.showLoginPage", false);
                        component.set("v.showSignPage", true); 
                    }
                }
                
            } 
        });
        $A.enqueueAction(action);
        
    },
    existingUserSignin : function(component, event, helper){
        debugger;
        var portalUrl = $A.get("$Label.c.PartnerPortalBaseUrl");
        window.location.href =portalUrl;
    },
    handleClick: function(component, event, helper) {
        debugger;
        component.set("v.isButtonDisabled", true);
        
    },
    loginAfterCreateAccount: function(component, event, helper) {
        debugger;
        component.set("v.showLoginPage", true);
        component.set("v.signupSuccess", false);
        
    },
    myFunction : function(component, event, helper) {
        debugger;
        var showPassword = component.get("v.showPassword");
        component.set("v.showPassword", !showPassword);
    }
    
})