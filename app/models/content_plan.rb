class ContentPlan < ActiveRecord::Base
  include Versioning
  include Organisations

  acts_as_taggable

  QUARTERS = 1..4
  YEARS = Time.now.year..(Time.now + 2.years).year

  has_many :tasks,    -> { order(created_at: :desc) }, dependent: :destroy, as: :taskable
  has_many :comments, -> { order(created_at: :desc) }, dependent: :destroy, as: :commentable

  has_many :content_plan_needs
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

  def maslow_need_ids
    content_plan_needs.map(&:need_id)
  end

  def maslow_need_ids=(ids)
    content_plan_needs.destroy_all
    ids.reject(&:blank?).each do |nid|
      ContentPlanNeed.find_or_create_by!(content_plan: self, need_id: nid)
    end
  end

  def need_ids
    content_plan_needs.any? ? content_plan_needs.map(&:need_id) : nil
  end

  def size
    contents.sum(:size)
  end
end
