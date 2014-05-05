class ContentPlan < ActiveRecord::Base
  include Versioning
  include Organisations

  acts_as_taggable

  paginates_per 15

  QUARTERS = 1..4
  YEARS = Time.now.year..(Time.now + 2.years).year

  has_many :tasks,    -> { order(created_at: :desc) }, dependent: :destroy, as: :taskable
  has_many :comments, -> { order(created_at: :desc) }, dependent: :destroy, as: :commentable

  has_many :content_plan_needs, dependent: :destroy
  has_many :needs, through: :content_plan_needs

  has_many :content_plan_users
  has_many :users, through: :content_plan_users

  has_many :content_plan_contents, dependent: :destroy
  has_many :contents, through: :content_plan_contents

  scope :due_date, ->(quarter, year) {
    scope = all
    scope = scope.where(due_quarter: quarter) if quarter.present?
    scope = scope.where(due_year: year) if year.present?
    scope
  }

  scope :contents, -> {
    Content.where(id: all.map(&:content_plan_contents).flatten.map(&:content_id).uniq).
      order("contents.ref_no")
  }

  validates :title, :ref_no, presence: true, length: { maximum: 255 }

  # Caching
  before_save do
    contents.each { |record| record.touch }
  end

  def name
    "#{ref_no} - #{title}"
  end
  alias_method :to_s, :name

  def size
    contents.map(&:size).compact.sum
  end
end
