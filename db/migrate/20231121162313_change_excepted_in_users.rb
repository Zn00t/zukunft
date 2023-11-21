class ChangeExceptedInUsers < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :excepted, :boolean, :default => false
  end
end
