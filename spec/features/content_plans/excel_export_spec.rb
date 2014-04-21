require "spec_helper"

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

  let(:content_plan_task) {
    content_plan.tasks.first
  }

  let(:content_plan_comment) {
    content_plan.comments.first
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
      visit xls_export_content_plan_path(content_plan)

      book = fetch_excel_export(page)

      # should be 3 sheets: Content Plan Contens, Tasks and Comments
      expect(book.worksheets.count).to eql 3

      # Content Plan Contens sheet should consist of 7 rows:
      # 1 - headers
      # 2 - first content line
      # 3 - first content tasks line (1 content task)
      # 4 - first content comments line (1 content comment)
      # 5 - second content line
      # 6 - second content tasks line (1 content task)
      # 7 - second content comments line (1 content comment)
      contents_sheet = book.worksheets[0]
      expect(contents_sheet.rows.count).to eql 7
      expect(contents_sheet.rows[0]).to eql ContentPlans::XlsExport::CONTENTS_HEADERS

      # Tasks sheet should consist of 2 rows:
      # 1 - headers
      # 2 - task line
      tasks_sheet = book.worksheets[1]
      expect(tasks_sheet.rows.count).to eql 2
      expect(tasks_sheet.rows[0].map(&:to_s)).to eql ContentPlans::XlsExport::TASKS_HEADERS
      expect(tasks_sheet.rows[1].map(&:to_s)).to eql task_row(content_plan_task)

      # Comments sheet should consist of 2 rows:
      # 1 - headers
      # 2 - comment line
      comments_sheet = book.worksheets[2]
      expect(comments_sheet.rows.count).to eql 2
      expect(comments_sheet.rows[0].map(&:to_s)).to eql ContentPlans::XlsExport::COMMENTS_HEADERS
      expect(comments_sheet.rows[1].map(&:to_s)).to eql comment_row(content_plan_comment)
    end
  end

  private

  def fetch_excel_export(page)
    downloaded_excel_export = page.source.force_encoding('UTF-8')
    spreadsheet = StringIO.new(downloaded_excel_export)
    book = Spreadsheet.open spreadsheet
  end

  def task_row(task)
    [
      task.title,
      task.done? ? 'completed' : 'pending'
    ]
  end

  def comment_row(comment)
    [
      comment.user.name,
      comment.message,
      comment.created_at.to_formatted_s(:long)
    ]
  end

  def content_row(content)
    [
      [content_record.ref_no, content_record.title].join(' '),
      content_record.size,
      content_record.status,
      content_record.platform,
      content_record.publish_by.present? ? content_record.publish_by : ''
    ]
  end

  def content_task_row(task)
    task_row(task)
  end

  def content_comment_row(comment)
    comment_row(task)
  end
end