XMLParser::Application.routes.draw do
  get 'get_info' => 'main_page#fetch', :as => 'get_info'

  root :to  => 'main_page#fetch'
end
