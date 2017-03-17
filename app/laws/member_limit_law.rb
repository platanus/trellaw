class MemberLimitLaw < LawBase
  def self.description
    'Max Members'
  end

  def self.get_settings_error(_settings)
    return 'limit is required' unless _settings.key? :limit
    return 'limit must be an integer' unless _settings[:limit].is_a? Integer
    return 'limit must be greater than 0' if _settings[:limit] <= 0
    nil
  end

  def check_card_violations(_card)
    if _card.member_tids.count > settings[:limit]
      add_violation(
        _card,
        'max_members',
        comment: comment
      )
    end
  end

  private

  def comment
    return I18n.t 'laws.member_limit.violations.max_members_one' if settings[:limit] == 1
    I18n.t('laws.member_limit.violations.max_members_many', limit: settings[:limit])
  end
end
