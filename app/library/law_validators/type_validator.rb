module LawValidators::TypeValidator
  def self.error_locals(_options)
    { data_type: human_type(_options[:value]) }
  end

  def self.validate(_value, _options)
    _value.is_a?(_options[:value].constantize)
  end

  def self.human_type(data_type)
    I18n.t("validators.type.alternatives.#{data_type.underscore}", default: data_type)
  end
end
