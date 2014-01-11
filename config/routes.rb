XMLParser::Application.routes.draw do
  get 'raw_xml'      	=> 'main_page#fetch',       	:as => 'raw_xml'
  get 'all_stations'  => 'main_page#all',         	:as => 'all_stations'  
  get 'train_info'  	=> 'main_page#train_info',  	:as => 'train_info'
  get 'station_info'	=> 'main_page#station_info',	:as => 'station_info'

  root :to  => 'main_page#all'
end
