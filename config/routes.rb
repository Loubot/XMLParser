XMLParser::Application.routes.draw do
  get 'get_info'      => 'main_page#fetch', :as => 'get_info'
  get 'all_stations'  => 'main_page#all',   :as => 'all_stations'  

  root :to  => 'main_page#fetch'
end
