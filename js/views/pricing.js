var Pricing = (function()
{
    var view;

    var pricingTypes;

    var pricingPractice;
    var pricingHome;

    var helper;

    /* CONSTRUCTOR */
    var Pricing = function(html,helperFunction) {
        console.log('PRICING: Constructor');

        view = html;
        pricingTypes = view.find('#pricing-types article');

        helper = helperFunction;

        /*if(helper.getInternetExplorerVersion() < 9 && helper.getInternetExplorerVersion() > -1){
            pricingTypes.find('canvas').css('height',pricingTypes.find('canvas').width());
        }
        else{
            initCanvas();
        }*/

    }

    /* PUBLIC FUNCTIONS */
    var resize = function(viewport){
        pricingTypes.each(function() {

            var type = $(this);
            var size = type.find('div').width()
            var priceHeight = type.find('div p').height();

            type.find('div').css('height',size);
            type.find('div p').css('marginTop',(size - priceHeight) *.5);

            //initCanvas();
        });
    }

    /* PRIVATE FUNCTIONS */
    var initCanvas = function(){
        pricingTypes.each(function(){

            var type = $(this);
            var canvas = type.find('canvas')[0];
            var context = type.find('canvas')[0].getContext('2d');
            var price = type.find('canvas').find('p').text();
            var pattern = new Image();
            var background = new Image();

            canvas.width = type.find('canvas').width();
            canvas.height = type.find('canvas').width();

            type.find('canvas').attr('width',type.find('canvas').width());
            type.find('canvas').attr('height',type.find('canvas').width());

            pattern.onload = function(){

                context.drawImage(background, 0, 0, canvas.width, canvas.height);

                /// change composite mode to use that shape
                context.font='bold '+(type.find('canvas').width()/2.8)+'px "Slabo 13px"';
                context.textBaseline = 'middle';
                context.textAlign = 'center';
                context.fillText(price,canvas.width/2,canvas.height/2);

                context.textAlign="center";
                context.globalCompositeOperation = 'source-in';

                context.drawImage(pattern, 0, 0, canvas.width, canvas.width);
            }

            pattern.src = "/images/pricing/pricing-pattern.jpg";
        });
    }

    /* SET PUBLIC FUNCTIONS */
    Pricing.prototype = {
        constructor: Pricing,
        resize: resize
    }

    return Pricing;
})();