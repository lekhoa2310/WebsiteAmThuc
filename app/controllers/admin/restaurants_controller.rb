class Admin::RestaurantsController < Admin::BaseController

  def index
    @page = 1
    @restaurants = Restaurant.where(actived: 1).paginate(:page => params[:page], :per_page => 3)
    @page =  params[:page].to_i if params[:page].present?
  end

  def store_pendding
    @page = 1
    @restaurants = Restaurant.where(actived: 0).all.paginate(:page => params[:page], :per_page => 3)
    @page =  params[:page].to_i if params[:page].present?
  end

  def show
    @restaurant = Restaurant.find_by_id params[:id]
  end

  def update
    @restaurant = Restaurant.find_by_id params[:id]
    if @restaurant.update_attributes(actived: 1)
      flash[:success] = "Bạn đã duyệt cho cửa hàng #{@restaurant.name} thành công"
      redirect_to admin_restaurants_path
    else
      flash[:success] = "Bạn đã duyệt cho cửa hàng #{@restaurant.name} thất bại"
      redirect_to admin_restaurants_store_pendding_path
    end
  end


end