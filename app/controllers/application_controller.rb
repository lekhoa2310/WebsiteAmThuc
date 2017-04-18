class ApplicationController < ActionController::Base

  before_action :current_user, :create_session

  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find_by id: session[:user_id]
  end

  def create_session
    if !@current_user
      session[:cart] = []
    end
  end
  # def authenticate!
  #   redirect_to login_path if @current_user.nil?
  # end
  #

end
