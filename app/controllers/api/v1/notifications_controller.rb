module Api::V1
  class NotificationsController < ApiController

    def check_notification
      @restaurant_hash = []
      @noti_restaurant = 0
      @noti_user = 0
      
      @order_shipping_users = @current_user.orders.where(actived: 1).order("created_at asc")
      if @order_shipping_users.present?
        @order_shipping_users.each do |ship|
          @noti_user += 1
        end
      end

      @restaurants = @current_user.restaurants.order("created_at asc")
      if @restaurants.present?
        @restaurants.each do |restaurant|
          @order_pendings = restaurant.orders.where(actived: 0).order("created_at asc")
          if @order_pendings.present?
            @noti_restaurant += 1
            @restaurant_hash = @restaurant_hash.push(name: restaurant.name,id: restaurant.id, num: @order_pendings.length)
          end
        end
      end
      @noti = @noti_user + @noti_restaurant
      render json: {
        success: true,
        data: {
          noti: @noti,
          noti_user: @noti_user,
          noti_restaurant: @noti_restaurant,
          restaurant_hash: @restaurant_hash
        }
      }
    end

  end
end
