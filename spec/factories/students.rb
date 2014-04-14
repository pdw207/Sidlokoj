# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :student do
    first_name "Kyle"
    last_name "Munchkin"
    nickname "Kolog"
    dob "12-12-70"
  end
end
