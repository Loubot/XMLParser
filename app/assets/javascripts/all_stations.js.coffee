$(document).ready ->
	tab = window.localStorage.getItem 'tab'
	$("##{tab}").attr 'class', 'tab active'

	$('.tab').click (e) ->
		window.localStorage.setItem 'tab', $(@).attr('id')
		$('.tab').attr 'class', 'tab'
		$(@).attr 'class', 'tab active'		
		