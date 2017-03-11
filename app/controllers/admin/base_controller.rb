class Admin::BaseController < ApplicationController
  before_action :check_admin

  def check_admin
    if @current_user.is_admin?

    else
      redirect_to posts_path
    end
  end
end
