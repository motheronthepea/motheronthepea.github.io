var About = (function()
{
    var view;

    var banner;

    /* CONSTRUCTOR */
    var About = function(html) {
        console.log('ABOUT: Constructor');

        view = html;

        banner = view.find('#about-image');
    }

    /* PUBLIC FUNCTIONS */
    var resize = function(viewport){
        setBannerSize(viewport);
    }

    /* PRIVATE FUNCTIONS */
    var setBannerSize = function(viewport){
        var height = viewport.viewportheight - $('header').height()*4;

        banner.css('height',height);

        resizeImage(viewport.viewportwidth,height);
    }

    var resizeImage = function(parentWidth,parentHeight){
        var image = banner.find('img');
        var imageOriginalHeight = 553;
        var imageOriginalWidth = 1400;
        var percentage = parentHeight / imageOriginalHeight;

        image.css('width',(imageOriginalWidth * percentage) + 'px');
        image.css('height',(imageOriginalHeight * percentage) + 'px');

        if(image.width() < parentWidth)
        {
            percentage = parentWidth / imageOriginalWidth;
            image.css('width',(imageOriginalWidth * percentage) + 'px');
            image.css('height',(imageOriginalHeight * percentage) + 'px');
        }

        image.css('top', (parentHeight/2 - (image.height() * .5)) + "px");
        //image.css('left', (parentWidth/2 - (image.width() * .5)) + "px");
    }


    /* SET PUBLIC FUNCTIONS */
    About.prototype = {
        constructor: About,
        resize: resize
    }

    return About;
})();