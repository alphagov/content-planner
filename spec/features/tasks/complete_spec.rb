require "spec_helper"

describe "Task completion", %q{
As a GDS Editor of the Content Planner
I want to be able to mark task as completed
So that users can see which tasks are completed
} do

  let!(:gds_editor) { create :user, :gds_editor }
  let!(:task_creator) { create :user, :gds_editor }
  let!(:content_plan) {
    c = create(:content_plan, :with_organisation,
                              :with_need,
                              :with_user)
    c.reload
  }

  let!(:first_user) { create :user }
  let!(:second_user) { create :user }
  let!(:task) {
    create :task, taskable: content_plan,
                  users: [first_user, second_user],
                  creator: task_creator
  }

  describe "Mark task as completed" do
    before {
      ActionMailer::Base.deliveries.clear
      visit content_plan_path(content_plan)
    }

    it "shoul send email notifications to task creator and task owners", js: true do
      expect {
        check "task_done"
      }.to change { task.reload.done }.from(nil).to(true)

      deliveries = ActionMailer::Base.deliveries
      deliveries.length.should eq(3)
      deliveries.map(&:to).flatten.should eq([task_creator.email, first_user.email, second_user.email ])
    end
  end

  describe "Unmark task as completed" do
    before {
      task.done = true
      task.save

      ActionMailer::Base.deliveries.clear
      visit content_plan_path(content_plan)
    }

    it "shoul not send email notifications on unmarking task as completed", js: true do
      expect {
        uncheck "task_done"
      }.to change { task.reload.done }.from(true).to(false)

      deliveries = ActionMailer::Base.deliveries
      deliveries.length.should eq(0)
    end
  end
end