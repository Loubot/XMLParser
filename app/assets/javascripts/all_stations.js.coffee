$(document).ready ->
	path = $(location).attr 'href'
	
	switch path.slice(-1)
			when '/' then $('#all_tab').attr 'class', 'tab active'
			when 'A' then $('#all_tab').attr 'class', 'tab active'
			when 'S' then $('#suburban_tab').attr 'class', 'tab active'
			when 'D' then $('#dart_tab').attr 'class', 'tab active'
			


	# tab = window.sessionStorage.getItem 'tab'
	# if !tab?
	# 	$("#all_tab").attr 'class', 'tab active'
			
	# $("##{tab}").attr 'class', 'tab active'

	# $('.tab').click (e) ->
	# 	window.sessionStorage.setItem 'tab', $(@).attr('id')
	# 	$('.tab').attr 'class', 'tab'
	# 	$(@).attr 'class', 'tab active'		
		