window.ResidentialRegisterView = Backbone.View.extend( {
    initialize: function () {
        console.log("ResidentailRegisterView initialized!");
        this.template = _.template(tpl.get('residential-register-page'));
    },

    render: function() {
        console.log("ResidentailRegisterView rendered!");
        $(this.el).html(this.template(this.model.toJSON()));
        return this;
    },

    events: {
        'click #back': 'backAction',
        'click #enroll': "enroll",
        'change #sameAsBilling': "copyAddress"
    },

    backAction: function(event) {
        event.preventDefault();
        var productsView = new ProductsView({model: this.model});
        window.appRouter.changePage(productsView);
    },

    copyAddress: function(event) {
        if($(event.currentTarget).is(":checked")) {
            $('#serviceAddressLine1').val($('#billingAddressLine1').val());
            $('#serviceAddressLine2').val($('#billingAddressLine2').val());
            $('#serviceCity').val($('#billingCity').val());
            $('#serviceState').val($('#billingState').val()).selectmenu("refresh", true);
            $('#serviceZip').val($('#billingZip').val());
            $('#serviceCountry').val($('#billingCountry').val()).selectmenu("refresh", true);
        } else {
            $('#serviceAddressLine1').val("");
            $('#serviceAddressLine2').val("");
            $('#serviceCity').val("");
            $('#serviceState').val("").selectmenu("refresh", true);
            $('#serviceZip').val("");
            $('#serviceCountry').val("").selectmenu("refresh", true);
        }
    },

    enroll: function(event) {
        console.log("Save Enroll button clicked.");
        event.preventDefault();
        if($('#email').val() === '') {
            alert('Enter Email');
            $('#email').focus();
            return false;
        }
        if($('#password').val() === '') {
            alert('Enter Password');
            $('#password').focus();
            return false;
        }
        if($('#firstName').val() === '') {
            alert('Enter First Name');
            $('#firstName').focus();
            return false;
        }
        if($('#lastName').val() === '') {
            alert('Enter Last Name');
            $('#lastName').focus();
            return false;
        }
        if($('#birthDate').val() === '') {
            alert('Enter Birth Date');
            $('#birthDate').focus();
            return false;
        }
        if($('#ssn').val() === '') {
            alert('Enter SSN');
            $('#ssn').focus();
            return false;
        }
        if($('#driversLicenseNo').val() === '') {
            alert("Enter Driver's License");
            $('#driversLicenseNo').focus();
            return false;
        }
        if($('#serviceStartDate').val() === '') {
            alert('Enter Service Start Date');
            $('#serviceStartDate').focus();
            return false;
        }
        if($('#billingAddressLine1').val() === '') {
            alert('Enter Billing Address Line 1');
            $('#billingAddressLine1').focus();
            return false;
        }
        if($('#billingCity').val() === '') {
            alert('Enter Billing City');
            $('#billingCity').focus();
            return false;
        }
        if($('#billingState').val() === '') {
            alert('Enter Billing State');
            $('#billingState').focus();
            return false;
        }
        if($('#billingZip').val() === '') {
            alert('Enter Billing Zip Code');
            $('#billingZip').focus();
            return false;
        }
        if($('#serviceAddressLine1').val() === '') {
            alert('Enter Service Address Line 1');
            $('#serviceAddressLine1').focus();
            return false;
        }
        if($('#serviceCity').val() === '') {
            alert('Enter Service Address City');
            $('#City').focus();
            return false;
        }
        if($('#serviceState').val() === '') {
            alert('Enter Service Address State');
            $('#State').focus();
            return false;
        }
        if($('#serviceZip').val() === '') {
            alert('Enter Service Address Zip Code');
            $('#Zip').focus();
            return false;
        }
        if($('#termsConditions').prop("checked") === false) {
            alert('Please accept terms & conditions');
            $('#termsConditions').focus();
            return false;
        }

        var url = window.config.baseUrl + "/enroll/customer";
        console.log('Making a REST POST call to URL [' + url + ']');
        var postData = this.formToJSON();
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
            console.log("Customer registered successfully!");
            var successView = new SuccessView({model: self.model});
            window.appRouter.changePage(successView);
            return true;
        });

//        xmlRequest.fail(function(jqXHR, textStatus) {
//            alert("Request failed: " + jqXHR.statusText);
//            return false;
//        });
    },

    formToJSON: function() {
        return JSON.stringify({
            "enrollmentId": null,
            "enrollmentType": "M",
            "customerType": "R",
            "smartMeter": $('#smartMeter').val(),
            "termsAndConditions": ($('#termsConditions').prop("checked") === true ? 'Y' : 'N'),
            "currentRate": this.model.get('currentRate'),
            "serviceStartDateRequested": $('#serviceStartDate').val(),
            "serviceStartDateConfirmed": null,
            "agentEmail": (this.model.get('agent.email') ? this.model.get('agent.email') : null),
            "status": {
                "statusId": 1
            },
            "residentialAccount": {
                "residentialAccountId": null,
                "firstName": $('#firstName').val(),
                "lastName": $('#lastName').val(),
                "middleName": $('#middleName').val(),
                "driversLicenseNo": $('#driversLicenseNo').val(),
                "utilityAccountNo": $('#utilityAccountNo').val(),
                "birthDate": $('#birthDate').val(),
                "esi": $('#esi').val(),
                "ssn": $('#ssn').val(),
                "billingContact": {
                    "contactId": null,
                    "contactName": null,
                    "contactType": "BI",
                    "addressLine1": $('#billingAddressLine1').val(),
                    "addressLine2": $('#billingAddressLine2').val(),
                    "cityName": $('#billingCity').val(),
                    "stateName": $('#billingState').val(),
                    "zipCode": $('#billingZip').val(),
                    "country": $('#billingCountry').val(),
                    "phoneNo": $('#billingPhoneNo').val(),
                    "cellPhoneNo": $('#cellPhoneNo').val(),
                    "faxNo": $('#faxNo').val(),
                    "email": $('#email').val(),
                    "password": $('#password').val(),
                    "loginType": "U"
                },
                "serviceContact": {
                    "contactId": null,
                    "contactName": null,
                    "contactType": "SI",
                    "addressLine1": $('#serviceAddressLine1').val(),
                    "addressLine2": $('#serviceAddressLine2').val(),
                    "cityName": $('#serviceCity').val(),
                    "stateName": $('#serviceState').val(),
                    "zipCode": $('#serviceZip').val(),
                    "country": $('#serviceCountry').val(),
                    "phoneNo": null,
                    "cellPhoneNo": null,
                    "faxNo": null,
                    "email": null,
                    "password": null,
                    "loginType": null
                }
            },
            "businessAccount": null,
            "product": {
                "productId": this.model.get("selectedProduct").productId
            }
        });
    }
});