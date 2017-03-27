class CardLimitLaw < LawBase
  def self.description
    'Maximum number of cards a list can have'
  end

  def self.get_settings_error(_settings)
    return 'limit is required' unless _settings.key? :limit
    return 'limit must be an integer' unless _settings[:limit].is_a? Integer
    return 'limit must be greater than 0' if _settings[:limit] <= 0
    nil
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
