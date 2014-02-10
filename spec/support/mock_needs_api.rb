class MockNeedsApi
  attr_reader :need

  def initialize(*need)
    @need = Need.new(need)
  end

  def needs
    self
  end

  def with_subsequent_pages
    []
  end
  
  def organisations
    []
  end
end
