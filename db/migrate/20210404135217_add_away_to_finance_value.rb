class AddAwayToFinanceValue < ActiveRecord::Migration[6.1]
  def change
    add_column FinanceValue, :away, :date
  end
end
