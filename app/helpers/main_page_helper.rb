module MainPageHelper
	def train_info_arrival(time)
		if time == '00:00:00'
        arrival = 'Originates here'
      else 
        arrival = time
      end
	end

	def train_info_depart(time)
		if time == '00:00:00'
			depart = 'Terminates here'
		else depart = time
		end
	end

	def station_info_arrival(time)
		if time = '00:00'
			arrival = 'Originates here'
		else 
			arrival = time 
		end
	end

	def station_info_depart(time)
		if time == '00:00'
        depart = 'Terminates here'
      else 
      	depart = time
      end
	end
end
