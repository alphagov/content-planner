class ContentPlanSearch < Searchlight::Search

  search_on ContentPlan.includes([:content_plan_needs, :contents, :organisationables])

  searches :ref_no, :status, :need_id, :tag, :organisation_ids

  def search_ref_no
    search.where(ref_no: ref_no)
  end

  def search_status
    search.where('`contents`.`status` = ?', status)
  end

  def search_need_id
    search.where('`content_plan_needs`.`need_id` = ?', need_id)
  end

  def search_tag
    search.tagged_with(tag)
  end

  def search_organisation_ids
    search.where('`organisationables`.`organisation_id` = ?', organisation_ids)
  end

end
