window.CustomerModel = Backbone.Model.extend({
	initialize: function () {
		console.log("CustomerModel is initialized.");
	},

	defaults: {
		customerType: ''
	},

    isResidentialCustomer: function() {
        return config.residential === this.customerType;
    },

    isCommercialCustomer: function() {
        return config.commercial === this.customerType;
    }
});