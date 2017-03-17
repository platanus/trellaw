FactoryGirl.define do
  factory :violation do
    board
    law "dummy"
    violation "violation"
    card_tid "12345"
    started_at Time.current - 2.days

    factory :finished_violation do
      finished_at Time.current - 1.days
    end
  end
end
