class Course < ActiveRecord::Base

  STATUSES = %w(Active Inactive)

  validates :subject, presence: true
  validates :status, presence: true, inclusion: {in: STATUSES}
  validates :rows, presence: true, numericality: true
  validates :columns, presence: true, numericality: true


  belongs_to :teacher, class_name: 'User'
  has_many :enrollments
  has_many :students, through: :enrollments
  accepts_nested_attributes_for :enrollments

  def self.active_courses_for(user)
    where(status: "Active", teacher: user)
  end

  def class_size
    rows * columns
  end
end
