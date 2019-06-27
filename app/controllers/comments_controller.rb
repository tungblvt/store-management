class CommentsController < ApplicationController
  before_action :have_permission

  def create
    @comment = current_user.comments.build comment_params
    if @comment.save
      flash[:success] = t "comments.success"
    else
      flash[:danger] = t "comments.failed"
    end
    redirect_to store_detail_path(@comment.store_id)
  end

  def comment_params
    params.require(:comment).permit Comment::COMMENT_PARAMS
  end

  def have_permission
    return if current_user
    redirect_to login_path
  end
end
