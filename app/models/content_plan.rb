class ContentPlan < ActiveRecord::Base
  # TODO Rename Type to publishing platform
  self.inheritance_column = :_type_disabled
  include Versioning
  acts_as_taggable

  TYPES = ["Mainstream", "Whitehall"]
  STATUS = ["Not started", "In Progress", "Completed", "Published"]

  validates :title, presence: true
  validates :size, presence: true
  validates :ref_no, presence: true

  has_many :source_url_content_plans
  has_many :source_urls, through: :source_url_content_plans

  has_many :tasks,    -> { order(created_at: :desc) }, dependent: :destroy
  has_many :comments, -> { order(created_at: :desc) }, dependent: :destroy

  def name
    "#{ref_no} - #{title}"
  end
end
