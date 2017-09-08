class LawBase
  include LawDsl

  def self.check_violations(_settings, _list)
    law = new(_settings)
    law.check_violations(_list)
    law.violations
  end

  def self.get_settings_error(_settings)
    law_attributes.each do |attribute|
      attr_value = _settings[attribute.name]
      attribute.validators.each do |validator|
        if !validator.validate(attr_value)
          return "#{attribute.label} #{validator.error_message}"
        end
      end
    end
    nil
  end

  attr_reader :settings, :violations

  def initialize(_settings)
    @settings = _settings
    @violations = []
  end

  def check_violations(_list)
    _list.each { |c| check_card_violations(c) }
  end

  def check_card_violations(_card)
    raise NotImplementedError, 'implement check_violations or check_card_violations'
  end

  def add_violation(_card, _name, comment: nil)
    @violations << DetectedViolation.new.tap do |violation|
      violation.violation = _name
      violation.card_tid = _card.tid
      violation.comment = comment
    end
  end
end
