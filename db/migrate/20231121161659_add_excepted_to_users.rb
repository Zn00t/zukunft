class AddExceptedToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :excepted, :boolean
  end
end
