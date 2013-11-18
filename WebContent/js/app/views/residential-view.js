window.ResidentialView = Backbone.View.extend({
    initialize: function() {
        console.log("ResidentialView is initialized!!");
        this.template = _.template(tpl.get('residential-page'));
    },

    events: {
        "click #searchBtn":"search",
        "click #geoLocationBtn": "getCurrentZipCode"
    },

    render: function () {
        console.log("ResidentialView is rendered!!");
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
        var url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=" + coords + "&sensor=true";
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

    search: function (event) {
        console.log("Search Products button clicked.");

        // Cancel the regular event flow
        event.preventDefault();

        // Gather data
        var $zip = $('#zip');
        var $currentRate = $('#rate');

        // validate requried fields
        if($zip.val() === '') {
            alert('Enter Zip Code!');
            $zip.focus();
            return false;
        }

        // Set values in model
        this.model.set({
            zipCode: $zip.val(),
            currentRate: $currentRate.val()
        });

        // Get the products data from server
        var url = window.config.baseUrl + "/products/zip/" + $zip.val();
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
                tdsps: tdsps
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

    }
});
