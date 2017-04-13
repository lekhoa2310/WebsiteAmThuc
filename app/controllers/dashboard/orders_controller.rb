class Dashboard::OrdersController < Dashboard::BaseController
  before_action :find_restaurant

  def orders_pending
    @page = 1
    @orders = Order.where('(actived = ? AND restaurant_id = ?)', 0, @restaurant.id).order('created_at asc').paginate(:page => params[:page], :per_page => 5)
    @page =  params[:page].to_i if params[:page].present?

  end

  def accept_order
    @order = Order.find_by_id params[:id]
    redirect_to posts_path if @order.restaurant.user_id != @current_user.id
    if @order.update_attributes(actived: 1)
      flash[:success] = "Chấp nhận đơn hàng thành công chuyển sang giao hàng."
      redirect_to orders_shipping_dashboard_restaurant_orders_path
    else
      flash[:error] = "Chưa chấp nhận đơn hàng"
      render :orders_pending
    end
  end

  def orders_shipping
    @page = 1
    @orders = Order.where('(actived = ? AND restaurant_id = ?)', 1, @restaurant.id).paginate(:page => params[:page], :per_page => 5)
    @page =  params[:page].to_i if params[:page].present?
  end

  def complete_ship
    @order = Order.find_by_id params[:id]
    redirect_to posts_path if @order.restaurant.user_id != @current_user.id
    if @order.update_attributes(actived: 2)
      flash[:success] = "Đơn hàng đã được hoàn tất."
      redirect_to orders_complete_dashboard_restaurant_orders_path
    else
      flash[:error] = "Đơn hàng chưa hoàn tất."
      render :orders_shipping
    end
  end

  def cancel_order
    @order = Order.find_by_id params[:id]
    redirect_to posts_path if @order.restaurant.user_id != @current_user.id
    if @order.update_attributes(actived: 3)
      flash[:success] = "Đơn hàng hủy thành công."
      redirect_to orders_complete_dashboard_restaurant_orders_path
    else
      flash[:error] = "Đơn hàng chưa hoàn tất."
      render :orders_pending
    end
  end

  def orders_complete
    @page = 1
    @orders = Order.where('(actived = ? AND restaurant_id = ?)', 2, @restaurant.id).paginate(:page => params[:page], :per_page => 5)
    @page =  params[:page].to_i if params[:page].present?
  end

  def orders_cancel
    @page = 1
    @orders = Order.where('(actived = ? AND restaurant_id = ?)', 3, @restaurant.id).paginate(:page => params[:page], :per_page => 5)
    @page =  params[:page].to_i if params[:page].present?
  end

  private

  def find_restaurant
    @restaurant = Restaurant.find_by_id params[:restaurant_id]
  end
end
