require "spec_helper"

describe "Dashboard" do
  include DashboardSteps
  include ActionView::Helpers::TextHelper

  let!(:content) { create :content, :with_content_plan, :with_organisation }
  let!(:content2) { create :content, :with_content_plan }

  let(:content_plan) { content.content_plans.reload.first }
  let(:content_plan2) { content2.content_plans.reload.first }
  let!(:organisation) { content.reload.organisations.first }

  before {
    create :user, :gds_editor
    visit root_path
  }

  context "list" do
    it { expect(page).to have_text(content_plan) }
    it { expect(page).to have_text(content_plan2) }
  end

  context "filter" do
    before { fill_in_filter }

    it { expect(page).to have_text(content_plan) }
    it { expect(page).to_not have_text(content_plan2) }
  end

  context "status bars" do
    let!(:contents) {
      50.times { create(:content_plan_content, content_plan: content_plan) }
      content_plan.contents.reload
    }

    before { visit root_path }

    it { expect_to_see_status_bars }
  end
end
