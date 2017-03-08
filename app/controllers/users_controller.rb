class UsersController < ApplicationController

  def index

  end
  def new
    redirect_to posts_path if @current_user
    @user = User.new
  end

  def create
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
      if @user.update(user_params)
        flash[:success] = "Update profile successfully"
        redirect_to posts_path
      else
        render :edit
      end
    end

    def change_password
      @user = @current_user
      if Digest::MD5::hexdigest(params[:old_password]) == @user.password
        if params[:new_password].length < 6
          flash[:error] = "Password is too short (minimum is 6 characters)"
          render :edit
        else
          if params[:new_password] == params[:confirm_password]
            @user.update(password: params[:new_password])
            flash[:success] = "Your password was change successfully"
            redirect_to edit_user_path
          else
            flash[:error] = "Confirm password  doesn't match New password"
            render :edit
          end
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
    params.require(:user).permit(:email, :password,:password_confirmation, :name, :address, :phone, :birthday, :gender)
  end

  def change_password_params
    params.permit(:old_password, :new_password, :confirm_password)
  end
end
