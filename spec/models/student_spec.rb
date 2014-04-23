require 'spec_helper'

describe Student do
  context 'validations' do
    let (:blank){[nil, ""]}

    it {should have_valid(:first_name).when("Elio", "Lyda")}
    it {should_not have_valid(:first_name).when(*blank)}

    it {should have_valid(:last_name).when("Gonzales", "Piere")}
    it {should_not have_valid(:last_name).when(*blank)}

  end

  context 'associations' do
    it{ should belong_to(:school)}
    it{ should have_many(:enrollments)}
  end

  context 'methods' do
    it '#full_name' do
      student = FactoryGirl.build(:student, first_name: "Barry", last_name:"JaJa")
      expect(student.full_name).to eq("Barry JaJa")
    end
  end

end
