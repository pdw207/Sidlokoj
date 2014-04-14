class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :name, null: false
      t.string :location, null: false
      t.string :phone_number
      t.integer :principal_id
      t.timestamps
    end
    # Add link associated ID to user table
    add_column :users, :admin, :boolean, default: false, null: true
  end
end
