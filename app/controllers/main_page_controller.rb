class MainPageController < ApplicationController

	require 'open-uri'

	def fetch
		@trains_info = Nokogiri::HTML(open('http://api.irishrail.ie/realtime/realtime.asmx/getCurrentTrainsXML_WithTrainType?TrainType=D'))
		@parse_trains_info = @trains_info.css("trainstatus")

	end
end
