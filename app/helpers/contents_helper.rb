module ContentsHelper
  def content_tag_filters(tags)
    tags.map do |t|
      link_to(t, contents_path(search: { tag: t }), class: "tag")
    end.join.html_safe
  end
end
