class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.string :name
      t.string :description
      t.boolean :active
      t.boolean :deleted
      t.timestamps
    end
  end
end
