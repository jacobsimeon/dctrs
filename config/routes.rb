Dctrs::Application.routes.draw do
  get "search" => "search#index"
  resources :providers, :only => :show
  root :to => 'home#index'
end
