namespace :db do
  desc "Populate organisation for dev env"
  task populate_organisation_and_need_for_dev_env: :environment do
    PopulateOrganisationAndNeedForDevEnv.run
  end
end

class PopulateOrganisationAndNeedForDevEnv
  TEST_NEED_IDS = [100655, 100654, 100252, 282, 184, 31661, 28665, 513, 78, 26455, 668620003, 201575]

  class << self
    def run
      unless Organisation.exists?(api_id: "hmrc")
        ops = {
          api_id: "hmrc",
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

      TEST_NEED_IDS.each do |need_api_id|
        unless Need.exists?(api_id: need_api_id)
          ops = {
            api_id: need_api_id,
            role: "user",
            goal: "go to the university",
            benefit: "I can graduate",
            organisation_ids: [Organisation.find_by(api_id: "hmrc").id]
          }

          Need.create!(ops)
        end
      end
    end
  end
end