require "lrucache"

class Organisation
  cattr_writer :organisations

  attr_reader :id, :name, :abbreviation, :parent_ids, :govuk_status

  def self.cache
    @cache ||= LRUCache.new(soft_ttl: 1.day, ttl: 2.days)
  end

  def self.reset_cache
    @cache = nil
  end

  def self.cache_fetch(key)
    inner_exception = nil
    cache.fetch(key) do
      begin
        yield
      rescue GdsApi::BaseError => e
        inner_exception = e
        raise RuntimeError.new("use_stale_value")
      end
    end
  rescue RuntimeError => e
    if e.message == "use_stale_value"
      raise inner_exception
    else
      raise
    end
  end

  def initialize(attrs)
    @id = attrs[:id]
    @name = attrs[:name]
    @abbreviation = attrs[:abbreviation]
    @parent_ids = attrs[:parent_ids]
    @govuk_status = attrs[:govuk_status]
  end

  def exempt?
    @govuk_status == "exempt"
  end

  def abbreviation_or_name
    abbreviation || name
  end

  def name_with_abbreviation
    if abbreviation.present? && abbreviation != name
      # Use square brackets around the abbreviation
      # as Chosen doesn't like matching with
      # parentheses at the start of a word
      "#{name} [#{abbreviation}]"
    else
      name
    end
  end
  alias_method :to_s, :name_with_abbreviation

  def self.all
    cache_fetch("all") do
      load_organisations
    end
  end

  def self.find(id)
    all.find { |organisation| organisation.id == id }
  end

  private

  def self.load_organisations
    all_orgs = orgs_from_api.map { |attrs| new(attrs.symbolize_keys) }
    all_orgs.reject { |org| org.exempt? }
  end

  def self.orgs_from_api
    begin
      need_api.organisations
    rescue GdsApi::HTTPErrorResponse #Needs API is down
      []
    end
  end

  def self.need_api
    ContentPlanner.needs_api
  end
end
