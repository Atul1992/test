window.LoginView = Backbone.View.extend( {
    initialize: function () {
        console.log("LoginView initialized!");
        this.template = _.template(tpl.get('login-page'));
    },

    render: function() {
        console.log("LoginView rendered!");
        this.$el.html(this.template(this.model.toJSON()));
        return this;
    },

    events: {
        "click #loginBtn": "login"
    },

    login: function(event) {
        console.log("Login button clicked.");

        // cancel the default navigation, as we will handle navigation in code
        event.preventDefault();

        // Validation
        if(!$('#email').val()) {
            alert('Email: is required.');
            $('#email').focus();
            return false;
        }
        if(!$('#password').val()) {
            alert('Password: is required.');
            $('#password').focus();
            return false;
        }

        var url = window.config.baseUrl + "/enroll/customer/validate";
        console.log('Making a REST POST call to URL [' + url + ']');
        var postData = this.formToJSON();
        var xmlRequest = $.ajax({
            type: 'POST',
            url: url,
            contentType: 'application/json',
            dataType: 'json',
            data: postData,
            async: false
        });

        // Success callback
        var self = this;
        xmlRequest.done(function(data) {
            console.log("Request succeded", data);
            console.log("Storing the returned contact in session storage");
            window.sessionStorage.setItem("contact", JSON.stringify(data));
            if(data.agent) {
                window.appRouter.navigate("agent", {trigger: true});
            } else {
                window.appRouter.navigate("customerHome", {trigger: true});
            }
        });

        // Error callback
        xmlRequest.fail(function(jqXHR, textStatus) {
            alert("Request failed. Reason [" + jqXHR.statusText + "]");
            return false;
        });
    },

    formToJSON: function() {
        return JSON.stringify({
            "email": $('#email').val(),
            "password": $('#password').val()
         });
    }
});