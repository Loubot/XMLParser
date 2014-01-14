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
# 				alert 'trainInfo ' + JSON.stringify json
# 			error: (error) ->
# 				alert 'shite ' + JSON.stringify error

#   $(".stationInfo").click (event) ->
#     event.preventDefault()
#     $.ajax
#       type: 'get'
#       data: { data: $(@).attr 'data' }
#       dataType: 'json'
#       url: '/train_info'
#       success: (json) ->
#         alert 'stationInfo ' + JSON.stringify json
#       error: (error) ->
#         alert 'shite' + JSON.stringify error