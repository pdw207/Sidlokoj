class RemoveUnique < ActiveRecord::Migration
  def up
    remove_index :enrollments, [:student_id, :course_id]
  end

  def down
    add_index :enrollments, [:student_id, :course_id], unique: true
  end
end
