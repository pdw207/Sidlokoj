class Request < ActiveRecord::Base

  STATUSES = %w(Approved Pending Denied)
  validates :status, presence: true, inclusion: {in: STATUSES}

  belongs_to :teacher, class_name: 'User'
  belongs_to :principal, class_name: 'User'

  def toggle_school
    if status == "Approved"
      teacher.schools << principal.principal_school
    else
      teacher.schools.delete(principal.principal_school)
    end
  end
end
