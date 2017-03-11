class ApplicationController < ActionController::Base

  before_action :current_user

  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find_by id: session[:user_id]
  end

end
