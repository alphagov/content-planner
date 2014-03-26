class MockNeedsApi
  attr_reader :need

  def initialize(*need)
    @need = Need.new(need)
  end

  def needs
    self
  end

  def need(id)
    with_subsequent_pages.find { |n| n.id == id }
  end

  def organisation
    OpenStruct.new(id: "hmrc",
                   name: "HM Revenue & Customs",
                   govuk_status: "live",
                   abbreviation: "HMRC",
                   parent_ids: [],
                   child_ids: [])
  end

  def with_subsequent_pages
    [
      OpenStruct.new(id: 100252,
                     role: "user",
                     goal: "go to the university",
                     benefit: "I can graduate",
                     organisation_ids: ["hmrc"],
                     organisations: [organisation],
                     applies_to_all_organisations: false,
                     in_scope: nil)
    ]
  end
end
