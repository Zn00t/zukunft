class FinanceValue < ApplicationRecord
  belongs_to :user

  attribute :sum, :float, default: 0
  attribute :rate, :integer, default: 25
  attribute :food, :float, default: 0
  attribute :invest, :float, default: 0
  attribute :cleaning, :integer, default: 0
end
