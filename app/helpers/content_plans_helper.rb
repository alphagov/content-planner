module ContentPlansHelper
  def content_plan_tag_filters(tags)
    tags.map do |t|
      link_to(t, content_plans_path(search: { tag: t }), class: "tag")
    end.join.html_safe
  end

  def due_date_options_for_select
    ContentPlan::YEARS.map do |year|
      ContentPlan::QUARTERS.map do |quarter|
        "q#{quarter} #{year}"
      end
    end.flatten
  end

  def sortable_column(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to(title, content_plan_path(content_plan_filter, {sort: column, direction: direction}), class: css_class)
  end
end
