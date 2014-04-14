class AddDefault < ActiveRecord::Migration
  def up
    change_column :requests, :status, :string, null: false, default: 'Pending'
  end
  def up
    change_column :requests, :status, :string, null: false
  end
end
