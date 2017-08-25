module LawValidators::GreaterThanValidator
  def self.error_message(_options)
    "must be greater than #{_options[:value]}"
  end

  def self.validate(_value, _options)
    max_value = _options[:value]
    _value > max_value
  end
end
