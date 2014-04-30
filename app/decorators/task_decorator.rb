class TaskDecorator < ApplicationDecorator
  def assigned_people
    if object.users.present?
      "Assigned: #{object.users.map(&:to_s).join(", ")}"
    else
      "Assigned: none"
    end
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
    [assigned_people, deadline].join('. ')
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