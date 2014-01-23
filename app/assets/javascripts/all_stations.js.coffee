$(document).ready ->
	tab = window.sessionStorage.getItem 'tab'
	if !tab?
		$("#all_tab").attr 'class', 'tab active'
			
	$("##{tab}").attr 'class', 'tab active'

	$('.tab').click (e) ->
		window.sessionStorage.setItem 'tab', $(@).attr('id')
		$('.tab').attr 'class', 'tab'
		$(@).attr 'class', 'tab active'		
		