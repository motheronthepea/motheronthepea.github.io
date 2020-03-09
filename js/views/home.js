var Home = (function()
{
    var view;

    var intro;
    var extra;

    /* CONSTRUCTOR */
    var Home = function(html) {
        console.log('HOME: Constructor');

        view = html;
        intro = view.find('#intro');
        extra = view.find('#extra-info');

        internLink();
    }

    /* PUBLIC FUNCTIONS */
    var resize = function(viewport){
        setVisualCenter();
        setContentCenter(viewport.viewportheight);
    }

    /* PRIVATE FUNCTIONS */
    var internLink = function(){
        intro.find('button').click(function(evt){
            $("html, body").animate({ scrollTop: extra.offset().top-50 },1000);
        });
    }

    var setVisualCenter = function(){

        var visual = intro.find('img');
        var content = intro.find('div');

        var margin = (content.height() - visual.height())*.5;

        if(margin < 0){
            margin = 0;

        }

        visual.css('marginTop',margin);
    }

    var setContentCenter = function(viewportheight){
        var introHeight = intro.height();
        var headerHeight = $('header').height();
        var calculatedHeight = viewportheight - headerHeight;

        var margin = (calculatedHeight - introHeight)*.5;

        if(margin < 50){
            margin = 50;
        }

        intro.css('margin',margin + 'px 0 ');
    }


    /* SET PUBLIC FUNCTIONS */
    Home.prototype = {
        constructor: Home,
        resize: resize
    }

    return Home;
})();