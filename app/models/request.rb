class Request < ActiveRecord::Base

  STATUSES = %w(Approved Pending Denied)
  validates :status, presence: true, inclusion: {in: STATUSES}

  belongs_to :teacher, class_name: 'User'
  belongs_to :principal, class_name: 'User'
end
