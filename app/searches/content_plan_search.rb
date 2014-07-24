class ContentPlanSearch < Searchlight::Search
  search_on ContentPlan.includes([:needs, :organisationables, :contents, :tags, :users]).order(:ref_no)

  searches :ref_no, :status, :need_id, :tag, :organisation_ids, :due_date, :user_id

  def search_ref_no
    search.where(ref_no: ref_no)
  end

  def search_status
    search.where("`contents`.`status` = ?", status)
  end

  def search_need_id
    search.where("`content_plan_needs`.`need_id` = ?", need_id)
  end

  def search_tag
    search.tagged_with(tag)
  end

  def search_organisation_ids
    search.where("`organisationables`.`organisation_id` = ?", organisation_ids)
  end

  def search_due_date
    quarter, year = due_date.split " "
    search.where(due_quarter: quarter.delete("q").to_i, due_year: year)
  end

  def search_user_id
    search.where("`content_plan_users`.`user_id` = ?", user_id)
  end
end
