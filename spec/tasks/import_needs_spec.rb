require 'spec_helper'
require 'gds_api/test_helpers/need_api'
include GdsApi::TestHelpers::NeedApi

describe ImportNeeds do
  let!(:organisation) { create :organisation }

  let(:needs_data) {
    [
      MockNeedsApi.new.with_subsequent_pages.first.instance_variable_get("@table")
    ]
  }
  let(:need_data) { needs_data[0] }

  describe "Create" do
    it "populates new needs" do
      need_api_has_needs(needs_data)

      expect {
        ImportNeeds.run
      }.to change { Need.count }.from(0).to(1)

      created_need = Need.first

      expect(created_need.api_id).to be_eql need_data[:id]
      expect(created_need.role).to be_eql need_data[:role]
      expect(created_need.goal).to be_eql need_data[:goal]
      expect(created_need.benefit).to be_eql need_data[:benefit]

      expect(created_need.organisations.count).to be_eql 1
      expect(created_need.reload.organisations.first.api_id).to be_eql(organisation.api_id)
    end
  end

  describe "Update" do
    let!(:second_organisation) {
      create :organisation, api_id: 'hmrc2'
    }
    let!(:need) {
      create :need, api_id: need_data[:id],
                    organisations: [organisation]
    }
    let(:new_need_role) { "New role" }
    let(:updated_need_data) {
      new_ops = needs_data
      new_ops[0][:role] = new_need_role
      new_ops[0][:organisation_ids] = [second_organisation.api_id]
      new_ops
    }

    it "updates an existing need when its data changes and doesn't duplicate entry" do
      need_api_has_needs(updated_need_data)

      expect {
        ImportNeeds.run
      }.not_to change { Need.count }.by(1)

      created_need = Need.first

      expect(created_need.role).to be_eql new_need_role
      expect(created_need.organisations.count).to be_eql 1
      expect(created_need.reload.organisations.first.api_id).to be_eql(second_organisation.api_id)
    end
  end
end