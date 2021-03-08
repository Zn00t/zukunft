class CreateFinanceValues < ActiveRecord::Migration[6.1]
  def change
    create_table :finance_values do |t|
      t.string :name
      t.float :sum
      t.integer :rate
      t.float :food
      t.float :invest
      t.integer :cleaning

      t.timestamps
    end
  end
end
