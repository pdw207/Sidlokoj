class AddStudentPhotoToStudents < ActiveRecord::Migration
  def change
    add_column :students, :student_photo, :string
  end
end
