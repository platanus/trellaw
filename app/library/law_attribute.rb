class LawAttribute
  VALID_TYPES = %i{string integer}

  attr_accessor :name, :attr_type, :default, :validators
  attr_reader :value

  def initialize(_name, _attr_type = nil, _default = nil)
    @name = _name.to_sym
    @attr_type = valid_attr_type!(_attr_type)
    @default = _default
    @validators = []
    @value = nil
  end

  def label
    I18n.t("attributes.#{name}.label", default: name)
  end

  def value=(_value)
    @value = cast_value(_value)
  end

  def to_hash
    {
      name: name,
      label: label,
      attr_type: attr_type,
      default: default,
      validations: validators_to_hash
    }
  end

  private

  def cast_value(_value)
    case attr_type
    when :integer
      _value.to_i
    else
      _value.to_s
    end
  end

  def valid_attr_type!(_attr_type)
    return :string if _attr_type.blank?
    fail "invalid attribute type" unless VALID_TYPES.include?(_attr_type)
    _attr_type
  end

  def validators_to_hash
    validators.inject({}) do |memo, validator|
      memo[validator.rule] = validator.options.merge(msg: validator.error_message)
      memo
    end
  end
end
