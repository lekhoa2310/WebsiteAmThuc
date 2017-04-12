module Api::V1
  class CartsController < ApiController

    def choose_food
      @restaurant = Restaurant.find_by_id params[:id]
      @food = Food.find_by_id params[:food_id]
      session[:cart][@restaurant.id] = session[:cart][@restaurant.id].push({'id' => @food.id, 'name' => @food.name, 'quantity' => 1, 'price' => @food.price })
      @total = 10000
      session[:cart][@restaurant.id].each do |f|
        @total += (f['quantity'] * f['price'] )
      end
      render json: {
        success: true,
        data: {
          restaurant_id: @restaurant.id,
          food_id: @food.id,
          food_name: @food.name,
          food_price: @food.price,
          total: @total
        }
      }

    end

    def increase_quantity
      @restaurant = Restaurant.find_by_id params[:id]
      @food = Food.find_by_id params[:food_id]
      @total = 10000
      @quantity = 0
      session[:cart][@restaurant.id].each do |f|
        if f["id"] == @food.id
          f["quantity"] += 1
          @quantity = f["quantity"]
        end
        @total += (f['quantity'] * f['price'] )
      end
        render json: {
        success: true,
        data: {
          restaurant_id: @restaurant.id,
          food_id: @food.id,
          food_name: @food.name,
          food_quantity: @quantity,
          food_price: @food.price,
          total: @total
        }
      }
    end

    def decrease_quantity
      @restaurant = Restaurant.find_by_id params[:id]
      @food = Food.find_by_id params[:food_id]
      @total = 10000
      @quantity = 0
      session[:cart][@restaurant.id].each do |f|
        if f["id"] == @food.id
          f["quantity"] -= 1
          @quantity = f["quantity"]
          if @quantity == 0
            session[:cart][@restaurant.id].delete(f)
            next
          end
        end
        @total += (f['quantity'] * f['price'] )
      end
      render json: {
        success: true,
        data: {
          restaurant_id: @restaurant.id,
          food_id: @food.id,
          food_name: @food.name,
          food_quantity: @quantity,
          food_price: @food.price,
          total: @total
        }
      }
    end

    def cancel_food
      @restaurant = Restaurant.find_by_id params[:id]
      @food = Food.find_by_id params[:food_id]
      @total = 10000
      session[:cart][@restaurant.id].each do |f|
        if f["id"] == @food.id
          session[:cart][@restaurant.id].delete(f)
          next
        end
        @total += (f['quantity'] * f['price'] )
      end
      render json: {
        success: true,
        data: {
          restaurant_id: @restaurant.id,
          food_id: @food.id,
          total: @total
        }
      }
    end


    def cart

    end

  end

end
