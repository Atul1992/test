window.SuccessView = Backbone.View.extend( {
    initialize: function () {
        console.log("SuccessView initialized!");
        this.template = _.template(tpl.get('success-page'));
    },

    render: function() {
        console.log("SuccessView rendered!");
        $(this.el).html(this.template(this.model.toJSON()));
        return this;
    }
});