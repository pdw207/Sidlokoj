# Read about factories at https://github.com/thoughtbot/factory_girl
FactoryGirl.define do
  factory :user do
    first_name 'Oningo'
    sequence(:last_name) {|n| "Boingo the #{n}"}
    sequence(:email) { |n| "oingoboingo#{n}@gmail.com" }
    password '12345678'

    trait :isteacher do
      admin false
    end
    trait :isprincipal do
      admin true
    end

    factory :principal, traits: [:isprincipal]
    factory :teacher, traits: [:isteacher]
  end
end
