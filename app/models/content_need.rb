class ContentNeed < ActiveRecord::Base
  belongs_to :content

  def need
    Need.find(need_id)
  end
end
