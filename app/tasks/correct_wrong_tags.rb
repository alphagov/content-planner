class CorrectWrongTags
  class << self
    def run
      ContentPlan.all.each do |content_plan|
        if content_plan.tags.present?
          correct_tags!(content_plan)
        end
      end

      Content.all.each do |content|
        if content.tags.present?
          correct_tags!(content)
        end
      end
    end

    def correct_tags!(instance)
      current_tag_list = instance.tag_list
      new_tag_list = current_tag_list.map { |tag| tag.gsub(/["\[\]\\]/, "") }
      instance.tag_list = new_tag_list.compact.uniq
      instance.save
    end
  end
end