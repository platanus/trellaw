module LawDsl
  extend ActiveSupport::Concern

  class_methods do
    def attribute(_name, _attr_type = nil, _default = nil)
      raise "nest attribute method is not allowed" if @current_attr
      @current_attr = LawAttribute.new(_name, _attr_type, _default)
      law_attributes << @current_attr
      yield if block_given?
    ensure
      @current_attr = nil
    end

    def validate(_rules)
      raise "rules needs to be a Hash" unless _rules.is_a?(Hash)
      raise "validate needs to run inside attribute block" unless @current_attr
      _rules.each do |rule, options|
        opts = options.is_a?(Hash) ? options : { value: options }
        @current_attr.validators << LawValidator.new(@current_attr, rule, opts)
      end
    end

    def law_attributes
      @law_attributes ||= []
    end
  end
end
