class SessionsController < ApplicationController

  def new
    if @current_user
      @user = User.find_by id: @current_user.id
      if @user.is_admin?
        redirect_to admin_users_path
      else
        redirect_to posts_path
     end
   end
  end

  def create
    user = User.find_by email:params[:session][:email]
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      if user.is_admin?
        redirect_to admin_users_path
      else
        redirect_to posts_path
      end
    else
      flash[:error] = "Email or password invalid."
      render :new
    end
  end

  def logout
     session[:user_id]  = nil
     redirect_to login_path
  end
end
