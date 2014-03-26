require "spec_helper"

feature "Content plans filter" do
  let!(:content_plan) { create(:content_plan, :with_organisation, :with_need, :with_tag, :with_user) }
  let!(:content_plan_2) { create(:content_plan, :with_organisation, :with_need, :with_tag, :with_user) }

  before { create :user, :gds_editor }

  scenario "filter content plans" do
    visit content_plans_path

    fill_in "search_ref_no", with: content_plan.ref_no
    fill_in "search_tag", with: content_plan.tags.first.to_s
    select content_plan.organisations.first.to_s, from: "search_organisation_ids"
    select content_plan.content_plan_needs.first.need.to_s, from: "search_need_id"
    select content_plan.users.first.to_s, from: "search_user_id"
    due_date = "q#{content_plan.due_quarter} #{content_plan.due_year}"
    select due_date, from: "search_due_date"

    click_on "Search"

    expect(page).to have_content(content_plan.ref_no)
    expect(page).to_not have_content(content_plan_2.ref_no)
  end
end
