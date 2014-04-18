require 'csv'

module ContentPlans
  class CsvExport
    HEADERS = [
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
      csv_data = generate_csv

      timestamp = Time.zone.now.strftime("%d_%m_%Y_%H_%M")
      csv_filename = "#{content_plan.ref_no}_#{content_plan.title}_dump_#{timestamp}.csv"

      [ csv_data, csv_filename ]
    end

    private

    def generate_csv
      ::CSV.generate(encoding: "UTF-8") do |csv_out|
        csv_out << HEADERS.flatten

        content_plan.contents.each do |content_record|
          csv_record = [
            [content_record.ref_no, content_record.title].join(' '),
            content_record.size,
            content_record.status,
            content_record.platform,
            content_record.publish_by.present? ? content_record.publish_by : ''
          ]

          csv_out << csv_record.flatten
        end
      end
    end
  end
end