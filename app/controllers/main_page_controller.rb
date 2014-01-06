class MainPageController < ApplicationController

	require 'open-uri'

	def fetch
		@trains_info = Nokogiri::XML(open('http://api.irishrail.ie/realtime/realtime.asmx/getAllStationsXML'))
		
		@parse_trains_info_all = @trains_info.at('[text()= "Lisburn"]').parent.text
	end
end
