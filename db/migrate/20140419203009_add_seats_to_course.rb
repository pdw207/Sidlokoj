class AddSeatsToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :rows, :integer
    add_column :courses, :columns, :integer
  end
end
