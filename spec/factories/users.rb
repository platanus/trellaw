FactoryGirl.define do
  factory :user do
    sequence(:email) { |x| "email_#{x}@trellaw.com" }
    password '12345678'
  end
end
