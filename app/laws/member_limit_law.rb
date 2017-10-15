Trellaw.define_law(:member_limit) do
  attribute(:limit, :integer, 3) do
    validate(
      required: true,
      type: "Integer",
      greater_than: 0
    )
  end

  card_violation(:max_members) do
    if card.member_tids.count > attributes[:limit]
      if attributes[:limit] == 1
        set_comment(:one)
      else
        set_comment(:many, limit: attributes[:limit])
      end
    end
  end

  @law_class.class_eval do
    def check_card_violations(_card)
      if _card.member_tids.count > settings[:limit].to_i
        add_violation(
          _card,
          'max_members',
          comment: comment
        )
      end
    end

    private

    def comment
      return I18n.t 'laws.member_limit.violations.max_members_one' if settings[:limit].to_i == 1
      I18n.t('laws.member_limit.violations.max_members_many', limit: settings[:limit])
    end
  end
end
