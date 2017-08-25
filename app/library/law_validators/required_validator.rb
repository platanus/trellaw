module LawValidators::RequiredValidator
  def self.error_message(_options)
    "is required"
  end

  def self.validate(_value, _options)
    !_value.blank?
  end
end
