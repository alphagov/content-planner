class CommentsController < ApplicationController
  expose(:comment, attributes: :comment_params)
  expose(:comments)

  def create
    if comment.save(comment_params)
      redirect_to comment.commentable
    else
      render :new
    end
  end

  def update
    if comment.update(comment_params)
      redirect_to comment.commentable
    else
      render :edit
    end
  end

  def comment_params
    params.require(:comment).permit(:message, :user_id, :commentable_id, :commentable_type)
  end
end
