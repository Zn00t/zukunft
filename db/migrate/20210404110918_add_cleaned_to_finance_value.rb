class AddCleanedToFinanceValue < ActiveRecord::Migration[6.1]
  def change
    add_column FinanceValue, :cleaned, :boolean
  end
end
