namespace :dbcalc do
  desc "Adds the weekly rate for each user to the user's sum"
  task :weekly_sum => :environment do
    if Time.now.saturday?
      FinanceValue.update_all "food = food + rate"
      puts "sum updated"
    else
      puts "Hey, its not Monday! (sum not updated)"
    end
  end
end