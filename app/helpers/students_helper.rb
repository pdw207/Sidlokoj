module StudentsHelper
  def short_name(student)

    if student.nickname.nil? || student.nickname.empty?
      student.first_name
    else
      student.nickname + " (" + student.first_name + ")"
    end
  end


end
