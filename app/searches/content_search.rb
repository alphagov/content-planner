class ContentSearch < Searchlight::Search

  search_on Content.includes([:content_needs, :content_plans])

  searches :content_plan_ids, :status, :need_id, :tag

  def search_content_plan_ids
    search.where('`content_plan_contents`.`content_plan_id` IN (?)', content_plan_ids)
  end

  def search_status
    search.where(status: status)
  end

  def search_need_id
    search.where('`content_plan_needs`.`need_id` = ?', need_id)
  end

  def search_tag
    search.tagged_with(tag)
  end

end
