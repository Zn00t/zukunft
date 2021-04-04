namespace :dbcalc do
  desc "Adds the weekly rate for each user to the user's sum"
  task :weekly_sum => :environment do
    if Time.now.monday?
      FinanceValue.update_all "food = food + rate"
      puts "sum updated"
      @values = FinanceValue.all
      @values.each do |v|
        if v.cleaned == false
          cleaning_sum_insert = FinanceValue.find(v).cleaning + 10
          FinanceValue.update(v, cleaning_sum_insert)
          puts "#{FinanceValue.find(v).name} didn't clean! +10 for dirtyness!"
        end
      end
    else
      puts "Hey, its not Monday! (sum not updated)"
    end
    if Date.today == Date.today.beginning_of_month
      FinanceValue.update_all "investition = investition + 7"
    end
  end
end