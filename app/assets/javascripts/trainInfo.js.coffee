# $(document).ready ->
# 	$('.trainInfo').click (event) ->
# 		event.preventDefault()
# 		info = $(@).attr('data').replace(' ', '+')
# 		$.ajax
# 			type: 'get'
# 			url: '/station_info'
# 			data: { data: info }
# 			dataType : 'json'
# 			success: (json) ->
# 				alert 'yos ' + JSON.stringify json
# 			error: (error) ->
# 				alert 'shite ' + JSON.stringify error

