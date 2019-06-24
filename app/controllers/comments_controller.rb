class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build comment_params
    if @comment.save
      flash[:success] = t "comments.success"
    else
      flash[:danger] = t "comments.failed"
    end
    redirect_to request.referer
  end

  def comment_params
    params.require(:comment).permit Comment::COMMENT_PARAMS
  end
end
