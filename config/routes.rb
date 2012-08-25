Dctrs::Application.routes.draw do
  get "search" => "search#index"
  root :to => 'home#index'
end
