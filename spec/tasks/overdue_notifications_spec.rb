require "spec_helper"

describe "overdue task's notifications script" do
  let!(:task_creator) { create :user, :gds_editor }
  let!(:first_task_owner) { create :user }
  let!(:second_task_owner) { create :user }

  let!(:content) { create :content }
  let(:task_title) { "Nice task" }
  let!(:task) {
    create :task, :overdue , title: task_title,
                             taskable: content,
                             users: [first_task_owner, second_task_owner],
                             creator: task_creator
  }

  let(:recepient_emails) {
    [task_creator.email, first_task_owner.email, second_task_owner.email]
  }

  before {
    ActionMailer::Base.deliveries.clear
    OverdueTaskNotifier.run
  }

  it "should send emails notifications to task creator and task owners" do
    deliveries = ActionMailer::Base.deliveries
    expect(deliveries.length).to be_eql(3)
    expect(deliveries.map(&:to).flatten).to be_eql(recepient_emails)
  end
end