class TaskDecorator < ApplicationDecorator
  def assigned_people
    if object.users.present?
      "Assigned on: #{object.users.map(&:to_s).join(", ")}"
    else
      "Not assigned"
    end
  end
end