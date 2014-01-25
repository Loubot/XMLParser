class MainPageController < ApplicationController

	require 'net/http'
  require 'will_paginate/array'
  require 'rexml/document'
  require 'json'

  before_filter :get_trains_info,    :only => [:fetch, :train_info]
  before_filter :get_station_coords,  :only => [:station_info]

  def get_station_coords
    rail_url = "http://api.irishrail.ie/realtime/realtime.asmx/getAllStationsXML"
    
    @xml_data = Net::HTTP.get_response(URI.parse(rail_url)).body
    @doc = REXML::Document.new(@xml_data)
    @allStationsWithCoords = {}
    @doc.elements.each('ArrayOfObjStation/objStation') do |name|
      hash = {}
      hash[name.elements['StationCode'].text.strip] = {  lat: name.elements['StationLatitude'].text,
                                                  lon: name.elements['StationLongitude'].text,
                                                  stationName: name.elements['StationDesc'].text }
      @allStationsWithCoords.merge!(hash)
    end 
  end

  def get_trains_info
    rail_url = "http://api.irishrail.ie/realtime/realtime.asmx/getCurrentTrainsXML"
    
    @xml_data = Net::HTTP.get_response(URI.parse(rail_url)).body
    @doc = REXML::Document.new(@xml_data)
    @allTrains = []
    #root = @doc.root
    @doc.elements.each('ArrayOfObjTrainPositions/objTrainPositions') do |name|
      message = name.elements['PublicMessage'].text.split('\\n')
      hash = {desc: message[1],lat: name.elements['TrainLatitude'].text, lon: name.elements['TrainLongitude'].text, 
                                                    code: name.elements['TrainCode'].text }
       
      @allTrains << hash
    end
  end

	def fetch
		
    
    @convert = @allStations.assoc('Belfast Central')
    @station = @convert.to_json
  end
	
  def all
    flash.now['success'] = params[:data]
    @home_page = 'all_stations'

    rail_url = "http://api.irishrail.ie/realtime/realtime.asmx/getCurrentTrainsXML_WithTrainType?TrainType=#{params[:data]}"
    
    @xml_data = Net::HTTP.get_response(URI.parse(rail_url)).body
    @doc = REXML::Document.new(@xml_data)
    @allStations = []
    #root = @doc.root
    @doc.elements.each('ArrayOfObjTrainPositions/objTrainPositions') do |name|
      message = name.elements['PublicMessage'].text.split('\\n')
      hash = {desc: message[1],lat: name.elements['TrainLatitude'].text, lon: name.elements['TrainLongitude'].text, 
                                                    code: name.elements['TrainCode'].text }
       
      @allStations << hash
    end
    
    @stations = @allStations.paginate(:page => params[:page])

    respond_to do |format|
      format.html
      format.json { render json: @allStations.to_json }
    end
  end

  def train_info
    
    @home_page = 'station_info'
    @returned_station = {}
    
    @returned_train = @allTrains.detect {|station| station[:code] == params[:data] }
    gon.returned_station = @returned_train
    
    #start get train movements
    #train = @allStations[(params[:data])]
    @date = Time.now.strftime("%d%B%Y")
    
    rail_url = "http://api.irishrail.ie/realtime/realtime.asmx/getTrainMovementsXML?TrainId=#{params[:data]}&TrainDate=#{@date}"
    
    @xml_data = Net::HTTP.get_response(URI.parse(rail_url)).body
    @doc = REXML::Document.new(@xml_data)
    @allTrains = []
    @doc.elements.each('ArrayOfObjTrainMovements/objTrainMovements') do |train| 
      arrival = train_info_arrival(train.elements['ExpectedArrival'].text)

      departure = train_info_depart(train.elements['ExpectedDeparture'].text)      
      
      hash = { stop:train.elements['LocationFullName'].text,
                stopCode:train.elements['LocationCode'].text,
                origin:train.elements['TrainOrigin'].text,
                exArrival:arrival,
                exDepart: departure,
                current?:train.elements['StopType'].text,
                destination:train.elements['TrainDestination'].text}
      @allTrains << hash
      
    end 

    respond_to do |format|
      format.html
      format.json { render json: { stops: @allTrains, coords: @returned_train } }
    end
  end

  def station_info   
    @home_page = "orange" 
    #@station = params[:data].gsub(' ','+' )
    @stationMessage = @allStationsWithCoords[params[:data]][:station]
    @rail_url = "http://api.irishrail.ie/realtime/realtime.asmx/getStationDataByCodeXML_WithNumMins?StationCode=#{params[:data]}&NumMins=90"
    @xml_data = Net::HTTP.get_response(URI.parse(@rail_url)).body
    @stationDoc = REXML::Document.new(@xml_data)
    @stationByTime = []

    @stationDoc.elements.each('ArrayOfObjStationData/objStationData') do |station|
      arrival = station_info_arrival(station.elements['Exparrival'].text)
      
      depart = station_info_depart(station.elements['Expdepart'].text)

      
      hash = { origin:station.elements['Origin'].text,
               destination: station.elements['Destination'].text,
               arrival: arrival,
               depart: depart,
               due: station.elements['Duein'].text,
               code: station.elements['Traincode'].text.strip }
      @stationByTime << hash
    end
     
    gon.returned_station = @allStationsWithCoords[params[:data]]
    @stationByTime
    returned_station = @allStationsWithCoords[params[:data]]

    respond_to do |format|
    format.html
    format.json { render json: {station:@stationByTime, coords:@allStationsWithCoords[params[:data]] } }
    end
  end  

  def get_all_stations
    @rail_url = "http://api.irishrail.ie/realtime/realtime.asmx/getAllStationsXML_WithStationType?StationType=#{params[:type]}"
    @xml_data = Net::HTTP.get_response(URI.parse(@rail_url)).body
    
    @allStations = Hash.from_xml(@xml_data)['ArrayOfObjStation']['objStation']
    @returnAllStations = @allStations.sort_by { |station| station['StationDesc'] }
    render json: @returnAllStations
  end
end
