class LawBase
  def self.check_violations(_settings, _list)
    law = new(_settings)
    law.check_violations(_list)
    law.violations
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
