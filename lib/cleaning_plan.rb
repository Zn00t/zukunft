module CleaningPlan
  extend self

  def generate_weekplan
    rooms = Room.where(active: true)
    users = User.where(active: true).all.shuffle

    now = Date.today

    user_index = 0

    task_start = now - (now.wday-1)
    task_end = task_start + 6

    rooms.each do |room|
      CleaningTask.where(room: room, task_start: task_start).first_or_create do |obj|
        obj.user = users[user_index % users.size]
      end

      user_index += 1
    end
  end

  def notify_telegram
    CleaningTask.current_week.open.each do |task|
      chat.notify_task(task: task)
    end
  end

  private
  # memoized chat object
  def chat
    @chat ||= Chat.new(token: Rails.application.credentials.tokens[:der_typ_der_kontrolliert])
  end
end
