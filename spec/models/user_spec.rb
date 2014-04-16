require 'spec_helper'

describe User do

  context 'validations' do
    let (:blank){[nil, ""]}

    it {should have_valid(:first_name).when("Fred", "Nancy")}
    it {should_not have_valid(:first_name).when(*blank)}

    it {should have_valid(:first_name).when("Smith", "O'Willey Peterson")}
    it {should_not have_valid(:last_name).when(*blank)}

    it {should_not have_valid(:email).when("bad_email@lazy_person", *blank)}
    it {should have_valid(:email).when("fantastic@gmail.com", "incredible@yahoo.com")}
  end

  context 'associations' do

    it {should have_one :principal_school}# As principal
    it {should have_many :schools} #As teacher

    it {should have_many :requests}
    it {should have_many :submitted_requests}
    it{ should have_many(:courses)}
  end

  context 'methods' do
    it 'should have full name' do
      person = FactoryGirl.build(:user, first_name: 'Joe', last_name: 'Blow')
      expect(person.full_name).to eq("Joe Blow")
    end

    it 'should have a student pool ' do
      pool = FactoryGirl.create_list(:student, 3)
      teacher = FactoryGirl.create(:teacher)

      pool.each do |student|
        teacher.schools << student.school
      end

      expect(teacher.student_pool.count).to eq(3)
    end

    it 'should list schools that they are not members of' do
      teacher = FactoryGirl.create(:teacher)
      member_school = FactoryGirl.create(:school)
      new_school = FactoryGirl.create(:school)

      # Teacher is a member of only one school
      teacher.schools << member_school

      expect(teacher.available_school_principals).to eq([new_school.principal])

    end

  end

end
