$(document).ready ->
  hash = gon.returned_station
  myLatLng = new google.maps.LatLng(hash[1].lat, hash[1].lon)
  mapOptions = 
  center: myLatLng
  zoom: 8

  map = new google.maps.Map(document.getElementById("map"),
    mapOptions);

  marker = new google.maps.Marker 
    position: myLatLng
    map: map
    title: hash[0]

  marker.setMap map