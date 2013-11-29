class Content < ActiveRecord::Base

  acts_as_taggable

  PLATFORM = ["Mainstream", "Whitehall"]

  STATUS = ["Not started", "In Progress", "Completed", "Published"]

  has_many :content_plan_contents, dependent: :destroy
  has_many :content_plans, through: :content_plan_contents, source: :content_plan

  has_many :content_needs

  attr_accessor :maslow_need_ids

  def maslow_need_ids
    content_needs.any? ? content_needs.map(&:need_id).join(",") : nil
  end

  def need_ids
    content_needs.any? ? content_needs.map(&:need_id) : nil
  end

end
