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
    if @restaurant.user.id == @current_user.id
      flash[:error] = "Bạn không thể đánh giá cửa hàng của bạn."
      redirect_to restaurant_reviews_path(@restaurant)
    else
      @last_review = Review.where('(user_id = ? AND restaurant_id = ? )', @current_user.id , @restaurant.id).first
      if @last_review.nil?

      else
        if  Review.where('(user_id = ? AND restaurant_id = ? )', @current_user.id , @restaurant.id).order('created_at desc').first.created_at > Time.now - 1.days
          flash[:error] = "Hôm nay bạn đã đánh giá cho cửa hàng #{@restaurant.name}"
          redirect_to restaurant_reviews_path(@restaurant)
        else

        end
      end
    end

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
    @restaurant = Restaurant.find_by_id params[:restaurant_id]
    @review = Review.find_by_id params[:id]
    if @review.destroy
      @reviews = @restaurant.reviews
      average = 0
      total_review = 0
      @reviews.each do |review|
        total_review += review.rating
      end
      average = total_review / @reviews.length
      @restaurant.update_attributes(rating: average)
      flash[:success]="Xóa đánh giá thành công"
      redirect_to restaurant_reviews_path
    else
      render :index
    end
  end
end
