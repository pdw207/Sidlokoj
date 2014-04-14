require 'spec_helper'

describe School do
  context 'validations' do
    let (:blank){[nil, ""]}

    it {should have_valid(:name).when("Greendale Community", "Shapiro Insititute")}
    it {should_not have_valid(:name).when(*blank)}

    it {should have_valid(:location).when("Orange County", "Brooklyn, NY")}
    it {should_not have_valid(:location).when(*blank)}

  end

  context 'associations' do
    it{ should belong_to(:principal)}
    it{ should have_many(:students)}
    it{ should have_many(:teachers)}
  end

end
