require 'spec_helper'
require 'carrierwave/test/matchers'

describe StudentPhotoUploader do

  include CarrierWave::Test::Matchers

  let(:uploader) { StudentPhotoUploader.new(FactoryGirl.build(:student), :car_photo) }
  let(:path){ Rails.root.join('spec/file_fixtures/valid_girl.png') }

  before {StudentPhotoUploader.enable_processing = true}
  after {StudentPhotoUploader.enable_processing = false}


  it 'can store a file without raising an error ' do
    expect(lambda { uploader.store!(File.open(path)) }).to_not raise_error
  end

end
