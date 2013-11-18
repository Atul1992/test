window.ProductsView = Backbone.View.extend( {
    initialize: function () {
        console.log("ProductsView initialized!");
        this.template = _.template(tpl.get('products-page'));
    },

    events: {
        "click #tdspBackBtn": 'backAction',
        "click li a": "productSelectAction"
    },

    render: function() {
        console.log("ProductsView rendered!");
        $(this.el).html(this.template(this.model.toJSON()));
        return this;
    },

    backAction: function(event) {
        event.preventDefault();

        if(this.isResidentialCustomer()) {
            var residentialView = new ResidentialView({model: this.model});
            window.appRouter.changePage(residentialView);
        } else if (this.isCommercialCustomer()) {
            var commercialView = new CommercialView({model: this.model});
            window.appRouter.changePage(commercialView);
        }
    },

    productSelectAction: function(event) {
        event.preventDefault();
        var selectedProductId = event.currentTarget.id;

        // Different forms for different customer type
        if(this.isResidentialCustomer()) {
            this.residentialRegistration(selectedProductId);
        } else if (this.isCommercialCustomer()) {
            this.commercialRegistration(selectedProductId);
        }

    },

    residentialRegistration: function(selectedProductId) {
        // Find the selected product to show on UI
        var selectedProduct = _.find(this.model.get("products"), function(product) {
            return (product.productId == selectedProductId);
        });

        // Set that in the model
        this.model.set({
            selectedProduct: selectedProduct
        });

        console.log(this.model.toJSON());

        // Show Residential Register View
        var residentialRegisterView = new ResidentialRegisterView({model: this.model});
        window.appRouter.changePage(residentialRegisterView);
    },

    commercialRegistration: function(selectedProductId) {
        // Show Commercial Register View
        if(this.model.get('matrix')) {
            var selectedProduct = _.find(this.model.get("products"), function(product) {
                return (product.productId == selectedProductId);
            });

            // Set that in the model
            this.model.set({
                selectedProduct: selectedProduct
            });

            console.log(this.model.toJSON());
        }

        var commercialRegisterView = new CommercialRegisterView({model: this.model});
        window.appRouter.changePage(commercialRegisterView);
    },

    isResidentialCustomer: function() {
        return config.residential === this.model.get('customerType');
    },

    isCommercialCustomer: function() {
        return config.commercial === this.model.get('customerType');
    }
});