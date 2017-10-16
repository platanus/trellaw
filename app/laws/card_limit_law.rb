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
end
