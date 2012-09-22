
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


function addMarker(location) {
    var latlong = new google.maps.LatLng(parseFloat(location.Lat), parseFloat(location.Long));
    marker = new google.maps.Marker({
        position: latlong,
        title: location.category,
        icon: '/images/maps/' + location.category + '.png',
        map: gMap
    });

    var content = "<h2>" + location.name + "</h2>" + "<div>" + location.location + "<br /> <a href=" + location.website + " target='_blank'>" + location.website + "</a> </div>";
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
