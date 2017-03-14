class RestaurantsController < ApplicationController
  def index

    @restaurants = Restaurant.paginate(:page => params[:page], :per_page => 4)
  end

  def show
    @restaurant = Restaurant.find_by_id params[:id]
  end
end
