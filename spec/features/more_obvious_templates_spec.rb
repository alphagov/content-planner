require "spec_helper"

feature "Make it more obious when you're looking at a content plan vs content" do

  before do
    user = build :user
    user.permissions = [User::Permissions::SIGNIN, User::Permissions::GDS_EDITOR]
    user.save
  end

  describe "Content plans is active" do
    scenario "index" do
      visit content_plans_path
      expect_content_plans_to_be_active
    end
    scenario "new" do
      visit new_content_plan_path
      expect_content_plans_to_be_active
    end
    scenario "edit" do
      content_plan = create :content_plan
      visit edit_content_plan_path(content_plan)
      expect_content_plans_to_be_active
    end
  end

  private

  def expect_content_plans_to_be_active
    page.should have_css(".active a[href='#{content_plans_path}']")
  end
end
