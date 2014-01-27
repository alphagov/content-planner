class Content < ActiveRecord::Base
  extend ActiveHash::Associations::ActiveRecordExtensions

  acts_as_taggable

  PLATFORMS = ["Mainstream", "Whitehall"]

  has_many :content_plan_contents, dependent: :destroy
  has_many :content_plans, through: :content_plan_contents, source: :content_plan

  has_many :content_needs

  has_many :content_users
  has_many :users, through: :content_users

  has_many :comments, -> { order(created_at: :desc) }, dependent: :destroy, as: :commentable

  has_many :status_transitions

  belongs_to :status, class_name: 'ContentStatus'

  attr_accessor :maslow_need_ids

  validates :title, presence: true

  before_save :track_status_transitions

  def maslow_need_ids
    content_needs.any? ? content_needs.map(&:need_id).join(",") : nil
  end

  def need_ids
    content_needs.any? ? content_needs.map(&:need_id) : nil
  end

  def whitehall?
    platform == "Whitehall"
  end

  def track_status_transitions
    if persisted? && status_id_changed?
      status_transitions.create from_id:     status_id_was,
                                to_id:       status_id,
                                occurred_at: Time.now
    end
  end

end
