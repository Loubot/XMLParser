XMLParser::Application.routes.draw do
  get 'raw_xml'             => 'main_page#fetch',       	    :as => 'raw_xml'
  get 'all_trains'          => 'main_page#all',         	    :as => 'all_trains'  
  get 'train_info'  	      => 'main_page#train_info',  	    :as => 'train_info'
  get 'station_info'	      => 'main_page#station_info',	    :as => 'station_info'
  get 'get_all_stations'    => 'main_page#get_all_stations',  :as => 'get_all_stations'
  get 'search_stations'			=> 'main_page#search_stations',		:as => 'search_stations'
  get 'search_results' 			=> 'main_page#search_results', 		:as => 'search_results'
  root :to  => 'main_page#all'
end
