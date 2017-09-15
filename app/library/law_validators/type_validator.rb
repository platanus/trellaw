module LawValidators::TypeValidator
  def self.error_locals(_options)
    { data_type: human_type(_options[:value]) }
  end

  def self.validate(_value, _options)
    case _options[:value]
    when "Integer"
      validate_integer(_value)
    else
      true
    end
  end

  def self.human_type(_data_type)
    I18n.t("validators.type.alternatives.#{_data_type.underscore}", default: _data_type)
  end

  def self.validate_integer(_value)
    return true if _value.blank?
    !!(_value.to_s =~ /\A[0-9]+\z/)
  end
end
