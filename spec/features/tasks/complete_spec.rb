require "spec_helper"

describe "Task completion", %q{
As a GDS Editor of the Content Planner
I want to be able to mark task as completed
So that users can see which tasks are completed
} do

  let!(:gds_editor) { create :user, :gds_editor }
  let!(:task_creator) { create :user, :gds_editor }
  let!(:content_plan) {
    create(:content_plan, :with_organisation, :with_need, :with_user).reload
  }

  let!(:first_user) { create :user }
  let!(:second_user) { create :user }

  describe "Mark task as completed", js: true do
    let!(:task) {
      create :task, taskable: content_plan,
                    users: [first_user, second_user],
                    creator: task_creator
    }

    before {
      ActionMailer::Base.deliveries.clear
      visit content_plan_path(content_plan)

      expect(task.done).to be_nil
      check "task_done"
    }

    it "should send email notifications to task creator and task owners" do
      expect(task.reload.done).to be_true

      deliveries = ActionMailer::Base.deliveries
      deliveries.length.should eq(3)
      deliveries.map(&:to).flatten.should eq([task_creator.email, first_user.email, second_user.email])
    end

    it "should save the user who completes the task" do
      expect(task.reload.completed_by).to eq(gds_editor)
    end

    it "should include the user who completes the task on the email" do
      mail = ActionMailer::Base.deliveries.first
      expect(mail.encoded).to include("was completed by #{gds_editor}")
    end

    it "should save the date the task was completed" do
      expect(task.reload.done_at).to be_a(Time)
    end
  end

  describe "Unmark task as completed", js: true do
    let!(:task) {
      create(:task, :completed,
                    taskable: content_plan,
                    users: [first_user, second_user],
                    creator: task_creator,
                    completed_by: gds_editor)
    }

    before {
      ActionMailer::Base.deliveries.clear
      visit content_plan_path(content_plan)

      uncheck "task_done"
    }

    it "should not send email notifications on unmarking task as completed" do
      expect(task.reload.done).to be_false

      deliveries = ActionMailer::Base.deliveries
      deliveries.length.should eq(0)
    end

    it "should unset the user who completed the task" do
      expect(task.reload.completed_by).to be_nil
    end

    it "should remove `done_at`" do
      expect(task.reload.done_at).to be_nil
    end
  end
end
