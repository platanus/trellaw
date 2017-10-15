class LawDsl
  attr_reader :law_name

  def initialize(_law_name, &block)
    @law_name = _law_name
    @law_class = create_law_class
    instance_eval(&block)
    nil
  end

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

  private

  def create_law_class
    class_name = LawUtils.law_class_name(law_name)
    Object.const_set(class_name, Class.new(LawBase))
  end

  def add_violation(klass, _name, &_block)
    raise "violation can't run inside attribute block" if @current_attr
    law_violations << klass.new(name: _name, law_name: law_name, condition_proc: _block)
  end

  def law_attributes
    @law_class.law_attributes
  end

  def law_violations
    @law_class.law_violations
  end
end
