class LawViolations::ListViolation < LawViolation
  attr_reader :cards, :attributes

  def set_violation_settings(_settings)
    @cards = valid_cards!(_settings[:cards])
    @detected_violation_card = cards.last
    @attributes = valid_attributes!(_settings[:attributes])
  end

  private

  def valid_cards!(_cards)
    fail "cards attribute is required" if _cards.blank?
    _cards
  end

  def valid_attributes!(_attributes)
    fail "law attributes are required" if _attributes.blank?
    _attributes
  end
end
