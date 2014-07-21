class ImportNeeds
  class << self
    def needs
      ContentPlanner.needs_api.needs.with_subsequent_pages
    end

    def run
      needs.each do |need_data|
        update_or_create_need!(need_data)
      end

    rescue ActiveRecord::RecordInvalid => invalid
      raise "Couldn't save need #{invalid.record.id} because: #{invalid.record.errors.full_messages.join(',')}"
    end

    def update_or_create_need!(need_data)
      need = Need.find_or_create_by(api_id: need_data.id)

      update_data = {
        role: need_data.role,
        goal: need_data.goal,
        benefit: need_data.benefit,
        organisation_ids: organisations(need_data.organisation_ids)
      }

      need.update!(update_data)
    end

    def organisations(organisation_ids)
      Organisation.where(api_id: organisation_ids).map(&:id).compact
    end
  end
end
