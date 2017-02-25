FactoryGirl.define do
  factory :trello_comment do
    sequence(:tid) { |x| "comment_#{x}" }
    text 'Im the law!'
  end
end
