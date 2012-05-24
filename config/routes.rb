IntimeServer::Application.routes.draw do
  authenticated :user do
    root :to => "buses#index"
  end
  root :to => "buses#index"
  devise_for :users
  resources :users, :only => [:show, :index]
  resources :buses
  resources :checks
  resources :bus_stops

  match 'bus_stops' => 'bus_stops#update', :via => :put
  match 'bus_stops' => 'bus_stops#destroy', :via => :delete

  resources :arrivals
end
