# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :student do
    first_name "Kyle"
    sequence (:last_name) {|n| "Munchkin the #{n}"}
    sequence (:nickname) {|n| "Kolog #{n}"}
    dob "12-12-70"
    school
  end
end
