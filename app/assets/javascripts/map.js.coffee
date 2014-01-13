$(document).ready ->
  # $(".stationInfo").click (event) ->
  #   event.preventDefault()
  #   $.ajax
  #     type: 'get'
  #     data: { data: $(@).attr 'data' }
  #     dataType: 'json'
  #     url: '/train_info'
  #     success: (json) ->
  #       alert 'yos ' + JSON.stringify json
  #     error: (error) ->
  #       alert 'shite' + JSON.stringify error


  hash = gon.returned_station
  myLatLng = new google.maps.LatLng(hash.lat, hash.lon)
  mapOptions = 
  center: myLatLng
  zoom: 14
  mapTypeId: google.maps.MapTypeId.ROADMAP

  map = new google.maps.Map(document.getElementById("map"),
    mapOptions);

  marker = new google.maps.Marker 
    position: myLatLng
    map: map
    title: hash[0]

  marker.setMap map