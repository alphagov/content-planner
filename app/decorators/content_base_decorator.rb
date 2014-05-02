class ContentBaseDecorator < ApplicationDecorator
  def tag_list
    object.tags.map(&:name)
  end

  def users_list
    collection_links(object.users)
  end
end