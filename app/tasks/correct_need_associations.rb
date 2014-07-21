class CorrectNeedAssociations
  class << self
    def run
      ContentPlanNeed.all.each do |content_plan_need|
        find_need_and_update_need_id!(instance)
      end

      ContentNeed.all.each do |content_need|
        find_need_and_update_need_id!(instance)
      end
    end

    def find_need_and_update_need_id!(instance)
      need = Need.find_by(api_id: instance.need_api_id)

      if need.present?
        instance.update_column(:need_id, need.id)
      end
    end
  end
end