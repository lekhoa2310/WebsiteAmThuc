Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :posts

  resources :users do
    member do
      post :change_password

    end
    end

  get"/login" => "sessions#new", as: :login
  post"/sign" => "sessions#create"
  get"/logout" => "sessions#logout"
  get "/api/v1/return_districts_by_city_id"  => "api/v1/districts#return_districts_by_city_id"
end
