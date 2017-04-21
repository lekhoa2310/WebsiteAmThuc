class ReviewsController < ApplicationController

  def index
    @page = 1
    @restaurant = Restaurant.find_by_id params[:restaurant_id]
    @reviews = @restaurant.reviews.order('updated_at desc').paginate(:page => params[:page], :per_page => 6)
    @page = params[:page].to_i if params[:page].present?
  end

  def new
    redirect_to login_path if !@current_user
    @restaurant = Restaurant.find_by_id params[:restaurant_id]
  end

  def create
    redirect_to login_path if !@current_user
    @restaurant = Restaurant.find_by_id params[:restaurant_id]
    @review = Review.new(user_id: @current_user.id, restaurant_id: @restaurant.id,rating: params[:score], content: params[:content])
    if @review.save
      @reviews = @restaurant.reviews
      average = 0
      total_review = 0
      @reviews.each do |review|
        total_review += review.rating
      end
      average = total_review / @reviews.length
      @restaurant.update_attributes(rating: average)
      flash[:success]= "Đánh giá cửa hàng thành công"
      redirect_to   restaurant_reviews_path
    else
      flash[:error] = "Đánh giá thất bại"
      render :new
    end
  end

  def destroy
    @review = Review.find_by_id params[:id]
    if @review.destroy
      flash[:success]="Xóa đánh giá thành công"
      redirect_to restaurant_reviews_path
    else
      render :index
    end
  end
end
