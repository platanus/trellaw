module LawValidators::GreaterThanValidator
  def self.error_locals(_options)
    { limit: _options[:value] }
  end

  def self.validate(_value, _options)
    max_value = _options[:value]
    _value > max_value
  end
end
