class MemberLimitLaw < LawBase
  attribute(:limit, :integer, 3) do
    validate(
      required: true,
      type: Integer,
      greater_than: 0
    )
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
