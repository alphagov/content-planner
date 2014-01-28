class Organisation
  cattr_writer :organisations

  attr_reader :id, :name, :abbreviation

  def initialize(attrs)
    @id = attrs[:id]
    @name = attrs[:name]
    @abbreviation = attrs[:abbreviation]
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

  def self.all
    @@organisations ||= self.load_organisations
  end

  def self.find(id)
    all.find { |organisation| organisation.id == id }
  end

  private
  def self.load_organisations
    (need_api.organisations || []).map {|attrs|
      self.new(attrs.symbolize_keys)
    }
  end

  def self.need_api
    ContentPlanner.needs_api
  end
end
