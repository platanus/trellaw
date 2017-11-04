module LawDsl
  def attribute(_name, _attr_type = nil, _default = nil)
    raise "nest attribute method is not allowed" if @current_attr
    @current_attr = LawAttribute.new(_name, _attr_type, _default)
    law_attributes << @current_attr
    yield if block_given?
  ensure
    @current_attr = nil
  end

  def card_violation(_name, &_block)
    add_violation(LawViolations::CardViolation, _name, &_block)
  end

  def list_violation(_name, &_block)
    add_violation(LawViolations::ListViolation, _name, &_block)
  end

  def validate(_rules)
    raise "rules need to be a Hash" unless _rules.is_a?(Hash)
    raise "validate needs to run inside attribute block" unless @current_attr
    _rules.each do |rule, options|
      opts = options.is_a?(Hash) ? options : { value: options }
      @current_attr.validators << LawValidator.new(rule, opts)
    end
  end

  def required_card_props(*attributes)
    raise "required_card_props can't run inside attribute block" if @current_attr
    attributes.each do |attribute|
      attribute = attribute.to_sym
      if !required_card_properties.include?(attribute)
        required_card_properties << attribute.to_sym
      end
    end
  end

  def add_violation(klass, _name, &_block)
    raise "violation can't run inside attribute block" if @current_attr
    law_violations << klass.new(name: _name, law_name: law_name, condition_proc: _block)
  end
end
