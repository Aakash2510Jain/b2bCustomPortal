({
	 hideMessageAfterTime: function(component, event, helper) {
        var durationInMilliseconds = 3000; // Set the desired duration in milliseconds
        
        setTimeout($A.getCallback(function() {
            // Set the showMessage attribute to false after the specified duration
            component.set("v.successMessage", false);
        }), durationInMilliseconds);
    }
})