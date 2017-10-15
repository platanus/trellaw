Trellaw.define_law(:card_limit) do
  attribute(:limit, :integer, 5) do
    validate(
      required: true,
      type: "Integer",
      greater_than: 0
    )
  end

  list_violation(:max_cards) do
    if cards.count > attributes[:limit]
      if attributes[:limit].to_i == 1
        set_comment(:one)
      else
        set_comment(:many, limit: attributes[:limit])
      end
    end
  end

  @law_class.class_eval do
    def check_violations(_list)
      if _list.count > settings[:limit].to_i
        add_violation(
          _list.last,
          'max_cards',
          comment: comment
        )
      end
    end

    private

    def comment
      return I18n.t 'laws.card_limit.violations.max_cards_one' if settings[:limit].to_i == 1
      I18n.t('laws.card_limit.violations.max_cards_many', limit: settings[:limit])
    end
  end
end
