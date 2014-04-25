require 'spec_helper'

describe Course do
  context 'validations' do
    let (:blank){[nil, ""]}

    it {should have_valid(:subject).when("Chemistry", "Bio", "AP-Lit", "Intro to Python")}
    it {should_not have_valid(:subject).when(*blank)}

    it {should have_valid(:rows).when(1,6,10)}
    it {should_not have_valid(:rows).when(*blank, "six")}

    it {should have_valid(:columns).when(1,6,10)}
    it {should_not have_valid(:columns).when(*blank, "four")}

    it {should ensure_inclusion_of(:status).in_array(Course::STATUSES)}
    it {should_not have_valid(:status).when(*blank, "Banana")}

  end

  context 'associations' do
    it{ should belong_to(:teacher)}
    it{ should have_many(:enrollments)}
    it{ should have_many(:students).through(:enrollments)}
  end

  context 'methods' do

    it 'displays active courses' do
      inactive_course = FactoryGirl.build(:course, status: "Inactive")
      active_course = FactoryGirl.build(:course, status: "Active")

      # Create a user and pass in some courses
      teacher = FactoryGirl.create(:teacher)
      teacher.courses << active_course
      teacher.courses << inactive_course

      expect(Course.active_courses_for(teacher)).to eq([active_course])

    end

    it 'provides total seats' do
      small_class = FactoryGirl.build(:course, rows: 3, columns: 5)
      expect(small_class.class_size).to eq(15)
    end
  end

end
