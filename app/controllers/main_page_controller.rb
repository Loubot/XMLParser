class MainPageController < ApplicationController

	require 'net/http'

  require 'rexml/document'

	def fetch
		rail_url = "http://api.irishrail.ie/realtime/realtime.asmx/getCurrentTrainsXML"
    
    @xml_data = Net::HTTP.get_response(URI.parse(rail_url)).body
    @doc = REXML::Document.new(@xml_data)
    @station = []
    @doc.elements.each('ArrayOfObjTrainPositions/objTrainPositions/TrainLatitude') do |a|
    	@station << a.text
    end
	end
end
