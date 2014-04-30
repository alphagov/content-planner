require "spec_helper"

feature "Reply on comment" do
  let!(:user) { create :user, :gds_editor }
  let!(:content) { create :content }
  let!(:comment) {
    create :comment, user: user, commentable: content
  }

  let(:reply_text) { "Reply message" }

  scenario "User replies on comment" do
    visit content_path(content)
    user_can_reply_comment(0, 1)
  end

  describe "Comment Replies page" do
    let!(:reply_comment) {
      create :comment, user: user, commentable: content, parent: comment
    }

    before {
      visit content_path(content)
    }

    scenario "should see comment and replies" do
      expect_to_see comment.message
      expect_to_see reply_comment.message
    end

    scenario "User can reply from this page" do
      user_can_reply_comment(1, 2)
    end
  end

  private

  def user_can_reply_comment(initial_children_count, final_children_count)
    within(dom_id_selector(comment)) do
      find(".reply_comment_link").click
    end

    expect {
      within(".reply_comment_form") do
        fill_in "reply[message]", with: reply_text
        click_on "Reply"
      end
    }.to change { comment.reload.children.count }.from(initial_children_count).to(final_children_count)
  end
end
