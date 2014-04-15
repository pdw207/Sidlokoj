# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :course do
    subject "Chemisty"
    school_year "Spring 2014"
    period 6
    start_date "2014-02-01"
    end_date "2014-05-20"
    teacher
  end
end
