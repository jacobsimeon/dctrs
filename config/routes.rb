Dctrs::Application.routes.draw do
  get "search" => "search#index"

  resources :providers, :only => :show
  resources :headers, :only => :index
  resources :taxonomies, :only => :index

  root :to => 'home#index'
end
