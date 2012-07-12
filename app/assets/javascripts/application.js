// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree ./required

// Enable pusher logging - don't include this in production
Pusher.log = function(message) {
  if (window.console && window.console.log) window.console.log(message);
};

// Flash fallback logging - don't include this in production
WEB_SOCKET_DEBUG = true;

var pusher_connect = new Pusher('199ae07749c9a979af5c');

$(document).ready(function(){
  
});


window.golfer = window.golfer || {
    	map: function() {
    		var	// get the page's canvas container
    			mapCanvas = document.getElementById('map_canvas'),
    			// define the Google Maps options
    			map_options = {
    				zoom: 15,
    				// let's initially center on downtown Austin
    				center: new google.maps.LatLng( 30.264664, -97.747378 ),
    				mapTypeId: google.maps.MapTypeId.ROADMAP
    			},
    			// then create the map
    			map = new google.maps.Map( mapCanvas, map_options ),

    			myMarker = 0,
    			displayLocation = function( position ) {
    				// create a new LatLng object for every position update
    				var myLatLng = new google.maps.LatLng( position.coords.latitude, position.coords.longitude );

    				// build entire marker first time thru
    				if ( !myMarker ) {
    					// define our custom marker image
    					var image = new google.maps.MarkerImage(
    						'bluedot_retina.png',
    						null, // size
    						null, // origin
    						new google.maps.Point( 8, 8 ), // anchor (move to center of marker)
    						new google.maps.Size( 17, 17 ) // scaled size (required for Retina display icon)
    					);

    					// then create the new marker
    					myMarker = new google.maps.Marker({
    						flat: true,
    						icon: image,
    						map: map,
    						optimized: false,
    						position: myLatLng,
    						title: 'Your Location',
    						visible: true
    					});

    				// just change marker position on subsequent passes
    				} else {
    					myMarker.setPosition( myLatLng );
    				}

    				// center map view on every pass
    				map.setCenter( myLatLng );
    			},
    			handleError = function( error ) {
    				var errorMessage = [ 
    					'We are not quite sure what happened.',
    					'Sorry. Permission to find your location has been denied.',
    					'Sorry. Your position could not be determined.',
    					'Sorry. Timed out.'
    				];

    				alert( errorMessage[ error.code ] );
    			},
    			// cache the userAgent
    			useragent = navigator.userAgent;

    		// set the map canvas's height/width (Google Maps needs inline height/width)
    		mapCanvas.style.width = mapCanvas.style.height = '100%';

    		// allow iPhone or Android to track movement
    		if ( useragent.indexOf('iPhone') !== -1 || useragent.indexOf('Android') !== -1 ) {
    			navigator.geolocation.watchPosition( 
    				displayLocation, 
    				handleError, 
    				{ 
    					enableHighAccuracy: true, 
    					maximumAge: 30000, 
    					timeout: 27000 
    				}
    			);			

    		// or let other geolocation capable browsers to get their static position
    		} else if ( navigator.geolocation ) {
    			navigator.geolocation.getCurrentPosition( displayLocation, handleError );
    		}
    	}
    };
  