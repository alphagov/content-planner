class User < ActiveRecord::Base
  include GDS::SSO::User

  serialize :permissions, Array

  validates :name, presence: true
  validates :email, presence: true

  has_many :comments, -> { order(created_at: :desc) }
  has_many :content_users
  has_many :contents, through: :content_users
  has_many :content_plan_users
  has_many :content_plans, through: :content_plan_users


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
