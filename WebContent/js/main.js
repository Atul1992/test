var AppRouter = Backbone.Router.extend({

	routes: {
		"": "home",
		"residential": "residential",
		"commercial": "commercial",
		"login": "login",
		"customerHome": "customerHome",
        "agentReg": "agentReg",
		"agent": "agent"
	},

	initialize: function () {
		console.log("AppRouter initialized!");
		this.firstPage = true;
        this.customer = new CustomerModel();
    },

	home: function () {
		console.log("Home Route!");
		this.changePage(new HomeView());
	},

    residential: function () {
		console.log("Residential Route!");
		this.customer = new CustomerModel({customerType: config.residential});
        console.log(this.customer.toJSON());
        var residentialView = new ResidentialView({model: this.customer});
		this.changePage(residentialView);
	},

	commercial: function () {
		console.log("Commercial Route!");
		this.customer = new CustomerModel({customerType: config.commercial});
        console.log(this.customer.toJSON());
        var commercialView = new CommercialView({model: this.customer});
		this.changePage(commercialView);
	},

    login: function () {
		console.log("Login Route!");
        console.log(this.customer.toJSON());
        var loginView = new LoginView({model: this.customer});
        this.changePage(loginView);
    },

    customerHome: function () {
		console.log("Customer Home Route!");
        var contactInSession = window.sessionStorage.getItem("contact");
        if(contactInSession) {
            // render customer home
            console.log("Contact found in session storgae");
            var contact = JSON.parse(contactInSession);
            this.customer = new CustomerModel({
                "contact": contact
            });
            console.log(this.customer.toJSON());
            var customerHomeView = new CustomerHomeView({model: this.customer});
            this.changePage(customerHomeView);
        } else {
            window.appRouter.navigate("#", {trigger: true});
        }
    },

    agentReg: function() {
        console.log("Agent Registration Route!");
        this.customer = new CustomerModel({customerType: config.agent});
        console.log(this.customer.toJSON());
        var agentRegisterView = new AgentRegisterView({model: this.customer});
        this.changePage(agentRegisterView);
    },

    agent: function () {
		console.log("Agent Route!");
        this.customer = new CustomerModel({customerType: config.agent, agent: {}});
        var agentInSession = window.sessionStorage.getItem("contact");
        if(agentInSession) {
            // render agent home
            console.log("Agent found in session storgae");
            var agent = JSON.parse(agentInSession);
            this.customer.set({"agent": agent});
            console.log(this.customer.toJSON());
            var agentView = new AgentView({model: this.customer});
            this.changePage(agentView);
        } else {
            window.appRouter.navigate("#login", {trigger: true});
        }
    },

    changePage: function (page) {
		page.$el.attr('data-role', 'page');
		page.render();
		$('body').append(page.$el);
		var transition = $.mobile.defaultPageTransition;
		//We don't want to animate the first page
		if(this.firstPage) {
			transition = 'none';
			this.firstPage = false;
		}
		$.mobile.changePage(page.$el, {changeHash: false, transition: transition});
	}

});

$(document).ready(function () {
    tpl.loadTemplates([
        'home-page', 'residential-page', 'commercial-page',
        'agent-page', 'products-page',
        'residential-register-page', 'commercial-register-page', 'success-page',
        'login-page', 'customer-home-page', 'agent-register-page'
    ],
        function () {
            window.appRouter = new AppRouter();
            Backbone.history.start();
        });
});