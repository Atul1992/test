window.AgentView = Backbone.View.extend( {
    initialize: function () {
        console.log("AgentView initialized!");
        this.template = _.template(tpl.get('agent-page'));
    },

    render: function() {
        console.log("AgentView rendered!");
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