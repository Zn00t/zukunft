class AddTelegramIdToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :telegram_id, :int
  end
end
