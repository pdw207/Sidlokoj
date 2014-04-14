class School < ActiveRecord::Base

  validates :name, presence: true
  validates :location, presence: true

  belongs_to :principal, class_name: 'User'
  has_many :students
  has_many :teachers, foreign_key: "teacher_id", class_name: 'User'
end
