class CommentsController < ApplicationController
  expose(:comment, attributes: :comment_params)
  expose(:comments)

  before_action :require_to_be_owner!, only: [:edit, :update, :destroy]

  def create
    if comment.save(comment_params)
      redirect_to comment.commentable
    else
      render :new
    end
  end

  def edit
  end

  def update
    if comment.update(comment_params)
      redirect_to comment.commentable, notice: "Comment updated"
    else
      render :edit
    end
  end

  def destroy
    comment.destroy
    redirect_to comment.commentable, notice: "Comment deleted"
  end

  private

  def comment_params
    params.require(:comment).permit(:message, :user_id, :commentable_id, :commentable_type)
  end

  def require_to_be_owner!
    comment_policy = CommentPolicy.new(current_user, comment)

    unless comment_policy.can_update_or_remove?
      notice = if !comment_policy.comment_author?
        "You have no permissions to #{action_name} this comment"
      elsif !comment_policy.comment_is_just_created?
        "Comment can be updated or deleted only in 5 minutes after posting"
      end

      redirect_to comment.commentable, notice: notice
    end
  end
end
