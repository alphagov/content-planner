class CommentMailer < ActionMailer::Base
  default from: 'DO NOT REPLY <content-planner@digital.cabinet-office.gov.uk>'

  def notify_user(comment, user)
    @comment = comment
    @user = user
    @url = comment.commentable.class == ContentPlan ? content_plan_url(comment.commentable) : content_url(comment.commentable)
    mail to: @user.email, subject: "#{@comment.user} commented on #{@comment.commentable}"
  end
end
