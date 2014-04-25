class CommentPolicy < Struct.new(:user, :comment)
  def edit?
    can_update_or_remove?
  end

  def update?
    can_update_or_remove?
  end

  def destroy?
    can_update_or_remove?
  end

  def can_update_or_remove?
    user.gds_editor? &&
    comment_author? &&
    comment_is_just_created?
  end

  def comment_author?
    comment.user == user
  end

  def comment_is_just_created?
    5.minutes.ago < comment.created_at &&
    comment.created_at < Time.zone.now
  end
end