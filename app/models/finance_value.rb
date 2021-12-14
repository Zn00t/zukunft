class FinanceValue < ApplicationRecord
  belongs_to :user

  attribute :sum, :float, default: 0
  attribute :rate, :int, default: 25
  attribute :food, :float, default: 0
  attribute :invest, :float, default: 0
  attribute :cleaning, :int, default: 0

  attribute :cleaning, :int, default: 0

end
