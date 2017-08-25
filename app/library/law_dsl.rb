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

    def law_attributes
      @law_attributes ||= []
    end
  end
end
