$(document).ready ->
	path = $(location).attr 'href'
	
	switch path.slice(-1)
			when '/' then $('#all_tab').attr 'class', 'tab active'
			when 'A' then $('#all_tab').attr 'class', 'tab active'
			when 'S' then $('#suburban_tab').attr 'class', 'tab active'
			when 'D' then $('#dart_tab').attr 'class', 'tab active'

	$('.form-control').click (e) ->
		e.stopPropagation()
	# $('#login').click ->
	# 	email = $('#email').val()
	# 	password = $('#pass').val()
	# 	$.ajax(
	# 		url:'http://localhost:3000/login'
	# 		data: {data: [email, password]} 
	# 		type:'get'
	# 		timeout:10000
	# 	).done (data) ->
	# 		alert 'Signed in'
	# 		$('#loginContainer').hide('slow')

			
	
