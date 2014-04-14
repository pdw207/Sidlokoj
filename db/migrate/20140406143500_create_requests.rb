class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer :teacher_id
      t.integer :principal_id
      t.string :status, null: false

      t.timestamps
    end

    add_index :requests, :teacher_id
    add_index :requests, :principal_id
  end
end
