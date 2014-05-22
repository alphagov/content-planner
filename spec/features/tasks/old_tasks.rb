require "spec_helper"

describe "Old tasks" do
  let!(:gds_editor) { create :user, :gds_editor }
  let!(:content_plan) {
    create(:content_plan, :with_organisation, :with_user)
  }
  let!(:task) {
    create :task, taskable: content_plan
  }
  let!(:done_task) {
    create(:task, :completed,
                  taskable: content_plan,
                  completed_by: gds_editor)
  }
  let!(:old_task) {
    create(:task, :completed,
                  taskable: content_plan,
                  completed_by: gds_editor,
                  done_at: Time.now.ago(1.day))
  }

  before {
    visit content_plan_path(content_plan)
  }

  it "do not show old tasks by default" do
    expect_to_see task.title
    expect_to_see done_task.title
    expect_to_see "Show completed tasks"
    within ".completed-tasks.hidden" do
      expect_to_see old_task.title
    end
  end

  describe "show old tasks by clicking on link", js: true do
    before {
      click_on "Show completed tasks"
    }

    it {
      expect_to_see_no "Show completed tasks"
      expect_to_see old_task.title
    }
  end
end
