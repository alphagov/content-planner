class User < ActiveRecord::Base
  include GDS::SSO::User

  serialize :permissions, Array

  validates :name, :email, presence: true,
                           length: { maximum: 255 }

  validates :uid, :organisation_slug, :permissions, allow_blank: true,
                                                    allow_nil: true,
                                                    length: { maximum: 255 }

  has_many :comments, -> { order(created_at: :desc) }
  has_many :content_users
  has_many :contents, through: :content_users
  has_many :content_plan_users
  has_many :content_plans, through: :content_plan_users

  has_many :task_and_users, dependent: :destroy
  has_many :tasks, through: :task_and_users

  has_many :created_tasks, class_name: "Task", foreign_key: :creator_id
  has_many :completed_tasks, class_name: "Task", foreign_key: :completed_by_id

  module Permissions
    SIGNIN = "signin"
    GDS_EDITOR = "GDS Editor"
  end

  def to_s
    name || email
  end

  def gds_editor?
    has_permission?(Permissions::GDS_EDITOR)
  end
end
