class AddCancelledToRestacks < ActiveRecord::Migration[6.1]
  def change
    add_column :restacks, :Cancelled, :boolean
  end
end
