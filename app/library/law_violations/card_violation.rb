class LawViolations::CardViolation < LawViolation
  attr_reader :card, :attributes

  def set_violation_settings(_settings)
    @detected_violation_card = @card = valid_card!(_settings[:card])
    @attributes = valid_attributes!(_settings[:attributes])
  end

  private

  def valid_card!(_card)
    fail "card is required" if _card.blank?
    _card
  end

  def valid_attributes!(_attributes)
    fail "law attributes are required" if _attributes.blank?
    _attributes
  end
end
