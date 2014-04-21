require "spec_helper"
require 'spreadsheet'

describe "The Excel export", %q{
As a User of the Content Planner
I want to be able to export content plan once all records have been changed to the 'live' status
So that I can have ability to review content plan in excel file
} do

  let!(:content_plan) {
    c = create(:content_plan, :with_organisation,
                              :with_need,
                              :with_tag,
                              :with_user,
                              :with_content,
                              :with_task,
                              :with_comment)
    c.reload
  }

  let(:content) {
    content_plan.contents.first
  }

  let!(:second_content) {
    create(:content, content_plan_ids: [content_plan.id])
  }

  let(:user) {
    content_plan.users.first
  }

  let!(:content_task) {
    create(:task, taskable: content)
  }

  let!(:content_comment) {
    create(:comment, commentable: content, user: user)
  }

  it "'Excel export' link should not be visible" do
    visit content_plan_path(content_plan)
    expect_to_see_no 'Excel export'
  end

  describe "all records have been changed to the 'live' status", type: :controller do
    before {
      content_plan.contents.update_all(status: "Live")
      visit content_plan_path(content_plan)
    }

    it "should be visible" do
      expect_to_see 'Excel export'
    end

    it "user can make 'Excel export'" do
      Spreadsheet.client_encoding = 'UTF-8'
      visit xls_export_content_plan_path(content_plan)

      book = fetch_excel_export(page)
      expect(book.worksheets.count).to eql 3
    end
  end

  private

  def fetch_excel_export(page)
    downloaded_excel_export = page.source.force_encoding('UTF-8')
    spreadsheet = StringIO.new(downloaded_excel_export)
    book = Spreadsheet.open spreadsheet
  end
end