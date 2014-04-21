require 'spec_helper'

describe Enrollment do
  context 'validations' do
    let (:blank){[nil, ""]}

    it {should have_valid(:student_id).when(1,3,4,5)}
    it {should_not have_valid(:student_id).when(*blank)}

    it {should have_valid(:course_id).when(1,3,4,5)}
    it {should_not have_valid(:course_id).when(*blank)}

    it {should have_valid(:seat).when(1,3,"4", 5)}
    it {should_not have_valid(:seat).when(nil, "", "one", "for")}

    before(:each) do
      FactoryGirl.create(:enrollment)
    end
    it { should validate_uniqueness_of(:course_id).scoped_to(:student_id) }
  end

  context 'associations' do
    it{ should belong_to(:course)}
    it{ should belong_to(:student)}
  end


end
