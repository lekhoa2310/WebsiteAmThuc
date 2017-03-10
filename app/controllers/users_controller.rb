class UsersController < ApplicationController

  def index

  end
  def new
    redirect_to posts_path if @current_user
    @user = User.new
    @cities= City.all
  end

  def get_all_districts
    @districts = District.all
    render :json => {:success => true , :data => @districts}
  end

  def create
    @cities= City.all
    @user = User.new user_params
    # @user.gender = 1 if @user.gender.nil?
      if  @user.save
        flash[:success] = "Registration successfully"
        redirect_to login_path
      else
        render :new
      end
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
        flash[:success] = "Update profile successfully"
        redirect_to posts_path
      else
        render :edit
      end
    end

    def change_password
      @user = @current_user
      @cities = City.all
      @city = @user.district.city
      @districts = @city.districts
      if Digest::MD5::hexdigest(params[:old_password]) == @user.password
          if params[:new_password] == params[:confirm_password]
            @user.update(password: params[:new_password])
            flash[:success] = "Your password was change successfully"
            session[:user_id]=nil
            redirect_to login_path
          else
            flash[:error] = "Confirm password  doesn't match New password"
            render :edit
          end
      else
        flash[:error] = "Old Password invalid"
        render :edit
      end
    end
    # def change_password
    #   @user= User.find(params[:id])
    #   if Digest::MD5::hexdigest(params[:old_password]) == @user.password
    #     if params[:new_password] == params[:confirm_password]
    #       @user.update(password: params[:new_password])
    #       flash[:success] = "Đổi mật khẩu thành công!"
    #     end
    #   else
    #     flash[:error_change] = "Mật khẩu cũ không đúng!"
    #   end
    #   redirect_to edit_user_path
    # end

    # def destroy
    #   @user = User.find_by_id params[:id]
    #   @user.destroy
    #   redirect_to users_path
    # end


  private
  def user_params
    params.require(:user).permit(:email, :password,:password_confirmation, :name,:district_id, :address, :phone, :birthday, :gender)
  end

  def user_update_params
    params.require(:user).permit(:email, :name,:district_id, :address, :phone, :birthday, :gender)
  end
  def change_password_params
    params.permit(:old_password, :new_password, :confirm_password)
  end
end
