
// Our global state
var gLocalSearch;
var gMap;
var gInfoWindow;
var gSearchForm;
var markersArray = [];

$(document).ready(function () {

    initialize();

    $('[type="checkbox"]').click(function () {
        if (this.checked == false) {
            clearOverlay(this.value);
        }
        else {
            for (i in markersArray) {
                if (markersArray[i].title == this.value) {
                    markersArray[i].animation = google.maps.Animation.DROP;
                    markersArray[i].setMap(gMap);
                }
            }
        }
    });

});

function initialize() {

    var mapStyles = [
         { featureType: "road", elementType: "geometry", stylers: [{ hue: "#8800ff" }, { lightness: 100}] }, {
           featureType: "road", stylers: [{ visibility: "on" }, { hue: "#91ff00" }, { saturation: -62 }, { gamma: 1.98 }, { lightness: 45}]}, {
           featureType: "water", stylers: [{ hue: "#005eff" }, { gamma: 0.72 }, { lightness: 42}]}, { 
           featureType: "transit.line", stylers: [{ visibility: "on" }]}, {
           featureType: "administrative.locality", stylers: [ { visibility: "on" }]}, {
           featureType: "administrative.neighborhood", elementType: "geometry",stylers: [{ visibility: "simplified" }]}, {
           featureType: "landscape",stylers: [{ visibility: "on" },{ gamma: 0.41 },{ lightness: 46 }]}, {
           featureType: "administrative.neighborhood", elementType: "labels.text", stylers: [{ visibility: "on" }, { saturation: 33 }, { lightness: 20}]
         }
        ];

    var myLatlng = new google.maps.LatLng(39.951904,-75.158597);

    // Initialize the local searcher
    gLocalSearch = new GlocalSearch();
    gLocalSearch.setSearchCompleteCallback(null, OnLocalSearch);

    var myOptions = { zoom: 11, center: myLatlng, styles: mapStyles, mapTypeId: google.maps.MapTypeId.ROADMAP }
    gMap = new google.maps.Map(document.getElementById("map"), myOptions);

 //   $.getJSON("http://bradoyler.github.com/mapdata.json?callback=?", function (data) {
    $.getJSON("/javascripts/bradoyler.json", function (data) {
        var locations = data;

        iw = new google.maps.InfoWindow();
        for (var i = 0; i < locations.length; i++) {
            var location = locations[i].company;

                addMarker(location);          
        }
    });
}

function addMarker(location) {
    var latlong = new google.maps.LatLng(parseFloat(location.Lat), parseFloat(location.Long));
    marker = new google.maps.Marker({
        position: latlong,
        title: location.category,
        icon: '/images/maps/' + location.category + '.png',
        map: gMap
    });

    var content = "<a href='http://www.weworkinphilly.com/companies/" + location.user_id + "'>" + location.name + "</a>" + "<div>" + location.location + "<br /> <a href=" + location.website + " target='_blank'>" + location.website + "</a> </div><div>Type: " + location.category + "</div>";
    createMyInfoWindow(marker, content, gMap);
    markersArray.push(marker);
}

function clearOverlay(category) {
    if (markersArray) {
        for (i in markersArray) {
            if (markersArray[i].title == category) markersArray[i].setMap();
        }
    }
}

function doSearch() {
    var query = document.getElementById("queryInput").value;
    gLocalSearch.setCenterPoint(gMap.getCenter());
    gLocalSearch.execute(query);
}

// Called when Local Search results are returned, we clear the old results and load the new ones.
function OnLocalSearch() {
    if (!gLocalSearch.results) return;

    // Move the map to the first result
    var first = gLocalSearch.results[0];
    gMap.setCenter(new google.maps.LatLng(parseFloat(first.lat), parseFloat(first.lng)));
    gMap.setZoom(9)

}

function createMyInfoWindow(marker, content, map) {
    google.maps.event.addListener(marker, 'click',
                 function () {
                     iw.setContent(content);
                     iw.open(map, marker);
                 });
}
