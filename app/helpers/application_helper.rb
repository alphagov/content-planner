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

  def breadcrumb(*links)
    content_tag :ul, class: "breadcrumb" do
      raw(links.map { |link|
        content_tag :li, class: "active" do
          if link.class == String
            link
          else
            link_to(link.first, link.last) + content_tag(:span, "/", class: "divider")
          end
        end
      }.join)
    end
  end

  # Highlight the nav item if current page matching controllers_options
  #
  # Examples
  #
  #   nav_item 'Foo', '/foo', 'controller_foo', 'controller_bar'
  #   nav_item 'Foo', '/foo', %w(controller_foo controller_bar)
  #   nav_item 'Foo', '/foo', 'controller_foo', controller_bar: ['edit', 'new']
  #   nav_item 'Foo', '/foo', controller_foo: 'index', controller_bar: ['edit', 'new']
  #
  def nav_item(text, url, *controllers_options)
    controllers_options.flatten!

    options = controllers_options.extract_options!

    wrapper_options = if controller_name.in?(controllers_options) or
                         [ * options[controller_name.to_sym] ].include?(action_name)
                        {class: 'active'}
                      end

    nav_element(text, url, wrapper_options)
  end

  def nav_element(text, url, wrapper_options = {})
    content_tag :li, wrapper_options do
      link_to text, url
    end
  end
end
