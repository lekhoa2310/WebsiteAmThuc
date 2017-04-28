module Api::V1
  class PostsController < ApiController
    def like
      @post= Post.find(params[:id])
      like = @post.likes.where(user_id: current_user.id).first
      if like
        like.update isLike: !like.isLike
      else
        like =@post.likes.new user_id: current_user.id, isLike: true
        like.save
      end
      render json:
      {
        success: true,
        data: {
          likes: @post.likes.where(isLike: true).count,
          isLike: like.isLike}
      }
    end

    def more_post
      @page = params[:page]
      @posts = Post.order('created_at desc').paginate(:page => @page, :per_page => 5)
      html = render_to_string(show: 'api/v1/posts/more_post.html.erb', layout: false)
      render json: {
        data: html
      }
    end
  end
end
