class Organisation < ActiveRecord::Base
  include FriendlyId

  friendly_id :slug

  has_ancestry

  has_many :organisation_needs, dependent: :destroy
  has_many :needs, through: :organisation_needs

  validates :api_id, presence: true

  # cattr_writer :organisations

  # attr_reader :id, :title, :format, :slug, :abbreviation, :govuk_status, :parent_organisations, :logo_formatted_name, :organisation_brand_colour_class_name, :organisation_logo_type_class_name

  # def self.cache
  #   @cache ||= LRUCache.new(soft_ttl: 1.day, ttl: 2.days)
  # end

  # def self.reset_cache
  #   @cache = nil
  # end

  # def self.cache_fetch(key)
  #   inner_exception = nil
  #   cache.fetch(key) do
  #     begin
  #       yield
  #     rescue GdsApi::BaseError => e
  #       inner_exception = e
  #       raise RuntimeError.new("use_stale_value")
  #     end
  #   end
  # rescue RuntimeError => e
  #   if e.message == "use_stale_value"
  #     raise inner_exception
  #   else
  #     raise
  #   end
  # end

  # def initialize(org)
  #   @id = org.details.slug #to preserve compatibility with old API
  #   @title = org.title
  #   @format = org.format
  #   @updated_at = Time.parse(org.updated_at) if org.updated_at
  #   @web_url = org.web_url
  #   @slug = org.details.slug
  #   @abbreviation = org.details.abbreviation
  #   @closed_at = Time.parse(org.details.closed_at) if org.details.closed_at
  #   @govuk_status = org.details.govuk_status
  #   @parent_organisations = org.parent_organisations
  #   @child_organisations = org.child_organisations
  #   @logo_formatted_name = org.details.logo_formatted_name
  #   @organisation_brand_colour_class_name = org.details.organisation_brand_colour_class_name
  #   @organisation_logo_type_class_name = org.details.organisation_logo_type_class_name
  # end

  # def self.model_name
  #   "Organisation"
  # end

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

  # def self.all
  #   cache_fetch("all") do
  #     load_organisations
  #   end
  # end

  # def self.find(slug)
  #   all.find { |organisation| organisation.slug == slug }
  # end

  private

  # def self.load_organisations
  #  (organisations_api.organisations.with_subsequent_pages || []).map { |org|
  #     new org
  #   }.reject { |dep| dep.exempt? }
  # end

  # def self.organisations_api
  #   ContentPlanner.organisations_api
  # end
end
