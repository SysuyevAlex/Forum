ActionController::Routing::Routes.draw do |map|
  map.devise_for :users

  map.resources :messages, :except=>[:index, :show]
  
  map.resources :topics, :except=>[:index, :show]

  map.resources :forums, :collection =>{:search => [:get, :post]} do |forums|
	forums.resources :topics, :only=>[:show]
  end

  map.root :controller => "forums"
  
end
