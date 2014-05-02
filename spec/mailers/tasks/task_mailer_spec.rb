require "spec_helper"

describe "Task completion notification" do
  let!(:task_creator) { create :user, :gds_editor }
  let!(:task_owner) { create :user, :gds_editor }

  let!(:content) { create :content }
  let(:task_title) { "Nice task" }
  let!(:task) {
    create :task, :completed, title: task_title,
                              taskable: content,
                              users: [task_owner]
  }

  let(:mail) { TaskMailer.notify(task, task_creator) }
  let(:subject) { "#{task.title} task was completed" }

  it "renders the headers" do
    mail.subject.should eq(subject)
    mail.to.should eq([task_creator.email])
    mail.from.should eq(["content-planner@digital.cabinet-office.gov.uk"])
  end

  it "renders the body" do
    mail.body.encoded.should match(subject)
    mail.body.encoded.should have_link("View", href: content_url(content) + "#task_#{task.id}")
  end
end