class LawValidator
  VALID_RULES = %i{required greater_than type}

  attr_accessor :rule, :options

  def initialize(_rule, _options = {})
    @rule = valid_rule!(_rule)
    @options = _options
  end

  def error_message
    locals = validator.try(:error_locals, options) || {}
    I18n.t("validators.#{rule}.error_message", locals)
  end

  def validate(_value)
    validator.validate(_value, options)
  end

  private

  def validator
    @validator ||= "LawValidators::#{rule.to_s.camelize}Validator".constantize
  end

  def valid_rule!(_rule)
    return :string if _rule.blank?
    fail "invalid rule: #{_rule}" unless VALID_RULES.include?(_rule)
    _rule
  end
end
