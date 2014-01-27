class Content < ActiveRecord::Base

  acts_as_taggable

  PLATFORMS = ["Mainstream", "Whitehall"]

  STATUS = ["Not started", "In progress", "Completed", "Published"]

  has_many :content_plan_contents, dependent: :destroy
  has_many :content_plans, through: :content_plan_contents, source: :content_plan

  has_many :content_needs
  has_many :content_users

  has_many :comments, -> { order(created_at: :desc) }, dependent: :destroy, as: :commentable

  attr_accessor :maslow_need_ids

  validates :title, presence: true

  def maslow_need_ids
    content_needs.any? ? content_needs.map(&:need_id).join(",") : nil
  end

  def need_ids
    content_needs.any? ? content_needs.map(&:need_id) : nil
  end

  def whitehall?
    platform == "Whitehall"
  end

end
