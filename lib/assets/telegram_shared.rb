require 'csv'

klingel_id = -1001149902183
#klingel_id = -7830823311 # test group

def send_to_klingel(message)
  chat_id = -1001149902183
  bot_token = Rails.application.credentials.BOT_TOKEN
  url = "https://api.telegram.org/bot#{bot_token}/sendMessage"
  RestClient.post(url, chat_id: chat_id, text: message)
  puts "test"
end

def send_backup_to_klingel
  create_backup()
  bot_token = Rails.application.credentials.BOT_TOKEN
  chat_id = -1001149902183
  file = File.open("storage/backups/#{Date.current.year}_KW#{Date.today.strftime("%U").to_i}.csv", 'r')
  url = "https://api.telegram.org/bot#{bot_token}/sendDocument"
  RestClient.post(url, chat_id: chat_id, document: file)
end

def create_backup
  file = "storage/backups/#{Date.current.year}_KW#{Date.today.strftime("%U").to_i}.csv"
  values = User.order(:name)
  headers = ["gelöscht", "Aktiv", "Name", "Essensrate", "Essenskasse", "Investitionskasse", "Putzkasse", "Geputzt?", "Weg bis:"]

  CSV.open(file, 'w', headers: true) do |writer|
    writer << headers
    values.each do |value|
      writer << [value.deleted, value.active, value.name, value.rate, value.food, value.invest, value.cleaning, value.cleaned, value.away]
    end
  end
end
