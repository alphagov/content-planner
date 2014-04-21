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

      # should be 5 sheets: Content Plan Details, Users, Contens, Tasks and Comments
      expect(book.worksheets.count).to eql 5

      # Content Plan Details sheet should consist of 13 rows:
      # Ref no:
      # Title:
      # Details:
      # Notes:
      # Due quarter:
      # Due Year:
      # Created at:
      # Updated at:
      # Needs (0):
      # Number of users:
      # Number of contents:
      # Number of tasks:
      # Number of comments:
      details_sheet = book.worksheets[0]
      expect(details_sheet.rows.count).to eql 13
      content_plan_details(content_plan).each_with_index do |data, index|
        expect(details_sheet.rows[index]).to eql data
      end

      # Users sheet should consist of 2 rows
      # 0 - headers
      # 1 - user line
      users_sheet = book.worksheets[1]
      expect(users_sheet.rows.count).to eql 2
      expect(users_sheet.rows[0]).to eql ContentPlans::XlsExport::USERS_HEADERS
      expect(users_sheet.rows[1].map(&:to_s)).to eql user_row(user.reload)

      # Contens sheet should consist of 7 rows:
      # 0 - headers
      # 1 - first content line
      # 2 - first content tasks headers line
      # 3 - first content tasks line (1 content task)
      # 4 - first content comments headers line
      # 5 - first content comments line (1 content comment)
      # 6 - second content line
      contents_sheet = book.worksheets[2]
      expect(contents_sheet.rows.count).to eql 7
      expect(contents_sheet.rows[0]).to eql ContentPlans::XlsExport::CONTENTS_HEADERS

      expect(contents_sheet.rows[1]).to eql content_row(content.reload)

      expect(contents_sheet.rows[2].map(&:to_s)).to eql ContentPlans::XlsExport::TASKS_HEADERS
      expect(contents_sheet.rows[3].map(&:to_s)).to eql content_task_row(content_task)

      expect(contents_sheet.rows[4].map(&:to_s)).to eql ContentPlans::XlsExport::COMMENTS_HEADERS
      expect(contents_sheet.rows[5].map(&:to_s)).to eql content_comment_row(content_comment)

      expect(contents_sheet.rows[6]).to eql content_row(second_content.reload)

      # Tasks sheet should consist of 2 rows:
      # 0 - headers
      # 1 - task line
      tasks_sheet = book.worksheets[3]
      expect(tasks_sheet.rows.count).to eql 2
      expect(tasks_sheet.rows[0].map(&:to_s)).to eql ContentPlans::XlsExport::TASKS_HEADERS
      expect(tasks_sheet.rows[1].map(&:to_s)).to eql task_row(content_plan_task)

      # Comments sheet should consist of 2 rows:
      # 0 - headers
      # 1 - comment line
      comments_sheet = book.worksheets[4]
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

  def content_plan_details(content_plan)
    needs = content_plan.content_plan_needs.map(&:need_id)

    [
      [ "Ref no:", content_plan.ref_no ],
      [ "Title:", content_plan.title ],
      [ "Details:", content_plan.details ],
      [ "Notes:", content_plan.notes ],
      [ "Due quarter:", content_plan.due_quarter ],
      [ "Due Year:", content_plan.due_year ],
      [ "Created at:", content_plan.created_at.to_formatted_s(:long) ],
      [ "Updated at:", content_plan.updated_at.to_formatted_s(:long) ],
      [ "Needs (#{needs.count}):", needs.join(', ') ],
      [ "Number of users:", content_plan.users.count ],
      [ "Number of contents:", content_plan.contents.count ],
      [ "Number of tasks:", content_plan.tasks.count ],
      [ "Number of comments:", content_plan.comments.count ]
    ]
  end

  def user_row(user)
    [
      user.uid.to_s,
      user.name,
      user.email,
      user.organisation_slug.to_s,
      user.permissions.join(', ')
    ]
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

  def content_row(content_record)
    [
      [content_record.ref_no, content_record.title].join(' '),
      content_record.size,
      content_record.status,
      content_record.platform,
      (content_record.publish_by.present? ? content_record.publish_by.strftime("%d/%m/%Y") : '')
    ]
  end

  def content_task_row(task)
    task_row(task).unshift('')
  end

  def content_comment_row(comment)
    comment_row(comment).unshift('')
  end
end