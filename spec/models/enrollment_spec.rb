require 'spec_helper'

describe Enrollment do
  context 'validations' do

    it {should have_valid(:seat).when(1,3,"4", 5)}
    it {should_not have_valid(:seat).when(nil, "", "one", "for")}

    before(:each) do
      FactoryGirl.create(:enrollment)
    end
  end

  context 'associations' do
    it{ should belong_to(:course)}
    it{ should belong_to(:student)}
  end


end
