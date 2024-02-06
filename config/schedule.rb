# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

set :output, "log/cron.log"

every :monday, at: "6:00pm" do
  rake "dbcalc:send_mail"
  rake "dbcalc:weekly_sum"
end

every :monday, at: "5:00pm" do
  rake "weekly_putz:new_week"
end

every :wednesday, at: "17:00" do
  runner 'Notifications.notify_heavy_debt!'
end
