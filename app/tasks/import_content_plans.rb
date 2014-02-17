require 'roo'

class ImportContentPlans
  def initialize(file_path)
    @file_path = file_path
  end

  def import
    xls = Roo::Spreadsheet.open(@file_path)
    xls.each_with_pagename do |name, sheet|
      next if name.match('_drop downs_')

      tag = create_tag(name)
      content_plan = create_content_plan(name, tag)
      # First row is a heading
      (2..sheet.last_row).each do |n|
        create_content(sheet.row(n), content_plan, tag, n)
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
    return "Not started" if status.blank?
    if status.match("Done")
      "Live"
    elsif status.match("In progress")
      "Drafting"
    elsif status.match("Not started")
      "Not started"
    else
      "Not started"
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
    type = content_type || ""
    type.truncate(255)
  end

  def extract_url(url)
    u = url || ""
    u.truncate(255)
  end

  def extract_title(title)
    t = title || ""
    t.truncate(255)
  end

  def extract_description(row)
    new_line = "\n\n"
    basic = [
      row[5],
      new_line,
      row[6],
      new_line,
      row[9],
      new_line
    ]

    source_url = ["## Source URL", new_line, row[10]]

    if row[10].present?
      basic << source_url
    end

    basic.join(" ")
  end

  def create_content(row, content_plan, tag, n)
    return if row.compact.empty?
    content_hash = {
      platform: row[0],
      size: extract_size(row[1]),
      status: extract_status(row[2]),
      title: extract_title(row[4]),
      description: extract_description(row),
      url: extract_url(row[7]),
      content_type: extract_content_type(row[8]),
      organisation_ids: ['hm-revenue-customs']
    }

    content = Content.create!(content_hash)

    content.maslow_need_ids = extract_need_id(row[11])
    content.tag_list = tag
    content.content_plans << content_plan
    content.save
  end

  def create_content_plan(name, tag)
    # name e.g. '1 - PAYE'
    title = name.match(/-(.*)/)[0][2..-1]
    ref_no = name.match(/\d{1,2}/)[0]
    plan = ContentPlan.create!(title: title, ref_no: ref_no, organisation_ids: ['hm-revenue-customs'])
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
