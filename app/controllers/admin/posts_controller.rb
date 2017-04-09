class Admin::PostsController < Admin::BaseController

  def index
    @page = 1
    @posts = Post.order('created_at desc').paginate(:page => params[:page], :per_page => 5)
    @page = params[:page].to_i if params[:page].present?
  end

  def find_post
    @page = 1
    title_name = params[:title_name]
    @posts = Post.where("title like ?", "%#{title_name}%").paginate(:page => params[:page], :per_page => 3)
    @page = params[:page].to_i if params[:page].present?
    if @posts.first.nil?
      flash[:error] = "Không tìm thấy bài đăng "
      redirect_to admin_posts_path
    end
  end

  def destroy
    redirect_to posts_path if !@current_user.is_admin?
    @post = Post.find_by_id params[:id]
    if @post.destroy
      flash[:success]= "Bạn vừa xóa bài viết thành công"
      redirect_to admin_posts_path
    else
      render :index
    end
  end
end
