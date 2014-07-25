class DummyData::LoadOrganisations
  class << self
    def run
      puts "[DummyData] load organisations ---------------------------------------------------------- started"

      organisation_relationships = {}

      organisations.each do |organisation_data|
        update_or_create_organisation(organisation_data)
        organisation_relationships[organisation_data.id] = child_organisation_slugs(organisation_data)
      end

      update_ancestry(organisation_relationships)

      puts "[DummyData] load organisations ---------------------------------------------------------- completed"
    end

    def organisations
      file = File.read("#{Rails.root}/db/dummy_data/organisations.json")
      JSON.parse(file).map do |r|
        Hashie::Mash.new(r)
      end
    end

    def update_or_create_organisation(organisation_data)
      update_data = {
        api_id: organisation_data.id,
        slug: organisation_data.id,
        title: organisation_data.name,
        format: organisation_data.format,
        web_url: organisation_data.web_url,
        abbreviation: organisation_data.abbreviation,
        govuk_status: organisation_data.govuk_status,
        logo_formatted_name: organisation_data.logo_formatted_name,
        organisation_brand_colour_class_name: organisation_data.organisation_brand_colour_class_name,
        organisation_logo_type_class_name: organisation_data.organisation_logo_type_class_name
      }

      if organisation_data.updated_at
        update_data[:api_updated_at] = Time.zone.parse(organisation_data.updated_at)
      end

      if organisation_data.closed_at
        update_data[:api_closed_at] = Time.zone.parse(organisation_data.closed_at)
      end

      organisation = Organisation.find_by_slug(organisation_data.id)

      if organisation.present?
        organisation.update!(update_data)
      else
        Organisation.create!(update_data)
      end
    end

    def child_organisation_slugs(organisation_data)
      organisation_data.child_ids
    end

    def update_ancestry(organisation_relationships)
      organisation_relationships.each do |organisation_slug, child_organisation_slugs|
        Organisation.where(slug: child_organisation_slugs).map do |child_organisation|
          child_organisation.update_attributes!(parent: Organisation.find_by_slug(organisation_slug))
        end
      end
    end
  end
end