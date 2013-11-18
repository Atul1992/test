window.CommercialRegisterView = Backbone.View.extend( {
    initialize: function () {
        console.log("CommercialRegisterView initialized!");
        this.template = _.template(tpl.get('commercial-register-page'));
    },

    render: function() {
        console.log("CommercialRegisterView rendered!");
        $(this.el).html(this.template(this.model.toJSON()));
        return this;
    },

    events: {
        'click #back': 'backAction',
        'click #enroll': "enroll",
        'change #sameAsBilling': "copyAddressToService",
        'change #loaSameAsBilling': "copyAddressToLoa"
    },

    backAction: function(event) {
        console.log('Back Action called. Matrix: ' + this.isMatrix() + ', Customized: ' + this.isCustomized());
        event.preventDefault();

        if(this.isMatrix()) {
            var productsView = new ProductsView({model: this.model});
            window.appRouter.changePage(productsView);
        } else if (this.isCustomized()) {
            var commercialView = new CommercialView({model: this.model});
            window.appRouter.changePage(commercialView);
        }
    },

    copyAddressToService: function(event) {
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

    copyAddressToLoa: function(event) {
        if($(event.currentTarget).is(":checked")) {
            $('#loaAddressLine1').val($('#billingAddressLine1').val());
            $('#loaAddressLine2').val($('#billingAddressLine2').val());
            $('#loaCity').val($('#billingCity').val());
            $('#loaState').val($('#billingState').val()).selectmenu("refresh", true);
            $('#loaZip').val($('#billingZip').val());
            $('#loaCountry').val($('#billingCountry').val()).selectmenu("refresh", true);
        } else {
            $('#loaAddressLine1').val("");
            $('#loaAddressLine2').val("");
            $('#loaCity').val("");
            $('#loaState').val("").selectmenu("refresh", true);
            $('#loaZip').val("");
            $('#loaCountry').val("").selectmenu("refresh", true);
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
        if($('#companyName').val() === '') {
            alert('Enter Company Name');
            $('#companyName').focus();
            return false;
        }
        if($('#billingPhoneNo').val() === '') {
            alert('Enter Phone');
            $('#billingPhoneNo').focus();
            return false;
        }
        if($('#federalTaxID').val() === '') {
            alert('Enter Federal Tax ID');
            $('#federalTaxID').focus();
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
        if($('#serviceAddressLine1').val() === '') {
            alert('Enter Service Address Line 1');
            $('#serviceAddressLine1').focus();
            return false;
        }
        if($('#loaFirstName').val() === '') {
            alert('Enter LOA Personal First Name');
            $('#loaFirstName').focus();
            return false;
        }
        if($('#termsConditions').prop("checked") === false) {
            alert('Please accept terms & conditions');
            $('#termsConditions').focus();
            return false;
        }

        var formData = this.getFormData();
        if(this.isCustomized()) {
            formData.product = null;
            formData.loaPersonalFirstName = $('#loaFirstName').val();
            formData.loaPersonalLastName = $('#loaLastName').val();
            formData.loaPersonalTitle = $('#loaTitle').val();
            formData.loaPersonalContact = this.getLoaContactData();
            formData.preferences = this.getPreferencesData();
        }

        console.log(formData);

        var postData = this.formToJSON(formData);
        var url = window.config.baseUrl + "/enroll/customer";
        console.log('Making a REST POST call to URL [' + url + ']');
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

    isMatrix: function() {
        return this.model.get('matrix');
    },

    isCustomized: function() {
        return this.model.get('customized');
    },

    getEnrollmentType: function() {
        if(this.isMatrix()) {
            return "M";
        } else if (this.isCustomized()) {
            return "C";
        }

        return null;
    },

    getFormData: function() {
        return {
            "enrollmentId": null,
            "enrollmentType": this.getEnrollmentType(),
            "customerType": "B",
            "smartMeter": $('#smartMeter').val(),
            "termsAndConditions": ($('#termsConditions').prop("checked") === true ? 'Y' : 'N'),
            "loaPersonalFirstName":null,
            "loaPersonalLastName":null,
            "loaPersonalTitle":null,
            "currentRate": this.model.get('currentRate'),
            "serviceStartDateRequested": $('#serviceStartDate').val(),
            "serviceStartDateConfirmed": null,
            "agentEmail": (this.model.get('agent.email') ? this.model.get('agent.email') : null),
            "status": {
                "statusId": 1
            },
            "residentialAccount": null,
            "businessAccount": {
                "businessAccountId": null,
                "companyName": $('#companyName').val(),
                "federalTaxId": $('#federalTaxID').val(),
                "billedMonth": this.model.get('billedMonth'),
                "billedUsage": this.model.get('billedUsage'),
                "billedPeakDemand": this.model.get('billedPeakDemand'),
                "businessType": {
                    "businessTypeId": this.model.get("businessTypeId")
                },
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
                    "cellPhoneNo": $('#mobilePhoneNo').val(),
                    "faxNo": $('#faxNo').val(),
                    "email": $('#email').val(),
                    "password": $('#password').val(),
                    "loginType": "U"
                },
                "serviceAddresses": [
                    {
                        "busAcctServiceAddressId": null,
                        "utilityAccountNo": $('#utilityAccountNo').val(),
                        "esi": $('#esi').val(),
                        "businessAccount": null,
                        "serviceContact": {
                            "contactId": null,
                            "contactName": $('#serviceContactName').val(),
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
                    }
                ]
            },
            "product": {
                "productId": (this.model.get('selectedProduct') ? this.model.get('selectedProduct').productId : null)
            }
        };
    },

    getLoaContactData: function() {
        return {
            "contactId":null,
            "contactName":null,
            "contactType":"LA",
            "addressLine1":$('#loaAddressLine1').val(),
            "addressLine2":$('#loaAddressLine2').val(),
            "cityName":$('#loaCity').val(),
            "stateName":$('#loaState').val(),
            "zipCode":$('#loaZip').val(),
            "country":$('#loaCountry').val(),
            "phoneNo":$('#loaPhoneNo').val(),
            "cellPhoneNo":$('#loaMobilePhoneNo').val(),
            "faxNo":$('#loaFaxNo').val(),
            "email":null,
            "password":null,
            "loginType":null
        }
    },

    getPreferencesData: function() {
        return {
            "preferenceId":null,
            "enerygyType":null,
            "customerService":($('#prefCustomerService').prop("checked") === true ? 'Y' : 'N'),
            "rewardPoints":($('#prefRewardPoints').prop("checked") === true ? 'Y' : 'N'),
            "savings":($('#prefSavings').prop("checked") === true ? 'Y' : 'N'),
            "smartEnergySolutions":($('#prefSmartEnegySolutions').prop("checked") === true ? 'Y' : 'N'),
            "notificationInterval":$('#notificationInterval').val(),
            "productTerm":$('#productTerm').val(),
            "productType":{
                "productTypeId":$('#productType').val()
            },
            "rep":{
                "repId":$('#currentRep').val()
            }
        }
    },

    formToJSON: function(data) {
        return JSON.stringify(data);
    }
});