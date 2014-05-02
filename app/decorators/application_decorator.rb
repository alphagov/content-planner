class ApplicationDecorator < Draper::Decorator
  delegate_all

  def collection_links(coll, separator = ", ")
    coll.map do |item|
      h.link_to item.name, h.url_for(item)
    end.join(separator)
       .html_safe
  end
end
