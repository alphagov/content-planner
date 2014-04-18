class MockOrganisationsApi
  def organisations
    self
  end

  def with_subsequent_pages
    [
      OpenStruct.new(id: "hmrc",
                     title: "HM Revenue & Customs",
                     format: "Ministerial department",
                     updated_at: "2013-08-22T11:02:18+01:00",
                     web_url: "https://www.gov.uk/government/organisations/hm-revenue-customs",
                     child_organisations: [],
                     parent_organisations: [],
                     details: OpenStruct.new(slug: "hm-revenue-customs",
                                             abbreviation: "HMRC",
                                             closed_at: nil,
                                             govuk_status: "live",
                                             logo_formatted_name: "HM Revenue & Customs",
                                             organisation_brand_colour_class_name: "hm-revenue-customs",
                                             organisation_logo_type_class_name: "hmrc"))
    ]
  end
end
