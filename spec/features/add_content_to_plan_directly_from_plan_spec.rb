require "spec_helper"

feature "Add content to plan directly from the Content Plan" do

  before do
    user = build :user
    user.permissions = [User::Permissions::SIGNIN, User::Permissions::GDS_EDITOR]
    user.save
  end

  scenario "new content from Content Plan" do
    content_plan = create :content_plan
    visit content_plan_path(content_plan)
    click_link "Add content"
    find("#content_content_plan_ids").value.should include(content_plan.id.to_s)
  end
end
