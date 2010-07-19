ActionController::Routing::Routes.draw do |map|
  map.devise_for :users

  map.resources :messages

  map.resources :topics

  map.resources :forums

  map.root :controller => "forums"

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
