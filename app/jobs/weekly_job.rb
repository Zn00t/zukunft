class WeeklyJob < ApplicationJob
  queue_as :default

  def perform(scheduled_time)
    FinanceValue.update_all "sum = sum + rate"
  end
end
