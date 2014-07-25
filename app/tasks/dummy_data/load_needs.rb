class DummyData::LoadNeeds
  class << self
    def run
      puts "[DummyData] load needs ---------------------------------------------------------- started"

      needs.each do |need_data|
        update_or_create_need!(need_data)
      end

      puts "[DummyData] load needs ---------------------------------------------------------- completed"
    end

    def needs
      file = File.read("#{Rails.root}/db/dummy_data/needs.json")
      JSON.parse(file).map do |r|
        Hashie::Mash.new(r)
      end
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
