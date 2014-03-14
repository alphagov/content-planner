class Content < ActiveRecord::Base
  include Organisations

  acts_as_taggable

  PLATFORMS = ["Mainstream", "Specialist"]

  STATUSES = {
    "Specialist" => [
      "Not started",
      "Drafting Agency",
      "Specialist 2i",
      "Specialist amends",
      "Ready for publish",
      "Live",
      "Blocked"
    ],
    "Mainstream" => [
      "Not started",
      "Drafting GDS",
      "Mainstream 2i",
      "Mainstream factcheck",
      "Mainstream amends",
      "Ready for publish",
      "Live",
      "Blocked"
    ]
  }
  STATUS = STATUSES.values.flatten.uniq

  has_many :content_plan_contents, dependent: :destroy
  has_many :content_plans, through: :content_plan_contents, source: :content_plan

  has_many :content_needs
  has_many :content_users
  has_many :users, through: :content_users

  has_many :tasks,    -> { order(created_at: :desc) }, dependent: :destroy, as: :taskable
  has_many :comments, -> { order(created_at: :desc) }, dependent: :destroy, as: :commentable

  validates :title, presence: true

  scope :mainstream, -> { where platform: "Mainstream" }
  scope :specialist,  -> { where platform: "Specialist" }
  scope :organisation, ->(organisation_id) {
    where id: Organisationable.for_content.where(organisation_id: organisation_id).pluck(:organisationable_id) if organisation_id.present?
  }

  # Caching
  before_save do
    content_plans.each { |record| record.touch }
  end

  def maslow_need_ids
    content_needs.map(&:need_id)
  end

  def maslow_need_ids=(ids)
    content_needs.destroy_all
    ids.reject(&:blank?).each do |nid|
      ContentNeed.find_or_create_by!(content: self, need_id: nid)
    end
  end

  def need_ids
    content_needs.any? ? content_needs.map(&:need_id) : nil
  end

  def specialist?
    platform == "Specialist"
  end

  def to_s
    "#{ref_no} #{title}"
  end

  def self.percentages_for(options)
    platform = options.fetch(:platform) { raise ArgumentError.new("#percentages_for expects platform: as part of options hash") }
    contents = options.fetch(:contents) { raise ArgumentError.new("#percentages_for expects contents scope: as part of options hash") }

    scope = contents.where(platform: platform)
    total = scope.sum(:size)
    STATUSES[platform].inject({}) do |hash, status|
      hash.tap do |new_hash|
        if total > 0
          sum = scope.where(status: status).sum(:size)
          new_hash[status] = [scope.where(status: status).count, ((sum / total.to_f) * 100.0).round(3)]
        else
          new_hash[status] = [0, 0]
        end
      end
    end
  end
end
