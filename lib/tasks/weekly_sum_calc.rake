require_relative '../assets/telegram_shared.rb'

namespace :dbcalc do
  desc "Adds the weekly rate for each user to the user's sum"
  task :weekly_sum => :environment do
    if Time.now.monday?
      FinanceValue.all.each do |value|
        if value.away.nil? && User.find(value.user_id).active
          food_sum_insert = value.food + value.rate
          FinanceValue.update(value.id, :food => food_sum_insert)
          puts "#{value.name}'s sum updated (+#{value.rate})"
        end
      end
      @values = FinanceValue.all
      @values.each do |v|
        if v.away.nil? && v.cleaned == false && User.find(v.user_id).active
          cleaning_sum_insert = FinanceValue.find(v.id).cleaning + 10
          FinanceValue.update(v.id, :cleaning => cleaning_sum_insert)
          puts "#{FinanceValue.find(v.id).name} didn't clean! +10 for dirtyness!"
        end
        FinanceValue.update(v.id, :cleaned => false) unless v.name == "Nini" || v.name == "Pitt" || v.name == "Alma"
      end
    else
      puts "Hey, its not Monday! (sum not updated)"
    end
    if Date.today.day.between?(1, 14)
      @values.each do |v|
        if User.find(v.user_id).active
          invest_insert = v.invest += 7
          FinanceValue.update(v.id, :invest => invest_insert)
          puts "#{v.name}'s invest updated (+7)'"
        end
      end
    else
      puts "not the beginning of the month! (investition not updated)"
    end
    FinanceValue.all.each do |v|
      if !v.away.nil? && (Date.today.strftime('%F') == v.away.strftime('%F') || v.away.past?)
        FinanceValue.update(v.id, :away => nil)
        puts "#{v.name} ist wieder da!"
      end
    end
  end

  task :send_mail => :environment do
    if Time.now.thursday?
      #WeeklyBackupMailer.weekly_backup.deliver_now
      puts "Mail ist raus!"
      send_to_klingel("Coming in hot!\nBackup der KW#{Date.today.strftime("%U").to_i}")
      send_backup_to_klingel()
    else
      puts "es ist nicht Montag (keine Backup Mail)"
    end
  end
  task :send_message => :environment do
    send_to_klingel("Hello World!")
  end
end