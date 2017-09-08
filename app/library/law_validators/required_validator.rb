module LawValidators::RequiredValidator
  def self.validate(_value, _options)
    !_value.blank?
  end
end
