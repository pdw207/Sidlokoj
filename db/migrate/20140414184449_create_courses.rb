class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :subject, null: false
      t.integer :teacher_id
      t.string :status, null: false, default: "Active"
      t.string :school_year
      t.integer :period
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
    add_index :courses, :teacher_id
  end
end
