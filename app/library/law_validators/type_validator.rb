module LawValidators::TypeValidator
  def self.error_locals(_options)
    { data_type: _options[:value] }
  end

  def self.validate(_value, _options)
    _value.is_a?(_options[:value].constantize)
  end
end
