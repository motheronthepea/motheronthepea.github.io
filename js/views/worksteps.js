var Worksteps = (function()
{
    var view;

    var worksteps;

    var helper;

    /* CONSTRUCTOR */
    var Worksteps = function(html,helperFunction) {
        console.log('WORKSTEPS: Constructor');

        view = html;
        worksteps = view.find('#steps article');

        helper = helperFunction;

        if(helper.getInternetExplorerVersion() < 9 && helper.getInternetExplorerVersion() > -1){
            worksteps.find('canvas').css('height',worksteps.find('canvas').width());
        }
        else{
            initCanvas();
        }

    }

    /* PUBLIC FUNCTIONS */
    var resize = function(viewport){
        initCanvas();
    }

    /* PRIVATE FUNCTIONS */
    var initCanvas = function(){

        worksteps.each(function(i){

            var type = $(this);
            var canvas = type.find('canvas')[0];
            var context = type.find('canvas')[0].getContext('2d');
            var price = type.find('canvas').find('h2').text();
            var pattern = new Image();

            canvas.width = type.find('canvas').width();
            canvas.height = type.find('canvas').height();

            pattern.onload = function(){

                pattern.width = canvas.width;
                pattern.height = pattern.width;

                context.font='bold '+(type.find('canvas').width()/2)+'px "Raleway"';
                context.textBaseline = 'middle';
                context.textAlign = 'center';
                context.fillText(price,canvas.width/2,canvas.height/2);
                context.textAlign="center";

                /// change composite mode to use that shape
                context.globalCompositeOperation = 'source-in';

                context.drawImage(pattern, 0, 0, canvas.width, canvas.width);


            }

            i++;

            pattern.src = "/images/worksteps/pattern"+i+".jpg";


        });
    }

    /* SET PUBLIC FUNCTIONS */
    Worksteps.prototype = {
        constructor: Worksteps,
        resize:resize
    }

    return Worksteps;
})();