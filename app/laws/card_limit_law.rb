class CardLimitLaw < LawBase
  attribute(:limit, :integer, 5) do
    validate(
      required: true,
      type: Integer,
      greater_than: 0
    )
  end

  def self.description
    'Maximum number of cards a list can have'
  end

  def check_violations(_list)
    if _list.count > settings[:limit]
      add_violation(
        _list.last,
        'max_cards',
        comment: comment
      )
    end
  end

  private

  def comment
    return I18n.t 'laws.card_limit.violations.max_cards_one' if settings[:limit] == 1
    I18n.t('laws.card_limit.violations.max_cards_many', limit: settings[:limit])
  end
end
