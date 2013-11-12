class CommentsController < ApplicationController
  expose(:comment, attributes: :comment_params)
  expose(:comments)

  def create
    if comment.save(comment_params)
      redirect_to content_plan_path(comment.content_plan)
    else
      render :new
    end
  end

  def update
    if comment.update(comment_params)
      redirect_to content_plan_path(comment.content_plan)
    else
      render :edit
    end
  end

  def comment_params
    params.require(:comment).permit(:message, :user_id, :content_plan_id)
  end
end
