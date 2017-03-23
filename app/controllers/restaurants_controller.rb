class RestaurantsController < ApplicationController

  def index
    @restaurants = Restaurant.paginate(:page => params[:page], :per_page => 4)
  end

  def show
    Paperclip::Attachment.default_options[:default_url] = "/images/foods/food.png"
    @restaurant = Restaurant.find_by_id params[:id]
    @foods = @restaurant.foods.paginate(:page => params[:page], :per_page => 4)
  end
end
