window.CustomerHomeView = Backbone.View.extend( {
    initialize: function () {
        console.log("CustomerHomeView initialized!");
        if(this.model.get('contact')) {
            var url = window.config.baseUrl + "/enroll/customer/get";
            console.log('Making a REST POST call to URL [' + url + ']');
            var postData = JSON.stringify(this.model.get('contact'));
            console.log('POST Data:', postData);
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
                self.model.set({
                    "enrollment": data
                })
            });
        }

        // Decide here which template to render, End user, commercial or agent
        this.template = _.template(tpl.get('customer-home-page'));
    },

    render: function() {
        console.log("CustomerHomeView rendered!");
        $(this.el).html(this.template(this.model.toJSON()));
        return this;
    },

    events: {
        "click #logout": "logoutAgent"
    },

    logoutAgent: function(event) {
        if(window.sessionStorage) {
            console.log("Removing the contact from session storage");
            window.sessionStorage.removeItem("contact");
        }

        return true;
    }
});
