window.AgentRegisterView = Backbone.View.extend( {
    initialize: function () {
        console.log("AgentRegisterView initialized!");
        this.template = _.template(tpl.get('agent-register-page'));
    },

    render: function() {
        console.log("AgentRegisterView rendered!");
        $(this.el).html(this.template(this.model.toJSON()));
        return this;
    },

    events: {
        'click #register': "register"
    },

    register: function(event) {
        console.log("Register button clicked.");
        event.preventDefault();
        
        //Get all the data in variables
        var $email = $('#email');
        var $password = $('#password');
        var $contactName = $('#contactName');
        var $addressLine1 = $('#addressLine1');
        var $city = $('#city');
        var $state = $('#state');
        var $zip = $('#zip');
        var $country = $('#country');
        var $phoneNo = $('#phoneNo');

        if($email.val() === '') {
            alert('Enter Email');
            $email.focus();
            return false;
        }
        if($password.val() === '') {
            alert('Enter Password');
            $password.focus();
            return false;
        }
        if($contactName.val() === '') {
            alert('Enter Contact Name');
            $contactName.focus();
            return false;
        }
        if($addressLine1.val() === '') {
            alert('Enter Address Line 1');
            $addressLine1.focus();
            return false;
        }
        if($city.val() === '') {
            alert('Enter City');
            $city.focus();
            return false;
        }
        if($state.val() === '') {
            alert('Enter State');
            $state.focus();
            return false;
        }
        if($zip.val() === '') {
            alert('Enter Zip Code');
            $zip.focus();
            return false;
        }
        if($country.val() === '') {
            alert('Enter Country');
            $country.focus();
            return false;
        }
        if($phoneNo.val() === '') {
            alert('Enter Phone No.');
            $phoneNo.focus();
            return false;
        }


        var url = window.config.baseUrl + "/enroll/agent";
        console.log('Making a REST POST call to URL [' + url + ']');
        var postData = this.formToJSON();
        console.log("POST DATA: ", postData);
        var self = this;
        var xmlRequest = $.ajax({
            type: 'POST',
            url: url,
            contentType: 'application/json',
            dataType: 'json',
            data: postData,
            async: false,
            statusCode: {
                409: function() {
                    alert("User already exists!!");
                }
            }
        });

        console.log(xmlRequest);
        xmlRequest.done(function(msg) {
            console.log("Agent registered successfully!");
            var successView = new SuccessView({model: self.model});
            window.appRouter.changePage(successView);
            return true;
        });

//        xmlRequest.fail(function(jqXHR, textStatus) {
//            alert("Request failed [" + jqXHR.statusText + "], TextStatus [" + textStatus + "]");
//            return false;
//        });
    },

    formToJSON: function() {
        return JSON.stringify({
            "contactId": null,
            "contactType": "AG",
            "loginType": "A",
            "contactName": $('#contactName').val(),
            "addressLine1": $('#addressLine1').val(),
            "addressLine2": $('#addressLine2').val(),
            "cityName": $('#city').val(),
            "stateName": $('#state').val(),
            "zipCode": $('#zip').val(),
            "country": $('#country').val(),
            "phoneNo": $('#phoneNo').val(),
            "cellPhoneNo": $('#mobileNo').val(),
            "faxNo": $('#faxNo').val(),
            "email": $('#email').val(),
            "password": $('#password').val()
        });
    }
});