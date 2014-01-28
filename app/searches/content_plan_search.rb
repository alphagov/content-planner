class ContentPlanSearch < Searchlight::Search

  search_on ContentPlan.includes([:content_plan_needs, :contents])

  searches :ref_no, :status_id, :need_id, :tag

  def search_ref_no
    search.where(ref_no: ref_no)
  end

  def search_status_id
    search.where('`contents`.`status_id` = ?', status_id)
  end

  def search_need_id
    search.where('`content_plan_needs`.`need_id` = ?', need_id)
  end

  def search_tag
    search.tagged_with(tag)
  end

end
