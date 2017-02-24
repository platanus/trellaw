class LawService < PowerTypes::Service.new(:law_name)
  def available?
    law_class
    true
  rescue NameError
    false
  end

  def name
    @law_name
  end

  def description
    return law_class.description if law_class.respond_to? :description
    @law_name.humanize
  end

  def get_settings_error(_settings)
    _settings = {} if _settings.nil?
    return 'not a hash' unless _settings.is_a? Hash
    return nil unless law_class.respond_to? :get_settings_error
    law_class.get_settings_error _settings.symbolize_keys
  end

  def required_card_properties(_settings)
    return [] unless law_class.respond_to? :required_card_properties
    law_class.required_card_properties(_settings.try(:symbolize_keys))
  end

  def check_violations(_settings, _list)
    violations = law_class.check_violations(_settings.try(:symbolize_keys), _list)
    violations.each { |v| v.law = @law_name }
    violations
  end

  def law_class
    @law_class ||= law_class_name.constantize
  end

  private

  def law_class_name
    "#{@law_name.camelize}Law"
  end
end
