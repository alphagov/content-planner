namespace :db do
  desc "Import organisations from Whitehall"
  task populate_organisation_for_dev_env: :environment do
    PopulateOrganisationForDevEnv.run
  end
end

class PopulateOrganisationForDevEnv
  class << self
    def run
      unless Organisation.exists?(id: "hmrc")
        ops = {
          title: "HM Revenue & Customs",
          format: "Ministerial department",
          slug: "hm-revenue-customs",
          abbreviation: "HMRC",
          govuk_status: "live",
          web_url: "https://www.gov.uk/government/organisations/hm-revenue-customs",
          logo_formatted_name: "HM Revenue & Customs",
          organisation_brand_colour_class_name: "hm-revenue-customs",
          organisation_logo_type_class_name: "hmrc",
          api_updated_at: "2013-08-22T11:02:18+01:00"
        }

        Organisation.create!(ops)
      end
    end
  end
end