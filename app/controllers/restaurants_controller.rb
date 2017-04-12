class RestaurantsController < ApplicationController


  def index
    @restaurants = Restaurant.where(actived: true).paginate(:page => params[:page], :per_page => 4)
  end

  def show
    @restaurant = Restaurant.find_by_id params[:id]
    @foods = @restaurant.foods.where(kind: "eat").paginate(:page => params[:page], :per_page => 9)
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
    @restaurant = Restaurant.find_by_id params[:id]

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
