window.CommercialView = Backbone.View.extend({
    initialize: function() {
        console.log("CommercialView is initialized!!");
        this.template = _.template(tpl.get('commercial-page'));

        // Get the business types
        var url = window.config.baseUrl + "/enroll/businessTypes";
        console.log('Making a REST GET call to fetch Business Types. URL [' + url + ']');
        var self = this;
        var xmlRequest = $.ajax({
            type: 'GET',
            url: url,
            dataType: 'json',
            async: false
        });

        xmlRequest.done(function(data) {
            self.model.set({businessTypes: data});
        });

        console.log(this.model.toJSON());
    },

    events: {
        "click #nextBtn":"nextAction",
        "click #geoLocationBtn": "getCurrentZipCode"
    },

    render: function () {
        console.log("CommercialView is rendered!!");
        $(this.el).html(this.template(this.model.toJSON()));
        return this;
    },

    getCurrentZipCode: function() {
        console.log("getCurrentZipCode is clicked!!");
        if(geoPosition.init()) {
            geoPosition.getCurrentPosition(this.successFunc, this.errorFunc);
        }
    },

    successFunc: function(position) {
        var latitude = position.coords.latitude;
        var longitude = position.coords.longitude;
        var coords = latitude + "," + longitude;
        var url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=" + coords + "&sensor=false";
        console.log("Making AJAX call to get address using lat/long [" + url + "]");
        $.ajax({
            type: 'GET',
            url: url,
            dataType: 'json',
            async: false
        }).done(function(data) {
                console.log("Address:", data.results[0]);
//            var currentZip = data.results[0].formatted_address.match(/,\s\w{2}\s(\d{5})/);
                if(data.results && data.results[0] && data.results[0].address_components[6]) {
                    var currentZip = data.results[0].address_components[6].short_name;
                    $('#zip').val(currentZip);
                } else {
                    alert("Zip Code couldn't be found");
                }
            }).fail(function(jqXHR, textStatus) {
                alert("Request failed: " + jqXHR.statusText);
                return false;
            });
    },

    errorFunc: function() {
        alert("Sorry! Geo Position is not supported.");
    },

    nextAction: function (event) {
        console.log("Next button clicked.");
        event.preventDefault();

        // capture all data in variables
        var $zip = this.$('#zip');
        var $currentRate = this.$('#currentRate');
        var $businessType = this.$('#businessType');
        var $billedMonth = this.$('#billedMonth');
        var $billedUsage = this.$('#billedUsage');
        var $billedPeakDemand = this.$('#billedPeakDemand');

        // validations
        if($zip.val() === '') {
            alert('Zip Code: is required.');
            $zip.focus();
            return false;
        }
        if($businessType.val() === '') {
            alert('Business Type: is required.');
            this.$('#businessType').focus();
            return false;
        }
        if($billedMonth.val() === '') {
            alert('Billed Month: is required.');
            $billedMonth.focus();
            return false;
        }

        // Decide the route (matrix or customized)
        // If the customer doesn't provide billed usage OR the usage is more than 1000 MWh (1,000,000 KWh)
        // OR demand is more than 250KW, they should be routed through to customized pricing
        var billedUsage = $billedUsage.val() ? parseInt($billedUsage.val()) : null;
        var billedPeakDemand = $billedPeakDemand.val() ? parseInt($billedPeakDemand.val()) : null;
        console.log('Billed Usage Entered [' + billedUsage + "], Billed Peak Demand Entered [" + billedPeakDemand + "]");

        var selectedBusinessType = _.find(this.model.get('businessTypes'), function(bType) {
            return (bType.businessTypeId == $businessType.val());
        });

        // Set the values in model
        this.model.set({
            "zipCode": $zip.val(),
            "currentRate": $currentRate.val(),
            "businessTypeId": $businessType.val(),
            "selectedBusinessType": selectedBusinessType,
            "billedMonth": $billedMonth.val(),
            "billedUsage": $billedUsage.val(),
            "billedPeakDemand": $billedPeakDemand.val()
        });

        if(!billedUsage || billedUsage > 1000000 || (billedPeakDemand && billedPeakDemand > 250)) {
            console.log("According to input provided, system chose the customized pricing route");
            this.customizedRoute();
        } else {
            console.log("According to input provided, system chose the matrix pricing route");
            this.matrixRoute($zip.val());
        }
    },

    matrixRoute: function(zipCode) {
        // Get the products data from server
        var url = window.config.baseUrl + "/products/zip/" + zipCode;
        console.log('Making a REST call to URL [' + url + ']');

        var self = this;

        var xmlRequest = $.ajax({
            type: 'GET',
            url: url,
            contentType: 'application/json',
            dataType: 'json',
            async: false
        });

        xmlRequest.done(function(products) {
            console.log("REST call succeded!");
            console.log("Total products Found [" + products.length + "]");
            console.log("Grouping Products by TDSPs");
            var tdsps = _.uniq(
                _.map(products, function(product){
                    return product.edcTdsp;
                }), false, function(item) {
                    return item.edcId;
                }
            );
            console.log("Total TDSPs grouped [" + tdsps.length + "]");
            self.model.set({
                products: products,
                tdsps: tdsps,
                matrix: true,
                customized: false
            });
            console.log(self.model.toJSON());
        });

        xmlRequest.fail(function(jqXHR, textStatus) {
            alert("Request failed: " + jqXHR.statusText);
            return false;
        });

        // If call succeded, create next view and pass data
        var productsView = new ProductsView({model: this.model});
        window.appRouter.changePage(productsView);

    },

    customizedRoute: function() {
        console.log("customizedRoute() method called");

        var url = window.config.baseUrl + "/products/productTypes";
        console.log('Making a REST call to get Product Types [' + url + ']');

        var self = this;

        $.ajax({
            type: 'GET',
            url: url,
            contentType: 'application/json',
            dataType: 'json',
            async: false
        })
        .done(function(productTypes) {
            console.log("REST call succeded!");
            console.log("Total product types Found [" + productTypes.length + "]");
            self.model.set({
                productTypes: productTypes
            });
        });

        var repUrl = window.config.baseUrl + "/enroll/reps";
        console.log('Making a REST call to get REPs [' + repUrl + ']');

        $.ajax({
            type:'GET',
            url:repUrl,
            contentType:'application/json',
            dataType:'json',
            async:false
        })
        .done(function (reps) {
            console.log("REST call succeded!");
            console.log("Total reps Found [" + reps.length + "]");
            self.model.set({
                reps: reps
            });
        });


        this.model.set({
            matrix: false,
            customized: true
        });

        console.log(this.model.toJSON());
        var commercialRegisterView = new CommercialRegisterView({model: this.model});
        window.appRouter.changePage(commercialRegisterView);
    }
});
