class MemberLimitLaw < LawBase
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
end
