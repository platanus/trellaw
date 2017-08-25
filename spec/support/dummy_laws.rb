class DummyLaw
  def self.description
  end

  def self.get_settings_error(_settings)
  end

  def self.required_card_properties(_settings)
    []
  end

  def self.check_violations(_settings, _list)
    []
  end

  def self.law_attributes
    []
  end
end

class EmptyDummyLaw
  # very empty
end
