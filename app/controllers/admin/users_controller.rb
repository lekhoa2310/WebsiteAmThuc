class Admin::UsersController < Admin::BaseController

  def index

    @page = 1
    @users = User.paginate(:page => params[:page], :per_page => 10)
    @page =  params[:page].to_i if params[:page].present?

  end

  def find_user
    @page = 1
    user_name = params[:user_name]
    @users = User.where("name like ?", "%#{user_name}%").paginate(:page => params[:page], :per_page => 10)
    @page =  params[:page].to_i if params[:page].present?
    if @users.first.nil?
      flash[:error] = "Không tìm thấy tài khoản "
      redirect_to admin_users_path
    end
  end

  def new
    @user = User.new
    @cities= City.all
  end


  def create
    @cities= City.all
    @user = User.new user_params
    # @user.gender = 1 if @user.gender.nil?
      if  @user.save
        flash[:success] = "Đăng ký thành công"
        redirect_to admin_users_path
      else
        render :new
      end
  end


  def show
    @user = User.find_by_id params[:id]
    @district = @user.district.name
    @city = @user.district.city.name
    @gender = "Nam"
    @gender = "Nữ " if @user.gender == false
    @role = "Khách hàng"
    @role = "Chủ cửa hàng" if @user.role == 1
  end

  def edit
    @user = User.find_by_id params[:id]
    @cities = City.all
    @city = @user.district.city
    @districts = @city.districts
    @male =false
    @female = false
     if @user.gender == true
      @male = true
     else @user.gender == 0
      @female = true
    end
  end

  def update
    @user = User.find_by_id params[:id]
    @user.assign_attributes(user_update_params)
    if @user.update_attributes(user_update_params)
      # flash[:success] = "Update profile successfully"
      flash[:success] = "Cập nhật thông tin người dùng #{@user.name} thành công"
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  def destroy
    @user = User.find_by_id params[:id]
    if @user.destroy
      flash[:success] = "Xóa người dùng thành công"
      redirect_to admin_users_path
    else
      flash[:error] = "Xóa người dùng thất bại"
      render :index
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password,:password_confirmation, :name,:district_id, :address, :phone, :birthday, :gender)
  end
  def user_update_params
    params.require(:user).permit(:email, :name,:district_id, :address, :phone, :birthday, :gender)
  end

end
