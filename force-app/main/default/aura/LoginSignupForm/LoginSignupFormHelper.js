({
    validateEmailFormat: function(email) {
        debugger;
        // Perform email validation logic here
        
        // Example: Simple email format validation using regex
        /*  var emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        //  var emailRegex = /^[a-zA-Z0-9._%+-]+@gmail\.com$/;
        if (!emailRegex.test(email)) {
            // Invalid email format
            component.set("v.emailErrorMessageForUserName", "Invalid email address");
            component.set("v.isEmailValidForUserName", false);
        } else {
            // Valid email format
            component.set("v.emailErrorMessageForUserName", "");
            component.set("v.isEmailValidForUserName", true);
        }*/
        var emailRegex =/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        return emailRegex.test(email);
    },
    
    validatePasswordFormat: function(password) {
        debugger;
        // Perform password validation logic here
        
        // Example: Minimum 8 characters validation
       
        return password.length >= 8;
    }
})