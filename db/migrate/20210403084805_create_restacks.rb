class CreateRestacks < ActiveRecord::Migration[6.1]
  def change
    create_table :restacks do |t|
      t.integer :from_id
      t.integer :to_id
      t.integer :value
      t.references
      t.timestamps
    end
  end
end
