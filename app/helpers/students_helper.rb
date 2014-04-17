module StudentsHelper
  def short_name(student)
    if student.nickname.empty?
      student.first_name
    else
      student.nickname
    end
  end
end
