class LawBase
  include ActiveModel::Serialization

  def initialize(_settings)
    @settings = _settings.try(:symbolize_keys)
  end

  def id
    law_name
  end

  def law_name
    self.class.to_s.chomp("Law").underscore.to_sym
  end

  def description
    translate_law_key(:description)
  end

  def definition
    translate_law_key(:definition)
  end

  def get_settings_error
    law_attributes.each do |attribute|
      attr_value = settings[attribute.name]
      attribute.validators.each do |validator|
        if !validator.validate(attr_value)
          return "#{attribute.label} #{validator.error_message}"
        end
      end
    end
    nil
  end

  def config
    @config ||= begin
      law_attributes.dup.map do |attribute|
        attribute.value = settings[attribute.name]
        attribute
      end
    end
  end

  def self.required_card_properties
    @required_card_properties ||= []
  end

  def required_card_properties
    self.class.required_card_properties
  end

  def self.law_attributes
    @law_attributes ||= []
  end

  def law_attributes
    self.class.law_attributes
  end

  def self.law_violations
    @law_violations ||= []
  end

  def law_violations
    self.class.law_violations
  end

  private

  def settings
    @settings
  end

  def translate_law_key(key)
    I18n.t("laws.#{law_name}.#{key}")
  end
end
