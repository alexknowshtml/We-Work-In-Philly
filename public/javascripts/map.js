
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
                if (markersArray[i].title.indexOf(this.value) > -1) {
                    var currentIcon = markersArray[i].icon.split("/")[3].split(".")[0];
                    if(markersArray[i].title.indexOf(this.value) < markersArray[i].title.indexOf(currentIcon)) {
                        markersArray[i].icon = '/images/maps/' + this.value + '.png';
                    }
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
        icon: '/images/maps/' + location.category.split(",")[0] + '.png',
        map: gMap
    });

    var content;
    if(location.is_group == true) {
      content = "<a style='font-size:22px; font-family: LeagueGothicRegular' href='/groups/" + location.user_id + "'>" + location.name + "</a><div>" + location.location + "<br /> <a href=" + location.website + " target='_blank'>" + location.website + "</a> ";
    } else {
      content = "<a style='font-size:22px; font-family: LeagueGothicRegular' href='/companies/" + location.user_id + "'>" + location.name + "</a><div>" + location.location + "<br /> <a href=" + location.website + " target='_blank'>" + location.website + "</a> ";
    }

    if(location.jobs != null && location.jobs != "") {
        content = content + "<a href=" + location.jobs + " target='_blank'>[Get a job here]</a> ";
    }
    content = content + "</div>";
    createMyInfoWindow(marker, content, gMap);
    markersArray.push(marker);
}

function clearOverlay(category) {
    if (markersArray) {
        //Get all the checked checkboxes
        var inputs = document.getElementsByTagName("input");
        var checked = [];
        for (i in inputs) {  
            if (inputs[i].type == "checkbox" && inputs[i].checked) {  
                checked.push(inputs[i]);
            }  
        }

        //Go through all of the markers
        for (i in markersArray) {
            //If the given marker is in the category that was just unchecked
            if (markersArray[i].title.indexOf(category) > -1) {
                
                //Go through and make sure the marker isn't in another category that is still checked
                var inAnotherCategory = false;
                var otherCategoryIndex = Number.POSITIVE_INFINITY;
                for(c in checked) {
                    var foundIndex = markersArray[i].title.indexOf(checked[c].value);
                    if(foundIndex > -1 && foundIndex < otherCategoryIndex) {
                        inAnotherCategory = true;
                        otherCategoryIndex = foundIndex;
                        markersArray[i].icon = '/images/maps/' + checked[c].value + '.png';
                        markersArray[i].animation = google.maps.Animation.DROP;
                        markersArray[i].setMap(gMap);
                    }
                }

                //If it's not in any checked category, clear it.
                if(!inAnotherCategory) {
                    markersArray[i].setMap();
                }
            }
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
