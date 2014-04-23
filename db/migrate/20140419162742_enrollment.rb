class Enrollment < ActiveRecord::Migration
  def change
    create_table :enrollments do |t|
      t.integer :student_id, null: false
      t.integer :course_id, null: false
      t.integer :seat, null: false

      t.timestamps
    end

    add_index :enrollments, :student_id
    add_index :enrollments, :course_id
    add_index :enrollments, [:student_id, :course_id], unique: true
  end


end
