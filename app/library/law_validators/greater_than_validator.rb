module LawValidators::GreaterThanValidator
  def self.error_locals(_options)
    { limit: _options[:value] }
  end

  def self.validate(_value, _options)
    return true if _value.blank?
    max_value = _options[:value]
    _value.to_i > max_value.to_i
  end
end
