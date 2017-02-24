FactoryGirl.define do
  factory :board do
    user
    sequence(:board_tid) { |x| "board_#{x}" }
  end
end
