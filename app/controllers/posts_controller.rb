class PostsController < ApplicationController
  before_action :check_user, except: [:index, :show, :contact, :create_contact, :find_post]
  before_action :find_post_by_id, only: [:edit, :update, :show, :destroy, :like]
  def index

    @posts = Post.order('created_at desc').paginate(:page => params[:page], :per_page => 5)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def find_post
    @page = 1
    title_name = params[:title_name]
    @posts = Post.where("title like ?", "%#{title_name}%").paginate(:page => params[:page], :per_page => 5)
    @page = params[:page].to_i if params[:page].present?
    if @posts.first.nil?
      flash[:error] = "Không tìm thấy bài đăng "
      redirect_to posts_path
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = @current_user.posts.new post_params
    if @post.save
      flash[:success]= "Bạn vừa đăng bài viết mới thành công"
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit
    # redirect_to posts_path if @post.user_id != @current_user.id
    if !(@post.user_id == @current_user.id || @current_user.is_admin? )
      redirect_to posts_path
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

  def show

  end

  def destroy
    # redirect_to posts_path if @post.user_id != @current_user.id
    if !(@post.user_id == @current_user.id || @current_user.is_admin? )
      redirect_to posts_path
    end
    if @post.destroy
      flash[:success]= "Bạn vừa xóa bài viết thành công"
      redirect_to posts_path
    else
      render :index
    end
  end

  def contact

  end

  def create_contact
    name = params[:name]
    email = params[:email]
    subject = params[:subject]
    content = params[:content]
    if @current_user
      user = @current_user.id
    else
      user = "chưa đăng ký"
    end
    if ExampleMailer.contact_email(user ,name, email, subject, content).deliver_now
      flash[:success] = 'Gửi liên hệ thành công'
      redirect_to contact_posts_path
    else
      flash[:error] = 'Gửi liên hệ thất bại'
      render :contact
    end
  end

  # def like
  #   @post= Post.find(params[:id])
  #   like = @post.likes.where(user_id: current_user.id).first
  #   if like
  #     like.update isLike: !like.isLike
  #   else
  #     like =@post.likes.new user_id: current_user.id, isLike: true
  #     like.save
  #   end
  #   render json:
  #   {
  #     success: true,
  #     data: {
  #       likes: @post.likes.where(isLike: true).count,
  #       isLike: like.isLike}
  #   }
  # end

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
