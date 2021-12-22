def send_to_klingel(message)
  bot_token = ENV['BOT_TOKEN']
  chat_id = -783082331

  HTTParty.post("https://api.telegram.org/bot#{bot_token}/sendMessage?chat_id=#{chat_id}&text=#{message}")
end