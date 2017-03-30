class RestaurantsController < ApplicationController


  def index
    @restaurants = Restaurant.where(actived: true).paginate(:page => params[:page], :per_page => 4)
  end

  def show
    @restaurant = Restaurant.find_by_id params[:id]
    @foods = @restaurant.foods.where(kind: "eat").paginate(:page => params[:page], :per_page => 4)
  end

  def show_foods_drinks
    @restaurant = Restaurant.find_by_id params[:id]
    @foods = @restaurant.foods.where(kind: "drink").paginate(:page => params[:page], :per_page => 4)
  end
end
