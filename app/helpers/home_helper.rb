module HomeHelper
  def progress_bar_class_for(status)
    "bar bar-" +
    case status
    when "Not started"
      "danger"
    when "Drafting"
      "warning"
    when "2i"
      "info"
    when "GDS 2i"
      "info"
    when "Amends"
      ""
    when "Factcheck"
      ""
    when "Ready for publish"
      "success"
    when "Live"
      "success"
    end
  end
end
