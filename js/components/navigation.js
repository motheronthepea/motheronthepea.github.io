var Navigation = (function()
{
    var navigation;

    var navigationState = "right";

    /* CONSTRUCTOR */
    var Navigation = function(html) {
        console.log('NAVIGATION: Constructor');

        navigation = html;
        navButton = $('#navigation-button');

        openCloseNavigation();
    }

    /* PUBLIC FUNCTIONS */
    var resize = function(viewport){
        if(viewport.viewportwidth < 767 && navigationState == "right"){
            navigationState = "left";
            reverse();
        }
        else if(viewport.viewportwidth > 767 && navigationState == "left"){
            navigationState = "right";
            reverse();
        }
    }

    /* PRIVATE FUNCTIONS */
    var reverse = function(){
        console.log('NAVIGATION: reverse');
        var list = navigation.find('div');
        var listItems = list.children('li');
        list.append(listItems.get().reverse());
    }

    var openCloseNavigation = function(){

        navButton.click(function(){
            if(navigation.css('display') == "none"){
                //show navigation
                navigation.slideDown();
                navButton.find('img').attr('src','/images/navigation/hamburger-close.png');
            }
            else
            {
                //hide navigation
                navigation.slideUp();
                navButton.find('img').attr('src','/images/navigation/hamburger.png');
            }
        })
    }

    /* SET PUBLIC FUNCTIONS */
    Navigation.prototype = {
        constructor: Navigation,
        resize: resize
    }

    return Navigation;
})();