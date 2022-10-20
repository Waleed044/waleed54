class AddColumnToUser2 < ActiveRecord::Migration[6.0]
  def change
    add_column  :users, :contact, :integer 
  end
end
