Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do

      resources :districts, only: [] do
        collection do
          get :return_districts_by_city_id
        end
      end
      resources :posts, only: [] do
        member do
          post :like
        end
      end
      resources :comments do
        member do
          post :create_reply_comment
          get :replies
          delete :destroy_reply
        end
      end
    end
  end

  namespace :admin do
    get 'restaurants/store_pendding', to: 'restaurants#store_pendding'
    resources :restaurants do
      collection do
        get :find_restaurant
      end
    end
    resources :users do
      collection do
        get :find_user
      end
    end
    resources :posts do
      collection do
        get :find_post
      end
    end
  end

  namespace :dashboard do
    get 'restaurants/store_pendding', to: 'restaurants#store_pendding'
    resources :restaurants do
      resources :foods do
        collection do
          get :find_food
        end
      end
      resources :staffs do
        collection do
          get :find_staff
        end
      end
    end

    resources :posts do
      collection do
        get :find_post
      end
    end
  end

  resources :posts
  # resources :comments
  resources :restaurants do
    member do
      get :show_foods_drinks
    end
  end
  resources :users do
    member do
      post :change_password
    end
    end

  get"/login" => "sessions#new", as: :login
  post"/sign" => "sessions#create"
  get"/logout" => "sessions#logout"
  # get "/api/v1/return_districts_by_city_id"  => "api/v1/districts#return_districts_by_city_id"
end
