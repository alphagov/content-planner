module ContentPlans
  class XlsExport
    CONTENTS_HEADERS = [
      'Title',
      'Size',
      'Status',
      'Platform',
      'Publish by'
    ]

    attr_reader :content_plan

    def initialize(content_plan)
      @content_plan = content_plan
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
      spreadsheet = StringIO.new
      book = Spreadsheet::Workbook.new

      contents_sheet = book.create_worksheet name: "Contents"
      contents_sheet.row(0).concat CONTENTS_HEADERS

      contents.each_with_index do |content, index|
        contents_sheet.row(index + 1).concat content
      end

      book.write spreadsheet
      spreadsheet.string
    end

    def contents
      content_plan.contents.map do |content_record|
        [
          [content_record.ref_no, content_record.title].join(' '),
          content_record.size,
          content_record.status,
          content_record.platform,
          content_record.publish_by.present? ? content_record.publish_by : ''
        ]
      end
    end
  end
end