class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :nickname
      t.string :dob
      t.integer :school_id

      t.timestamps
    end

    add_index :students, :first_name
  end
end
