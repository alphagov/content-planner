class CommentsController < ApplicationController
  expose(:comment, attributes: :comment_params)
  expose(:commentable) {
    params[:commentable_type].constantize.find(params[:commentable_id])
  }
  expose(:next_comments) {
    commentable.comments.roots.includes(:user, :commentable,  children: [:user, :parent, :commentable]).page(params[:page])
  }

  before_action :require_to_be_owner!, only: [:edit, :update, :destroy]
  before_action :check_ability_to_reply!, only: [:reply]

  def show
  end

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

  def reply
    reply_comment = Comments::Reply.new(comment,
                                        reply_params.merge(user: current_user)).run

    if reply_comment.success?
      redirect_to comment.commentable
    else
      redirect_to comment.commentable,
                  alert: reply_comment.errors
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:message, :user_id, :commentable_id, :commentable_type)
  end

  def reply_params
    params.require(:reply).permit(:message)
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

  def check_ability_to_reply!
    self.comment = Comment.find(params[:id])

    unless CommentPolicy.new(current_user, comment).reply?
      redirect_to comment.commentable,
                  notice: "You can't reply on this comment"
    end
  end
end
