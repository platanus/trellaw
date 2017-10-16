Trellaw.define_law(:max_days_on_list) do
  attribute(:days, :integer, 7) do
    validate(
      required: true,
      type: "Integer",
      greater_than: 0
    )
  end

  card_violation(:max_days) do
    if card.added_at < attributes[:days].days.ago
      if attributes[:days] == 1
        set_comment(:one)
      else
        set_comment(:many, days: attributes[:days])
      end
    end
  end

  @law_class.class_eval do
    def required_card_properties
      [:movement]
    end
  end
end
