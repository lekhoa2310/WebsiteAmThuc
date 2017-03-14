class Dashboard::FoodsController < Dashboard::BaseController

  def index
    @page = 1
    @restaurant = Restaurant.find_by_id params[:restaurant_id ]
    @foods = @restaurant.foods.paginate(:page => params[:page], :per_page => 3)
    @page =  params[:page].to_i if params[:page].present?
  end

  def new
    @food = Food.new
  end

  def create
    @restaurant = Restaurant.find_by_id params[:restaurant_id ]
    @food = @restaurant.foods.new food_params
    if @food.save
      flash[:success] = "Thêm thực phẩm thành công"
      redirect_to dashboard_foods_path
    else
      flash[:error] = "Thêm thực phẩm thất bại"
      render :new
    end
  end

  private

  def food_params
    params.require(:food).permit(:kind, :name, :price )

  end
end
