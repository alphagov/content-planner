class ContentBaseDecorator < ApplicationDecorator
  def tags_list
    object.tags.map(&:name)
  end

  def users_list
    collection_links(object.users)
  end
end
