class SessionsController < ApplicationController

  def new
    redirect_to posts_path if @current_user
  end

  def create
    user = User.find_by email:params[:session][:email]
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to posts_path
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
