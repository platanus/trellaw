FactoryGirl.define do
  factory :detected_violation do
    law "dummy"
    violation "violation"
    sequence(:card_tid) { |x| "card_#{x}" }
  end
end
