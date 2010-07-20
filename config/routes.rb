ActionController::Routing::Routes.draw do |map|
  map.devise_for :users

  map.resources :messages

  map.resources :topics

  map.resources :forums
  
  map.resources :forums, :collection =>{:search => [:get, :post]}

  map.root :controller => "forums"
  
end
