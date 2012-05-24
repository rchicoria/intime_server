// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require_tree .

var map;

var flightPlanCoordinates = [];
var markersArray = [];
//var flightPath;

// function gmaps_initialize_w_route() {
//   var latlng = new google.maps.LatLng(40.209508,-8.419712);
//   var myOptions = {
// 	  zoom: 14,
// 	  center: latlng,
// 	  mapTypeId: google.maps.MapTypeId.ROADMAP
//   };

//   map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);

//   flightPath = new google.maps.Polyline({
//     path: flightPlanCoordinates,
//     strokeColor: "#FF0000",
//     strokeOpacity: 1.0,
//     strokeWeight: 2
//   });

//   google.maps.event.addListener(map, 'click', function(event) {
//     flightPath.setMap(null);
//     flightPlanCoordinates.push(event.latLng);
//     flightPath = new google.maps.Polyline({
//     path: flightPlanCoordinates,
//     strokeColor: "#FF0000",
//     strokeOpacity: 1.0,
//     strokeWeight: 2
//     });
//     flightPath.setMap(map);
//     placeMarker(event.latLng);
//   });

// }

function gmaps_initialize() {
  var latlng = new google.maps.LatLng(40.209508,-8.419712);
  var myOptions = {
    zoom: 14,
    center: latlng,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };

  map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);

  for (var i = 0; i < markersArray.length; i++ ) {
    markersArray[i].setMap(map);
  }
}

function clearOverlays() {
  if (markersArray) {
    for (var i = 0; i < markersArray.length; i++ ) {
      markersArray.pop().setMap(null);
    }
  }
  flightPlanCoordinates = [];
  flightPath.setMap(null);
}

function removeLastMarker() {
  if (markersArray) {
    markersArray.pop().setMap(null);
  }
}