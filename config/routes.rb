Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :admin do
    get 'restaurants/store_pendding', to: 'restaurants#store_pendding'
    resources :restaurants
    resources :users
  end

  namespace :dashboard do
    get 'restaurants/store_pendding', to: 'restaurants#store_pendding'
    resources :restaurants do
      resources :foods
      resources :staffs
    end

  end

  resources :posts
  resources :restaurants
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
