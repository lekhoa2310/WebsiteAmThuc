class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create

    @user = User.new user_params
    byebug
    @user.gender = 1 if @user.gender.nil?
      if  @user.save
        flash[:success] = "Registration successfully"
        redirect_to login_path
      else
        render :new
      end

  end




  private
  def user_params
    params.require(:user).permit(:email, :password,:password_confirmation, :name, :address, :phone, :birthday, :gender)
  end
end
