class Dashboard::StaffsController <  Dashboard::BaseController
  before_action :find_restaurant

  def index
    @page = 1
    @staffs = @restaurant.staffs.paginate(:page => params[:page], :per_page => 3)
    @page =  params[:page].to_i if params[:page].present?
  end

  def new
    @staff = @restaurant.staffs.new
  end

  def create
    @staff = @restaurant.staffs.new staff_params
    if @staff.save
      flash[:success] = "Thêm nhân viên thành công"
      redirect_to dashboard_restaurant_staffs_path
    else
      # flash[:error] = "Thêm nhân viên thất bại"
      render :new
    end
  end

  def edit
    @staff = Staff.find_by_id params[:id]
    @male = false
    @female = false
    if @staff.gender == true
      @male = true
    else
      @female = true
    end
  end

  def update
    @staff = Staff.find_by_id params[:id]
    if @staff.update_attributes(staff_params)
      flash[:success] = "Chỉnh sửa nhân viên thành công"
      redirect_to dashboard_restaurant_staffs_path
    else
      flash[:error] = "Chỉnh sửa nhân viên thất bại"
      render :edit
    end
  end

  def destroy
    @staff = Staff.find_by_id params[:id]
    if @staff.destroy
      flash[:success] = "Xóa nhân viên thành công"
      redirect_to dashboard_restaurant_staffs_path
    else
      flash[:error] = "Xóa nhân viên thất bại"
      render :edit
    end
  end
  private

  def staff_params
    params.require(:staff).permit(:kind, :name, :salary, :phone, :birthday, :gender)
  end
  def find_restaurant
    @restaurant = Restaurant.find_by_id params[:restaurant_id]
  end
end
