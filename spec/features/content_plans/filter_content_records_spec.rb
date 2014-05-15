require "spec_helper"

describe "Content records", %q{
As a User of the Content Planner
I want to be able to filter content records in content plan details page
So that I can find records quickly
} do

  let!(:user) { create :user, :gds_editor }
  let!(:content_plan) {
    c = create(:content_plan, :with_organisation,
               :with_need,
               :with_user)
    c.reload
  }

  let(:content_title) { "First Content" }

  let!(:content) {
    create :content, title: content_title,
                     content_plans: [content_plan],
                     platform: "Whitehall",
                     status: "Live"
  }

  let(:another_content_title) { "Second content" }
  let!(:another_content) {
    create :content, title: another_content_title,
                     content_plans: [content_plan],
                     platform: "Publisher",
                     status: "Drafting - agency"
  }

  before {
   visit content_plan_path(content_plan)
  }

  describe "ability to filter" do
    it "should display content records" do
      expect_to_see content_title
      expect_to_see another_content_title
    end

    it "should allow to filter by title", js: true do
      within(".contents-search-form") do
        fill_in "search_title", with: content_title[3..5]
        click_on "Search"
      end

      expect_to_see content_title
      expect_to_see_no another_content_title

      within(".contents-search-form") do
        fill_in "search_title", with: another_content_title
        click_on "Search"
      end

      expect_to_see another_content_title
      expect_to_see_no content_title
    end

    it "should allow to filter by platform", js: true do
      within(".contents-search-form") do
        page.execute_script("$('#search_platform').val('Whitehall')")
        click_on "Search"
      end

      expect_to_see content_title
      expect_to_see_no another_content_title

      within(".contents-search-form") do
        page.execute_script("$('#search_platform').val('Publisher')")
        click_on "Search"
      end

      expect_to_see another_content_title
      expect_to_see_no content_title
    end

    it "should allow to filter by status", js: true do
      within(".contents-search-form") do
        page.execute_script("$('#search_status').val('Live')")
        click_on "Search"
      end

      expect_to_see content_title
      expect_to_see_no another_content_title

      within(".contents-search-form") do
        page.execute_script("$('#search_status').val('Drafting - agency')")
        click_on "Search"
      end

      expect_to_see another_content_title
      expect_to_see_no content_title
    end
  end
end
