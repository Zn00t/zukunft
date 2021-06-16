# Preview all emails at http://localhost:3000/rails/mailers/weekly_backup_mailer
require 'csv'

class WeeklyBackupMailerPreview < ActionMailer::Preview
  def weekly_backup
    file = "/storage/backups/#{Date.current.year}_KW#{Date.today.strftime("%U").to_i}"
    values = FinanceValue.order(:name)
    headers = ["Name", "Gesamt", "Essensrate", "Essenskasse", "Investitionskasse", "Putzkasse", "Geputzt?"]

    CSV.generate(file, headers: true) do |writer|
      writer << headers
      values.each do |value|
        writer << [value.name, value.rate, value.food, value.invest, value.cleaning, value.cleaned]
      end
    end
    WeeklyBackupMailer.weekly_backup

    #attachments["#{Date.current.year}_KW#{Date.weeknum}"] = File.read(file)
  end
end
