class Student < ActiveRecord::Base
  validates :last_name, presence: true
  validates :first_name, presence: true


  belongs_to :school
  has_many :enrollments

  mount_uploader :student_photo, StudentPhotoUploader

  def full_name
    self.first_name + " " + self.last_name
  end
end
