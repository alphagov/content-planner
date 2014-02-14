class ContentSearch < Searchlight::Search
  search_on Content.includes([:content_needs, :content_plans, :content_plan_contents, :organisationables])

  searches :content_plan_ids, :status, :need_id, :tag, :organisation_ids

  def search_content_plan_ids
    search.where('`content_plan_contents`.`content_plan_id` IN (?)', content_plan_ids)
  end

  def search_status
    search.where(status: status)
  end

  def search_need_id
    search.where('`content_needs`.`need_id` = ?', need_id)
  end

  def search_tag
    search.tagged_with(tag)
  end

  def search_organisation_ids
    search.where('`organisationables`.`organisation_id` = ?', organisation_ids)
  end
end
