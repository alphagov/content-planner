module SourceUrlsHelper

  def source_tag_filters(tags)
    tags.map do |t|
      link_to(t, source_urls_path(tag: t), class: 'label label-success tag')
    end.join.html_safe
  end
end
