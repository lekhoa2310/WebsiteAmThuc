class CommentsController < ApplicationController

  def create
    @post = Post.find(comment_params[:post_id])
    comment = @post.comments.create(comment_params.merge(user_id: @current_user.id))
    render json:
      {
        success: true,
        data: {
          user: comment.user.name,
          id: comment.id,
          content: comment.content
        }
      }
  end

  def destroy
    @comment = Comment.find_by(params[:id])
    if @comment.user.id == @current_user.id
      if @comment.destroy
        render json: {success: true}
      else
        render json: {success: false}
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end
end
