class Dashboard::BaseController < ApplicationController
  before_action :check_user

  def check_user
      redirect_to posts_path if @current_user.nil?
  end

end
