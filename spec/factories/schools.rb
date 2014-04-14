# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :school do
    sequence(:name, 100) { |n| "Washington High PS #{n}" }
    location "Brooklyn, NY"
    phone_number "212-789-1023"
    principal
  end
end
