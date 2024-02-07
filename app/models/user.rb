# name.string
# password_digest:string
#
# password:string virtual
# password_confirmation:string virtual

class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true
  has_many :restacks

  has_one :current_cleaningtask, -> { current_week }, class_name: 'CleaningTask'
  has_many :cleaning_tasks

  attribute :sum, :float, default: 0
  attribute :rate, :integer, default: 25
  attribute :food, :float, default: 0
  attribute :invest, :float, default: 0
  attribute :cleaning, :integer, default: 0
  attribute :excepted, :boolean, default: false

  scope :active, -> { where(active: true) }

  def total_debt
    food + invest + cleaning
  end
  alias_method :sum, :total_debt # shim for refactoring

  def shopped_food(amount:)
    update(food: self.food - amount)
  end

  def mark_away!(until_date:)
    update(away: until_date)
  end

  def receive_money!(from:, amount:)
    User.transaction do
      sender = User.find(from)
      self.food += amount
      sender.food -= amount
      self.save!
      sender.save!
    rescue ActiveRecord::RecordNotFound => e
      self.errors.add(:base, "Nutzer nicht gefunden")
    end
  end
end
