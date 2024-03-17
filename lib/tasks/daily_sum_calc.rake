namespace :dbcalc do

  desc "calculates the sum of all three accounts (food, invest, cleaning) and saves them"
  task :archive_sums => :environment do
    food_sum = User.non_deleted.sum(:food)
    invest_sum = User.non_deleted.sum(:invest)
    cleaning_sum = User.non_deleted.sum(:cleaning)
    HistoricalSum.create(food: food_sum, invest: invest_sum, cleaning: cleaning_sum)
  end
end