class Dashboard::FoodsController < Dashboard::BaseController


before_action :find_restaurant
  def index
    @page = 1
    @foods_eat = @restaurant.foods.where(kind: "eat").paginate(:page => params[:page], :per_page => 3)
    @foods_drink = @restaurant.foods.where(kind: "drink").paginate(:page => params[:page], :per_page => 3)
    @page =  params[:page].to_i if params[:page].present?
    @foods_page = @foods_eat
    @foods_page = @foods_drink if @foods_drink.count > @foods_eat.count

  end

  def find_food
    @page = 1
    food_name = params[:food_name]
    @restaurants = Restaurant.find_by_id params[:id]
    @foods = @restaurant.foods.where("name like ?", "%#{food_name}%").paginate(:page => params[:page], :per_page => 3)
    @page =  params[:page].to_i if params[:page].present?

    if @foods.first.nil?
      flash[:error] = "Không tìm thấy thực phẩm "
      redirect_to dashboard_restaurant_foods_path
    end
  end

  def new
    @food = Food.new
  end

  def create
    @food = @restaurant.foods.new food_params
    if @food.save
      flash[:success] = "Thêm thực phẩm thành công"
      redirect_to dashboard_restaurant_foods_path
    else
      flash[:error] = "Thêm thực phẩm thất bại"
      render :new
    end
  end

  def edit
    @food = Food.find_by_id params[:id ]
    @eat = ""
    @drink = ""
    @eat = "selected" if @food.kind == "eat"
    @drink = "selected" if @food.kind == "drink"

  end

  def update
    @food = Food.find_by_id params[:id ]
    if @food.update_attributes(food_params)
      flash[:success] = "Chỉnh sửa đồ ăn thành công"
      redirect_to dashboard_restaurant_foods_path
    else
      flash[:error] = "Chỉnh sửa đồ ăn thất bại"
      render :edit
    end
  end

  def destroy
    @food = Food.find_by_id params[:id ]
    if @food.destroy
      flash[:success] = "Xóa đồ ăn thành công"
      redirect_to dashboard_restaurant_foods_path
    else
      flash[:success] = "Xóa đồ ăn thất bại"
      redirect_to dashboard_restaurant_foods_path
    end
  end

  private

  def food_params
    params.require(:food).permit(:kind, :name, :price, :image )

  end
  def find_restaurant
    @restaurant = Restaurant.find_by_id params[:restaurant_id]
  end
end
