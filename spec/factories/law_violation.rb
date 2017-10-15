FactoryGirl.define do
  factory :law_violation do
    name "foo"
    law_name "member_limit"
    condition_proc { Proc.new { true } }
    comment_proc { Proc.new { "comment" } }

    skip_create
    initialize_with { new(attributes) }

    factory :card_violation, class: LawViolations::CardViolation do
      # just use defaults
    end

    factory :list_violation, class: LawViolations::ListViolation do
      # just use defaults
    end
  end
end
