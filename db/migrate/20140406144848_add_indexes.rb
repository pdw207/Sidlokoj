class AddIndexes < ActiveRecord::Migration
  def change
    add_index :users, :school_id
    add_index :users, :teacher_id
    add_index :schools, :principal_id
  end
end
