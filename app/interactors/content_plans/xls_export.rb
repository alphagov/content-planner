module ContentPlans
  class XlsExport

    TASKS_HEADERS = [
      'Title',
      'Status'
    ]

    COMMENTS_HEADERS = [
      'User',
      'Message',
      'Added at'
    ]

    CONTENTS_HEADERS = [
      'Title',
      'Size',
      'Status',
      'Platform',
      'Publish by'
    ]

    attr_reader :content_plan, :spreadsheet, :book

    def initialize(content_plan)
      @content_plan = content_plan

      @spreadsheet = StringIO.new
      @book = Spreadsheet::Workbook.new

      t = TASKS_HEADERS
      self.class.const_set('CONTENT_TASK_HEADERS', t.unshift('Tasks:').push('', ''))

      c = COMMENTS_HEADERS
      self.class.const_set('CONTENT_COMMENTS_HEADERS', c.unshift('Comments:').push(''))
    end

    def run
      xls_data = generate_xls

      slug = content_plan.title.squish.downcase.tr(" ","_")
      timestamp = Time.zone.now.strftime("%d_%m_%Y_%H_%M")
      xls_filename = "#{content_plan.ref_no}_#{slug}_dump_#{timestamp}.xls"

      [ xls_data, xls_filename ]
    end

    private

    def generate_xls
      generate_contents_sheet
      generate_tasks_sheet
      generate_comments_sheet

      book.write spreadsheet
      spreadsheet.string
    end

    def generate_contents_sheet
      contents_sheet = book.create_worksheet name: "Contents"
      contents_sheet.row(0).concat CONTENTS_HEADERS

      contents.flatten(1).each_with_index do |content, index|
        contents_sheet.row(index + 1).concat content
      end
    end

    def generate_tasks_sheet
      tasks_sheet = book.create_worksheet name: "Tasks"
      tasks_sheet.row(0).concat TASKS_HEADERS

      tasks(content_plan).each_with_index do |task, index|
        tasks_sheet.row(index + 1).concat task
      end
    end

    def generate_comments_sheet
      comments_sheet = book.create_worksheet name: "Comments"
      comments_sheet.row(0).concat COMMENTS_HEADERS

      comments(content_plan).each_with_index do |comment, index|
        comments_sheet.row(index + 1).concat comment
      end
    end

    def contents
      content_plan.contents.map do |content_record|
        fetch_content_record_data(content_record)
      end
    end

    def fetch_content_record_data(content_record)
      content_record_data = [
        [
          [content_record.ref_no, content_record.title].join(' '),
          content_record.size,
          content_record.status,
          content_record.platform,
          content_record.publish_by.present? ? content_record.publish_by : ''
        ]
      ]

      if content_record.tasks.present?
        content_record_data += [ CONTENT_TASK_HEADERS ]

        tasks(content_record).each do |task|
          content_record_data += [ task.unshift('') ]
        end
      end

      if content_record.comments.present?
        content_record_data += [ CONTENT_COMMENTS_HEADERS ]

        comments(content_record).each do |comment|
          content_record_data += [ comment.unshift('') ]
        end
      end

      content_record_data
    end

    def tasks(instance)
      instance.tasks.map do |task|
        [
          task.title,
          task.done? ? 'completed' : 'pending'
        ]
      end
    end

    def comments(instance)
      instance.comments.map do |comment|
        [
          comment.user.name,
          comment.message,
          comment.created_at.to_formatted_s(:long)
        ]
      end
    end
  end
end