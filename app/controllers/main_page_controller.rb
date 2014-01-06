class MainPageController < ApplicationController

	require 'net/http'

  require 'rexml/document'

	def fetch
		rail_url = "http://api.irishrail.ie/realtime/realtime.asmx/getAllStationsXML"
    
    @xml_data = Net::HTTP.get_response(URI.parse(rail_url)).body
    @doc = REXML::Document.new(@xml_data)
    @allStations = {}
    root = @doc.root
    @stations = @doc.elements.each('ArrayOfObjStation/objStation') do |name|
    	hash = {}
    	hash[name.elements['StationDesc'].text] = [name.elements['StationLatitude'].text,name.elements['StationLongitude'].text]
    	 
    	@allStations.merge!(hash)
    end
    @station = @allStations['Belfast Central']
	end
end
