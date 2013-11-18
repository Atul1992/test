$(document).bind("mobileinit", function () {
    console.log('mobileinit');
    $.mobile.ajaxEnabled = false;
    $.mobile.linkBindingEnabled = false;
    $.mobile.hashListeningEnabled = false;
    $.mobile.pushStateEnabled = false;

    $.mobile.defaultPageTransition = "fade";

    // Remove page from DOM when it's being replaced
    $(document).on('pagehide', 'div[data-role="page"]', function (event, ui) {
    	console.log('[' + event.currentTarget + "] removed!");
        $(event.currentTarget).remove();
    });

    // auto focus the first visible input element
    $(document).on('pageshow', 'div[data-role="page"]', function() {
        console.log("pageshow called");
        $($('.ui-page-active :input:visible')[0]).focus();
    });
});
