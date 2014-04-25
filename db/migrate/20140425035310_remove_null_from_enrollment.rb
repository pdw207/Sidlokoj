class RemoveNullFromEnrollment < ActiveRecord::Migration
  def up
      change_column :enrollments, :student_id, :integer, null: true
      change_column :enrollments, :course_id, :integer, null: true
      change_column :enrollments, :seat, :integer, null: true
  end

  def down
      change_column :enrollments, :student_id, :integer, null: false
      change_column :enrollments, :course_id, :integer, null: false
      change_column :enrollments, :seat, :integer, null: false
    end

end
