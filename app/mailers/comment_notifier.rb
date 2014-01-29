class CommentNotifier
  attr_reader :comment

  def initialize(comment)
    @comment = comment
    notify!
  end

  def notify!
    comment.commentable.users.each do |user|
      CommentMailer.notify_user(comment, user).deliver unless user == comment.user
    end
  end
end
