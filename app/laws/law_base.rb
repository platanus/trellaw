class LawBase
  include ActiveModel::Serialization

  attr_reader :settings, :violations

  def initialize(_settings)
    @settings = _settings.try(:symbolize_keys)
    @violations = []
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
    self.class.law_attributes.each do |attribute|
      attr_value = settings[attribute.name]
      attribute.validators.each do |validator|
        if !validator.validate(attr_value)
          return "#{attribute.label} #{validator.error_message}"
        end
      end
    end
    nil
  end

  def attributes
    self.class.law_attributes.inject([]) do |memo, attribute|
      memo << attribute.to_hash
      memo
    end
  end

  def required_card_properties
    []
  end

  def check_violations(_cards_list)
    _cards_list.each { |card| check_card_violations(card) }
  end

  def check_card_violations(_card)
    raise NotImplementedError, 'implement check_violations or check_card_violations'
  end

  def add_violation(_card, _name, comment: nil)
    @violations << DetectedViolation.new.tap do |violation|
      violation.law = law_name
      violation.violation = _name
      violation.card_tid = _card.tid
      violation.comment = comment
    end
  end

  def self.law_attributes
    @law_attributes ||= []
  end

  protected

  def translate_law_key(key)
    I18n.t("laws.#{law_name}.#{key}")
  end
end
