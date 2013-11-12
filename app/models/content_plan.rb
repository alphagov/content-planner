class ContentPlan < ActiveRecord::Base
  self.inheritance_column = :_type_disabled
  acts_as_taggable

  TYPES = ["Mainstream", 'Specialist']
  STATUS = ["Not started", "In Progress", "Completed", "Published"]

  validates :title, presence: true
  validates :size, presence: true

  has_many :source_url_content_plans
  has_many :source_urls, through: :source_url_content_plans

  has_many :tasks,    -> { order(created_at: :desc) }
  has_many :comments, -> { order(created_at: :desc) }

  def name
    "#{ref_no} - #{title}"
  end
end
