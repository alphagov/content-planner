class ContentBaseDecorator < ApplicationDecorator
  def tags_list
    object.tags.map(&:name)
  end

  def users_list
    collection_links(object.users)
  end

  def needs_list
    object.needs.map do |need|
      h.link_to(
        need.api_id,
        MASLOW_CURRENT_HOST + "/needs/#{need.api_id}",
        target: "_blank",
        :'data-tooltip' => "",
        title: need.story
      )
    end.join(", ").html_safe
  end
end
