class AddSchoolIdtoUser < ActiveRecord::Migration
  def change
    add_column :users, :school_id, :integer
    add_column :users, :teacher_id, :integer
  end
end
