require "spec_helper"

describe "Comment Reply notification" do
  let!(:user) { create :user, :gds_editor }
  let!(:another_user) { create :user, :gds_editor }
  let!(:content) { create :content }
  let!(:comment) {
    create :comment, user: user, commentable: content
  }

  let(:reply_text) { "Reply message" }
  let!(:reply_comment) {
    create :comment, message: reply_text,
                     user: another_user,
                     commentable: content,
                     parent: comment
  }

  let(:mail) { CommentMailer.reply_notification(reply_comment, user) }
  let(:subject) { "#{another_user} replied on comment on #{content}" }

  it "renders the headers" do
    mail.subject.should eq(subject)
    mail.to.should eq([user.email])
    mail.from.should eq(["content-planner@digital.cabinet-office.gov.uk"])
  end

  it "renders the body" do
    mail.body.encoded.should match(subject)
    mail.body.encoded.should match(reply_comment.message)
    mail.body.encoded.should have_link("View", href: comment_url(comment))
  end
end
