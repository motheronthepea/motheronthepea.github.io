var Helper = (function ($) {

    /* CONSTRUCTOR */
    var Helper = function () {
        console.log('HELPER: constructor');
    }

    /* PUBLIC FUNCTIONS */
    //get viewport size
    var getSize = function()
    {
        if (typeof window.innerWidth != 'undefined')
        {
            viewportwidth = window.innerWidth,
                viewportheight = window.innerHeight
        }

        // IE6 in standards compliant mode (i.e. with a valid doctype as the first line in the document)
        else if (typeof document.documentElement != 'undefined'
            && typeof document.documentElement.clientWidth !=
            'undefined' && document.documentElement.clientWidth != 0)
        {
            viewportwidth = document.documentElement.clientWidth,
                viewportheight = document.documentElement.clientHeight
        }

        // older versions of IE
        else
        {
            viewportwidth = document.getElementsByTagName('body')[0].clientWidth,
                viewportheight = document.getElementsByTagName('body')[0].clientHeight
        }

        var viewport = {
            viewportwidth: viewportwidth,
            viewportheight: viewportheight
        };

        return viewport;
    }

    //check which browser
    var browserCheck = function()
    {
        var browserName = "";

        var ua = navigator.userAgent.toLowerCase();
        if ( ua.indexOf( "opera" ) != -1 ) {
            browserName = "opera";
            speed = 0.05;
        } else if ( ua.indexOf( "msie" ) != -1 ) {
            browserName = "msie";
            speed = 0.3;
        } else if (ua.indexOf( "chrome" ) != -1) {
            browserName = "chrome";
            speed = 0.15;
        } else if ( ua.indexOf( "safari" ) != -1 ) {
            browserName = "safari";
            speed = 0.15;
        } else if ( ua.indexOf( "mozilla" ) != -1 ) {
            if ( ua.indexOf( "firefox" ) != -1 ) {
                browserName = "firefox";
                speed = 0.05;
            } else {
                browserName = "mozilla";
                speed = 0.05;
            }
        }

        return browserName;
    }

    //check ie version
    var getInternetExplorerVersion = function()
    {
        var rv = -1; // Return value assumes failure.
        if (navigator.appName == 'Microsoft Internet Explorer') {
            var ua = navigator.userAgent;
            var re = new RegExp("MSIE ([0-9]{1,}[\.0-9]{0,})");
            if (re.exec(ua) != null)
                rv = parseFloat(RegExp.$1);
        }
        return rv;
    }

    var is_touch_device = function() {
        return !!('ontouchstart' in window);
    }


    /* SET PUBLIC FUNCTIONS */
    Helper.prototype = {
        constructor: Helper,
        getSize: getSize,
        getInternetExplorerVersion: getInternetExplorerVersion
    }

    return Helper;

})(jQuery);