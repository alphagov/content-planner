class User < ActiveRecord::Base
  include GDS::SSO::User

  serialize :permissions, Array

  validates :name, presence: true
  validates :email, presence: true

  has_many :comments

  module Permissions
    SIGNIN = 'signin'
    GDS_EDITOR = 'GDS Editor'
  end

  def to_s
    name || email
  end

  # GDS::SSO::User overwrites for Rails 4
  def self.find_for_gds_oauth(auth_hash)
    user_params = GDS::SSO::User.user_params_from_auth_hash(auth_hash.to_hash)

    # update details of existing user
    user = where(uid: auth_hash["uid"]).first
    if user
      user.update_attributes(user_params)
      user
    else # Create a new user.
      create!(user_params)
    end
  end

  def gds_editor?
    has_permission?(Permissions::GDS_EDITOR)
  end
end
