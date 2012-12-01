Dctrs::Application.routes.draw do
  get "search" => "search#index"

  resources :raw_providers, :only => :create
  resources :providers, :only => :show

  root :to => 'home#index'
end
