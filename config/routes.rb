XMLParser::Application.routes.draw do

  get 'login'             => "sessions#new",                :as => 'login'
  get 'logout'            => 'sessions#destroy',            :as => 'logout'
  get 'signup'            => 'users#new',                   :as => 'signup'
  

  resources :users
  resources :sessions, only: [:create, :new, :destroy]


  get 'raw_xml'             => 'main_page#fetch',       	    :as => 'raw_xml'
  get 'all_trains'          => 'main_page#all',         	    :as => 'all_trains'  
  get 'train_info'  	      => 'main_page#train_info',  	    :as => 'train_info'
  get 'station_info'	      => 'main_page#station_info',	    :as => 'station_info'
  get 'get_all_stations'    => 'main_page#get_all_stations',  :as => 'get_all_stations'
  get 'search_stations'			=> 'main_page#search_stations',		:as => 'search_stations'
  get 'nearby_stations' 		=> 'main_page#nearby_stations', 	:as => 'nearby_stations'

  get 'new'                 => 'users#new',                   :as => 'new'
  post 'login'							=> 'users#login', 			          :as => 'login'
  post 'addFavourite'       => 'users#addFavourite',          :as => 'addFavourite'
  root :to  => 'main_page#all'
end
