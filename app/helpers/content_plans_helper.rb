module ContentPlansHelper
  def content_plan_tag_filters(tags)
    tags.map do |t|
      link_to(t, content_plans_path(search: {tag: t}), class: 'label label-success tag')
    end.join.html_safe
  end

  def due_date_options_for_select
    ContentPlan::YEARS.map do |year|
      ContentPlan::QUARTERS.map do |quarter|
        "q#{quarter} #{year}"
      end
    end.flatten
  end
end
