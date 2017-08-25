class LawAttribute
  VALID_TYPES = %i{string integer}

  attr_accessor :name, :attr_type, :default, :validators

  def initialize(_name, _attr_type = nil, _default = nil)
    @name = _name.to_sym
    @attr_type = valid_attr_type!(_attr_type)
    @default = _default
    @validators = []
  end

  def to_param
    {
      name: name,
      attr_type: attr_type,
      default: default,
      validations: validators_to_params
    }
  end

  private

  def valid_attr_type!(_attr_type)
    return :string if _attr_type.blank?
    fail "invalid attribute type" unless VALID_TYPES.include?(_attr_type)
    _attr_type
  end

  def validators_to_params
    validators.inject({}) do |memo, validator|
      memo[validator.rule] = validator.options
      memo
    end
  end
end
