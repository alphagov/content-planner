require "spec_helper"

describe "Content Plan management" do
  include ContentPlanSteps

  before { create :user, :gds_editor }

  context "create" do
    before { create_content_plan! }

    it {
      expect(page).to have_text("Content plan was successfully created.")
      expect(page).to have_text("Some title")
      expect(page).to have_text("X")
    }
  end

  context "edit" do
    let!(:user) { create :user }
    let!(:need) { Need.all.first }
    let!(:organisation) { Organisation.all.first }
    let(:content_plan) { ContentPlan.last }
    let!(:attributes) {
      attributes_for(:content_plan).tap do |attributes|
        attributes[:tag_list] = "tag 999"
        attributes[:users] = user.to_s
        attributes[:needs] = need.id.to_s
        attributes[:organisations] = organisation.title
      end
    }
    let(:expect_to_see_new_attributes) {
      attributes.each do |key, value|
        expect(page).to have_text(value)
      end
    }

    before {
      create_content_plan!
      visit edit_content_plan_path(content_plan)
    }

    it {
      fill_in "Ref no", with: attributes[:ref_no]
      fill_in "Title", with: attributes[:title]
      fill_in "Details", with: attributes[:details]
      fill_in "Notes", with: attributes[:notes]
      fill_in "Tag list", with: attributes[:tag_list]
      select attributes[:users], from: "content_plan_user_ids"
      select attributes[:organisations], from: "content_plan_organisation_ids"
      select attributes[:due_quarter], from: "Quarter"
      select attributes[:due_year], from: "Year"

      need_text = find("option", text: Regexp.new(attributes[:needs])).text
      select need_text, from: "content_plan_maslow_need_ids"

      click_on "Update Content plan"

      expect_to_see_new_attributes
    }
  end
end
