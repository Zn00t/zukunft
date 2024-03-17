class CreateTableSumsHistory < ActiveRecord::Migration[6.1]
  def change
    create_table :sums_history do |t|
      t.float :food
      t.float :invest
      t.float :cleaning
      t.timestamps
    end
  end
end
