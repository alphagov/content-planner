require "spec_helper"

describe "Tasks", %q{
As a GDS Editor of the Content Planner
I want to be able to add tasks
} do

  let!(:gds_editor) { create :user, :gds_editor }
  let!(:content_plan) {
    c = create(:content_plan, :with_organisation,
                              :with_need,
                              :with_user)
    c.reload
  }

  let!(:first_user) { create :user }
  let!(:second_user) { create :user }
  let(:task_title) { "Test task" }

  describe "Task creation" do
    before {
      visit content_plan_path(content_plan)
    }

    it "should not allow to create task without title" do
      expect {
        within("#new_task") do
          click_on "Create Task"
        end
      }.to_not change { content_plan.reload.tasks.count }.from(0).to(1)

      within(".task_title") do
        expect_to_see "can't be blank"
      end
    end

    it "shoul allow to add new task with proper data" do
      expect {
        within("#new_task") do
          fill_in "task[title]", with: task_title
          select first_user.to_s, from: "task_user_ids"
          select second_user.to_s, from: "task_user_ids"

          click_on "Create Task"
        end
      }.to change { content_plan.reload.tasks.count }.from(0).to(1)

      created_task = content_plan.reload.tasks.first
      expect(created_task.users.count).to be_eql 2

      assigned_users = created_task.users
      expect(created_task.decorate.assigned_people).to be_eql("Assigned: #{first_user}, #{second_user}")
    end
  end
end