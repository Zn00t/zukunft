namespace :dbcalc do
  desc "Adds the weekly rate for each user to the user's sum"
  task :weekly_sum => :environment do
    if Time.now.thursday?
      FinanceValue.all.each do |value|
        if value.away.nil?
          food_sum_insert = value.food + value.rate
          FinanceValue.update(value.id, :food => food_sum_insert)
          puts "#{value.name}'s sum updated (+#{value.rate})"
        end
      end
      @values = FinanceValue.all
      @values.each do |v|
        if v.away.nil? && v.cleaned == false
          cleaning_sum_insert = FinanceValue.find(v.id).cleaning + 10
          FinanceValue.update(v.id, :cleaning => cleaning_sum_insert)
          puts "#{FinanceValue.find(v.id).name} didn't clean! +10 for dirtyness!"
          FinanceValue.update_all(:cleaned => false)
        end
      end
    else
      puts "Hey, its not Monday! (sum not updated)"
    end
    if Date.today == Date.today.beginning_of_month
      FinanceValue.update_all "investition = investition + 7"
    else
      puts "not the beginning of the month! (investition not updated)"
    end
    FinanceValue.all.each do |v|
        if !v.away.nil? && Date.today.strftime('%F') == v.away.strftime('%F')
          FinanceValue.update(v.id, :away => nil)
          puts "#{v.name} ist wieder da!"
        end
    end
  end
end