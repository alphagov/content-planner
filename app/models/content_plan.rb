class ContentPlan < ActiveRecord::Base
  include Versioning
  acts_as_taggable

  validates :title, presence: true
  validates :ref_no, presence: true

  has_many :source_url_content_plans
  has_many :source_urls, through: :source_url_content_plans

  has_many :tasks,    -> { order(created_at: :desc) }, dependent: :destroy
  has_many :comments, -> { order(created_at: :desc) }, dependent: :destroy, as: :commentable

  has_many :content_plan_needs

  has_many :content_plan_contents, dependent: :destroy
  has_many :contents, through: :content_plan_contents

  attr_accessor :maslow_need_ids

  def name
    "#{ref_no} - #{title}"
  end

  def maslow_need_ids
    content_plan_needs.any? ? content_plan_needs.map(&:need_id).join(",") : nil
  end

  def need_ids
    content_plan_needs.any? ? content_plan_needs.map(&:need_id) : nil
  end

  def status
    contents_status = contents.map(&:status).uniq
    i = contents_status.map do |st|
      Content::STATUS.index(st)
    end.max
    i.nil? ? Content::STATUS.first : Content::STATUS[i]
  end

  def size
    contents.map(&:size).sum
  end
end
