class School < ActiveRecord::Base

  validates :name, presence: true
  validates :location, presence: true

  belongs_to :principal, class_name: 'User'
  has_many :students
  has_many :teacher_assignments
  has_many :teachers, through: :teacher_assignments

end
