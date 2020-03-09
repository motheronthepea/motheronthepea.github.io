var Application = (function()
{
    // components
    var navigation

    //views
    var home;
    var pricing;
    var about;
    var worksteps;
    var contact;

    //workers
    var helper;

    //variables
    var debugHtml;
    var debug;

    /* CONSTRUCTOR */
    var Application = function() {
        debugHtml = $('#debug');
        checkDebugState();

        console.log('APPLICATION: Constructor');

        helper = new Helper();

        setup();

        resize();
        $(window).resize(resize);

        var today = new Date();
        $('#year').text(today.getFullYear());
    }

    /* PUBLIC FUNCTIONS */
    var setupHome = function(){
        var homeHtml = $('#home');
        home = new Home(homeHtml);

        resize();
    }

    var setupPricing = function(){
        var pricingHtml = $('#pricing');
        pricing = new Pricing(pricingHtml,helper);

        resize();
    }

    var setupAbout = function(){
        var aboutHtml = $('#about');
        about = new About(aboutHtml);

        resize();
    }

    var setupWorkSteps = function(){
        var workstepsHtml = $('#worksteps');
        worksteps = new Worksteps(workstepsHtml,helper);

        resize();
    }

    var setupContact = function(){
        var contactHtml = $('#contact');
        contact = new Contact(contactHtml);

        resize();
    }

    /* PRIVATE FUNCTIONS */
    var setup = function(){
        var navigationHtml = $('nav');
        navigation = new Navigation(navigationHtml);

        resize();
    }

    /* PRIVATE FUNCTIONS */
    var resize = function(){

        //viewport size
        var viewport = helper.getSize();

        navigation.resize(viewport);

        if(home){
            home.resize(viewport);
        }

        if(about){
            about.resize(viewport);
        }

        if(pricing){
            pricing.resize(viewport);
        }

        if(worksteps){
            worksteps.resize(viewport);
        }

        if(contact){
            contact.resize(viewport);
        }
    }

    var checkDebugState = function()
    {
        if(debugHtml.css('display') == "none")
        {
            debug = false;
            console.log = function() {}
        }
        else
        {
            debug = true;
        }
    }

    /* SET PUBLIC FUNCTIONS */
    Application.prototype = {
        constructor: Application,
        setupHome: setupHome,
        setupPricing: setupPricing,
        setupAbout: setupAbout,
        setupWorkSteps: setupWorkSteps,
        setupContact: setupContact
    }

    return Application;
})();