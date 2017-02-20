FactoryGirl.define do
  factory :violation do
    board
    law "dummy"
    violation "violation"
    card_tid "12345"
    started_at Time.current
  end
end
