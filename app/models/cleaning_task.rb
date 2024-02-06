class CleaningTask < ApplicationRecord
  belongs_to :room
  belongs_to :user

  validates_presence_of :room, :user

  scope :open, -> { where(done: false) }

  scope :current_week, -> {
    today = Date.today
    where(task_start: today - (today.wday - 1) % 7)
  }

  def task_end
    task_start + 6
  end

  def done!
    self.done = true
    self.save
  end
end
