var Contact = (function()
{
    var view;

    var helper;

    var position;

    var map;

    /* CONSTRUCTOR */
    var Contact = function(html,helperFunction) {
        console.log('CONTACT: Constructor');

        view = html;
        helper = helperFunction;
    }

    /* PUBLIC FUNCTIONS */
    var resize = function(){
    }

    /* SET PUBLIC FUNCTIONS */
    Contact.prototype = {
        constructor: Contact,
        resize: resize
    }

    return Contact;
})();