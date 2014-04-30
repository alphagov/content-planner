module Comments
  class Reply
    attr_reader :comment, :comment_owner, :reply_comment, :reply_params, :success

    def initialize(comment, reply_params)
      @comment = comment
      @comment_owner = comment.user
      @reply_params = reply_params

      @reply_comment = comment.children.new(reply_params)
    end

    def run
      persist!

      if success?
        unless reply_comment.user == comment_owner
          notify_parent_comment_owner!
        end

        notify_other_reply_recipients!
      end

      self
    end

    def persist!
      reply_comment.commentable = comment.commentable
      @success = reply_comment.save
    end

    def success?
      @success
    end

    def errors
      reply_comment.errors.full_messages.join(', ')
    end

    def notify_parent_comment_owner!
      CommentMailer.reply_notification(reply_comment,
                                       comment_owner).deliver!
    end

    def notify_other_reply_recipients!
      reply_recipients = comment.reply_recipients.reject { |u| u == reply_comment.user }

      reply_recipients.each do |notified_recipient|
        CommentMailer.reply_notification(reply_comment,
                                         notified_recipient).deliver!
      end
    end
  end
end