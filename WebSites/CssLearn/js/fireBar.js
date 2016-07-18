
(function (document, $, undefined) {
    var loadBar;
    $(document).ajaxSend(function (event, xhr, settings) {
        var obj = jQuery.parseJSON(settings.data);
        loadBar = obj.pluginName;
        $("[data-pluginName='" + loadBar + "']").show();
        delete obj.pluginName;
        settings.data = JSON.stringify(obj);
    });
    $(document).ajaxComplete(function (event, xhr, settings) {
        //alert(jQuery.parseJSON(settings.data).pluginName);
        $("[data-pluginName='" + loadBar + "']").hide();
    });

})(document, jQuery)