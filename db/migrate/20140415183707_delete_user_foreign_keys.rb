class DeleteUserForeignKeys < ActiveRecord::Migration
  def up
    remove_column :users, :school_id
    remove_column :users, :teacher_id
  end
  def down
    add_column :users, :school_id, :integer
    add_column :users, :teacher_id, :integer
  end
end
