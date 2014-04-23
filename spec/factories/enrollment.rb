
FactoryGirl.define do
  factory :enrollment do
    sequence(:seat){|n| n }
    course
    student
  end
end
