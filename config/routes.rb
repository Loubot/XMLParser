XMLParser::Application.routes.draw do
  get 'raw_xml'      => 'main_page#fetch',       :as => 'raw_xml'
  get 'all_stations'  => 'main_page#all',         :as => 'all_stations'  
  get 'station_info'  => 'main_page#select_one',  :as=> 'station_info'

  root :to  => 'main_page#fetch'
end
