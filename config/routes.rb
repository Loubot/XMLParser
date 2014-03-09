XMLParser::Application.routes.draw do
  get "user/new"

  get "user/update"

  get 'raw_xml'             => 'main_page#fetch',       	    :as => 'raw_xml'
  get 'all_trains'          => 'main_page#all',         	    :as => 'all_trains'  
  get 'train_info'  	      => 'main_page#train_info',  	    :as => 'train_info'
  get 'station_info'	      => 'main_page#station_info',	    :as => 'station_info'
  get 'get_all_stations'    => 'main_page#get_all_stations',  :as => 'get_all_stations'
  get 'search_stations'			=> 'main_page#search_stations',		:as => 'search_stations'
  get 'nearby_stations' 		=> 'main_page#nearby_stations', 	:as => 'nearby_stations'


  post 'login'							=> 'user#login', 			             :as => 'login'
  root :to  => 'main_page#all'
end
