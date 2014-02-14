require 'dullard'

class ImportContentPlans
  def initialize(file_path)
    @file_path = Pathname.new(file_path)

    raise ArgumentError.new("#{file_path} does not exist") unless @file_path.exist?
  end

  def import
    workbook = Dullard::Workbook.new @file_path

    workbook.sheets.each do |sheet|
      next if sheet.name.match('p downs')
      tag = create_tag(sheet.name)

      content_plan = create_content_plan(sheet, tag)

      sheet.rows.each_with_index do |row, i|
        create_content(row, content_plan, tag) unless i == 0
      end
    end
  end

  private

  def extract_need_id(needs)
    return [] unless needs
    match = needs.match(/\d{6,}/)
    if match
      [match[0]]
    else
      []
    end
  end

  def extract_status(status)
    return nil unless status
    if status.match('Done')
      'Live'
    elsif status.match('In progress')
      'Drafting'
    elsif status.match('Not started')
      'Not started'
    else
      'Not started'
    end
  end

  def extract_size(size)
    return nil unless size
    match = size.match(/\d/)
    if match
      match[0].to_i
    else
      if size.match('Big')
        5
      elsif size.match('Small')
        3
      elsif size.match('Tweak')
        2
      else
        nil
      end
    end
  end

  def extract_content_type(content_type)
    type = content_type || ''
    type.truncate(255)
  end

  def extract_url(url)
    u = url || ''
    u.truncate(255)
  end

  def extract_title(title)
    t = title || ''
    t.truncate(255)
  end

  def create_content(row, content_plan, tag)
    content_hash = {
      platform: row[0],
      size: extract_size(row[1]),
      status: extract_status(row[2]),
      title: extract_title(row[4]),
      description: "#{row[5]} \n\n #{row[6]} \n\n ### Source URL \n\n #{row[9]}",
      url: extract_url(row[7]),
      content_type: extract_content_type(row[8]),
      organisation_ids: ['hm-revenue-customs']
    }

    content = Content.create(content_hash)
    content.maslow_need_ids = extract_need_id(row[10])
    content.tag_list = tag
    content.content_plans << content_plan
    content.save
  end

  def create_content_plan(sheet, tag)
    # name e.g. '1 - PAYE'
    title = sheet.name.match(/-(.*)/)[0][2..-1]
    ref_no = sheet.name.match(/\d{1,2}/)[0]
    plan = ContentPlan.create(title: title, ref_no: ref_no, organisation_ids: ['hm-revenue-customs'])
    plan.tag_list = tag.name
    plan.save
    plan
  end

  def create_tag(name)
    ActsAsTaggableOn::Tag.find_or_create_with_like_by_name(
      sheet_name_for_tag(name)
    )
  end

  def sheet_name_for_tag(name)
    name.match(/-(.*)/)[0][2..-1].strip.mb_chars.downcase.to_s
  end
end
