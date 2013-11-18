window.HomeView = Backbone.View.extend( {
    initialize: function () {
        console.log("HomeView initialized!");
        this.template = _.template(tpl.get('home-page'));
    },

    render: function() {
        console.log("HomeView rendered!");
        $(this.el).html(this.template());
        return this;
    }
});
