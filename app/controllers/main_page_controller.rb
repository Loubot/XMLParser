class MainPageController < ApplicationController

	require 'net/http'
  require 'will_paginate/array'
  require 'rexml/document'

  before_filter :get_station_info, :only => [:fetch, :all, :select_one]

  def get_station_info
    rail_url = "http://api.irishrail.ie/realtime/realtime.asmx/getCurrentTrainsXML"
    
    @xml_data = Net::HTTP.get_response(URI.parse(rail_url)).body
    @doc = REXML::Document.new(@xml_data)
    @allStations = {} 
    #root = @doc.root
    @doc.elements.each('ArrayOfObjTrainPositions/objTrainPositions') do |name|
      hash = {}
      hash[name.elements['PublicMessage'].text] = {lat: name.elements['TrainLatitude'].text, lon: name.elements['TrainLongitude'].text}
       
      @allStations.merge!(hash)
    end
  end

	def fetch
		
    
    @convert = @allStations.assoc('Belfast Central')
    @station = @convert.to_json
  end
	
  def all
    @home_page = 'all_stations'
    @stations = []

    @doc.elements.each('ArrayOfObjTrainPositions/objTrainPositions') do |name|
      @stations << name.elements['PublicMessage'].text
    end
    @stations.sort!
    @stations = @stations.paginate(:page => params[:page])
  end

  def select_one
    @home_page = 'station_info'
    @returned_station = {}
    @returned_station[params[:data]] = @allStations.assoc(params[:data])
    gon.returned_station = @allStations.assoc(params[:data])
  end
end
