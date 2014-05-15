require "spec_helper"

describe "Profile page", %q{
As a User of the Content Planner
I want to be able to see my profile page
So that I can review all related content like content plans, contents, tasks and comments
} do

  let!(:user) { create :user }
  let!(:content_plan) {
    c = create(:content_plan, :with_organisation,
               :with_need,
               users: [user])
    c.reload
  }
  let!(:content) {
    create :content, content_plans: [content_plan],
                     users: [user]
  }

  let(:task_title) { "Nice task" }
  let!(:task) {
    create :task, taskable: content_plan,
                  title: task_title,
                  users: [user]
  }

  let(:comment_message) { "Nice comment" }
  let!(:comment) {
    create :comment, message: comment_message,
                     user: user,
                     commentable: content_plan
  }

  describe "Task creation" do
    before {
      visit user_path(user)
    }

    it "should display user's bio" do
      expect_to_see user.name
      expect_to_see "Email: #{user.email}"
    end

    it "should display related content plans" do
      expect(page).to have_link(
        content_plan.title,
        href: content_plan_path(content_plan))
    end

    it "should display related contents" do
      expect(page).to have_link(
        content.to_s,
        href: content_path(content))
    end

    it "should display related content plans" do
      expect_to_see content_plan.title
    end

    it "should display user's comments" do
      within(".comments") do
        expect_to_see comment_message
      end
    end

    it "should display user's assigned tasks" do
      within(".tasks") do
        expect_to_see task.title
      end
    end
  end
end
