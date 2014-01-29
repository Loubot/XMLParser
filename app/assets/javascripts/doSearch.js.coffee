$(document).ready ->
	$('#searchStations form').submit (e) ->
		e.preventDefault()
		url = $(@).attr 'action'
		searchParams = $('#_search_stations_results_data').val()
		
			
		$.ajax
			url: url
			data: { data: searchParams }	
			type: 'get'
			dataType: 'json'
			timeout: 10000
			success: (json) ->
				populateResults(json)
			error: (error) ->
				alert JSON.stringify error


populateResults = (stations) ->
	$(stations).each ->
		$('#results').append """#{<%= link_to }"""