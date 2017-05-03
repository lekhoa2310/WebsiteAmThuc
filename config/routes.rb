Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do

      resources :districts, only: [] do
        collection do
          get :return_districts_by_city_id
        end
      end

      # resources :restaurants, only: [] do
      #   collection do
      #     get :find_restaurants_by_city
      #   end
      # end
      resources :posts, only: [] do
        member do
          post :like
        end

        collection do
          get :more_post
        end

      end
      resources :comments do
        member do
          post :create_reply_comment
          get :replies
          delete :destroy_reply
        end
      end

      resources :carts, only: [] do
        member do
          post :choose_food
          post :increase_quantity
          post :decrease_quantity
          post :cancel_food
          post :cart
        end
      end

      # resources :reviews, only: [] do
      #   member do
      #     delete :destroy_review
      #   end
      # end

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

      resources :orders, only: [] do
        collection do
          get :orders_pending
          get :orders_shipping
          get :orders_complete
          get :orders_cancel
        end


        member do
          patch :accept_order
          patch :complete_ship
          patch :cancel_order
        end
      end

    end

    resources :orders, only: [] do
      collection do
        get :orders_pending_user
        get :orders_shipping_user
        get :orders_complete_user
        get :orders_cancel_user
      end


      member do
        patch :cancel_order_user
      end
    end

    resources :posts do
      collection do
        get :find_post
      end
    end
  end

  resources :posts do
    collection do
      get :find_post
      get :contact
    end
  end
  # resources :comments
  resources :restaurants do

    resources :reviews
    member do
      get :show_foods_drinks
      get :new_cart
      post :cart

    end

    collection do
      get :find_restaurant
      get :find_restaurant_by_address
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
