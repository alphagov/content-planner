class PlanContentsSearch < Searchlight::Search
  search_on Content

  searches :content_plan_id, :title, :platform, :status

  def search_content_plan_id
    search.for_content_plan(content_plan_id)
  end

  def search_title
    search.for_title(title)
  end

  def search_platform
    search.platform(platform)
  end

  def search_status
    search.for_status(status)
  end
end
