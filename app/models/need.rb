class Need < ActiveRecord::Base
  has_many :organisation_needs, dependent: :destroy
  has_many :organisations, through: :organisation_needs

  has_many :content_plan_needs, dependent: :destroy
  has_many :content_plans, through: :content_plan_needs

  has_many :content_needs, dependent: :destroy
  has_many :contents, through: :content_needs

  validates :api_id, presence: true, uniqueness: true

  def org_names
    organisations.map(&:abbreviation)
  end

  def to_s
    "[#{api_id}](#{org_names.join(', ')}) #{story}"
  end

  def story
    "As a #{role} I want to #{goal} so that #{benefit}"
  end
end
