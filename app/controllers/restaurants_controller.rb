class RestaurantsController < ApplicationController

  def index
    @page = 1
    @restaurants = @current_user.restaurants.paginate(:page => params[:page], :per_page => 3)
    @page =  params[:page].to_i if params[:page].present?

  end

  def new
    @restaurant = @current_user.restaurants.new
    @cities = City.all
  end

  def create
    @cities = City.all
    @restaurant = @current_user.restaurants.new restaurant_params
    if @restaurant.save
      flash[:success] = "Tạo cửa hàng thành công"
      redirect_to restaurants_path
    else
      # flash[:error] = "Tạo cửa hàng thất bại"
      render :new
    end
  end

  def edit
    @restaurant = Restaurant.find_by_id params[:id]
    if @restaurant.user_id != @current_user.id
      redirect_to restaurants_path
    end
    @cities = City.all
    @city = City.find_by_id @restaurant.district.city.id
    @districts = @city.districts
  end

  def update
    @restaurant = Restaurant.find_by_id params[:id]
    if @restaurant.user_id != @current_user.id
      redirect_to restaurants_path
    end
    if @restaurant.update_attributes(restaurant_params)
      flash[:success] = "Cập nhật cửa hàng #{@restaurant.name} thành công"
      redirect_to restaurants_path
    else
      flash[:error] = "Cập nhật cửa hàng #{@restaurant.name} thất bại"
      render :edit
    end
  end
  def show
    @restaurant = Restaurant.find_by_id params[:id]
  end

  def destroy
    @restaurant = Restaurant.find_by_id params[:id]
    if @restaurant.user_id != @current_user.id
      redirect_to restaurants_path
    end
    if @restaurant.destroy
      flash[:success] = "Xóa cửa hàng thành công"
      redirect_to restaurants_path
    else
      flash[:error] = "Xóa cửa hàng thất bại "
      redirect_to restaurants_path
    end
  end
  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :phone, :district_id, :address)

  end

end
