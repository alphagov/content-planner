require 'spec_helper'

describe OrganisationNeed do
  let(:organisation_need) { create :organisation_need }

  describe "validations" do
    before {
      organisation_need.organisation = nil
      organisation_need.need = nil
    }

    it "should not be valid with empty user or task" do
      expect(organisation_need).to have(1).error_on(:organisation)
      expect(organisation_need).to have(1).error_on(:need)
    end
  end
end
