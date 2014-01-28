class ContentPlanDecorator < ApplicationDecorator

  def due_date
    "Q#{due_quarter} #{due_year}"
  end
end
