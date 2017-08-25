class MaxDaysOnListLaw < LawBase
  attribute(:days, :integer, 7) do
    validate(
      required: true,
      type: Integer,
      greater_than: 0
    )
  end

  def self.description
    'Maximum number of days a card can be on this list'
  end

  def self.required_card_properties(_settings)
    [:movement]
  end

  private

  def check_card_violations(_card)
    if _card.added_at < settings[:days].days.ago
      add_violation(
        _card,
        'max_days',
        comment: comment
      )
    end
  end

  def comment
    return I18n.t 'laws.max_days_on_list.violations.max_days_one' if settings[:days] == 1
    I18n.t('laws.max_days_on_list.violations.max_days_many', days: settings[:days])
  end
end
