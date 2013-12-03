module ApplicationHelper

  def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end
  
  def user_needs_links(ids)
    maslow = Plek.current.find("maslow")
    Array.wrap(ids).map do |id|
      link_to(id, maslow+"/needs/#{id}", target: "_blank")
    end.join(", ").html_safe
  end

  def conent_plan_links(content_plans)
    content_plans.map do |cp|
      link_to(cp.ref_no, content_plan_path(cp))
    end.join(", ").html_safe
  end
end
