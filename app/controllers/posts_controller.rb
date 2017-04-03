class PostsController < ApplicationController
  before_action :check_user, except: [:index, :show]
  before_action :find_post, only: [:edit, :update, :show, :destroy, :like]
  def index
    @posts = Post.all
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
    redirect_to posts_path if @post.user_id != @current_user.id
  end

  def update
    if @post.update_attributes(post_params)
      flash[:success]= "Bạn vừa sửa bài viết thành công"
      redirect_to posts_path
    else
      render :edit
    end
  end

  def show

  end

  def destroy
    redirect_to posts_path if @post.user_id != @current_user.id
    if @post.destroy
      flash[:success]= "Bạn vừa xóa bài viết thành công"
      redirect_to posts_path
    else
      render :index
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

  def find_post
    @post = Post.find_by_id params[:id]
  end
end
