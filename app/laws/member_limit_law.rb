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
        comment: 'Epa! Don\'t add more than 1 cuate for cards in this list my friend, yes?'
      )
    end
  end
end
