class ChangeTelegramToBigintOnUsers < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :telegram_id, :bigint
  end
end
