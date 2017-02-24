FactoryGirl.define do
  factory :trello_list do
    sequence(:tid) { |x| "list_#{x}" }
    sequence(:name) { |x| "List ##{x}" }
  end
end
