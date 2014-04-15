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
    it {should have_many :schools}
    it {belong_to :school}
    it {should have_many :requests}
    it {should have_many :submitted_requests}
    it{ should have_many(:courses)}
  end

  context 'methods' do
    it 'should have full name' do
      person = FactoryGirl.build(:user, first_name: 'Joe', last_name: 'Blow')
      expect(person.full_name).to eq("Joe Blow")
    end
  end

end
