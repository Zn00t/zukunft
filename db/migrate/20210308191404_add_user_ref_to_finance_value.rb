class AddUserRefToFinanceValue < ActiveRecord::Migration[6.1]
  def change
    add_reference :finance_values, :user, foreign_key: true
  end
end
