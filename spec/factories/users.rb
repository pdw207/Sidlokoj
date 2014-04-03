# Read about factories at https://github.com/thoughtbot/factory_girl
FactoryGirl.define do
  factory :user do
    first_name 'Oningo'
    last_name 'Boingo'
    sequence(:email) { |n| "oingoboingo#{n}@gmail.com" }
    password '12345678'
  end
end
