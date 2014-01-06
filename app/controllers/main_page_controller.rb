class MainPageController < ApplicationController

	require 'net/http'

  require 'rexml/document'

	def fetch
		rail_url = "http://api.irishrail.ie/realtime/realtime.asmx/getAllStationsXML"
    
    @xml_data = Net::HTTP.get_response(URI.parse(rail_url)).body
    @doc = REXML::Document.new(@xml_data)
    @station = []
    root = @doc.root
    @stations = @doc.elements.each('ArrayOfObjStation/objStation') do |name|
    	@station << name.elements['StationLatitude'].text
    end
    
	end
end
