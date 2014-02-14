class Organisation
  cattr_writer :organisations

  attr_reader :id, :name, :abbreviation, :parent_ids, :govuk_status

  def initialize(attrs)
    @id = attrs[:id]
    @name = attrs[:name]
    @abbreviation = attrs[:abbreviation]
    @parent_ids = attrs[:parent_ids]
    @govuk_status = attrs[:govuk_status]
  end

  def exempt?
    @govuk_status == 'exempt'
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
    @@organisations ||= load_organisations
  end

  def self.find(id)
    all.find { |organisation| organisation.id == id }
  end

  private

  def self.load_organisations
    all_orgs = (need_api.organisations || []).map { |attrs| new(attrs.symbolize_keys) }
    all_orgs.reject { |org| org.exempt? }
  end

  def self.need_api
    ContentPlanner.needs_api
  end
end
