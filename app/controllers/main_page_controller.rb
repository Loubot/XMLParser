class MainPageController < ApplicationController

	require 'net/http'

  require 'rexml/document'

  before_filter :get_station_info, :only => [:fetch, :all, :select_one]

  def get_station_info
    rail_url = "http://api.irishrail.ie/realtime/realtime.asmx/getAllStationsXML"
    
    @xml_data = Net::HTTP.get_response(URI.parse(rail_url)).body
    @doc = REXML::Document.new(@xml_data)
    @allStations = {} 
    #root = @doc.root
    @doc.elements.each('ArrayOfObjStation/objStation') do |name|
      hash = {}
      hash[name.elements['StationDesc'].text] = {lat: name.elements['StationLatitude'].text, lon: name.elements['StationLongitude'].text}
       
      @allStations.merge!(hash)
    end
  end

	def fetch
		
    
    @convert = @allStations.assoc('Belfast Central')
    @station = @convert.to_json
  end
	
  def all
    
    @stations = []

    @doc.elements.each('ArrayOfObjStation/objStation') do |name|
      @stations << name.elements['StationDesc'].text
    end
    @stations.sort!
  end

  def select_one
    @returned_station = @allStations.assoc(params[:data])
    gon.returned_station = @allStations.assoc(params[:data])
  end
end
