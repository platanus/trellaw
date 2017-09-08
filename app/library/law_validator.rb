class LawValidator
  VALID_RULES = %i{required greater_than type}

  attr_accessor :law_attr, :rule, :options

  def initialize(_law_attr, _rule, _options = {})
    @law_attr = valid_attr!(_law_attr)
    @rule = valid_rule!(_rule)
    @options = _options
  end

  def error_message
    locals = validator.try(:error_locals, options) || {}
    msg = I18n.t("validators.#{rule}.error_message", locals)
    "#{law_attr.name} #{msg}"
  end

  def validate(_value)
    validator.validate(_value, options)
  end

  private

  def validator
    @validator ||= "LawValidators::#{rule.to_s.camelize}Validator".constantize
  end

  def valid_attr!(_law_attr)
    fail "invalid LawAttribute instance" unless _law_attr.is_a?(LawAttribute)
    _law_attr
  end

  def valid_rule!(_rule)
    return :string if _rule.blank?
    fail "invalid rule: #{_rule}" unless VALID_RULES.include?(_rule)
    _rule
  end
end
