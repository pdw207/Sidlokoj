class TeacherAssignment < ActiveRecord::Base

  belongs_to :school
  belongs_to :teacher, class_name: 'User'

end
