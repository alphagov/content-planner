class ContentSearch < Searchlight::Search
  search_on Content.includes([:content_needs, :content_plans, :content_plan_contents, :organisationables, :users, :tags])
                   .references(:content_needs, :content_plans, :content_plan_contents, :organisationables, :users, :tags)

  searches :content_plan_ids, :status, :need_id, :tag, :organisation_ids, :user_id

  def initialize(param1, column, direction)
    super(param1)

    @column = column
    @direction = direction
  end

  def results
    super().order("contents.#{@column} #{@direction}")
  end

  def search_content_plan_ids
    search.where("`content_plan_contents`.`content_plan_id` IN (?)", content_plan_ids)
  end

  def search_status
    search.where(status: status)
  end

  def search_need_id
    search.where("`content_needs`.`need_id` = ?", need_id)
  end

  def search_tag
    search.tagged_with(tag)
  end

  def search_organisation_ids
    search.where("`organisationables`.`organisation_id` = ?", organisation_ids)
  end

  def search_user_id
    search.where("`content_users`.`user_id` = ?", user_id)
  end
end
