class LawAttribute
  VALID_TYPES = %i{string integer}

  attr_accessor :name, :attr_type, :default

  def initialize(_name, _attr_type = nil, _default = nil)
    @name = _name
    @attr_type = valid_attr_type!(_attr_type)
    @default = _default
  end

  def to_param
    {
      name: name,
      attr_type: attr_type,
      default: default
    }
  end

  private

  def valid_attr_type!(_attr_type)
    return :string if _attr_type.blank?
    fail "invalid attribute type" unless VALID_TYPES.include?(_attr_type)
    _attr_type
  end
end
