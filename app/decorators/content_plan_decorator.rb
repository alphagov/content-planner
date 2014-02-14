class ContentPlanDecorator < ApplicationDecorator
  def due_date
    if due_quarter && due_year
      "Q#{due_quarter} #{due_year}"
    else
      "-"
    end
  end
end
