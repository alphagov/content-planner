class CommentMailer < ActionMailer::Base
  default from: "DO NOT REPLY <content-planner@digital.cabinet-office.gov.uk>"

  def notify_user(comment, user)
    @comment = comment
    @user = user
    @url = comment.commentable.class == ContentPlan ? content_plan_url(comment.commentable) : content_url(comment.commentable)
    mail to: @user.email, subject: "#{@comment.user} commented on #{@comment.commentable}"
  end

  def reply_notification(reply_comment, notified_user)
    @reply_comment = reply_comment
    @replied_person = reply_comment.user
    @notified_user = notified_user
    @commentable = reply_comment.commentable

    @url = comment_url(@reply_comment.parent)

    @subject = "#{@replied_person} replied on comment on #{@commentable}"

    mail to: @notified_user.email, subject: @subject
  end
end
