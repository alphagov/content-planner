# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :organisation do
    title "HM Revenue & Customs"
    format "Ministerial department"
    slug "hmrc"
    abbreviation "HMRC"
    govuk_status "live"
    web_url "https://www.gov.uk/government/organisations/hm-revenue-customs"
    logo_formatted_name "HM Revenue & Customs"
    organisation_brand_colour_class_name "hm-revenue-customs"
    organisation_logo_type_class_name "hmrc"
    api_updated_at "2013-08-22T11:02:18+01:00"
  end
end
