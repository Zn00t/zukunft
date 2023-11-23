class Room < ApplicationRecord

  validates :name, presence: true

  attribute :name, :string
  attribute :description, :string, default: ""
  attribute :active, :boolean, default: true
  attribute :deleted, :boolean, default: false

  def activate!
    update(active: true)
  end

  def deactivate!
    update(active: false)
  end

  def delete!
    update(deleted: true)
  end

  def update_description!(new_description)
    update(description: new_description)
  end

  end