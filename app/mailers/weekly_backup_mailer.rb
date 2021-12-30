require 'csv'
class WeeklyBackupMailer < ApplicationMailer

  def weekly_backup
    file = "storage/backups/#{Date.current.year}_KW#{Date.today.strftime("%U").to_i}.csv"
    values = FinanceValue.order(:name)
    headers = ["Name", "Essensrate", "Essenskasse",  "Investitionskasse", "Putzkasse", "Geputzt?"]

    CSV.open(file, 'w',  headers: true) do |writer|
      writer << headers
      values.each do |value|
        writer << [value.name, value.rate, value.food, value.invest, value.cleaning, value.cleaned]
      end
    end
    attachments["#{Date.current.year}_KW#{Date.today.strftime("%U").to_i}.csv"] = File.read(file)
    mail(headers = {to: "zukunftstest@gmail.com", subject: "Zukunft Finanzboard Backup KW#{Date.today.strftime("%U").to_i}"})
  end

end