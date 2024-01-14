module Notifications
  extend self


  def notify_heavy_debt!
    debt_users = User.active.where('food + cleaning + invest > ?', 100)
    debt_users.map!{|u| chat.user_mention(u.name, u.telegram_id)}

    plus_users = User.active.select(:id, :telegram_id, "(food + invest + cleaning) AS sum").order(sum: :desc).limit(3)
    plus_users.map!{|u| chat.user_mention(u.name, u.telegram_id)}
    chat.send_message("#{debt_users.join(' ')} haben mehr als 100euro schulden.\nBitte sendet etwas an #{plus_users.join(' ')}. Dankee!")
  end

  private
  # memoized chat object
  def chat
    @chat ||= Chat.new(token: Rails.application.credentials.BOT_TOKEN)
  end
end
