class SourceUrl < ActiveRecord::Base

  acts_as_taggable

  validates :from_url, presence: true, uniqueness: true
  validate :no_to_url_when_to_archive

  def state
    if transitioned?
      "Transitioned"
    elsif archive?
      "To archive"
    elsif needs_assigned? && content_plan_assigned? && false #content plans are all completed
      "Ready to transition"
    elsif needs_assigned? && content_plan_assigned?
      "Needs & content plan assigned"
    else
      "Not analysed"
    end
  end

  def no_to_url_when_to_archive
    if archive? && to_url.present?
      errors.add(:to_url, "must be blank when archiving")
    else
      true
    end
  end
end
