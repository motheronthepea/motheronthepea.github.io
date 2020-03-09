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

        position = {lat: 51.051217, lng: 3.739246};

        initMap();
    }

    /* PUBLIC FUNCTIONS */
    var resize = function(){
        var latlng = new google.maps.LatLng(position.lat,position.lng);
        map.setCenter(latlng);
    }

    /* PRIVATE FUNCTIONS */
    var initMap = function(){

        var color =
            [
                {
                    "featureType": "landscape",
                    "stylers": [
                        { "color": "#cdcbc3" }
                    ]
                },{
                "featureType": "water",
                "stylers": [
                    { "color": "#7a7fc4" }
                ]
            },{
                "featureType": "road.highway",
                "stylers": [
                    { "color": "#9bbe7c" }
                ]
            },{
                "featureType": "poi.park",
                "stylers": [
                    { "color": "#8faca0" }
                ]
            },{
                "featureType": "poi.school",
                "stylers": [
                    { "color": "#b6c0b4" }
                ]
            },{
            }
            ]


        //MAP OPTIONS - standard Brussels
        var mapOptions =
        {
            center: new google.maps.LatLng(position.lat, position.lng),
            zoom: 14,
            mapTypeId: google.maps.MapTypeId.ROADMAP,
            styles: color
        }

        //SET MAP
        map = new google.maps.Map(document.getElementById('map'),mapOptions);

        var latlng = new google.maps.LatLng(position.lat,position.lng);
        new google.maps.Marker({
            position: latlng,
            map: map
        });
    }

    /* SET PUBLIC FUNCTIONS */
    Contact.prototype = {
        constructor: Contact,
        resize: resize
    }

    return Contact;
})();