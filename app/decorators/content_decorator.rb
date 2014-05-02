class ContentDecorator < ContentBaseDecorator
  def content_plans_list
    collection_links(object.content_plans)
  end
end
