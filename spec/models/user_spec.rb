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
  end

end
