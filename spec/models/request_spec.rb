require 'spec_helper'

describe Request do

  context 'validations' do
    let (:blank){[nil, ""]}
    it {should ensure_inclusion_of(:status).in_array(Request::STATUSES)}
  end

  context 'associations' do
    it{ should belong_to(:teacher)}
    it{ should belong_to(:principal)}
  end

  context 'methods' do
    it 'should add school with approved request' do
      teacher = FactoryGirl.create(:teacher)
      initial_school_count = teacher.schools.count

      # Connect the school to the principal
      principal = FactoryGirl.create(:principal)
      school = FactoryGirl.create(:school)
      principal.principal_school = school

      request = Request.new(teacher: teacher, principal: principal, status: "Approved")

      # Add school to teacher
      request.toggle_school
      expect(teacher.schools.last).to eq(school)
      expect(teacher.schools.count).to eq(initial_school_count + 1)
    end

    it 'should remove school with not approved request' do

      # Start with a teacher which is a part of a school
      teacher = FactoryGirl.create(:teacher)
      school = FactoryGirl.create(:school)
      teacher.schools << school

      # Connect the school to the principal
      principal = FactoryGirl.create(:principal)
      principal.principal_school = school

      request = Request.new(teacher: teacher, principal: principal, status: "Pending")
      request.toggle_school

      # Add school to teacher
      expect(teacher.schools).to_not include(school)
      expect(teacher.schools.count).to eq(0)
    end
  end
end
