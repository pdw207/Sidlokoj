class Course < ActiveRecord::Base

  STATUSES = %w(Active Inactive)

  validates :subject, presence: true
  validates :status, presence: true, inclusion: {in: STATUSES}

  belongs_to :teacher, class_name: 'User'
end
