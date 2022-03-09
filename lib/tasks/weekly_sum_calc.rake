require_relative '../assets/telegram_shared.rb'

namespace :dbcalc do
  desc "Adds the weekly rate for each user to the user's sum"
  task :weekly_sum => :environment do
    if Time.now.monday?
      User.all.each do |user|
        next unless user.away.nil?
        next unless user.active

        # increase food
        user.food += user.rate
        puts "#{user.name}'s sum updated (+#{user.rate})"

        # if user didn't clean, increase cleaning account
        # some users are exempt

        exempt_users = ["Nini", "Pitt", "Alma"]

        if !user.cleaned &&
            !exempt_users.include?(user.name)
          user.cleaning += 10
          puts "#{user.name} didn't clean! +10 for dirtyness!"
        else
          user.cleaned = false unless exempt_users.include?(user.name)
        end
        user.save
      end
    else
      puts "Hey, its not Monday! (sum not updated)"
    end

    if Date.today.day == 1
      User.find_each do |user|
        next unless user.active
        user.invest += 7
        puts "#{user.name}'s invest updated (+7)'"
        user.save
      end
    else
      puts "not the beginning of the month! (investition not updated)"
    end

    User.find_each do |user|
      if !user.away.nil? && (Date.today.strftime('%F') == user.away.strftime('%F') || user.away.past?)
        user.away = nil
        puts "#{user.name} ist wieder da!"
        user.save
      end
    end
  end

  task :send_mail => :environment do
    if Time.now.monday?
      puts "Mail ist raus!"
      send_to_klingel("Coming in hot!\nBackup der KW#{Date.today.strftime("%U").to_i}")
      send_backup_to_klingel()
    else
      puts "es ist nicht Montag (keine Backup Mail)"
    end
  end
  task :send_message => :environment do
    #send_to_klingel("Hello World!")
  end
end
