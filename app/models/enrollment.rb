class Enrollment < ActiveRecord::Base

  validates :student_id, presence: true
  validates :course_id, presence: true
  validates :seat, presence: true, numericality: true
  validates_uniqueness_of :course_id, scope: :student_id

  belongs_to :course
  belongs_to :student


end
