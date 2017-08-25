module LawValidators::TypeValidator
  def self.error_message(_options)
    "must be #{_options[:value]}"
  end

  def self.validate(_value, _options)
    _value.is_a?(_options[:value])
  end
end
