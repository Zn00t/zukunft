class WeeklyJob < ApplicationJob
  queue_as :default

  def perform(scheduled_time)
  end
end
