Trellaw.define_law(:max_days_on_list) do
  attribute(:days, :integer, 7) do
    validate(
      required: true,
      type: "Integer",
      greater_than: 0
    )
  end

  @law_class.class_eval do
    def required_card_properties
      [:movement]
    end

    private

    def check_card_violations(_card)
      if _card.added_at < settings[:days].to_i.days.ago
        add_violation(
          _card,
          'max_days',
          comment: comment
        )
      end
    end

    def comment
      return I18n.t 'laws.max_days_on_list.violations.max_days_one' if settings[:days].to_i == 1
      I18n.t('laws.max_days_on_list.violations.max_days_many', days: settings[:days])
    end
  end
end
