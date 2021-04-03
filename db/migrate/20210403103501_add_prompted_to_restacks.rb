class AddPromptedToRestacks < ActiveRecord::Migration[6.1]
  def change
    add_column :restacks, :prompted, :boolean
  end
end
