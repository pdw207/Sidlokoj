class Enrollment < ActiveRecord::Base

  validates :seat, presence: true, numericality: true

  belongs_to :course
  belongs_to :student


end
