class MaxDaysOnListLaw < LawBase
  attribute(:days, :integer, 7) do
    validate(
      required: true,
      type: "Integer",
      greater_than: 0
    )
  end

  required_card_props(:movement)

  card_violation(:max_days) do
    if card.added_at < attributes[:days].days.ago
      if attributes[:days] == 1
        set_comment(:one)
      else
        set_comment(:many, days: attributes[:days])
      end
    end
  end
end
