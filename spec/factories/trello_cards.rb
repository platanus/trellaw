FactoryGirl.define do
  factory :trello_card do
    sequence(:tid) { |x| "card_#{x}" }
    sequence(:name) { |x| "Card ##{x}" }
  end
end
