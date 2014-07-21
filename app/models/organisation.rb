class Organisation < ActiveRecord::Base
  include FriendlyId

  friendly_id :slug

  has_ancestry

  has_many :organisation_needs, dependent: :destroy
  has_many :needs, through: :organisation_needs

  validates :api_id, presence: true

  def self.param_key
    "org"
  end

  def exempt?
    @govuk_status == "exempt"
  end

  def abbreviation_or_title
    abbreviation || title
  end

  def title_with_abbreviation
    if abbreviation.present? && abbreviation != title
      # Use square brackets around the abbreviation
      # as Chosen doesn't like matching with
      # parentheses at the start of a word
      "#{title} [#{abbreviation}]"
    else
      title
    end
  end
  alias_method :to_s, :title_with_abbreviation

  def to_param
    slug
  end

  def path
    "/government/organisations/#{slug}"
  end
end
