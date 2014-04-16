class CreateTeacherAssignments < ActiveRecord::Migration
  def change
    create_table :teacher_assignments do |t|
      t.integer :teacher_id
      t.integer :school_id
      t.timestamps
    end
  end
end
