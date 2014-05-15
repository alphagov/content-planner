require "spec_helper"

feature "Add comments from content" do
  let!(:user) { create :user, :gds_editor }
  let!(:content) { create :content }
  let!(:comment) {
    create :comment, user: user, commentable: content
  }

  let(:comment_text) { "Test comment" }
  let(:updated_comment_text) { "Updated test comment" }

  before {
    visit content_path(content)
  }

  scenario "add comment from content" do
    fill_in "comment_message", with: comment_text
    click_on "Create Comment"

    current_path.should eq(content_path(content))
    expect_to_see comment_text
  end

  describe "update and delete links" do
    include RSpec::Rails::RequestExampleGroup

    describe "5 minutes passed" do
      before {
        comment.created_at = comment.created_at - 5.minutes
        comment.save

        visit content_path(content)
      }

      it "comment should have no edit or delete links" do
        comment_has_not_edit_and_delete_links
      end

      it "should not allow to update or delete comment" do
        doesnt_allow_to_update_or_delete_comment("time_passed")
      end
    end

    describe "not owner of comment" do
      let!(:another_user) { create :user, :gds_editor }

      before {
        comment.user = another_user
        comment.save

        visit content_path(content)
      }

      it "comment should have no edit or delete links" do
        comment_has_not_edit_and_delete_links
      end

      it "should not allow to update or delete comment" do
        doesnt_allow_to_update_or_delete_comment("permissions")
      end
    end
  end

  scenario "edit comment from content" do
    within(dom_id_selector(comment)) do
      click_on "edit_comment"
    end

    fill_in "comment_message", with: updated_comment_text
    click_on "Update Comment"

    current_path.should eq(content_path(content))
    expect_to_see updated_comment_text
    expect_to_see "Comment updated"
  end

  scenario "delete comment from content" do
    expect {
      within(dom_id_selector(comment)) do
        click_on "delete_comment"
      end
    }.to change { user.reload.comments.count }.from(1).to(0)

    expect_to_see "Comment deleted"
    current_path.should eq(content_path(content))
    expect_to_see_no comment.message
  end

  private

  def comment_has_not_edit_and_delete_links
    within(dom_id_selector(comment)) do
      expect(page).to_not have_selector("a[data-action='edit_comment']")
      expect(page).to_not have_selector("a[data-action='delete_comment']")
    end
  end

  def doesnt_allow_to_update_or_delete_comment(restrict_rule)
    visit edit_comment_path(comment)
    expect_to_see notice_by_restrict_rule(restrict_rule)

    expect {
      delete comment_path(comment)
    }.to_not change { Comment.count }.by(-1)
  end

  def notice_by_restrict_rule(restrict_rule)
    if restrict_rule == "permissions"
     "You have no permissions to edit this comment"
    else
      "Comment can be updated or deleted only in 5 minutes after posting"
    end
  end
end
