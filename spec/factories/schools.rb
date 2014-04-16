# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :school do
    sequence(:name, 100) { |n| "Washington High PS #{n}" }
    location "Brooklyn, NY"
    phone_number "212-789-1023"
    principal

    factory :school_with_students do

      ignore do
        student_count 5
      end

      after(:create) do |school, evaluator|
        create_list(:student, evaluator.student_count, school: school)
      end

    end

  end
end
