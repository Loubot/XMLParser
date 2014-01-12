class MainPageController < ApplicationController

	require 'net/http'
  require 'will_paginate/array'
  require 'rexml/document'

  before_filter :get_station_info,    :only => [:fetch, :all, :train_info]
  before_filter :get_station_coords,  :only => [:station_info]

  def get_station_coords
    rail_url = "http://api.irishrail.ie/realtime/realtime.asmx/getAllStationsXML"
    
    @xml_data = Net::HTTP.get_response(URI.parse(rail_url)).body
    @doc = REXML::Document.new(@xml_data)
    @allStationsWithCoords = {}
    @doc.elements.each('ArrayOfObjStation/objStation') do |name|
      hash = {}
      hash[name.elements['StationDesc'].text] = {   lat: name.elements['StationLatitude'].text,
                                                  lon: name.elements['StationLongitude'].text}
      @allStationsWithCoords.merge!(hash)
    end 
  end

  def get_station_info
    rail_url = "http://api.irishrail.ie/realtime/realtime.asmx/getCurrentTrainsXML"
    
    @xml_data = Net::HTTP.get_response(URI.parse(rail_url)).body
    @doc = REXML::Document.new(@xml_data)
    @allStations = []
    #root = @doc.root
    @doc.elements.each('ArrayOfObjTrainPositions/objTrainPositions') do |name|
      hash = {desc: name.elements['PublicMessage'].text,lat: name.elements['TrainLatitude'].text, lon: name.elements['TrainLongitude'].text, 
                                                    code: name.elements['TrainCode'].text }
       
      @allStations << hash
    end
  end

	def fetch
		
    
    @convert = @allStations.assoc('Belfast Central')
    @station = @convert.to_json
  end
	
  def all
    @home_page = 'all_stations'
    
    @stations = @allStations.paginate(:page => params[:page])
  end

  def train_info
    
    @home_page = 'station_info'
    @returned_station = {}
    
    @returned_station = @allStations.detect {|station| station[:code] == params[:data] }
    gon.returned_station = @returned_station
    
    #start get train movements
    #train = @allStations[(params[:data])]
    @date = Time.now.strftime("%d%B%Y")
    
    rail_url = "http://api.irishrail.ie/realtime/realtime.asmx/getTrainMovementsXML?TrainId=#{params[:data]}&TrainDate=#{@date}"
    
    @xml_data = Net::HTTP.get_response(URI.parse(rail_url)).body
    @doc = REXML::Document.new(@xml_data)
    @allTrains = []
    @doc.elements.each('ArrayOfObjTrainMovements/objTrainMovements') do |train| 
      hash = { stop:train.elements['LocationFullName'].text,
                origin:train.elements['TrainOrigin'].text,
                exArrival:train.elements['ExpectedArrival'].text,
                exDepart: train.elements['ExpectedDeparture'].text,
                current?:train.elements['StopType'].text,
                destination:train.elements['TrainDestination'].text}
      @allTrains << hash
      
    end 
  end

  def station_info   
    @home_page = "orange" 
    @station = params[:data].gsub(' ','+' )
    @stationMessage = params[:data]
    @rail_url = "http://api.irishrail.ie/realtime/realtime.asmx/getStationDataByNameXML_withNumMins?StationDesc=#{@station}&NumMins=90"
    @xml_data = Net::HTTP.get_response(URI.parse(@rail_url)).body
    @stationDoc = REXML::Document.new(@xml_data)
    @stationByTime = []

    @stationDoc.elements.each('ArrayOfObjStationData/objStationData') do |station|
      hash = { origin:station.elements['Origin'].text,
               destination: station.elements['Destination'].text,
               arrival: station.elements['Exparrival'].text,
               depart: station.elements['Expdepart'].text,
               due: station.elements['Duein'].text,
               code: station.elements['Traincode'].text.strip }
      @stationByTime << hash
    end
    @thisStation = @allStationsWithCoords[params[:data]]
    gon.returned_station = @allStationsWithCoords[params[:data]]
    @stationByTime
  end
end
