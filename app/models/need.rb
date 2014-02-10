class Need
  attr_accessor :data

  def self.all
    ContentPlanner.needs_api.needs.with_subsequent_pages.map do |n|
      new(n)
    end.compact
  end

  def find(n)
    new(ContentPlanner.needs_api.need(n))
  end

  def initialize(data)
    @data = data
  end

  def ==(other)
    other.is_a?(self.class) && other.id == id
  end

  def id
    @data.id
  end

  def org_names
    @data.organisations.map(&:abbreviation)
  end

  def to_s
    "[#{id}](#{org_names.join(', ')}) As a #{data.role} I want to #{data.goal} so that #{data.benefit}"
  end

  def persisted?
    true
  end
end
