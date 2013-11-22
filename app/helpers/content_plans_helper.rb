module ContentPlansHelper
  def content_plan_tag_filters(tags)
    tags.map do |t|
      link_to(t, content_plans_path(tag: t), class: 'label label-success tag')
    end.join.html_safe
  end

  def user_needs_links(ids)
    ids.map do |id|
      maslow = Plek.current.find("maslow")
      link_to(id, maslow+"/needs/#{id}", target: "_blank")
    end.join(", ").html_safe
  end
end
