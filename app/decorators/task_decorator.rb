class TaskDecorator < ApplicationDecorator
  def assigned_people
    if object.users.present?
      "Assigned: #{users_with_links}".html_safe
    else
      "Assigned: none"
    end
  end

  def users_with_links
    object.users.map do |user|
      h.link_to user, user
    end.join(", ")
  end

  def deadline_status
    if deadline_passed? && not_completed?
      "overdue_task"
    end
  end

  def deadline
    if object.deadline.present?
      "Deadline: #{object.deadline.strftime("%B #{object.deadline.day.ordinalize}, %Y")}"
    end
  end

  def tooltip_content
    deadline
  end

  private

  def deadline_passed?
    object.deadline.present? &&
    (object.deadline.to_date < Time.zone.now.to_date)
  end

  def not_completed?
    !object.done?
  end
end
