class DummyLaw < LawBase
  def check_violations(_list)
    []
  end

  def self.law_attributes
    []
  end
end

class EmptyDummyLaw
  # very empty
end
