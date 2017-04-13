class RestaurantsController < ApplicationController


  def index
    @restaurants = Restaurant.where(actived: true).paginate(:page => params[:page], :per_page => 4)
  end

  def show
    @restaurant = Restaurant.find_by_id params[:id]
    @foods = @restaurant.foods.order('kind desc').paginate(:page => params[:page], :per_page => 9)
    session[:cart][@restaurant.id] = [] if session[:cart][@restaurant.id].nil?
    @total = 10000
    session[:cart][@restaurant.id].each do |f|
      @total += (f['quantity'] * f['price'] )
    end

  end

  def new_cart
    redirect_to login_path if !@current_user
    @restaurant = Restaurant.find_by_id params[:id]
    @total = 10000
    session[:cart][@restaurant.id].each do |f|
      @total += (f['quantity'] * f['price'] )
    end
  end

  def cart
    total = 10000
    @restaurant = Restaurant.find_by_id params[:id]
    @order = Order.new(user_id: @current_user.id, restaurant_id: @restaurant.id,phone: params[:phone], address: params[:address])
    if @order.save
      session[:cart][@restaurant.id].each do |f|
        @foods_of_order = FoodsOfOrder.new(order_id: @order.id, food_id: f["id"], quantity: f["quantity"], price: f["price"])
        if @foods_of_order.save
          total += (f["quantity"] * f["price"])
          next
        else
          @order.destroy
          break
          flash[:error] = "Đặt hàng thất bại"
          redirect_to restaurant_path(@restaurant)
        end
      end
      @order.update_attributes(total: total)
      flash[:success] = "Đặt hàng thành công"
      redirect_to restaurant_path(@restaurant)
    else
      flash[:error] = "Đặt hàng thất bại"
      redirect_to restaurant_path(@restaurant)
    end
  end

  def find_restaurant
    @page = 1
    restaurant_name = params[:restaurant_name]
    result = Restaurant.where(:actived => 1)
    @restaurants = result.where("name like ?", "%#{restaurant_name}%").paginate(:page => params[:page], :per_page => 3)
    @page =  params[:page].to_i if params[:page].present?

    if @restaurants.first.nil?
      flash[:error] = "Không tìm thấy cửa hàng "
      redirect_to admin_restaurants_path
    end
  end

  def show_foods_drinks
    @restaurant = Restaurant.find_by_id params[:id]
    @foods = @restaurant.foods.where(kind: "drink").paginate(:page => params[:page], :per_page => 4)
  end
end
