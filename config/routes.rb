IntimeServer::Application.routes.draw do
  resources :travels

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

  match "/bus_stops_by_coordinates" => "bus_stops#get_by_coordinates"
  match "/check_in" => "buses#check_in"
  match "/check_out" => "buses#check_out"
  match "/ping" => "buses#ping"
end
