module Notifications
  extend self


  def notify_heavy_debt!
    debt_users = User.active.where('food + cleaning + invest > ?', 100).all
    debt_users = debt_users.map{|u| chat.user_mention(u.name, u.telegram_id)}

    plus_users = User.active.select(:id, :name, :telegram_id, "(food + invest + cleaning) AS sum").order(sum: :asc).limit(3).all
    plus_users = plus_users.map{|u| "#{chat.user_mention(u.name, u.telegram_id)} (#{u[:sum]} €)"}
    chat.send_message("#{debt_users.join(' ')} haben mehr als 100 € schulden.\nBitte sendet etwas an #{plus_users.join(' ')}. Dankee!")
  end

  private
  # memoized chat object
  def chat
    @chat ||= Chat.new(token: Rails.application.credentials.tokens[:der_typ_der_kontrolliert])
  end
end
