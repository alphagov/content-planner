require "spec_helper"

describe "edit tasks", js: true do
  let!(:gds_editor) { create :user, :gds_editor }
  let!(:content_plan) {
    create(:content_plan, :with_organisation, :with_user)
  }
  let!(:task) {
    create :task, taskable: content_plan
  }

  let(:title) { "Edited task" }

  before {
    visit content_plan_path(content_plan)
    find("#task_#{task.id}").hover # show edit button
    find(".edit-task-btn").click   # click edit button
    within "#edit-task#{task.id}-form" do
      fill_in "task_title", with: title
      click_on "Update Task"
    end
  }

  it { expect(task.reload.title).to eq(title) }
end
