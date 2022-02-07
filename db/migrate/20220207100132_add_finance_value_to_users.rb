class AddFinanceValueToUsers < ActiveRecord::Migration[6.1]
  def up
    add_column :users, :rate, :integer, null: false, default: 0
    add_column :users, :food, :float, null: false, default: 0.0
    add_column :users, :invest, :float, null: false, default: 0.0
    add_column :users, :cleaning, :integer, null: false, default: 0
    add_column :users, :cleaned, :boolean, null: false, default: false
    add_column :users, :away, :date

    User.reset_column_information

    User.find_each do |user|
      fv = FinanceValue.where(user_id: user.id).first
      user.rate = fv.rate
      user.food = fv.food
      user.invest = fv.invest
      user.cleaning = fv.cleaning
      user.cleaned = fv.cleaned
      user.away = fv.away
      user.save!
    end
  end

  def down
    raise "no down migration supported"
  end
end
