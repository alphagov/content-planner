module LogoHelper
  def logo_classes(options = {})
    logo_class = ['organisation-logo']
    logo_class << 'stacked' if options[:stacked]
    if options[:use_identity] == false
      logo_class << 'no-identity'
    else
      class_name = options[:class_name]
      logo_class << class_name
    end
    logo_class = logo_class.join('-')

    classes = ['organisation-logo']
    classes << logo_class
    classes << "#{logo_class}-#{options[:size]}" if options[:size]
    classes.join(" ")
  end

  def organisation_logo_name(organisation, stacked = true)
    if stacked
      format_with_html_line_breaks(ERB::Util.html_escape(organisation.logo_formatted_name))
    else
      organisation.title
    end
  end

  def format_with_html_line_breaks(string)
    ERB::Util.html_escape(string || "").strip.gsub(/(?:\r?\n)/, "<br/>").html_safe
  end
end
