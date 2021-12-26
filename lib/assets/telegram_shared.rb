def send_to_klingel(message)
  bot_token = ENV['BOT_TOKEN']
  chat_id = -1001149902183
  url = "https://api.telegram.org/bot#{bot_token}/sendMessage"
  RestClient.post(url, chat_id: chat_id, text: message)
  puts "test"
end
def send_backup_to_klingel
  bot_token = ENV['BOT_TOKEN']
  chat_id = -1001149902183
  file = File.open("storage/backups/#{Date.current.year}_KW#{Date.today.strftime("%U").to_i}.csv")
  url = "https://api.telegram.org/bot#{bot_token}/sendDocument"
  RestClient.post(url, chat_id: chat_id, document: File.open(file, 'r'))
end
