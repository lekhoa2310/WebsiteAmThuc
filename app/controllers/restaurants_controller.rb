class RestaurantsController < ApplicationController


  def index
    @restaurants = Restaurant.where(actived: true).paginate(:page => params[:page], :per_page => 4)
  end

  def show
    @restaurant = Restaurant.find_by_id params[:id]
    @foods = @restaurant.foods.paginate(:page => params[:page], :per_page => 4)
  end
end
