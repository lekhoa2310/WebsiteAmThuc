class Dashboard::PostsController < Dashboard::BaseController

  before_action :find_post_by_id, only: [:edit, :update, :destroy]
  def index
    @page = 1
    @posts = @current_user.posts.order('created_at desc').paginate(:page => params[:page], :per_page => 5)
    @page =  params[:page].to_i if params[:page].present?
  end

  def find_post
    @page = 1
    title_name = params[:title_name]
    @posts = @current_user.posts.where("title like ? ", "%#{title_name}%").paginate(:page => params[:page], :per_page =>5)
    @page = params[:page].to_i if params[:page].present?
    if @posts.first.nil?
      flash[:error] = "Không tìm thấy bài đăng"
      redirect_to dashboard_posts_path
    end

  end

  def edit
    # redirect_to posts_path if @post.user_id != @current_user.id
    if !(@post.user_id == @current_user.id || @current_user.is_admin? )
      redirect_to dashboard_post_path
    end
  end

  def update
    if @post.update_attributes(post_params)
      flash[:success]= "Bạn vừa sửa bài viết thành công"
      redirect_to dashboard_posts_path
    else
      render :edit
    end
  end


  def destroy
    # redirect_to posts_path if @post.user_id != @current_user.id
    if !(@post.user_id == @current_user.id || @current_user.is_admin? )
      redirect_to dashboard_posts_path
    end
    if @post.destroy
      flash[:success]= "Bạn vừa xóa bài viết thành công"
      redirect_to dashboard_posts_path
    else
      render :index
    end
  end

  private

  def check_user
      redirect_to login_path if @current_user.nil?
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end

  def find_post_by_id
    @post = Post.find_by_id params[:id]
  end

end
