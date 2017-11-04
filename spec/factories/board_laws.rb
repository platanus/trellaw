FactoryGirl.define do
  factory :board_law do
    board
    law 'dummy'
    list_tid "TrelloListId"

    trait :with_settings do
      settings do
        {
          limit: 1,
          days: 5
        }
      end
    end
  end
end
