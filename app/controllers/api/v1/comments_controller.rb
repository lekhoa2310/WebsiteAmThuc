module Api::V1
  class CommentsController < ApiController
    def create_reply_comment
      @comment = Comment.find_by_id(reply_params[:comment_id])
      comment = @comment.comments.create(reply_params.merge(user_id: @current_user.id))
      render json: {
        success: true,
        data: {
          user: comment.user.name,
          id: comment.id,
          content: comment.content
        }
      }
    end

    def replies
      @comment = Comment.find_by_id(params[:id])
      @replies = Comment.where(comment_id: params[:id])
      html = render_to_string(show: 'api/v1/comments/replies.html.erb', layout: false)
      render json: {
        data: html
      }
    end

    def destroy_reply
      @comment = Comment.find_by_id(params[:id])
      if @comment.user.id == @current_user.id
        if @comment.destroy
          render json: { success: true }
        else
          render json: { success: false }
        end
      end
    end

    private
    def reply_params
      params.require(:reply).permit(:content, :comment_id)

    end
  end
end
