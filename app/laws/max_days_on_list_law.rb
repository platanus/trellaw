class MaxDaysOnListLaw < LawBase
  def self.description
    'Maximum number of days a card can be on this list'
  end

  def self.get_settings_error(_settings)
    return 'day is required' unless _settings.key? :days
    return 'day must be an integer' unless _settings[:days].is_a? Integer
    return 'day must be greater than 0' if _settings[:days] <= 0
    nil
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
