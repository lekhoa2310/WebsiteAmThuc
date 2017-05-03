class SessionsController < ApplicationController

  def new
    session[:referer_url] = URI(request.referer).path

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
      my_path = session[:referer_url]
      session[@last_user] = nil
      session[:referer_url] = nil
      if my_path.nil?
        if user.is_admin?
          flash[:error] = nil
          session[:cart] = []
          redirect_to admin_users_path
        else
          flash[:error] = nil
          session[:cart] = []
          redirect_to posts_path
        end
      else
        redirect_to my_path
      end
    else
      # flash[:error] = "Email or password invalid."
      flash[:error] = "Email hoặc mật khẩu không chính xác."
      render :new
    end
  end

  def logout
     session[:user_id]  = nil
     redirect_to posts_path
  end
end
