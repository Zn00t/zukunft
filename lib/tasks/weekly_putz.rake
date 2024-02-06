

namespace :weekly_putz do
  desc "Renew plan and notify users"
  task :new_week => :environment do
    CleaningPlan.generate_weekplan
    CleaningPlan.notify_telegram
  end
end
