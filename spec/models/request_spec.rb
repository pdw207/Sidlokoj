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
end
