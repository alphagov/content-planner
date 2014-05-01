module ApplicationHelper
  def display_base_errors(resource)
    return "" if (resource.errors.empty?) || (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end

  def govspeak(text)
    Govspeak::Document.new(text).to_sanitized_html_without_images.html_safe if text
  end

  def user_needs_links(ids)
    maslow = Plek.current.find("maslow")
    Array.wrap(ids).map do |id|
      link_to(id, maslow + "/needs/#{id}", target: "_blank", :'data-tooltip' => "", title: Need.find(id).try(:story))
    end.join(", ").html_safe
  end

  def content_organisations(organisations)
    orgs = organisations.compact
    return if orgs.empty?
    orgs.map(&:abbreviation_or_title).join(", ")
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

    wrapper_options = if controller_name.in?(controllers_options) ||
                         [* options[controller_name.to_sym]].include?(action_name)
                        { class: "active" }
                      end

    nav_element(text, url, wrapper_options)
  end

  def nav_element(text, url, wrapper_options = {})
    content_tag :li, wrapper_options do
      link_to text, url
    end
  end

  def users_options_for_select
    User.all.map { |user| [user.to_s, user.id] }
  end

  def organisations_options_for_select
    Organisation.all.map do |organisation|
      [organisation.to_s, organisation.slug]
    end
  end

  def needs_options_for_select
    Need.all.map do |need|
      [need.to_s, need.id]
    end
  end
end
