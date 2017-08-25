class LawValidator
  VALID_RULES = %i{required}

  attr_accessor :law_attr, :rule, :options

  def initialize(_law_attr, _rule, _options = {})
    @law_attr = valid_attr!(_law_attr)
    @rule = valid_rule!(_rule)
    @options = _options
  end

  def error_message
    "#{law_attr.name} #{validator.error_message(options)}"
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
